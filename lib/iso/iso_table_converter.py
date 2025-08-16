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
    with open("./lib/iso/iso-639-3_20230123.tab", mode="r", encoding="utf-8") as f:
        #skip header
        f.readline()
        for line in f.readlines():
            line = line.replace("\n", "")
            line = line.split("\t")

            # remove scope, language and comment field fields
            del line[4:6]; del line[5]

            # rename codes that conflict with dart keywords, or that are not valid in strings
            for c, i in enumerate(line):
                if(i in ["is", "new", "try", "for", "var"]):
                    line[c] = i + "_"
                if("'" in i or "’" in i):
                    line[c] = line[c].replace("'", "").replace("’", "")

            # append the data in the format [Ref_name, iso_1, iso_2T, iso_2B, iso_3]
            content.append(line[::-1])

    # open a new dart file to write the processed data
    with open("./lib/iso/iso_table.dart", mode="w+", encoding="utf-8") as f:

        # credits
        f.write("// based on iso_table.txt which was scraped from")
        f.write("// https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes\n\n\n\n")

        # iterate over the different language codes
        for cnt, iso in enumerate([iso639_1, iso639_2T, iso639_2B, iso639_3][:1]):
            # write the enum containing all codes for this langauge
            f.write(f"/// Enum containing the {iso} codes for languages\n")
            if(cnt == 0):
                f.write(is_warning)
            f.write(f"enum {iso}" + "{\n\t")
            
            c = 1
            for i in content:
                if(i[1] == ""):
                    continue
                f.write(r"// " + str(i[0]) + ", \n\t")
                f.write(str(i[cnt+1]) + ", \n\t")
                c += 1
            f.write("\n}\n\n")

            f.write(f"/// Map to convert ISO 639-1, 639-1, 639-1, 639-1, to an enum entry of `{iso}`\n{is_warning}")
            f.write(f"const Map<String, {iso}> isoTo{iso} = const" + " {\n")
            c = 1
            for i in content:
                i_new = list(dict.fromkeys(i[1:5]))
                for j in range(len(i_new)):
                    if(i[cnt+1] == "" or i_new[j] == ""):
                        continue
                    f.write(f"\t'{i_new[j]}' : {iso}.{i[cnt+1]},")
                    c += 1
                    f.write("\n")
            f.write("\n};\n\n\n")

        # create a Map from ISO code to full language name
        f.write(f"/// Map to convert ISO 639-1, 639-2, 639-2T, 639-3, to an language string\n")
        f.write(f"const Map<Enum, String> isoToLanguage = const" + " {\n")
        cnt = 0
        for c in content:
            if(c[1] != ""):
                f.write(f"\t{iso639_1}.{c[1]} : '{c[0]}', ")
                cnt += 1
                f.write("\n")
                
        f.write("};")

        # create a Map from language name to ISO codes
        f.write(f"/// Map to convert ISO 639-1, to a language string\n")
        f.write(f"const Map<String, {iso639_1}> languageToIso639_1 = " + " {\n")
        cnt = 0
        for c in content:
            if(c[1] != ""):
                f.write(f"\t'{c[0]}' : {iso639_1}.{c[1]} , ")
                cnt += 1
                f.write("\n")

        f.write("};")

if __name__ == "__main__":
    main()
