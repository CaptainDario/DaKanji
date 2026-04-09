import csv
import re



source = "//based on conj.csv which was scraped from\n//https://gitlab.com/yamagoya/jmdictdb/-/tree/master/jmdictdb/data\n\n\n\n"
base_path = "./lib/helper/conjugation/"
file_name = "conj"

def main():

    with open(f"{base_path}{file_name}.dart", mode="w+", encoding="utf8") as f:
        f.write(source)

        f.write("/// Enum containing the conjugation forms\n")
        f.write("enum Conj {\n")

        with open(f"{base_path}{file_name}.csv", newline='') as csvfile:

            conj_reader = csv.reader(csvfile, delimiter='\t', quotechar='|')

            for row in conj_reader:
                if(row[0] == "id"):
                    continue

                r = re.sub(r" \(.*\)", "", row[1]).replace("-", "_")
                f.write(f"\t{r},\n")
        
        f.write("}\n\n")

        f.write("/// A map from the id to the conjugation form enum\n")
        f.write("const Map<int, Conj> conjIdToConjEnum = {\n")

        with open(f"{base_path}{file_name}.csv", newline='') as csvfile:

            conj_reader = csv.reader(csvfile, delimiter='\t', quotechar='|')

            for row in conj_reader:
                if(row[0] == "id"):
                    continue

                r = re.sub(r" \(.*\)", "", row[1]).replace("-", "_")
                f.write(f"\t{row[0]} : Conj.{r},\n")
        
        f.write("};\n\n")


        f.write("/// A map from the conjugation form enum to the id\n")
        f.write("const Map<Conj, int> conjEnumToConjId = {\n")

        with open(f"{base_path}{file_name}.csv", newline='') as csvfile:

            conj_reader = csv.reader(csvfile, delimiter='\t', quotechar='|')

            for row in conj_reader:
                if(row[0] == "id"):
                    continue

                r = re.sub(r" \(.*\)", "", row[1]).replace("-", "_")
                f.write(f"\tConj.{r} : {row[0]},\n")
        
        f.write("};\n\n")

        f.write("/// A map from the conjugation form enum to a string description\n")
        f.write("const Map<Conj, String> conjEnumToConjDescription = {\n")

        with open(f"{base_path}{file_name}.csv", newline='') as csvfile:

            conj_reader = csv.reader(csvfile, delimiter='\t', quotechar='|')

            for row in conj_reader:
                if(row[0] == "id"):
                    continue

                r = re.sub(r" \(.*\)", "", row[1]).replace("-", "_")
                f.write(f"\tConj.{r} : '{row[1]}',\n")
        
        f.write("};")




if __name__ == "__main__":
    main()