import subprocess
import re

create_repo_cmd = "flatpak-builder --repo=repo --force-clean build-dir com.DaAppLab.DaKanji.yml"
bundle_repo_cmd = "flatpak build-bundle repo com.DaAppLab.DaKanji.flatpak com.DaAppLab.DaKanji"

pattern = r"v(\d+\.\d+\.\d+).*?\((\d{2}\.\d{2}\.\d{4})\)"
release_date_template = '<release version="VVV" date="DDD" />'
releases_tag = "<releases></releases>"


def add_release_dates():
    """ Adds all releases dates from the changelog to the metainfo.xml
    """

    # read all releases
    releases = []
    with open("../CHANGELOG.md") as f:
        for line in f.readlines():
            match = re.search(pattern, line)
            if(match):
                date = match.group(2).split(".")
                date = f"{date[2]}-{date[1]}-{date[0]}"
                releases.append(release_date_template
                    .replace("VVV", match.group(1))
                    .replace("DDD", date))

    # create releases tag
    releases = "<releases>\n    " + "\n    ".join(releases) + "\n  </releases>"

    # create new metainfo file
    with open("metainfo_template.xml") as template:
        metainfo_template = template.read()
        with open("com.DaAppLab.DaKanji.metainfo.xml", mode="w+") as out:
            out.write(metainfo_template.replace(releases_tag, releases))


def main():

    add_release_dates()
    print("added releases")

    subprocess.run(create_repo_cmd, shell=True)
    subprocess.run(bundle_repo_cmd, shell=True)


if __name__ == "__main__":

    main()