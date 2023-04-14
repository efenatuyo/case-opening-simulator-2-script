from flask import Flask, request
import configparser
import random
import string
config = configparser.ConfigParser(allow_no_value=True)
config.read('database.ini')
app = Flask(__name__)

def get_random_string(length):
    letters = string.ascii_lowercase
    result_str = ''.join(random.choice(letters) for i in range(length))
    return result_str

def check_stats(method, **kwargs):
    if method == "exists":
        discordId = kwargs.get("discord_id")
        if discordId in config["stats"]:
            return True
        else:
            config["stats"][discordId] = None
            config[discordId] = {}
            config[discordId]["executed_count"] = "0"
            config[discordId]["cases_count"] = "0"
            with open("database.ini", "w") as configfile:
                config.write(configfile)
            return True
    elif method == "info":
        discordId = kwargs.get("discord_id")
        return {"executed_count": config[discordId]["executed_count"], "cases_count": config[discordId]["cases_count"]}
        
@app.route('/add_new')
def add_new():
    discordId = request.headers["discordId"]
    if discordId in config["verifedDiscordId"]:
      return {"success": False}
    randomString = get_random_string(10)
    config["verifedCodes"][randomString] = discordId
    config["verifedDiscordId"][discordId] = randomString
    with open("database.ini", "w") as configfile:
      config.write(configfile)
    check_stats(method="exists", discord_id=discordId)
    return {"key": randomString, "success": True}

def add(ip, key):
  config["ips"][ip] = key
  with open("database.ini", "w") as configfile:
      config.write(configfile)
    
@app.route('/check')
def check():
  key = request.args.get("key")
  ip = request.args.get("UserIp")
  if key in config['verifedCodes']:
    add(ip, key)
    return {"key": key, "discordId": config['verifedCodes'][key], "success": True}
  return {"success": False}

@app.route('/new_case')
def new_case():
    ip = request.headers["ip"]
    key = config["ips"][ip]
    discordId = config["verifedCodes"][key]
    crate_cost = request.headers["crate_cost"]
    check_stats(method="exists", discord_id=discordId)
    config[discordId]["cases_count"] = str(int(config[discordId]["cases_count"]) + 1)
    with open("database.ini", "w") as configfile:
      config.write(configfile)
    return {"success": True}
    
@app.route('/executed')
def executed():
    ip = request.headers["ip"]
    key = config["ips"][ip]
    discordId = config["verifedCodes"][key]
    check_stats(method="exists", discord_id=discordId)
    config[discordId]["executed_count"] = str(int(config[discordId]["executed_count"]) + 1)
    with open("database.ini", "w") as configfile:
      config.write(configfile)
    return {"success": True}

@app.route('/get_info')
def get_info():
    discordId = request.headers["discord_id"]
    check_stats(method="exists", discord_id=discordId)
    info = check_stats(method="info", discord_id = discordId)
    return {"success": True, "info": info}
    
@app.route('/check_ip')
def check_ip():
  if request.headers["UserIp"] in config["ips"]:
    return {"key": config["verifedCodes"][config["ips"][ request.headers["UserIp"]]],"success": True}
  else:
    return {"success": False}

app.run(host='0.0.0.0', port=81)
