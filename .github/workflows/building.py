import re
import sys

import utils



def set_env_flutter_version():
    """ Sets a github actions environment FLUTTER_VERSION
    variable to the flutter version from pubspec 
    """

    # read version from pubspec
    with open("pubspec.yaml", mode="r") as f:
        content = f.read()
    matches = re.search("flutter: \"(.*)\"", content)
    version = matches.groups(0)[0]

    utils.set_github_env("FLUTTER_VERSION", version)

def get_latest_changes() :
    """ Reads the Changelog from the last release and returns it.
    """
    with open("CHANGELOG.md", mode="r", encoding="utf8") as f:
        changelog = f.read()

    newest_changes = re.search("##(.*?)----------------", changelog, re.DOTALL).groups()[0]

    return newest_changes

def create_latest_changes_txt():
    """ Creates a file called "latest_changes.txt" and 
    writes the Changelog of the newest release to it
    """
    
    with open("latest_changes.txt", mode="w+", encoding="utf8") as f:
        f.write(get_latest_changes())   



if __name__ == "__main__":
    
    arg = sys.argv[1]

    if(arg == "set_env_flutter_version"):
        set_env_flutter_version()