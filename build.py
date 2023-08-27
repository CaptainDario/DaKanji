import subprocess
import platform
import os
import argparse



def parse_args():
    """ Parse the commandline arguments
    """

    parser = argparse.ArgumentParser(description='Helper script to build dakanji')


    # --- LINUX -------------------------------------------------- 
    parser.add_argument('--linux'  , action='store_true', help='Build portable linux executable')
    parser.add_argument('--flatpak', action='store_true', help='Build flatpak (requires --linux)')
    parser.add_argument('--snap'   , action='store_true', help='Build snap')
    parser.add_argument('--la'     , action='store_true', help='Build portable, flatpak, snap')
    
    args = parser.parse_args()

    return args

def build_linux():
    """ Builds a portable linux application and a zipped version
    """

    subprocess.run("flutter build linux --release", shell=True)
    if(os.path.isfile("./build/linux/x64/release/bundle/DaKanji.zip")):
        os.remove("./build/linux/x64/release/bundle/DaKanji.zip")
    subprocess.run("zip -r ./build/linux/x64/release/bundle/DaKanji.zip ./build/linux/x64/release/bundle/", shell=True)

def build_snap():
    """ Builds a snap
    """

    subprocess.run("snapcraft")

def build_flatpak():
    """ Builds a flatpak on linux.
    Updates the file "flatpak/com.DaAppLab.DaKanji.metainfo.xml"
    """

    # update description
    with open("flatpak/com.DaAppLab.DaKanji.metainfo.xml", mode="r") as f:
        current_version = f.read()
    

    # create repo
    subprocess.run("flatpak-builder --force-clean build-dir flatpak/com.DaAppLab.DaKanji.json --repo=repo")
    # creat 
    subprocess.run("flatpak build-bundle repo com.DaAppLab.DaKanji.flatpak com.DaAppLab.DaKanji")



if __name__ == "__main__":
    
    args = parse_args()
    
    if(platform.system() == "Linux"):

        print(f"Building on Linux")
        
        if(args.linux or args.flatpak or args.la):
            print("Starting building portable linux application")
            build_linux()
            print("Finished building portable linux application\n")

        if(args.snap or args.la):
            print("Starting building snap")
            build_snap()
            print("Finished building snap\n")

        if(args.flatpak or args.la):
            print("Starting building flatpak")
            build_flatpak()
            print("Finished building flatpak\n")
