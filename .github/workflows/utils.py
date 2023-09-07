import os
import re



def get_dakanji_version() -> str:
    """ Reads the dakanji version from pubspec and returns it
    """

    with open("pubspec.yaml", mode="r") as f:
        content = f.read()
    matches = re.search("version: (.*)", content)
    version = matches.groups(0)[0]

    return version

def get_flutter_version() -> str:
    """ Reads the used flutter version from pubspec and returns it
    """

    with open("pubspec.yaml", mode="r") as f:
        content = f.read()
    matches = re.search("flutter: \"(.*)\"", content)
    version = matches.groups(0)[0]

    return version

def set_github_env(name : str, value : str):
    """ Creates a github actions environment variable

    Args:
        name (str): the name of the varaible
        value (str): the value of the variable
    """

    env_file = os.getenv('GITHUB_ENV')

    with open(env_file, "a") as f:
        f.write(f"{name}={value}\n")

def get_latest_changes() -> str:
    """ Reads the Changelog from the last release and returns it.
    """
    with open("CHANGELOG.md", mode="r", encoding="utf8") as f:
        changelog = f.read()

    newest_changes = re.search("##(.*?)----------------", changelog, re.DOTALL).groups()[0]

    return newest_changes