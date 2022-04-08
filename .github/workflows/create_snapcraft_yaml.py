#############################################################
#                                                           #
# Script to read the the template_snapcraft.yaml and create #
# a snapcraft_yaml with the current version of Dakanji.     #
#                                                           #
#############################################################



import os
from get_version import get_version


def create_snapcraft_yaml():
    with open("snap/template_snapcraft.yaml", mode="r", encoding="utf8") as f:
        snapcraft = f.read()

    version = get_version()
    snapcraft = snapcraft.replace("${VERSION}", version[:version.index("+")])

    with open("snap/snapcraft.yaml", mode="w+", encoding="utf8") as f:
        f.write(snapcraft)   



if __name__ == "__main__":
    create_snapcraft_yaml()