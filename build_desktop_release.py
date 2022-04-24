##########################################################
#                                                        #
# Builds release version of DaKanji                      #
#                                                        #
##########################################################

import os
import subprocess
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

        # flatpak
        # flatpak run org.flatpak.Builder --force-clean ./build/flatpak  com.daapplab.dakanji.json
        # 


    # MacOS
    elif platform == "darwin":
        subprocess.run("flutter build macos --release", shell=True)

    # Windows
    elif platform == "win32":
        subprocess.run("flutter build windows --release", shell=True)

        if(not os.path.isdir(windows_blob_dir)):
            os.mkdir(windows_blob_dir)

        if(not os.path.isfile(windows_blob_dir + win_tf)):
            shutil.copyfile("blobs/" + win_tf, windows_blob_dir + win_tf)
