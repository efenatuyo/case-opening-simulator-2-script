from flask import Flask, request
import os
from threading import Thread
import discord
from discord.ext import commands
import requests
bot = commands.Bot(command_prefix = "!", intents = discord.Intents.all())
admins = [1088925059558674452, 965607288083718154, 1092208365968572427]
app = Flask(__name__)

@bot.command(name="generate_key")
async def generate_key(ctx, user: discord.User):
    if ctx.author.id in admins:
        response = requests.get("website/add_new", headers={"discordId": str(user.id)})
        if not response.json()["success"]:
            await ctx.reply("This user already has a key!")
        else:
            await ctx.reply("Generated a new key! check your dms")
            await user.send(f"Key: {response.json()['key']}")
            for user_id in admins:
                users = await bot.fetch_user(user_id)
                await users.send(f"New key for {user.id}\nKey: {response.json()['key']}")
    else:
        await ctx.reply("You are not allowed to generate a key")

@bot.command(name="stats")
async def stats(ctx):
    response = requests.get("website/get_info", headers={"discord_id": str(ctx.author.id)})
    if response.json()["success"]:
        info = response.json()["info"]
        embed = discord.Embed(title=f"Stats for {ctx.author.name}#{ctx.author.discriminator}", color=0x00ff00)
        embed.add_field(name="Executed count", value=info["executed_count"])
        embed.add_field(name="Cases count", value=info["cases_count"])
        await ctx.reply(embed=embed)
    else:
        return ctx.reply("Failed to get stats")
    
@app.route('/get_script')
def get_script():
    key = request.args.get('key')
    ip = request.headers['X-Forwarded-For']
    requests.get(f"website/check?UserIp={str(ip)}&key={str(key)}")
    with open("script.lua", "r") as f:
      key = f.read()
    return key


@app.route('/bypass')
def bypass():
    calculated = request.args.get('calculated').replace(" ", "")
    PlaceVersion = request.args['PlaceVersion']
    return str(float(calculated) * int(PlaceVersion) / 2)

@app.route('/online')
def online():
    return os.environ['version']

@app.route('/new_case')
def new_case():
    ip = request.headers["X-Forwarded-For"]
    requests.get("website/new_case", headers={"ip": str(ip)})
    return "1"
    
@app.route('/executed')
def executed():
    ip = request.headers["X-Forwarded-For"]
    requests.get("website/executed", headers={"ip": str(ip)})
    return "1"

@app.route('/check_key')
def check_key():
    userId = request.args.get('X-UserID')
    ip = request.headers['X-Forwarded-For']
    
    response = requests.get(f"website/check_ip", headers={"UserIp": str(ip)})
    if not response.json()["success"]:
        return "0"
    requests.post("webhook", data={"content": f"Request from IP address {ip}\nRoblox Id: {userId}\nKey: {response.json()['key']}"})
    return "1"

@app.route('/first_number')
def first_number():
    userId = request.args.get('X-UserID')
    PlaceVersion = request.args.get('X-PlaceVersion')
    return str(int(userId) * int(PlaceVersion))

def run():  
    app.run(host='0.0.0.0', port=81)

def keep_alive():
    server = Thread(target=run)
    server.start()

keep_alive()
bot.run("")