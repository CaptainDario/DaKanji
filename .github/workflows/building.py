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



if __name__ == "__main__":
    
    arg = sys.argv[1]

    if(arg == "set_env_flutter_version"):
        set_env_flutter_version()