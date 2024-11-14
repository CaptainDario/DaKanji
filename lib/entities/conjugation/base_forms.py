import pathlib
import collections
from itertools import product

from furigana.furigana import split_furigana


base_path = pathlib.Path(__file__).parent.resolve()



def generate_combinations(data):
    # Convert all elements to tuples for uniformity
    data_tuples = [(x,) if isinstance(x, str) else x for x in data]
    
    # Generate all combinations
    combinations = [''.join(combination) for combination in product(*data_tuples)]
    
    return combinations

def convert_verbs():

    print(base_path)

    items = collections.OrderedDict()

    # get all the verb defintions from def file
    with open(f"{base_path}/Verb.csv", encoding="euc_jis_2004") as f:

            for line in f.readlines():

                elems = line.split(",")

                try:
                    t = []
                    split = split_furigana(elems[0])
                    for s in split:
                        if(s.furigana is not None):
                            t.append((s.text, s.furigana))
                        else:
                            t.append((s.text))

                    combinations = generate_combinations(t)
                except:
                    combinations = [elems[0], elems[10]]

                for combination in combinations:
                    
                    if(combination in items):
                        cur = items[combination]
                        if(elems[10] not in cur):
                            cur.append(elems[10])
                            items[combination] = cur
                    else:
                        items[combination] = [elems[10]]

    # open the dart file in which the forms should be written
    with open(f"{base_path}/base_forms.dart", mode="w+") as f_dest:

        f_dest.write("/// This file is auto generated, do not modify manually!\n\n\n")
        f_dest.write("Map<String, List<String>> conjugationToBaseForm = {\n")
        
        for k, v in items.items():
            f_dest.write(f"\t'{k}' : {str(v)},\n")

        f_dest.write("\n")

        f_dest.write("};")

if __name__ == "__main__":

    convert_verbs()