##########################################
#  
# This script removes empty translations from the localization files.
# It also generates the dart files for the localizations.
#
##########################################


import os
import subprocess
import json



if __name__ == "__main__":

    # create separate json files for every langauge
    with open("assets/translations/localizations.json", "r", encoding="utf8") as f:
        languages = ["en", "de", "ru", "jp", "cn", "it", "fr", "es"]
        f_content = f.read()
        for code in languages:
            jason_dict = json.loads(f_content)

            for category, category_children in jason_dict.items():
                for category_entry, localizations in category_children.items():
                    if(category_entry == ""):
                        del jason_dict[category][category_entry]
                    if(code in localizations):
                        jason_dict[category][category_entry] = localizations[code]
                    #else:
                    #    del jason_dict[category][category_entry] 
            
            js = json.dumps(jason_dict, indent=2, sort_keys=True)
            with open(f"assets/translations/{code}.json", "w+", encoding="utf8") as f:
                f.write(js)


    # run the dart commands to generate the dart localizations files
    shared_args = ["flutter", "pub", "run", "easy_localization:generate", "-S", "assets/translations/", "-O", "./lib", "-o",]
    subprocess.call([*shared_args, "locales_keys.dart", "-f", "keys"], shell=True)
    subprocess.call([*shared_args, "CodegenLoader.dart", "-f", "json"], shell=True)


    # remove empty translations
    path = os.path.join(os.getcwd(), "lib", "CodegenLoader.dart")

    f = []
    with open(path, encoding="utf8", mode="r") as file:
        f = file.readlines()
        
        # remove all lines which have empty translations
        for cnt, line in enumerate(f):
            if (': ""' in line):
                del f[cnt]
    
    # save the files back to disk
    with open(path, encoding="utf8", mode="w+") as file:
        file.write("".join(f))


