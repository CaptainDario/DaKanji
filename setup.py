import os
import json
import urllib.request
import shutil
import re
import sys
import subprocess


repo_url = "https://api.github.com/repos/CaptainDario/DaKanji-Dependencies/releases/tags/"
tmp_dir = "tmp"
files_to_exclude = []
default_files_to_exclude = ["audios.zip",
    "CNN_single_char.zip",
    "dictionary.zip",
    "examples.zip",
    "krad.zip",
    "mecab_dict.zip",
    "radk.zip",
]
files_to_exclude_win = [
    "libmecab_arm64.dylib",
]
files_to_exclude_mac = [
]
files_to_exclude_lin = [
    "libmecab_arm64.dylib",
]

release_url = None
assets_version = None


def exclude_files_per_platform():
    """ Excludes files that are not needed for the current platform
    """

    files_to_exclude = default_files_to_exclude

    if(sys.platform.startswith("win32")):
        files_to_exclude.extend(files_to_exclude_win)
    elif(sys.platform.startswith("darwin")):
        files_to_exclude.extend(files_to_exclude_mac)
    elif(sys.platform.startswith("linux")):
        files_to_exclude.extend(files_to_exclude_lin)

def get_release_url():
    """ gets the url to the latest assets release of DaKanji
    """

    with open("pubspec.yaml", mode="r") as f:
        content = f.read()
        m = re.search(r'version: (.*)\+', content)
        assets_version = m.group(1)
        print("Downloading assets for version: ", assets_version)

    return repo_url + "v" + assets_version

def get_asset_info(url: str):
    """ Gets information about all assets for DaKanji from the given url

    Args
        url : url to the assets release of DaKanji
    """

    # get url to latest download
    req = urllib.request.Request(url)
    asset_names, asset_urls, asset_sizes = [], [], []
    with urllib.request.urlopen(req) as response:
        the_page = json.loads(response.read())
        #print(json.dumps(the_page, sort_keys=True, indent=4))
        for k, v in the_page.items():
            if(k == "assets"):
                for asset in the_page[k]:
                    asset_urls.append(asset["browser_download_url"])
                    asset_names.append(asset["name"])
                    asset_sizes.append(asset["size"])
    return asset_names, asset_urls, asset_sizes

def download_assets(url: str):

    asset_names, asset_urls, _ = get_asset_info(url)                

    # download to temp dir and unzip
    if not os.path.exists(tmp_dir):
        os.mkdir(tmp_dir)
    for name, url in zip(asset_names, asset_urls):
        if(name in files_to_exclude):
            continue
        print(f"Downloading: {name}")
        urllib.request.urlretrieve(url, f"{tmp_dir}/{name}")

def move_assets():
    """ Moves the downloaded assets to their destination
    """

    # move files to correct location
    print("Moving downloaded assets")
    for f in os.listdir(tmp_dir):

        # move mecab dynamic libraries to blobs to allow standalone testing
        if(f.startswith("libmecab")):
            shutil.copy(f"{tmp_dir}/{f}", "test/text/")

def init_submodules():

    print("Initalizing packages")

    subprocess.run(["git", "submodule", "init"])
    subprocess.run(["git", "submodule", "update"])

    base_dir = os.getcwd()

    os.chdir(f"{base_dir}/plugins/DaKanji-dependencies/flutter_appavailability")
    subprocess.run(["flutter", "pub", "get"], shell=True)

    os.chdir(f"{base_dir}/plugins/DaKanji-dependencies/liquid_swipe_flutter")
    subprocess.run(["flutter", "pub", "get"], shell=True)

    os.chdir(f"{base_dir}/plugins/DaKanji-Dictionary/database_builder")
    subprocess.run(["flutter", "pub", "get"], shell=True)

    os.chdir("../..")

def setup_dakanji_env():
    """
    """

    env_exists = os.path.isfile("dakanji.env")

    if(not env_exists):
       
        i = input("No dakanji.env file found!\n This will disable all online functionality, do you want to continue? (y)")

        if(i == "y"):
            shutil.copyfile("dakanji.env.template", "dakanji.env")
        else:
            print("aborting setup")
            sys.exit(-1)

def help() -> str:
    return """
        --download-all  : download all assets, this includes assets that are not needed to run dakanji on THIS platform
        --no_download   : Does NOT download any assets and expects to find all assets in a folder called 'tmp'
        --no-delete     : Do not delete the tmp folder
        --ignore-no-env : Should the setup continue even if no dakanji.env file is found
        """


def main():

    args = sys.argv[1:]

    if("--help" in args or "-h" in args):
        print(help())
        sys.exit(0)

    print("Setting up DaKanji")

    # switch to dev branch
    subprocess.run(["git", "checkout", "dev"], shell=True)
    subprocess.run(["git", "pull"], shell=True)

    init_submodules()
    if("--ignore-no-env" not in args):
        setup_dakanji_env()    

    # should all assets be downloaded regardelss of platform
    if("--download-all" not in args):
        exclude_files_per_platform()
    
    # Should the assets NOT be downloaded
    if("--no-download" not in args):
        release_url = get_release_url()
        download_assets(release_url)

    move_assets()

    # delete the tmp folder if not specified
    if("--no-delete" not in args):
        # delete temp dir
        print("Deleting temporary folder")
        shutil.rmtree(tmp_dir)

    subprocess.run(["flutter", "pub", "get"], shell=True)
    subprocess.run(["dart", "run", "build_runner", "build", "--delete-conflicting-outputs"], shell=True)

    print("Setup done! Run: \n flutter run")
    
if __name__ == "__main__":

    main()