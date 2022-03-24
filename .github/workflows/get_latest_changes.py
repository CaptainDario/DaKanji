#############################################################
#                                                           #
# Script to read the changes of the latest release from the #
# CHANGELOG.md and dump them to latest_changes.txt.         #
#                                                           #
#############################################################



import re


def create_latest_changes_txt():
    with open("CHANGELOG.md", mode="r", encoding="utf8") as f:
        changelog = f.read()

    newest_changes = re.search("##(.*?)----------------", changelog, re.DOTALL).groups()[0]
    
    with open("latest_changes.txt", mode="w+", encoding="utf8") as f:
        f.write(newest_changes)   


if __name__ == "__main__":
    create_latest_changes_txt()