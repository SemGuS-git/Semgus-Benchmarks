from io import StringIO
import numpy as np
import sys
import json

def decl_mat(out, N, letter):
    for i in range(N+1):
        for j in range(i,N+1):
            out.write(f" ({letter}_{i}_{j} Bool)")
            
def child(out,N,k,letter):
    out.write(f"(R.Sem t{k} len")
    for i in range(N):
        out.write(f" s_{i}")
        
    for i in range(N+1):
        for j in range(i,N+1):
            out.write(f" {letter}_{i}_{j}")
    
    out.write(")")

def lhs_leaf(out,N,mapp):
    for i in range(N+1):
        for j in range(i,N+1):
            out.write(f" (= X_{i}_{j} {mapp(i,j)})")
            
def recurse_sum_tree(n,head,arr):
    for i in range(1,n+1):
        inner = head + [i]
        r = n-i
        if r > 0:
            recurse_sum_tree(r,inner,arr)
        else:
            arr.append(inner)

def indexify(skips,start):
    k = 0
    ret = []
    for i in skips:
        a = start + k
        k += i
        b = start+k
        ret.append((a,b))
    return ret

def get_disjuncts(row,col):
    arr = []
    recurse_sum_tree(col-row,[],arr)
    return [indexify(m,row) for m in arr]

def gen_regex_file(info, desc):
    
    N = info['strlen']
    charmap = info['charmap']
    wildcard_char = info['wildcard_char']
    wild_acc = info['wildcard_acc']
    wild_rej = info['wildcard_rej']
    blank = info['blank']
    examples_pos = info['examples_pos']
    examples_neg = info['examples_neg']

    
    out = StringIO()
    
    out.write(f""";; {desc}
""")
    
    if wild_acc != -1:
        out.write(f"""
;; Positive-example wildcard character: {wild_acc} (only matched by `any`)""")
    if wild_rej != -1:
        out.write(f"""
;; Negative-example wildcard character: {wild_rej} (matched by all character classes)""")
        
    
    out.write("""
(declare-term-types
    ;; Nonterminals
    ((Start 0) (R 0))
    
    ;; Productions
    (
        (($eval($eval_1 R)))
    
        (
            ($eps)
            ($phi)
            """)
    for c in charmap.values():
        out.write(f"($char_{c})")
        out.write("""
                """)
    out.write("""($any)
            ($or ($or_1 R) ($or_2 R))
            ($concat ($concat_1 R) ($concat_2 R))
            ($star ($star_1 R))
        )
    )
)

(define-funs-rec
    (
        (Start.Sem ((t Start) (len Int)""")

    for i in range(N):
        out.write(f" (s_{i} Int)")

    out.write(""" (result Bool)) Bool)
        (R.Sem ((t R) (len Int)""")

    for i in range(N):
        out.write(f" (s_{i} Int)")

    decl_mat(out, N, "X")

    out.write(""") Bool)
    )
    
    (
        (! (match t (
            (($eval t1) """)
    for i in range(N):
        out.write("""
                (exists
                    (""")

        decl_mat(out,N,"X")
        out.write(")")
        out.write("""
                    (and """)
        out.write(f"(= len {i}) ")
        child(out,N,1,"X")
        out.write(f" (= result X_0_{i})")
        out.write(""")
                )""")
        
    out.write("""
            )
        )) :input (len""")
    for i in range(N):
        out.write(f" s_{i}")

    out.write(""") :output (result))
        (! (match t (""")
    
    ### EPS
    out.write("""
            ($eps (and """)

    lhs_leaf(out,N,lambda i,j: "true" if i == j else "false")
    out.write("""))""")
    
    #### PHI
    out.write("""
            ($phi (and """)
    lhs_leaf(out,N,lambda i,j: "false")
    out.write("""))""")
    
    #### ANY
    out.write("""
            ($any (and """)
    lhs_leaf(out,N,lambda i,j: "true" if i+1 == j else "false")
    out.write("""))
""")

    #### CHARACTER MATCHES
    for c in charmap.values():
        out.write(f"            ($char_{c} (and ")
        lhs_leaf(out,N,lambda i,j: "false" if i+1 != j else (f"(= s_{i} {c})" if wild_rej == -1 else f"(or (= s_{i} {c}) (= s_{i} {wild_rej}))"))
        out.write("""))
""")
    
    #### OR
    out.write("""            (($or t1 t2)
                (exists
                    (
                        """)
    decl_mat(out, N, "A")
    out.write("""
                        """)
    decl_mat(out,N,"B")
    out.write("""
                    )
                    (and 
                        """)
    child(out,N,1,"A")
    out.write("""
                        """)
    child(out,N,2,"B")
    out.write("""
                        (and""")
    for i in range(0,N+1):
        for j in range(i,N+1):
            out.write("""
                            """)
            out.write(f"(= X_{i}_{j} (or A_{i}_{j} B_{i}_{j}))")

    out.write("""
                        )
                    )
                )
            )""")
            
    #### CONCAT
    out.write("""
            (($concat t1 t2)
                (exists
                    (
                        """)
    decl_mat(out, N, "A")
    out.write("""
                        """)
    decl_mat(out,N,"B")
    out.write("""
                    )
                    (and 
                        """)
    child(out,N,1,"A")
    out.write("""
                        """)
    child(out,N,2,"B")
    out.write("""
                        (and
                            """)
    for i in range(0,N+1):
        out.write(f"(= X_{i}_{i} (and A_{i}_{i} B_{i}_{i})")
        out.write(""")
                            """)
        for j in range(i+1,N+1):
            out.write(f"(= X_{i}_{j} (or")
            for k in range(i,j+1):
                out.write(f" (and A_{i}_{k} B_{k}_{j})")
            out.write("""))
                            """)
    out.write("""
                        )
                    )
                )
            )""")
    
    #### STAR
    out.write("""
            (($star t1)
                (exists
                    (
                        """)
    decl_mat(out,N,"A")
    out.write("""
                    )
                    (and 
                        """)
    child(out,N,1,"A")
    out.write("""
                        
                        (and""")

    for i in range(0,N+1):
        out.write("""
                        """)
        out.write(f"(= X_{i}_{i} true)")
        out.write("""
                        """)
        
        if i < N:
            out.write(f"(= X_{i}_{i+1} A_{i}_{i+1})")
            out.write("""
                        """)
        
        for j in range(i+2, N+1):
            out.write(f"(= X_{i}_{j} (or")
            for group in reversed(get_disjuncts(i,j)):
                if len(group) == 1:
                    (k,l) = group[0]
                    out.write(f" A_{k}_{l}")
                else:
                    out.write(" (and")
                    for (k,l) in group:
                        out.write(f" A_{k}_{l}")
                    out.write(")")
            out.write("""))
                        """)
            
    out.write("""
                        )
                    )
                )
            )
        )) :input (len""")

    for i in range(0,N):
        out.write(f" s_{i}")
    out.write(""") :output (""")

    for i in range(0,N+1):
        for j in range(i,N+1):
            out.write(f" X_{i}_{j}")

    out.write("""))
    )
)

(synth-fun match_regex() Start)
""")

    for eg in examples_pos:
        out.write(f"""
(constraint (Start.Sem match_regex {len(eg)}""")
        for c in eg:
            out.write(f" {c}")
        for i in range(len(eg),N):
            out.write(f" {blank}")
        out.write(""" true))""")

    for eg in examples_neg:
        out.write(f"""
(constraint (Start.Sem match_regex {len(eg)}""")
        for c in eg:
            out.write(f" {c}")
        for i in range(len(eg),N):
            out.write(f" {blank}")
        out.write(""" false))""")

    out.write("""
(check-synth)
""")
    return out.getvalue()


    
# def formulate(input,kind):
#     if kind == "fixed-length":
#         return formulate(input)
#     raise Exception(kind)




def get_input_info(examples_pos, examples_neg, wildcard_char):
    charmap = dict()
    
    has_wildcard_acc = False
    has_wildcard_rej = False
    
    strlen = max([len(eg) for eg in examples_pos] + [len(eg) for eg in examples_neg])
    
    for eg in examples_pos:
        
        for char in eg:
            if char == wildcard_char:
                has_wildcard_acc = True
            elif char not in charmap:
                charmap[char] = len(charmap)
    for eg in examples_neg:
        for char in eg:
            if char == wildcard_char:
                has_wildcard_rej = True
            elif char not in charmap:
                charmap[char] = len(charmap)
    
    wildcard_acc = (int(np.ceil(len(charmap)/10))*10) + 10 if has_wildcard_acc else -1
    wildcard_rej = (int(np.ceil(len(charmap)/10))*10) + 20 if has_wildcard_rej else -1
    blank = (int(np.ceil(len(charmap)/10))*10) + 30
    
    examples_pos = [ [wildcard_acc if char==wildcard_char else charmap[char] for char in eg] for eg in examples_pos ]
    examples_neg = [ [wildcard_rej if char==wildcard_char else charmap[char] for char in eg] for eg in examples_neg ]
    
    hmm = list(charmap.keys())
    hmm.sort()
    if hmm == [f"{a}" for a in range(len(hmm))]:
        charmap = {f"{a}": a for a in range(len(hmm))}
    
    return {
        'strlen': strlen,
        'charmap':charmap,
        'wildcard_char': wildcard_char,
        'wildcard_acc':wildcard_acc,
        'wildcard_rej':wildcard_rej,
        'blank': blank,
        'examples_pos':examples_pos,
        'examples_neg':examples_neg,
    }




# def formulate(input):
#     charmap = {"0":0,"1":1,"X":2,"Y":3} # hardcoded
    
#     examples = []
    
#     for key in input['posEx']:
#         encoded = [len(key)]
#         for c in key:
#             if not c in charmap.keys():
#                 raise Exception("Invalid character", c)
#             encoded.append(charmap[c])
#         examples.append({"i":encoded, "o": True})
        
#     for key in input['negEx']:
#         encoded = [len(key)]
#         for c in key:
#             if c == "X":
#                 c = "Y"  # For negative examples, use negative sigma character
#             if not c in charmap.keys():
#                 raise Exception("Invalid character", c)
#             encoded.append(charmap[c])
#         examples.append({"i":encoded, "o": False})
    
#     return {"s": "s", "X": "X", "A": "A", "B": "B", "sigma_neg": 3, "NA": 9,
#         "n": max([len(e["i"]) for e in examples]),
#         "charset": [0, 1], # hardcoded
#         "examples": examples,
#         "author": "Wiley Corning",
#         "description": f"{input['benchmarkName']}: {input['comment']}",
#         "benchmarkName": input['benchmarkName']
#     }

# if len(sys.argv) != 3:
#     print("This script generates a Semgus grammar for regular expressions on strings of a fixed length.")
#     print("Usage: gen-regex-file str_len num_chars")

with open("sources/messy-regex.json") as f:
    problems = json.load(f)
    
    for problem in problems:
        info = get_input_info(problem["posEx"], problem["negEx"], 'X')
        desc = f"{problem['benchmarkName']}: {problem['comment']}"
        
        print(info)
        
        f = open(f"{problem['benchmarkName']}.sl","w")
        f.write(gen_regex_file(info, desc))

# N = int(sys.argv[1])
# C = int(sys.argv[2])
# print(gen_regex_file(N,C))