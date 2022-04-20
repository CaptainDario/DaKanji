#############################################################
#                                                           #
# Script to read the version of the latest release from the #
# pubspec.yaml and dump them to current_version.txt.        #
#                                                           #
#############################################################



import re

def get_version():
    """ Read the version from pubspec.yaml and return it
    """
    
    with open("pubspec.yaml") as f:

        version = re.search("version: (.*)", f.read()).groups()[0]  

        return version


if __name__ == "__main__":

        
    with open("dakanji_version.txt", mode="w+", encoding="utf8") as f:
        f.write("DAKANJI_VERSION=" + get_version())
