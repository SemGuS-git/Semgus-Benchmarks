from jinja2 import Environment, FileSystemLoader
import json 

env = Environment(
    loader = FileSystemLoader(".")
)

template = env.get_template("regex-template.txt")

with open("messy-regex.json") as f:
    problems = json.load(f)

def formulate(input):
    charmap = {"0":0,"1":1,"X":2} # hardcoded
    
    examples = []
    
    for key in input['posEx']:
        encoded = []
        for c in key:
            if not c in charmap.keys():
                raise Exception("Invalid character", c)
            encoded.append(charmap[c])
        examples.append({"i":encoded, "o": True})
        
    for key in input['negEx']:
        encoded = []
        for c in key:
            if not c in charmap.keys():
                raise Exception("Invalid character", c)
            encoded.append(charmap[c])
        examples.append({"i":encoded, "o": False})
    
    return {"s": "s", "X": "X", "A": "A", "B": "B", "NA": 9,
        "n": max([len(e["i"]) for e in examples]),
        "charset": [0, 1], # hardcoded
        "examples": examples,
        "comment": input['comment'],
        "benchmarkName": input['benchmarkName']
    }
    
def writeFile(params):
    fname = params['benchmarkName']+".sem"
    print("Writing to file " + fname)
    txt = template.render(params).strip()
    with open(fname, 'w') as f:
        f.write(txt)

for problem in problems:
    writeFile(formulate(problem))