import os
import json
import urllib.request
import shutil
import re
import sys


repo_url = "https://api.github.com/repos/CaptainDario/DaKanji-Dependencies/releases/tags/"
tmp_dir = "tmp"
move_to_blobs = ["libtensorflow", "libmecab"]
move_to_dict  = ["dict", "examples", "krad", "radk"]
move_to_tf_lite = ["CNN_single_char.tflite"]
files_to_exclude = ["audios.zip", "libtensorflowlite_c_arm64.dylib", "libtensorflowlite_c_x86_64.dylib"]

release_url = None
assets_version = None


def exclude_files_per_platform():
    """ Excludes files that are not needed for the current platform
    """

    if(sys.platform.startswith("win32")):
        files_to_exclude.append("libtensorflowlite_c-mac.dylib")
        files_to_exclude.append("libtensorflowlite_c-linux.so")
    elif(sys.platform.startswith("darwin")):
        files_to_exclude.append("libtensorflowlite_c-linux.so")
        files_to_exclude.append("libtensorflowlite_c-win.dll")
        files_to_exclude.append("libmecab.dll")
    elif(sys.platform.startswith("linux")):
        files_to_exclude.append("libtensorflowlite_c-mac.dylib")
        files_to_exclude.append("libtensorflowlite_c-win.dll")
        files_to_exclude.append("libmecab.dll")

def get_release_url():
    """ gets the url to the latest assets release of DaKanji
    """

    with open("pubspec.yaml", mode="r") as f:
        content = f.read()
        m = re.search(r'version: (.*)\+', content)
        assets_version = m.group(1)
        print("Downloading assets for version: ", assets_version)

    return repo_url + "v" + assets_version

def download_assets():
    """ Downloads all assets for DaKanji
    """

    # get url to latest download
    req = urllib.request.Request(release_url)
    asset_names, asset_urls = [], []
    with urllib.request.urlopen(req) as response:
        the_page = json.loads(response.read())
        print(f"Using release: {the_page['name']}")
        #print(json.dumps(the_page, sort_keys=True, indent=4))
        for i in the_page["assets"]:
            for k, v in i.items():
                if(k == "browser_download_url"):
                    asset_urls.append(v)
                if(k == "name"):
                    asset_names.append(v)

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
        
        # move ipadic assets
        if(f.startswith("ipadic")):
            shutil.copy(f"{tmp_dir}/ipadic.zip", "assets/")

        # move tf lite assets
        if(f.startswith(tuple(move_to_tf_lite))):
            shutil.copy(f"{tmp_dir}/{f}", "assets/tflite_models/")
        
        
        # move the dictionary related assets
        if(f.startswith(tuple(move_to_dict))):
            shutil.copy(f"{tmp_dir}/{f}", "assets/dict/")



if __name__ == "__main__":

    print("Setting up DaKanji")

    args = sys.argv[1:]

    if("--help" in args or "-h" in args):
        print("""
        --download-all : download all assets, this includes assets that are not needed to run dakanji on THIS platform
        --no_download  : Does NOT download any assets and expects to find all assets in a folder called 'tmp'
        --no-delete    : Do not delete the tmp folder
        """)
        sys.exit(0)

    if("--download-all" not in args):
        exclude_files_per_platform()
    
    if("--no_download" not in args):
        release_url = get_release_url()
        download_assets()

    move_assets()

    if("--no-delete" not in args):
        # delete temp dir
        print("Deleting temporary folder")
        shutil.rmtree(tmp_dir)

    print("Setup done! Run: \n flutter run")
    