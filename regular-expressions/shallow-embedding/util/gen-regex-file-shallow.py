from io import StringIO
import numpy as np
import sys
import json

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
    
#    if wild_acc != -1:
#        out.write(f"""
#;; Positive-example wildcard character: {wild_acc} (only matched by `any`)""")
#    if wild_rej != -1:
#        out.write(f"""
#;; Negative-example wildcard character: {wild_rej} (matched by all character classes)""")
        
    
    out.write("""           
;; (set-info :format-version "2.2.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

(declare-term-types
    ;; Nonterminals
    ((Start 0) (R 0))
    
    ;; Productions
    (
        (($eval R))
    
        (
            ($char_0)         ;; (str.to.re "0")
            ($char_1)         ;; (str.to.re "1")
            ($any)            ;; (re.allchar)
            ($question R)     ;; (re.opt r1)
            ($or R R)         ;; (re.union r1 r2)
            ($concat R R)     ;; (re.++ r1 r2)
            ($star R)         ;; (re.* r1)
        )
    )
)

(define-funs-rec
    (
        (Start.Sem ((t Start) (str String) (result Bool)) Bool)
        ;;(R.Sem ((t R) (str String) (r1 RegLan)) Bool)
        (R.Sem ((t R) (result RegLan)) Bool)
    )
    
    (
        (! (match t (
            (($eval t1) (exists
                ((r1 RegLan))
                (and
                    (R.Sem t1 r1) 
                    (= result (str.in_re str r1))
                )
            ))
        )) :input (str) :output (result))
        (! (match t (
            ($char_0 (= result (str.to_re "0")) )
            ($char_1 (= result (str.to_re "1")) )
            ($any (= result re.allchar) ) 
            (($or t1 t2)
                (exists
                    (
                        (r1 RegLan) 
                        (r2 RegLan) 
                    )
                    (and 
                        (R.Sem t1 r1) 
                        (R.Sem t2 r2) 
                        (= result (re.union r1 r2))
                    )
                )
            )
            (($concat t1 t2)
                (exists
                    (
                        (r1 RegLan)
                        (r2 RegLan)
                    )
                    (and 
                        (R.Sem t1 r1) 
                        (R.Sem t2 r2)
                        (= result (re.++ r1 r2))
                    )
                )
            )
            (($question t1)
                (exists
                    (
                        (r1 RegLan)
                    )
                    (and 
                        (R.Sem t1 r1)
                        (= result (re.opt r1))
                    )
                )
            )
            (($star t1)
                (exists
                    (
                        (r1 RegLan)
                    )
                    (and 
                        (R.Sem t1 r1) 
                        (= result (re.* r1))
                    )
                )
            )
        )) :input () :output (result))
    )
)

(synth-fun match_regex() Start)""")

    list_pos = [ ]
    for eg in examples_pos:
        curr_eg = ""
        for c in eg:
            if c >= 10:
                curr_eg += "X"
            else:
                curr_eg += str(c)
        list_pos.append(curr_eg)
    for eg_pos in generate_all_on_list(list_pos):
        out.write(f"""
(constraint (Start.Sem match_regex \"""")
        out.write(f"{eg_pos}")
        out.write("""\" true))""")

    list_neg = [ ]
    for eg in examples_neg:
        curr_eg = ""
        for c in eg:
            if c >= 10:
                curr_eg += "X"
            else:
                curr_eg += str(c)
        list_neg.append(curr_eg)
    for eg_neg in generate_all_on_list(list_neg):
        out.write(f"""
(constraint (Start.Sem match_regex \"""")
        out.write(f"{eg_neg}")
        out.write("""\" false))""")

    out.write("""
(check-synth)
""")
    return out.getvalue()


def generate_all_on_list(listt):
    output_list = [ ]
    for string in listt:
        output_list += generate_all_combinations(string)
    return output_list

def generate_all_combinations(string):
    if "X" not in string:
        return [string]

    i = string.index("X")
    replace_0 = generate_all_combinations(string[:i] + "0" + string[i+1:])
    replace_1 = generate_all_combinations(string[:i] + "1" + string[i+1:])

    return replace_0 + replace_1

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




with open("sources/messy-regex.json") as f:
    problems = json.load(f)
    
    for problem in problems:
        info = get_input_info(problem["posEx"], problem["negEx"], 'X')
        desc = f"{problem['benchmarkName']}: {problem['comment']}"
        
        print(info)
        
        f = open(f"../{problem['benchmarkName']}.sl","w")
        f.write(gen_regex_file(info, desc))
