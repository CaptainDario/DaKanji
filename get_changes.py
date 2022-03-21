#############################################################
#                                                           #
# Script to read the changes of the latest release from the #
# CHANGELOG.md and print them to std out.                   #
#                                                           #
#############################################################



import re


if __name__ == "__main__":
    with open("CHANGELOG.md", mode="r", encoding="utf8") as f:
        changelog = f.read()

    newest_changes = re.search("(##.*?)----------------", changelog, re.DOTALL).groups()[0]
    print(newest_changes)