import re
import sys

import utils



def set_env_flutter_version():
    """ Sets a github actions environment FLUTTER_VERSION
    variable to the flutter version from pubspec 
    """

    utils.set_github_env("FLUTTER_VERSION", utils.get_flutter_version())

def set_env_dakanji_version():
    """ Sets a github actions environment DAKANJI_VERSION
    variable to the dakanji version from pubspec 
    """

    utils.set_github_env("DAKANJI_VERSION", utils.get_dakanji_version())

def create_latest_changes_txt():
    """ Creates a file called "latest_changes.txt" and 
    writes the Changelog of the newest release to it
    """
    
    with open("latest_changes.txt", mode="w+", encoding="utf8") as f:
        f.write(utils.get_latest_changes())

def create_release_notes_txt():
    """ Creates a file called "latest_changes.txt" and 
    writes the Changelog of the newest release to it
    """

    with open(".github/workflows/github_release_text.txt", mode="r") as f:
        release_notes = f.read()
    
    release_notes = release_notes.replace("CHANGELOG", utils.get_latest_changes())

    with open("release_notes.txt", mode="w+", encoding="utf8") as f:
        f.write(release_notes)

def update_snapcraft_yaml():
    """ Updates the snapcraft yaml with
        * current flutter version from pubspec
    """

    with open("snap/snapcraft.yaml", mode="r+") as f:
        snap = f.read()
        snap = re.sub("source-tag: .*", f"source-tag: {utils.get_flutter_version()}", snap)
        f.seek(0)
        f.write(snap)
        f.truncate()

def comment_large_assets_in_pubspec():
    """ Comments all large assets in pubspec.yaml for building .appbundle
    """

    content = ""
    with open("pubspec.yaml", mode="r") as f:
        last_line = ""
        for line in f:
            content += line if "# downloadable:" not in last_line else f"#{line}"
            last_line = line

    with open("pubspec.yaml", mode="w+") as f:
        f.write(content)



if __name__ == "__main__":
    
    arg = sys.argv[1]

    if(arg == "set_env_flutter_version"):
        set_env_flutter_version()

    if(arg == "set_env_dakanji_version"):
        set_env_dakanji_version()

    if(arg == "create_latest_changes_txt"):
        create_latest_changes_txt()

    if(arg == "update_snapcraft_yaml"):
        update_snapcraft_yaml()

    if(arg == "create_release_notes_txt"):
        create_release_notes_txt()

    if(arg == "comment_large_assets_in_pubspec"):
        comment_large_assets_in_pubspec()

        