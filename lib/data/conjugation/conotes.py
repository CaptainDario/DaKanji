import csv



source = "//based on conotes.csv which was scraped from\n//https://gitlab.com/yamagoya/jmdictdb/-/tree/master/jmdictdb/data\n\n\n\n"
base_path = "./lib/helper/conjugation/"
file_name = "conotes"

def main():

    with open(f"{base_path}{file_name}.dart", mode="w+", encoding="utf8") as f:
        f.write(source)

        f.write("/// A map from the id to a note regarding conjugation of a word\n")
        f.write("const Map<int, String> conotes = {\n")

        with open(f"{base_path}{file_name}.csv", newline='', encoding="utf8") as csvfile:
            content = csvfile.read().replace("\n ", "").split("\n")

            conj_reader = csv.reader(content, delimiter='\t', quotechar="'")
            
            for row in conj_reader:
                if(row[0] == "id"):
                    continue
                print(row)
                r1 = (row[1]).replace("'", '"')
                f.write(f"\t{row[0]} : '{r1}',\n")
        
        f.write("};")




if __name__ == "__main__":
    main()