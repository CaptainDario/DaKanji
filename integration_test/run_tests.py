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
    device, additional_args = "", ""

    # copy the tf lite binaries
    if platform == "linux" or platform == "linux2":
        device = "linux"
        additional_args += "--profile"

    # MacOS
    elif platform == "darwin":

        if(arg.startswith("ios_")):
            device = arg.replace("ios_", "")
        else:
            device = "macos"
            additional_args += "--profile"

    # Windows
    elif platform == "win32":
        device = "windows"
        additional_args += "--profile"
    
    if(arg == "android"):
        device = "emulator"


    # run all tests
    for file in os.listdir("integration_test"):
        if(file.endswith("_test.dart")):
            command =  "xvfb-run flutter drive "
            command += "--driver=test_driver/integration_test.dart "
            command += "--target=integration_test/draw_screen_test.dart "
            command += f"-d {device} "
            command += additional_args
            print(f"Executing: {command}")
            ret_val = subprocess.run(command, shell=True)
            if(ret_val.returncode != 0):
                print(f"Error in {file}, returned {ret_val}")
                sys.exit(-1)
            