import os
import json
import urllib.request
import shutil
import zipfile


repo_url = "https://api.github.com/repos/CaptainDario/DaKanji-Dependencies/releases/latest"
tmp_dir = "tmp"
move_to_blobs = ["libtensorflow", "libmecab"]



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
        print(f"Downloading: {name}")
        urllib.request.urlretrieve(url, f"{tmp_dir}/{name}")

def move_assets():
    """ Moves the downloaded assets to their destination
    """

if __name__ == "__main__":

    print("Setting up DaKanji")
    download_latest()

    # move files to correct location
    print("Moving downloaded assets")
    for f in os.listdir(tmp_dir):

        # move dynamic libraries to blobs
        if(f.startswith(tuple(move_to_blobs))):
            shutil.move(f"{tmp_dir}/{f}", "blobs/")
        
        # move ipadic to assets and unpack
        if(f.startswith("ipadic")):
            with zipfile.ZipFile(f"{tmp_dir}/ipadic.zip", 'r') as zip_ref:
                zip_ref.extractall("assets/")

        # move the dictionary database to assets
        if(f.startswith("dict")):
            shutil.move(f"{tmp_dir}/{f}", "assets/dict/")

        

    # delete temp dir
    print("Deleting temporary folder")
    shutil.rmtree(tmp_dir)