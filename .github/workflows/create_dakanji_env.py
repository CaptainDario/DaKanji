import os



if __name__ == "__main__":

    with open("dakanji.env", mode="w+") as f:

        f.write(f"SENTRY_DSN={os.environ['SENTRY_DSN']}\n")
        f.write(f"APTABASE_APP_KEY={os.environ['APTABASE_APP_KEY']}\n")

