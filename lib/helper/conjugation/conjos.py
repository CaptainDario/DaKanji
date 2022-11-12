import csv



source = "//based on conj.csv which was scraped from\n//https://gitlab.com/yamagoya/jmdictdb/-/tree/master/jmdictdb/data\n\n"
base_path = "./lib/helper/conjugation/"
file_name = "conjos"

def main():

    with open(f"{base_path}{file_name}.dart", mode="w+", encoding="utf8") as f:
        f.write(source)

        f.write("import 'conjo.dart';\n")
        f.write("import 'conj.dart';\n")
        f.write("import 'kwpos.dart';\n\n\n\n")

        f.write("// Convenience constants\n")
        f.write("const bool f = false;\n")
        f.write("const bool t = true;\n\n")
        f.write("/// \n")
        f.write("List<Conjo> conjos = [\n")

        with open(f"{base_path}{file_name}.csv", newline='', encoding="utf8") as csvfile:

            conj_reader = csv.reader(csvfile, delimiter='\t', quotechar='|')

            for row in conj_reader:
                if(row[0] == "pos"):
                    continue

                entry = f"\tConjo(posIdToPosEnum[{row[0]}]!, conjIdToConjEnum[{row[1]}]!, {', '.join(row[2:6])}, '{row[6]}'"
                if(row[7] != ""):
                    entry += f", euphr: '{row[7]}'"
                if(row[8] != ""):
                    entry += f", euphk: '{row[8]}'"
                f.write(entry + "),\n")
        
        f.write("];")

        f.write("\n\n/// A list with all `Pos` elements for which a conjugation is available\n")
        f.write("List<Pos> posUsed = [\n")

        with open(f"{base_path}{file_name}.csv", newline='', encoding="utf8") as csvfile:

            conj_reader = csv.reader(csvfile, delimiter='\t', quotechar='|')

            included = []
            for row in conj_reader:
                if(row[0] == "pos"):
                    continue
                if(row[0] not in included):
                    included.append(row[0])
                    f.write(f"\tposIdToPosEnum[{row[0]}]!,\n")
        
        f.write("];")

        f.write("\n\n/// A list with all Ids elements for which a conjugation is available\n")
        f.write("List<int> posIdsUsed = [\n")

        with open(f"{base_path}{file_name}.csv", newline='', encoding="utf8") as csvfile:

            conj_reader = csv.reader(csvfile, delimiter='\t', quotechar='|')

            included = []
            for row in conj_reader:
                if(row[0] == "pos"):
                    continue
                if(row[0] not in included):
                    included.append(row[0])
                    f.write(f"\t{row[0]},\n")
        
        f.write("];")





if __name__ == "__main__":
    main()