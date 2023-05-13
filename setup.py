import os
import json
import urllib.request
import shutil
import zipfile
import sys


repo_url = "https://api.github.com/repos/CaptainDario/DaKanji-Dependencies/releases/latest"
tmp_dir = "tmp"
move_to_blobs = ["libtensorflow", "libmecab"]
move_to_dict  = ["dict", "examples", "krad"]
files_to_exclude = ["audios.zip", "libtensorflowlite_c_arm64.dylib", "libtensorflowlite_c_x86_64.dylib"]



def download_latest():
    """ Downloads all assets for DaKanji
    """

    # get url to latest download
    req = urllib.request.Request(repo_url)
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

if __name__ == "__main__":

    print("Setting up DaKanji")

    # exclude files for current platform
    if(sys.platform.startswith("win32")):
        files_to_exclude.append("libtensorflowlite_c-mac.so")
        files_to_exclude.append("libtensorflowlite_c-linux.so")
    elif(sys.platform.startswith("darwin")):
        files_to_exclude.append("libtensorflowlite_c-linux.so")
        files_to_exclude.append("libtensorflowlite_c-win.dll")
        files_to_exclude.append("libmecab_x86.dll")
    elif(sys.platform.startswith("linux")):
        files_to_exclude.append("libtensorflowlite_c-mac.so")
        files_to_exclude.append("libtensorflowlite_c-win.dll")
        files_to_exclude.append("libmecab_x86.dll")

    download_latest()

    # move files to correct location
    print("Moving downloaded assets")
    for f in os.listdir(tmp_dir):

        # move dynamic libraries to blobs
        if(f.startswith(tuple(move_to_blobs))):
            shutil.copy(f"{tmp_dir}/{f}", "blobs/")
        
        # move ipadic to assets and unpack
        if(f.startswith("ipadic")):
            shutil.copy(f"{tmp_dir}/ipadic.zip", "assets/")

        # move the dictionary database to assets
        if(f.startswith(tuple(move_to_dict))):
            shutil.copy(f"{tmp_dir}/{f}", "assets/dict/")

        

    # delete temp dir
    print("Deleting temporary folder")
    shutil.rmtree(tmp_dir)