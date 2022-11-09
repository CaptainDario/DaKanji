import csv



source = "//based on kwpos.csv which was scraped from\n//https://gitlab.com/yamagoya/jmdictdb/-/tree/master/jmdictdb/data\n\n"
base_path = "./lib/helper/conjugation/"
file_name = "kwpos"

def main():

    with open(f"{base_path}{file_name}.dart", mode="w+", encoding="utf8") as f:
        f.write(source)

        f.write("import 'pos.dart';\n\n\n\n")

        f.write("/// A map from the id to the pos description\n")
        f.write("const Map<int, Pos> conj = {\n")

        with open(f"{base_path}{file_name}.csv", newline='') as csvfile:

            conj_reader = csv.reader(csvfile, delimiter='\t', quotechar='|')

            for row in conj_reader:
                if(row[0] == "id"):
                    continue

                r2 = row[2].replace("'", '"')
                f.write(f"\t{row[0]} : Pos('{row[1]}', '{r2}'),\n")
        
        f.write("};")




if __name__ == "__main__":
    main()