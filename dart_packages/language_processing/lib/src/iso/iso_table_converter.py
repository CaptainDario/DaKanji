### Data source: https://iso639-3.sil.org/code_tables/download_tables#639-3%20Code%20Set

iso639_1  = "Iso639_1"
iso639_2T = "Iso639_2T"
iso639_2B = "Iso639_2B"
iso639_3  = "Iso639_3"

is_warning = """/// 
/// Note: Some ISO codes have been because of conflicts with dart's keywords.
/// `is` -> `is_` 
/// `new` -> `new_`
/// `for` -> `for_`
"""

def main():

    # read the iso table from sil.org
    content = []
    with open("iso-639-3_20230123.tab", mode="r", encoding="utf-8") as f:
        #skip header
        f.readline()
        for line in f.readlines():
            line = line.replace("\n", "")
            line = line.split("\t")

            # remove scope, language and comment field fields
            del line[4:6]; del line[5]

            # rename codes that conflict with dart keywords, or that are not valid in strings
            for c, i in enumerate(line):
                if(i in ["is", "new", "try", "for", "var", "do", "if", "in", "else", "assert", "switch", "case", "default", "break", "continue", "return", "true", "false", "null", "super", "this", "extends", "with", "implements", "class", "enum", "interface", "abstract", "final", "const", "static", "void", "dynamic", "import", "export", "library", "part", "native", "external", "typedef", "operator", "get", "set", "async", "await", "yield"]):
                    line[c] = i + "_"
                if("'" in i or "’" in i):
                    line[c] = line[c].replace("'", "").replace("’", "")

            # append the data in the format [Ref_name, iso_1, iso_2T, iso_2B, iso_3]
            content.append(line[::-1])

    # open a new dart file to write the processed data
    with open("iso_table.dart", mode="w+", encoding="utf-8") as f:

        # linter ignore for camel case types
        f.write("// ignore_for_file: camel_case_types\n\n")

        # credits
        f.write("// based on iso_table.txt which was scraped from")
        f.write("// https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes\n\n\n\n")

        # iterate over ALL the different language codes
        for cnt, iso in enumerate([iso639_1, iso639_2T, iso639_2B, iso639_3]):
            
            # 1. Write the Enum
            f.write(f"/// Enum containing the {iso} codes for languages\n")
            f.write(is_warning)
            f.write(f"enum {iso}" + "{\n\t")
            
            c = 1
            for i in content:
                # Check if the code exists for the current ISO level (index: cnt+1)
                if(i[cnt+1] == ""):
                    continue
                f.write(r"// " + str(i[0]) + ", \n\t")
                f.write(str(i[cnt+1]) + ", \n\t")
                c += 1
            f.write("\n}\n\n")

            # 2. Write the Map: String (Any ISO Code) -> Enum Entry (Current ISO Level)
            f.write(f"/// Map to convert ISO 639-1, 639-2, 639-3, to an enum entry of `{iso}`\n{is_warning}")
            f.write(f"const Map<String, {iso}> isoTo{iso} = " + " {\n")
            c = 1
            for i in content:
                # If this language doesn't have a code for the current ISO level, skip it
                if(i[cnt+1] == ""):
                    continue
                
                # Get all available codes (1, 2T, 2B, 3) for this row to map them all to the current enum
                i_new = list(dict.fromkeys(i[1:5]))
                for j in range(len(i_new)):
                    if(i_new[j] == ""):
                        continue
                    f.write(f"\t'{i_new[j]}' : {iso}.{i[cnt+1]},")
                    c += 1
                    f.write("\n")
            f.write("\n};\n\n\n")

            # 3. Write the Map: Enum Entry (Current ISO Level) -> Full Language Name
            # Construct variable name like iso639_1ToLanguage
            map_name_to_lang = f"{iso[0].lower() + iso[1:]}ToLanguage"
            
            f.write(f"/// Map to convert {iso} to a language string\n")
            f.write(f"const Map<{iso}, String> {map_name_to_lang} = " + " {\n")
            
            for c in content:
                if(c[cnt+1] != ""):
                    f.write(f"\t{iso}.{c[cnt+1]} : '{c[0]}', ")
                    f.write("\n")
            f.write("};\n\n\n")

            # 4. Write the Map: Full Language Name -> Enum Entry (Current ISO Level)
            map_name_from_lang = f"languageTo{iso}"

            f.write(f"/// Map to convert a language string to {iso}\n")
            f.write(f"const Map<String, {iso}> {map_name_from_lang} = " + " {\n")
            
            # Keep track of keys we have already written to avoid duplicates (which break const Maps)
            used_keys = set()

            for c in content:
                if(c[cnt+1] != ""):
                    lang_name = c[0]
                    code = c[cnt+1]

                    # If the language name already exists as a key, append the code to make it unique
                    # Example: "Gadang" -> "Gadang (gdk)"
                    if lang_name in used_keys:
                        lang_name = f"{lang_name} ({code})"

                    # Check again just in case the new name also conflicts (unlikely but safe)
                    if lang_name in used_keys:
                        continue 

                    f.write(f"\t'{lang_name}' : {iso}.{code} , ")
                    f.write("\n")
                    used_keys.add(lang_name)

            f.write("};\n\n\n")

if __name__ == "__main__":
    main()