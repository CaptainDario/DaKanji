


iso639_1  = "iso639_1"
iso639_2T = "iso639_2T"
iso639_2B = "iso639_2B"
iso639_3  = "iso639_3"

is_warning = """/// 
/// Note: ISO code `is` has been renamed to `is_` because it conflicts with dart's 
/// keyword `is`
"""

def main():

    # read the iso table from wikipedia
    content = []
    with open("./lib/helper/iso/iso_table.txt", mode="r", encoding="utf-8") as f:
        for line in f.readlines():
            line = line.replace("\n", "")
            line = line.split("\t")

            # remove the plus annotations and rename the code `is` to `is_`
            for c, i in enumerate(line):
                if("+" in i):
                    line[c] = i[:(i.index('+')) - 1]
                if("is" == i):
                    line[c] = "is_"

            content.append(line)

            

    # open a new dart file to write the processed data
    with open("./lib/helper/iso/iso_table.dart", mode="w+", encoding="utf-8") as f:

        # credits
        f.write("// based on iso_table.txt which was scraped from")
        f.write("// https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes\n\n\n\n")

        # iterate over the different language codes
        for cnt, iso in enumerate([iso639_1, iso639_2T, iso639_2B, iso639_3]):
            # write the enum containing all codes for this langauge
            f.write(f"/// Enum containing the {iso} codes for languages\n")
            if(cnt == 0):
                f.write(is_warning)
            f.write(f"enum {iso}" + "{\n\t")
            for c, i in enumerate(content, start=1):

                f.write(str(i[cnt+1]) + ", ")
                
                if(c % 15 == 0 and c > 0):
                    f.write("\n\t")
            f.write("\n}\n\n")

            f.write(f"/// Map to convert ISO 639-1, 639-1, 639-1, 639-1, to an enum entry of `{iso}`\n{is_warning}")
            f.write(f"const Map<String, {iso}> isoTo{iso} = const" + " {\n")
            for i in content:
                i_new = list(dict.fromkeys(i[1:5]))
                for j in range(len(i_new)):
                    f.write(f"\t'{i_new[j]}' : {iso}.{i[cnt+1]},")
                f.write("\n")
            f.write("\n};\n\n\n")

        # create a Map from ISO code to full language name
        f.write(f"/// Map to convert ISO 639-1, 639-1, 639-1, 639-1, to an language string\n")
        f.write(f"const Map<Enum, String> isoToLanguage = const" + " {\n")
        for c in content:
            f.write(f"\t{iso639_1}.{c[1]} : '{c[0]}', ")
            f.write(f"{iso639_2T}.{c[2]} : '{c[0]}', \n")
            f.write(f"\t{iso639_2B}.{c[3]} : '{c[0]}', ")
            f.write(f"{iso639_3}.{c[4]} : '{c[0]}',\n\n")
        f.write("};")

if __name__ == "__main__":
    main()
