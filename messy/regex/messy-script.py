from jinja2 import Environment, FileSystemLoader
import json,os

env = Environment(
    loader = FileSystemLoader(".")
)


with open("sources/messy-regex.json") as f:
    problems = json.load(f)
    
def formulate(input,kind):
    if kind == "fixed-length":
        return formulate_fixedlength(input)
    if kind == "magic":
        return formulate_magic(input)
    raise Exception(kind)

def formulate_fixedlength(input):
    charmap = {"0":0,"1":1,"X":2,"Y":3} # hardcoded
    
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
            if c == "X":
                c = "Y"  # For negative examples, use negative sigma character
            if not c in charmap.keys():
                raise Exception("Invalid character", c)
            encoded.append(charmap[c])
        examples.append({"i":encoded, "o": False})
    
    return {"s": "s", "X": "X", "A": "A", "B": "B", "sigma_neg": 3, "NA": 9,
        "n": max([len(e["i"]) for e in examples]),
        "charset": [0, 1], # hardcoded
        "examples": examples,
        "comment": f"{input['benchmarkName']}: {input['comment']}",
        "benchmarkName": input['benchmarkName']
    }
    
def formulate_magic(input):
    examples = []
    
    for key in input['posEx']:
        examples.append({"string":key, "match": True});
        
    for key in input['negEx']:
        examples.append({"string":key.replace("X","Y"), "match": False});
    
    return {
        "examples": examples,
        "comment": f"{input['benchmarkName']}: {input['comment']}",
        "benchmarkName": input['benchmarkName']
    }


templates = {k0: {k1: env.get_template(f"sources/regex-{k0}-{k1}.template") for k1 in ('linear','logarithmic')} for k0 in ('fixed-length','magic')}


def run(sem,star,params,template):
    fname = f"{sem}/{star}/{params['benchmarkName']}.sem"
    print("Writing to file " + fname)
    txt = template.render(params).strip()
    os.makedirs(os.path.dirname(fname),exist_ok=True)
    with open(fname, 'w') as f:
        f.write(txt)

for problem in problems:
    for sem in templates:
        for star in templates[sem]:
            run(sem,star,formulate(problem,sem), templates[sem][star])