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
import platform



def main():
    # delete old localization files
    for f in os.listdir("assets/translations/languages/"):
        os.remove(f"assets/translations/languages/{f}")
    if(os.path.exists("lib/CodegenLoader.dart")):
        os.remove("lib/CodegenLoader.dart")
    if(os.path.exists("lib/locales_keys.dart")):
        os.remove("lib/locales_keys.dart")

    # create separate json files for every langauge
    with open("assets/translations/localizations.json", "r", encoding="utf8") as f:
        with open("lib/globals.dart", "r", encoding="utf8") as f_globals:
            languages = f_globals.read()
            languages_filtered = re.search("g_DaKanjiLocalizations = (.*);", languages).groups()[0]
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
                    if(code in localizations.keys() and category_entry != ""):
                        localization[category][category_entry] = localizations[code]
                    else:
                        localization[category][category_entry] = ""
            
            js = json.dumps(localization, indent=2, sort_keys=True)
            with open(f"assets/translations/languages/{code}.json", "w+", encoding="utf8") as f:
                f.write(js)


    # run the dart commands to generate the dart localizations files
    shared_args = ["flutter", "pub", "run", "easy_localization:generate", "-S", "assets/translations/languages/", "-O", "./lib", "-o",]
    subprocess.call([*shared_args, "locales_keys.dart", "-f", "keys"], shell= True if platform.system() == "Windows" else False)
    subprocess.call([*shared_args, "CodegenLoader.dart", "-f", "json"], shell= True if platform.system() == "Windows" else False)

    # remove empty translations
    path = os.path.join(os.getcwd(), "lib")

    f, f_without_empties = [], []
    with open(os.path.join(path, "CodegenLoader.dart"), encoding="utf8", mode="r") as file:
        f = file.readlines()
        
        # remove all lines which have empty translations
        for cnt, line in enumerate(f):
            if (not '": ""' in line and not ": null" in line):
                f_without_empties.append(line)

    # save the files back to disk
    with open(os.path.join(path, "CodegenLoader.dart"), encoding="utf8", mode="w+") as file:
        file.write("".join(f_without_empties))

if __name__ == "__main__":

    main()


