import csv



source = "//based on kwpos.csv which was scraped from\n//https://gitlab.com/yamagoya/jmdictdb/-/tree/master/jmdictdb/data\n\n\n\n"
base_path = "./lib/helper/conjugation/"
file_name = "kwpos"

def main():

    with open(f"{base_path}{file_name}.dart", mode="w+", encoding="utf8") as f:
        f.write(source)

        f.write("/// An enum containing the pos tags to identify pos elements\n")
        f.write("enum Pos {\n")

        with open(f"{base_path}{file_name}.csv", newline='') as csvfile:

            conj_reader = csv.reader(csvfile, delimiter='\t', quotechar='|')

            for row in conj_reader:
                if(row[0] == "id"):
                    continue

                f.write(f"\t{row[1].replace('-', '_')},\n")
        
        f.write("}\n\n")

        f.write("/// A map from the pos-ids to the matching enum\n")
        f.write("const Map<int, Pos> posIdToPosEnum = {\n")

        with open(f"{base_path}{file_name}.csv", newline='') as csvfile:

            conj_reader = csv.reader(csvfile, delimiter='\t', quotechar='|')

            for row in conj_reader:
                if(row[0] == "id"):
                    continue

                r2 = row[2].replace("'", '"')
                f.write(f"\t{row[0]} : Pos.{row[1].replace('-', '_')},\n")
        
        f.write("};\n\n")

        f.write("/// A map from the pos-enum to the matching pos-ids\n")
        f.write("const Map<Pos, int> posEnumToPosId = {\n")

        with open(f"{base_path}{file_name}.csv", newline='') as csvfile:

            conj_reader = csv.reader(csvfile, delimiter='\t', quotechar='|')

            for row in conj_reader:
                if(row[0] == "id"):
                    continue

                r2 = row[2].replace("'", '"')
                f.write(f"\tPos.{row[1].replace('-', '_')} : {row[0]},\n")
        
        f.write("};\n\n")

        f.write("/// A map from the pos-strings to the matching enum\n")
        f.write("const Map<String, Pos> posStringToPosEnum = {\n")

        with open(f"{base_path}{file_name}.csv", newline='') as csvfile:

            conj_reader = csv.reader(csvfile, delimiter='\t', quotechar='|')

            for row in conj_reader:
                if(row[0] == "id"):
                    continue

                r2 = row[2].replace("'", '"')
                f.write(f"\t'{row[1]}' : Pos.{row[1].replace('-', '_')},\n")
        
        f.write("};\n\n")

        f.write("/// A map from the Pos-strings to the matching enum\n")
        f.write("const Map<String, Pos> posDescriptionToPosEnum = {\n")

        with open(f"{base_path}{file_name}.csv", newline='') as csvfile:

            conj_reader = csv.reader(csvfile, delimiter='\t', quotechar='|')

            for row in conj_reader:
                if(row[0] == "id"):
                    continue

                r2 = row[2].replace("'", '"')
                f.write(f"\t'{r2}' : Pos.{row[1].replace('-', '_')},\n")
        
        f.write("};\n\n")

        f.write("/// A map from a pos-enum to the pos-strings\n")
        f.write("const Map<Pos, String> posEnumToPosString = {\n")

        with open(f"{base_path}{file_name}.csv", newline='') as csvfile:

            conj_reader = csv.reader(csvfile, delimiter='\t', quotechar='|')

            for row in conj_reader:
                if(row[0] == "id"):
                    continue

                r2 = row[2].replace("'", '"')
                f.write(f"\tPos.{row[1].replace('-', '_')} : '{row[1]}',\n")
        
        f.write("};\n\n")

        f.write("/// A map from a Pos-enum to the Pos-description\n")
        f.write("const Map<Pos, String> posEnumToPosDescription = {\n")

        with open(f"{base_path}{file_name}.csv", newline='') as csvfile:

            conj_reader = csv.reader(csvfile, delimiter='\t', quotechar='|')

            for row in conj_reader:
                if(row[0] == "id"):
                    continue

                r2 = row[2].replace("'", '"')
                f.write(f"\tPos.{row[1].replace('-', '_')} : '{r2}',\n")
        
        f.write("};\n\n")



if __name__ == "__main__":
    main()