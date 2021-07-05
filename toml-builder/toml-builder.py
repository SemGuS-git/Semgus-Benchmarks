from jinja2 import Environment, FileSystemLoader

env = Environment(
    loader = FileSystemLoader(".")
)

template = env.get_template("regex-template.txt")

def formulate(input):
    charmap = dict()
    
    examples = []
    
    for key in input:
        encoded = []
        for c in key:
            if not c in charmap.keys():
                charmap[c] = len(charmap)+1
            encoded.append(charmap[c])
        examples.append({"i":encoded, "o": input[key]})
    
    return {"s": "s", "X": "X", "A": "A", "B": "B", "NA": 0,
        "n": max([len(e["i"]) for e in examples]),
        "charset": list(charmap.values()),
        "examples": examples,
    }
    
input = {
    "": True,
    "a": True,
    "b": True,
    "c": False,
    "ab": True,
    "ca": False,
    "ba": True,
    "ac": False,
}

txt = template.render(formulate(input)).strip()

print(txt)

with open('output.txt', 'w') as f:
    f.write(txt)
    
print(formulate({"test":True, "best": False}))