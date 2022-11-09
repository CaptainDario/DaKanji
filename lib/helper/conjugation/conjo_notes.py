import csv



source = "//based on conjo_notes.csv which was scraped from\n//https://gitlab.com/yamagoya/jmdictdb/-/tree/master/jmdictdb/data\n\n"
base_path = "./lib/helper/conjugation/"
file_name = "conjo_notes"

def main():

    with open(f"{base_path}{file_name}.dart", mode="w+", encoding="utf8") as f:
        f.write(source)
        f.write("import 'conjo_note.dart';\n\n\n\n")
        f.write("/// \n")
        f.write("const String f = 'f';\n")
        f.write("/// \n")
        f.write("const String t = 't';\n\n")
        f.write("/// \n")
        f.write("const List conjo_notes = [\n")

        with open(f"{base_path}{file_name}.csv", newline='') as csvfile:

            conj_reader = csv.reader(csvfile, delimiter='\t', quotechar='|')

            for row in conj_reader:
                if(row[0] == "pos"):
                    continue
                f.write(f"\tConjoNote({', '.join(row)}),\n")
        
        f.write("];")



if __name__ == "__main__":
    main()