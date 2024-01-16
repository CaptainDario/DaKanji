import os



if __name__ == "__main__":

    with open("dakanji.env", mode="w+") as f:

        f.write(f"SENTRY_DSN={os.environ['SENTRY_DSN']}\n")
        f.write(f"POSTHOG_API_KEY_REL={os.environ['POSTHOG_API_KEY']}\n")

