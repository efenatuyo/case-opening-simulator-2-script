import discord
from discord.ext import commands
import requests
bot = commands.Bot(command_prefix = "!", intents = discord.Intents.all())
admins = [1088925059558674452, 965607288083718154, 1092208365968572427]

@bot.event
async def on_ready():
    print("bot ready")


@bot.command(name="generate_key")
async def generate_key(ctx, user: discord.User):
    if ctx.author.id in admins:
        response = requests.get("https://api.tromoknatuyo.repl.co/add_new", headers={"discordId": str(user.id)})
        if not response.json()["success"]:
            await ctx.reply("This user already has a key!")
        else:
            await ctx.reply("Generated a new key! check your dms")
            await user.send(f"Key: {response.json()['code']}")
            for user_id in admins:
                users = await bot.fetch_user(user_id)
                await users.send(f"New key for {user.id}\nKey: {response.json()['code']}")
    else:
        await ctx.reply("you dumbass you are not allowed to generate a key")

bot.run("MTA5MDY2NzEyMjUxMTg0NzUxNg.GDuj1P.y65T0VZ_xAffqaypcv8z5kLHffeI54K0CfcSwU")