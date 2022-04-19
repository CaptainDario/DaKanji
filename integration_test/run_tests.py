import subprocess
import os
import sys



if __name__ == "__main__":

    for file in os.listdir("integration_test"):
        if(file.endswith("_test.dart")):
            ret_val = subprocess.run(f"flutter test ./integration_test/{file}", shell=True)
            if(ret_val.returncode != 0):
                print(f"Error in {file}, returned {ret_val}")
                sys.exit(-1)
            