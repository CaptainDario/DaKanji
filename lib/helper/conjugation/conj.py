import csv



source = "//based on conj.csv which was scraped from\n//https://gitlab.com/yamagoya/jmdictdb/-/tree/master/jmdictdb/data\n\n\n\n"
base_path = "./lib/helper/conjugation/"
file_name = "conj"

def main():

    with open(f"{base_path}{file_name}.dart", mode="w+", encoding="utf8") as f:
        f.write(source)

        f.write("/// A map from the id to the conjugation form string\n")
        f.write("const Map<int, String> conj = {\n")

        with open(f"{base_path}{file_name}.csv", newline='') as csvfile:

            conj_reader = csv.reader(csvfile, delimiter='\t', quotechar='|')

            for row in conj_reader:
                if(row[0] == "id"):
                    continue
                f.write(f"\t{row[0]} : '{row[1]}',\n")
        
        f.write("};")




if __name__ == "__main__":
    main()