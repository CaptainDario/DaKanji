import os
import re



if __name__ == "__main__":
    
    # read version from pubspec
    with open("pubspec.yaml", mode="r") as f:
        content = f.read()
    matches = re.search("flutter: \"(.*)\"", content)
    version = matches.groups(0)[0]

    # set env
    env_file = os.getenv('GITHUB_ENV')

    with open(env_file, "a") as myfile:
        myfile.write(f"FLUTTER_VERSION={version}")