import subprocess
import os
import sys
from sys import platform
import shutil



tf_lite_win = ""


if __name__ == "__main__":

    if(len(sys.argv) > 1):
        arg = sys.argv[1]
    else:
        arg = ""

    # the device to run the tests on
    device = ""

    # copy the tf lite binaries
    if platform == "linux" or platform == "linux2":
        #os.makedirs(os.path.dirname("build/linux/x64/debug/blobs/"), exist_ok=True)
        #shutil.copy("blobs/libtensorflowlite_c-linux.so", "build/linux/x64/debug/blobs/")

        device = "linux"

    # MacOS
    elif platform == "darwin":

        if(arg.startswith("ios_")):
            device = arg.replace("ios_", "")
        else:
            device = "macos"

    # Windows
    elif platform == "win32":
        #os.makedirs(os.path.dirname("build/windows/runner/Debug/blobs/"), exist_ok=True)
        #shutil.copy("blobs/libtensorflowlite_c-win.dll", "build/windows/runner/Debug/blobs/")

        device = "windows"
    
    if(arg == "android"):
        device = "emulator"


    # run all tests
    for file in os.listdir("integration_test"):
        if(file.endswith("_test.dart")):
            command =  "flutter drive "
            command += "--driver=test_driver/integration_test.dart "
            command += "--target=integration_test/draw_screen_test.dart "
            command += f"-d {device} "
            command += "--profile "
            ret_val = subprocess.run(command, shell=True)
            if(ret_val.returncode != 0):
                print(f"Error in {file}, returned {ret_val}")
                sys.exit(-1)
            