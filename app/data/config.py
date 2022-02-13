from environs import Env

env = Env()
env.read_env()

BOT_TOKEN = env.str("BOT_TOKEN")
ADMINS_ID = env.list("ADMINS_ID")
CHANNELS_ID = env.list("CHANNELS_ID")
IP = env.str("IP")

