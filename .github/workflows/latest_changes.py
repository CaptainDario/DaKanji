#############################################################
#                                                           #
# Script to read the changes of the latest release from the #
# CHANGELOG.md and dump them to latest_changes.txt.         #
#                                                           #
#############################################################



import re

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
    create_latest_changes_txt()