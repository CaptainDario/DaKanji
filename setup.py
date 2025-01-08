import os
import json
import urllib.request
import shutil
import re
import sys
import subprocess


repo_url = "https://api.github.com/repos/CaptainDario/DaKanji-Dependencies/releases/tags/"
tmp_dir = "tmp"
move_to_blobs = ["libtensorflow", "libmecab"]
move_to_dict  = ["dict", "examples", "krad", "radk"]
move_to_tf_lite = ["CNN_single_char.tflite"]
files_to_exclude = ["audios.zip", "libtensorflowlite_c_arm64.dylib", "libtensorflowlite_c_x86_64.dylib"]
files_to_exclude_win = [
    "libtensorflowlite_c-mac.dylib",
    "libtensorflowlite_c_arm64.so", "libtensorflowlite_c_x86.so",
]
files_to_exclude_mac = [
    "libmecab_arm64.dll", "libmecab_x86.dll",
    "libtensorflowlite_c_x86.so",  "libtensorflowlite_c_arm64.so",
    "libtensorflowlite_c_x86.dll", "libtensorflowlite_c_arm64.dll"
]
files_to_exclude_lin = [
    "libmecab_arm64.dll", "libmecab_x86.dll",
    "libtensorflowlite_c_arm64.dll", "libtensorflowlite_c_x86.dll",
    "libtensorflowlite_c-mac.dylib",
]

release_url = None
assets_version = None


def exclude_files_per_platform():
    """ Excludes files that are not needed for the current platform
    """

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

def download_assets(url: str):
    """ Downloads all assets for DaKanji from the given url

    url : url to the assets release of DaKanji
    """

    # get url to latest download
    req = urllib.request.Request(url)
    asset_names, asset_urls = [], []
    with urllib.request.urlopen(req) as response:
        the_page = json.loads(response.read())
        print(json.dumps(the_page, sort_keys=True, indent=4))
        for k, v in the_page.items():
            if(k == "assets"):
                for asset in the_page[k]:
                    for aK, aV in asset.items():
                        if(aK == "browser_download_url"):
                            asset_urls.append(aV)
                        if(aK == "name"):
                            asset_names.append(aV)

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

        # move dynamic libraries to blobs
        if(f.startswith(tuple(move_to_blobs))):
            shutil.copy(f"{tmp_dir}/{f}", "blobs/")
        
        # move mecab_dict to assets
        if(f.startswith("mecab_dict")):
            shutil.copy(f"{tmp_dir}/mecab_dict.zip", "assets/")

        # move tf lite assets
        if(f.startswith(tuple(move_to_tf_lite))):
            shutil.copy(f"{tmp_dir}/{f}", "assets/tflite_models/")
        
        
        # move the dictionary related assets
        if(f.startswith(tuple(move_to_dict))):
            shutil.copy(f"{tmp_dir}/{f}", "assets/dict/")

def init_submodules():

    print("Initalizing packages")

    subprocess.run(["git", "submodule", "init"])
    subprocess.run(["git", "submodule", "update"])

    os.chdir("plugins/DaKanji-dependencies")
    subprocess.run(["flutter", "pub", "get"])

    os.chdir("../DaKanji-Dictionary")
    subprocess.run(["flutter", "pub", "get"])

    os.chdir("../flutter_browser_app")
    subprocess.run(["flutter", "pub", "get"])

    os.chdir("../..")

def setup_dakanji_env():

    env_exists = os.path.exists("dakanji.env")

    if(not env_exists):
       
        i = input("No dakanji.env file found!\n This will disable all online functionality, do you want to continue? (y)")

        if(i == "y"):
            shutil.copyfile("dakanji.env.template", "dakanji.env")
        else:
            print("aborting setup")
            sys.exit(-1)


def main():

    print("Setting up DaKanji")

    args = sys.argv[1:]

    # switch to dev branch
    subprocess.run(["git", "checkout", "dev"], shell=True)
    subprocess.run(["git", "pull"], shell=True)

    init_submodules()

    if("--help" in args or "-h" in args):
        print("""
        --download-all : download all assets, this includes assets that are not needed to run dakanji on THIS platform
        --no_download  : Does NOT download any assets and expects to find all assets in a folder called 'tmp'
        --no-delete    : Do not delete the tmp folder
        """)
        sys.exit(0)

    if("--download-all" not in args):
        exclude_files_per_platform()
    
    if("--no-download" not in args):
        release_url = get_release_url()
        download_assets(release_url)

    move_assets()

    if("--no-delete" not in args):
        # delete temp dir
        print("Deleting temporary folder")
        shutil.rmtree(tmp_dir)

    subprocess.run(["flutter", "pub", "get"])
    subprocess.run(["dart", "run", "build_runner", "build", "--delete-conflicting-outputs"])

    print("Setup done! Run: \n flutter run")
    
if __name__ == "__main__":

    main()