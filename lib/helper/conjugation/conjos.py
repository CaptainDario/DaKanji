import csv



source = "//based on conj.csv which was scraped from\n//https://gitlab.com/yamagoya/jmdictdb/-/tree/master/jmdictdb/data\n\n"
base_path = "./lib/helper/conjugation/"
file_name = "conjos"

def main():

    with open(f"{base_path}{file_name}.dart", mode="w+", encoding="utf8") as f:
        f.write(source)

        f.write("import 'conjo.dart';\n\n\n\n")

        f.write("// Convenience constants\n")
        f.write("const String f = 'f';\n")
        f.write("const String t = 't';\n\n")
        f.write("/// \n")
        f.write("const List<Conjo> conjos = [\n")

        with open(f"{base_path}{file_name}.csv", newline='', encoding="utf8") as csvfile:

            conj_reader = csv.reader(csvfile, delimiter='\t', quotechar='|')

            for row in conj_reader:
                if(row[0] == "pos"):
                    continue

                entry = f"\tConjo({', '.join(row[:6])}, '{row[6]}'"
                if(row[7] != ""):
                    entry += f", euphr: '{row[7]}'"
                if(row[8] != ""):
                    entry += f", euphk: '{row[8]}'"
                f.write(entry + "),\n")
        
        f.write("];")




if __name__ == "__main__":
    main()