import re
import sys

import utils



def set_env_flutter_version():
    """ Sets a github actions environment FLUTTER_VERSION
    variable to the flutter version from pubspec 
    """

    utils.set_github_env("FLUTTER_VERSION", utils.get_flutter_version())

def create_latest_changes_txt():
    """ Creates a file called "latest_changes.txt" and 
    writes the Changelog of the newest release to it
    """
    
    with open("latest_changes.txt", mode="w+", encoding="utf8") as f:
        f.write(utils.get_latest_changes())

def update_snapcraft_yaml():
    """ Updates the snapcraft yaml with
        * current flutter version from pubspec
    """

    with open("snap/snapcraft.yaml", mode="r") as f:
        snap = f.read()
    
    snap = re.sub("source-tag: .*", f"source-tag: {utils.get_flutter_version()}", snap)

    with open("snap/snapcraft.yaml", mode="w+"):
        f.write(snap)



if __name__ == "__main__":
    
    arg = sys.argv[1]

    if(arg == "set_env_flutter_version"):
        set_env_flutter_version()

    if(arg == "create_latest_changes_txt"):
        create_latest_changes_txt()

    if(arg == "update_snapcraft_yaml"):
        update_snapcraft_yaml()