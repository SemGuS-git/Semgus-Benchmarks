import os,glob
from jinja2 import Environment, FileSystemLoader

prefix = "../messy/imperative/"

allFiles = [fp.replace("\\","/")[len(prefix):] for fp in glob.glob(prefix+"**/*.sem",recursive=True)]


batches = dict()

for batch,file in [(s[:s.index("/")],s) for s in allFiles]:
    batches.setdefault(batch,[]).append(file)

env = Environment(loader = FileSystemLoader("."))
template = env.get_template("toml-template.txt")

# all
txt = template.render({"batches": batches}).strip()

print(txt)

with open(prefix+'messy-imperative-all.toml', 'w') as f:
    f.write(txt)

for batch in batches:
    with open(prefix+batch+".toml", 'w') as f:
        f.write(template.render({"batches": {batch: batches[batch]}}))