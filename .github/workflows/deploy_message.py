#############################################################
#                                                           #
# Script to read the changes of the latest release from the #
# CHANGELOG.md and dump them to latest_changes.txt.         #
#                                                           #
#############################################################



import os
from latest_changes import get_latest_changes


def create_deploy_message_txt():
    with open(".github/workflows/deploy_message.txt", mode="r", encoding="utf8") as f:
        deploy_message = f.read()

    deploy_message = deploy_message.replace("LATEST_CHANGES", get_latest_changes())

    with open("deploy_message.txt", mode="w+", encoding="utf8") as f:
        f.write(deploy_message)   



if __name__ == "__main__":
    create_deploy_message_txt()