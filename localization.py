##########################################
#  
# This script removes empty translations from the localization files.
# It also generates the dart files for the localizations.
#
##########################################


import os
import subprocess
import json
import re

def main():
    # delete old localization files
    for f in os.listdir("assets/translations/"):
        if(f != "localizations.json"):
            os.remove(f"assets/translations/{f}")
    os.remove("lib/CodegenLoader.dart")
    os.remove("lib/locales_keys.dart")

    # create separate json files for every langauge
    with open("assets/translations/localizations.json", "r", encoding="utf8") as f:
        with open("lib/globals.dart", "r", encoding="utf8") as f_globals:
            languages = f_globals.read()
            languages_filtered = re.search("SUPPORTED_LANGUAGES = (.*);", languages).groups()[0]
            print("found following supported languages:", languages_filtered)
            languages = eval(languages_filtered)
        f_content = f.read()
        for code in languages:
            jason_dict = json.loads(f_content)
            localization = {}

            for category, category_children in jason_dict.items():
                if(category not in localization):
                    localization[category] = {}
                for category_entry, localizations in category_children.items():
                    if(code in localizations and category_entry != ""):
                        localization[category][category_entry] = localizations[code]
                    else:
                        localization[category][category_entry] = ""
            
            js = json.dumps(localization, indent=2, sort_keys=True)
            with open(f"assets/translations/{code}.json", "w+", encoding="utf8") as f:
                f.write(js)


    # run the dart commands to generate the dart localizations files
    shared_args = ["flutter", "pub", "run", "easy_localization:generate", "-S", "assets/translations/", "-O", "./lib", "-o",]
    subprocess.call([*shared_args, "locales_keys.dart", "-f", "keys"], shell=True)
    subprocess.call([*shared_args, "CodegenLoader.dart", "-f", "json"], shell=True)


    # remove empty translations
    path = os.path.join(os.getcwd(), "lib", "CodegenLoader.dart")

    f, f_without_empties = [], []
    with open(path, encoding="utf8", mode="r") as file:
        f = file.readlines()
        
        # remove all lines which have empty translations
        for cnt, line in enumerate(f):
            if (not '": ""' in line and not ": null" in line):
                f_without_empties.append(line)

    # save the files back to disk
    with open(path, encoding="utf8", mode="w+") as file:
        file.write("".join(f_without_empties))

if __name__ == "__main__":

    main()


