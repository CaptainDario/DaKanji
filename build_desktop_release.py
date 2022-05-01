##########################################################
#                                                        #
# Builds release version of DaKanji                      #
#                                                        #
##########################################################

import os
import subprocess
import sys
from sys import platform
import shutil


linux_blob_dir = "build/"
macos_blob_dir = "build/macos/Build/Products/Release/da_kanji_mobile.app/Contents/Resources/blobs/"
windows_blob_dir = "build/windows/runner/Release/blobs/"

linux_tf = "libtensorflowlite_c-linux.so"
macos_tf = "libtensorflowlite_c-mac.dylib"
win_tf = "libtensorflowlite_c-win.dll"


if __name__ == "__main__":


    # Linux
    if platform == "linux" or platform == "linux2":
        subprocess.run("flutter build linux --release", shell=True)
        os.makedirs(os.path.dirname("build/linux/x64/release/bundle/blobs/"), exist_ok=True)
        shutil.copy("blobs/libtensorflowlite_c-linux.so", "build/linux/x64/release/bundle/blobs/")

    # MacOS
    elif platform == "darwin":
        subprocess.run("flutter build macos --release", shell=True)

    # Windows
    elif platform == "win32":
        subprocess.run("flutter build windows --release", shell=True)
        os.makedirs(os.path.dirname("build/windows/runner/release/blobs/"), exist_ok=True)
        shutil.copy("blobs/libtensorflowlite_c-win.dll", "build/windows/runner/release/blobs/")
