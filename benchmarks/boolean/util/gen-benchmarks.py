from io import StringIO
import sys
import json

def convert(binstring):
    s = ""
    for char in binstring:
        if char == "0":
            s += "false "
        elif char == "1":
            s += "true "
    return s

def out_vars(out, numVars):
    for i in range(numVars):
        out.write(f"""v{i} """)

def gen_file(problem, description):
    numVars = problem['size']
    probType = problem['type']
    expectedSoln = problem['expectedOutput']

    out = StringIO()

    out.write(f""";; {description}

;; (set-info :format-version "2.4.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

""")

    if probType == "cube":
        out.write("""(declare-term-types
    ;; Nonterminals
    ((B 0) (V 0))

    ;; Productions
    (
        ( ; B productions
            ($var V)
            ($and V B)
        )
        ( ; V productions
""")

        for i in range(numVars):
            out.write(f"""            ($v{i})
""")        

        out.write("""        )
    )
)

(define-funs-rec
    ((B.Sem ((bt B) """)

        for i in range(numVars):
            out.write(f"""(v{i} Bool) """)

        out.write(""" (result Bool)) Bool)
     (V.Sem ((vt V) """)

        for i in range(numVars):
            out.write(f"""(v{i} Bool) """)

        out.write(""" (result Bool)) Bool))

    ((! (match bt
        ((($var vt) (exists ((r Bool))
            (and (V.Sem vt """)

        out_vars(out, numVars)

        out.write("""r)
                (= result r))))
         (($and ct1 bt2) (exists ((r1 Bool) (r2 Bool))
            (and
                (C.Sem ct1 """)

        out_vars(out, numVars)
        
        out.write("""r1)
                (B.Sem bt2 """)

        out_vars(out, numVars)

        out.write("""r2)
                (= result (and r1 r2)))))))
        :input ( """)

        out_vars(out, numVars)

        out.write(""") :output (result))

     (! (match vt
        (""")

        for i in range(numVars):
            if i != 0:
                out.write(" ")
            out.write(f"""($v{i} (= result v{i}))
        """)

        out.write("""))
        :input ( """)

        out_vars(out, numVars)

        out.write(""") :output (result))))""")

    elif probType == "cnf":
        out.write("""(declare-term-types
    ;; Nonterminals
    ((B 0) (C 0) (V 0))

    ;; Productions
    (
        ( ; B productions
            ($clause C)
            ($and C B)
        )
        ( ; C productions
            ($var V)
            ($nvar V)
            ($or V C)
        )
        ( ; V productions
""")

        for i in range(numVars):
            out.write(f"""            ($v{i})
""")        

        out.write("""        )
    )
)

(define-funs-rec
    ((B.Sem ((bt B) """)

        for i in range(numVars):
            out.write(f"""(v{i} Bool) """)

        out.write(""" (result Bool)) Bool)
     (C.Sem ((ct C) """)

        for i in range(numVars):
            out.write(f"""(v{i} Bool) """)

        out.write(""" (result Bool)) Bool)
     (V.Sem ((vt V) """)

        for i in range(numVars):
            out.write(f"""(v{i} Bool) """)

        out.write(""" (result Bool)) Bool))

    ((! (match bt
        ((($clause ct1) (exists ((r Bool))
            (and
                (C.Sem ct1 """)
        out_vars(out, numVars)
        out.write("""r)
                (= result r))))
         (($and ct1 bt2) (exists ((r1 Bool) (r2 Bool))
            (and
                (C.Sem ct1 """)

        out_vars(out, numVars)
        
        out.write("""r1)
                (B.Sem bt2 """)

        out_vars(out, numVars)

        out.write("""r2)
                (= result (and r1 r2)))))))
        :input ( """)

        out_vars(out, numVars)

        out.write(""") :output (result))

     (! (match ct
        ((($var vt) (exists ((r Bool))
            (and (V.Sem vt """)

        out_vars(out, numVars)

        out.write("""r)
                (= result r))))
         (($nvar vt) (exists ((r Bool))
            (and (V.Sem vt """)

        out_vars(out, numVars)

        out.write("""r)
                (= result (not r)))))
         (($or vt1 ct2) (exists ((r1 Bool) (r2 Bool))
            (and
                (V.Sem vt1 """)

        out_vars(out, numVars)
        
        out.write("""r1)
                (C.Sem ct2 """)

        out_vars(out, numVars)

        out.write("""r2)
                (= result (or r1 r2)))))))
        :input ( """)

        out_vars(out, numVars)

        out.write(""") :output (result))

     (! (match vt
        (""")

        for i in range(numVars):
            if i != 0:
                out.write(" ")
            out.write(f"""($v{i} (= result v{i}))
        """)

        out.write("""))
        :input ( """)

        out_vars(out, numVars)

        out.write(""") :output (result))))""")
    elif probType == "dnf":
        out.write("""(declare-term-types
    ;; Nonterminals
    ((B 0) (C 0) (V 0))

    ;; Productions
    (
        ( ; B productions
            ($conj C)
            ($or C B)
        )
        ( ; C productions
            ($var V)
            ($nvar V)
            ($and V C)
        )
        ( ; V productions
""")

        for i in range(numVars):
            out.write(f"""            ($v{i})
""")        

        out.write("""        )
    )
)

(define-funs-rec
    ((B.Sem ((bt B) """)

        for i in range(numVars):
            out.write(f"""(v{i} Bool) """)

        out.write(""" (result Bool)) Bool)
     (C.Sem ((ct C) """)

        for i in range(numVars):
            out.write(f"""(v{i} Bool) """)

        out.write(""" (result Bool)) Bool)
     (V.Sem ((vt V) """)

        for i in range(numVars):
            out.write(f"""(v{i} Bool) """)

        out.write(""" (result Bool)) Bool))

    ((! (match bt
        ((($conj ct1) (exists ((r Bool))
            (and
                (C.Sem ct1 """)
        out_vars(out, numVars)
        out.write("""r)
                (= result r))))
         (($or ct1 bt2) (exists ((r1 Bool) (r2 Bool))
            (and
                (C.Sem ct1 """)

        out_vars(out, numVars)
        
        out.write("""r1)
                (B.Sem bt2 """)

        out_vars(out, numVars)

        out.write("""r2)
                (= result (or r1 r2)))))))
        :input ( """)

        out_vars(out, numVars)

        out.write(""") :output (result))

     (! (match ct
        ((($var vt) (exists ((r Bool))
            (and (V.Sem vt """)

        out_vars(out, numVars)

        out.write("""r)
                (= result r))))
         (($nvar vt) (exists ((r Bool))
            (and (V.Sem vt """)

        out_vars(out, numVars)

        out.write("""r)
                (= result (not r)))))
         (($and vt1 ct2) (exists ((r1 Bool) (r2 Bool))
            (and
                (V.Sem vt1 """)

        out_vars(out, numVars)
        
        out.write("""r1)
                (C.Sem ct2 """)

        out_vars(out, numVars)

        out.write("""r2)
                (= result (and r1 r2)))))))
        :input ( """)

        out_vars(out, numVars)

        out.write(""") :output (result))

     (! (match vt
        (""")

        for i in range(numVars):
            if i != 0:
                out.write(" ")
            out.write(f"""($v{i} (= result v{i}))
        """)

        out.write("""))
        :input ( """)

        out_vars(out, numVars)

        out.write(""") :output (result))))""")

    out.write(f"""
(synth-fun formula() B)

;; solution: {expectedSoln}

""")
    
    for c in problem['posEx']:
        vals = convert(c);
        out.write(f"""(constraint (B.Sem formula {vals} true))
""")

    for c in problem['negEx']:
        vals = convert(c);
        out.write(f"""(constraint (B.Sem formula {vals} false))
""")
    
    out.write("""
(check-synth)""")

    return out.getvalue()

json_file = "boolean-problems.json"
if len(sys.argv) > 1:
    json_file = sys.argv[1]
with open(json_file) as f:
    problems = json.load(f)

    for problem in problems:
        description = f"{problem['name']}: synthesize a {problem['type']} from {problem['size']} variables"
        
        f = open(f"../{problem['type']}/{problem['name']}.sl","w")
        f.write(gen_file(problem, description))
