#############################################################
#                                                           #
# Script to read the version of the latest release from the #
# pubspec.yaml and dump them to current_version.txt.        #
#                                                           #
#############################################################



import re



if __name__ == "__main__":



    with open("pubspec.yaml") as f:

        version = re.search("version: (.*)", f.read()).groups()[0]
        
        with open("dakanji_version.txt", mode="w+", encoding="utf8") as f:
            f.write(version)