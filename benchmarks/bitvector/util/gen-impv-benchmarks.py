from io import StringIO
import sys
import json

def gen_file(problem, description, bvtype):
    name = problem['name']
    numInputs = problem['inputs']
    prods = problem['prods']
    consts = problem['consts']
    numVars = problem['numImpVars']
    isBool = "isBool" in problem
    isLogical = "logical" in problem
    isSubterms = "subterms" in problem

    remainingProds = prods.copy()

    inputsString = ""
    typesString = ""
    if numInputs >= 1:
        inputsString += "x"
        typesString += "(x (_ BitVec 32))"
    if numInputs >= 2:
        inputsString += " y"
        typesString += " (y (_ BitVec 32))"
    if numInputs >= 3:
        inputsString += " z"
        typesString += " (z (_ BitVec 32))"
    if numInputs >= 4:
        inputsString += " w"
        typesString += " (w (_ BitVec 32))"
    constString = inputsString
    varTypesString = typesString
    for i in range(numVars):
        inputsString += " o" + str(i+1)
        typesString += " (o" + str(i+1) + " (_ BitVec 32))"

    outputsString = ""
    seqString = ""
    for i in range(numVars):
        outputsString += " ro" + str(i+1)
        seqString += " ri" + str(i+1)
    outputsString = outputsString[1:]
    seqString = seqString[1:]
    
    out = StringIO()
    out.write(f""";; {description}

;; (set-info :format-version "2.4.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

""")

    startString = ""
    if isBool:
        startString = "(Start 0) "
    
    out.write(f"""(declare-term-types
    ({startString}(S 0) (E 0))
    (""")
    
    if isBool:
        out.write(f"""
        (
            ($bvult S S)
            ($bvule S S)
        )""")

    out.write(f"""
        (
""")
    for i in range(numVars):
        out.write(f"""            ($=o{i+1} E)
""")
    out.write(f"""            ($seq S S)
        )
        (
""")
    # variable productions
    if numInputs >= 1:
        out.write(f"""            ($xvar)
""")
    if numInputs >= 2:
        out.write(f"""            ($yvar)
""")
    if numInputs >= 3:
        out.write(f"""            ($zvar)
""")
    if numInputs >= 4:
        out.write(f"""            ($wvar)
""")
    for i in range(numVars):
        out.write(f"""            ($o{i+1})
""")
    for c in consts:
        out.write(f"""            (${c})
""")
    
    # bitvector productions
    if "bvnot" in prods:
        remainingProds.remove("bvnot")
        out.write(f"""            ($bvnot E)
""")
    if "bvneg" in prods:
        remainingProds.remove("bvneg")
        out.write(f"""            ($bvneg E)
""")
    if "bvand" in prods:
        remainingProds.remove("bvand")
        out.write(f"""            ($bvand E E)
""")
    if "bvor" in prods:
        remainingProds.remove("bvor")
        out.write(f"""            ($bvor E E)
""")
    if "bvxor" in prods:
        remainingProds.remove("bvxor")
        out.write(f"""            ($bvxor E E)
""")
    if "bvlshr" in prods or "bvshr" in prods:
        if "bvlshr" in prods: remainingProds.remove("bvlshr")
        if "bvshr" in prods: remainingProds.remove("bvshr")
        out.write(f"""            ($bvlshr E E)
""")
    if "bvshl" in prods:
        remainingProds.remove("bvshl")
        out.write(f"""            ($bvshl E E)
""")
    if "bvadd" in prods:
        remainingProds.remove("bvadd")
        out.write(f"""            ($bvadd E E)
""")
    if "bvsub" in prods:
        remainingProds.remove("bvsub")
        out.write(f"""            ($bvsub E E)
""")
    if "bvmul" in prods:
        remainingProds.remove("bvmul")
        out.write(f"""            ($bvmul E E)
""")
    if "bvdiv" in prods:
        remainingProds.remove("bvdiv")
        out.write(f"""            ($bvdiv E E)
""")
    if "bvuge" in prods:
        remainingProds.remove("bvuge")
        out.write(f"""            ($bvuge E E)
""")
    if "bveq" in prods:
        remainingProds.remove("bveq")
        out.write(f"""            ($bveq E E)
""")
    if "bvredor" in prods:
        remainingProds.remove("bvredor")
        out.write(f"""            ($bvredor E)
""")

    if len(remainingProds) > 0:
       return "bad result: no support for: " + str(remainingProds)
    

    out.write(f"""        )
""")

    resultString = ""
    if isBool:
        resultString = "(result Bool)"
    else:
        resultString = "(result (_ BitVec 32))"

    out.write(f"""    )
)

(define-funs-rec
    (""")
    if isBool:
        out.write(f"""(Start.Sem ((t Start)""")
        if numInputs >= 1:
            out.write(f""" (x (_ BitVec 32))""")
        if numInputs >= 2:
            out.write(f""" (y (_ BitVec 32))""")
        if numInputs >= 3:
            out.write(f""" (z (_ BitVec 32))""")
        if numInputs >= 4:
            out.write(f""" (w (_ BitVec 32))""")
        for i in range(numVars):
            out.write(f""" (o{i+1} (_ BitVec 32))""")
        out.write(f""" (result Bool)) Bool)
     """)

    out.write(f"""(S.Sem ((st S)""")
    if numInputs >= 1:
        out.write(f""" (x (_ BitVec 32))""")
    if numInputs >= 2:
        out.write(f""" (y (_ BitVec 32))""")
    if numInputs >= 3:
        out.write(f""" (z (_ BitVec 32))""")
    if numInputs >= 4:
        out.write(f""" (w (_ BitVec 32))""")
    for i in range(numVars):
        out.write(f""" (o{i+1} (_ BitVec 32))""")

    for i in range(numVars):
        out.write(f""" (ro{i+1} (_ BitVec 32))""")
    out.write(f""") Bool)
     (E.Sem ((et E)""")
    if numInputs >= 1:
        out.write(f""" (x (_ BitVec 32))""")
    if numInputs >= 2:
        out.write(f""" (y (_ BitVec 32))""")
    if numInputs >= 3:
        out.write(f""" (z (_ BitVec 32))""")
    if numInputs >= 4:
        out.write(f""" (w (_ BitVec 32))""")
    for i in range(numVars):
        out.write(f""" (o{i+1} (_ BitVec 32))""")

    out.write(f""" (result (_ BitVec 32))) Bool))

    (""")

    if isBool:
        out.write(f"""(! (match t
        ((($bvule et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)) (ro1 (_ BitVec 32)) (ro2 (_ BitVec 32)))
            (and
                (S.Sem et1 x y o1 o2 ro1 ro2)
                (= result (or (bvult ro1 ro2) (= ro1 ro2))))))
          (($bvult et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)) (ro1 (_ BitVec 32)) (ro2 (_ BitVec 32)))
            (and
                (S.Sem et1 x y o1 o2 ro1 ro2)
                (= result (bvult ro1 ro2)))))
         ))
         :input (x y o1 o2) :output (result))
     """)
    
    out.write(f"""(! (match st
        (
""")
    for i in range(numVars):
        out.write(f"""         (($=o{i+1} et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r)
""")
        for j in range(numVars):
            if j == i:
                out.write(f"""                (= ro{j+1} r)
""")
            else:
                out.write(f"""                (= ro{j+1} o{j+1}) 
""")
        out.write(f"""         )))
""")
    out.write(f"""         (($seq st1 st2) (exists (""")
    for i in range(numVars):
        out.write(f"""(ri{i+1} (_ BitVec 32)) """)
    out.write(f""")
            (and
                (S.Sem st1 {inputsString} {seqString})
                (S.Sem st2 {constString} {seqString} {outputsString}))))))
         :input ( {inputsString} ) :output ( {outputsString} ))
     (! (match et
        (
""")

    # variable semantics 
    if numInputs >= 1:
        out.write(f"""         ($xvar (= result x))
""")
    if numInputs >= 2:
        out.write(f"""         ($yvar (= result y))
""")
    if numInputs >= 3:
        out.write(f"""         ($zvar (= result z))
""")
    if numInputs >= 4:
        out.write(f"""         ($wvar (= result w))
""")

    for i in range(numVars):
        out.write(f"""         ($o{i+1} (= result o{i+1}))
""")

    for c in consts:
        hexv = f"#x{c:08x}"
        out.write(f"""         (${c} (= result {hexv}))
""")
    
    # bitvector productions
    if "bvnot" in prods:
        out.write(f"""         (($bvnot et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r)
                (= result (bvnot r)))))
""")
    if "bvneg" in prods:
        out.write(f"""         (($bvneg et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r)
                (= result (bvneg r)))))
""")
    if "bvand" in prods:
        out.write(f"""         (($bvand et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r1)
                (E.Sem et2 {inputsString} r2)
                (= result (bvand r1 r2)))))
""")
    if "bvor" in prods:
        out.write(f"""         (($bvor et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r1)
                (E.Sem et2 {inputsString} r2)
                (= result (bvor r1 r2)))))
""")
    if "bvxor" in prods:
        out.write(f"""         (($bvxor et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r1)
                (E.Sem et2 {inputsString} r2)
                (= result (bvxor r1 r2)))))
""")
    if "bvlshr" in prods or "bvshr" in prods:
        out.write(f"""         (($bvlshr et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r1)
                (E.Sem et2 {inputsString} r2)
                (= result (bvlshr r1 r2)))))
""")
    if "bvshl" in prods:
        out.write(f"""         (($bvshl et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r1)
                (E.Sem et2 {inputsString} r2)
                (= result (bvshl r1 r2)))))
""")
    if "bvadd" in prods:
        if bvtype == "imperative":
            out.write(f"""         (($bvadd et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r1)
                (E.Sem et2 {inputsString} r2)
                (= result (bvadd r1 r2)))))
""")
        elif bvtype == "impv-saturated":
            out.write(f"""         (($bvadd et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r1)
                (E.Sem et2 {inputsString} r2)
                (= result (ite (bvult #x00000000 ((_ extract 63 32) (bvadd (concat #x00000000 r1) (concat #x00000000 r2)))) #xffffffff ((_ extract 31 0) (bvadd (concat #x00000000 r1) (concat #x00000000 r2))))))))
""")
    if "bvsub" in prods:
        if bvtype == "imperative":
            out.write(f"""         (($bvsub et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r1)
                (E.Sem et2 {inputsString} r2)
                ;; 2's complement
                (= result (bvadd (bvadd r1 (bvnot r2)) #x00000001)))))
""")
        if bvtype == "impv-saturated":
            out.write(f"""         (($bvsub et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r1)
                (E.Sem et2 {inputsString} r2)
                ;; 2's complement
                (= result (ite (bvult r1 r2) #x00000000 (bvadd (bvadd r1 (bvnot r2)) #x00000001))))))
""")
    if "bvmul" in prods:
        if bvtype == "imperative":
            out.write(f"""         (($bvmul et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r1)
                (E.Sem et2 {inputsString} r2)
                (= result (bvmul r1 r2)))))
""")
        elif bvtype == "saturated":
            out.write(f"""         (($bvmul et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r1)
                (E.Sem et2 {inputsString} r2)
                (= result (ite (bvult #x00000000 ((_ extract 63 32) (bvmul (concat #x00000000 r1) (concat #x00000000 r2)))) #xffffffff ((_ extract 31 0) (bvmul (concat #x00000000 r1) (concat #x00000000 r2))))))))
""")
    if "bvdiv" in prods:
        out.write(f"""         (($bvdiv et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r1)
                (E.Sem et2 {inputsString} r2)
                (= result (bvudiv r1 r2)))))
""")
    if "bvuge" in prods:
        out.write(f"""         (($bvuge et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r1)
                (E.Sem et2 {inputsString} r2)
                (= result (ite (or (= r1 r2) (bvult r2 r1)) #x00000001 #x00000000))))) 
""")
    if "bveq" in prods:
        out.write(f"""         (($bveq et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r1)
                (E.Sem et2 {inputsString} r2)
                (= result (ite (= r1 r2) #x00000001 #x00000000))))) 
""")
    if "bvredor" in prods:
        out.write(f"""         (($bvredor et1) (exists ((r1 (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r1)
                (= result (ite (= r1 #x00000000) #x00000000 #x00000001))))) 
""")

    out.write(f"""          ))
         :input ( {inputsString} ) :output (result))""")
    
    startNT = "Start" if isBool else "S"
    out.write(f"""))

(synth-fun bvformula() {startNT})

""")

    # constraints
    zeroesString = "" if isBool else "#x00000000 " * (numVars - 1)
    if "constraints" in problem and not isLogical:
        constraintList = problem['constraints']
        for c in constraintList:
            out.write(f"""(constraint (S.Sem bvformula {c} {zeroesString}))
""")

    if isSubterms:
        subterms = problem['subterms']
        for key in subterms:
            out.write(f"""(define-fun {key} ({varTypesString}) (_ BitVec 32) {subterms[key]})
""")
    
    if isLogical:
        semString = "Start.Sem" if isBool else "S.Sem"
        out.write(f"""(constraint (forall ({typesString} {resultString})
            (= ({semString} bvformula {inputsString} result {zeroesString})
                (= result {problem['logical']} ))))
""")

    out.write(f"""
(check-synth)""")
    
    return out.getvalue()

json_file = "brahma.json"
if len(sys.argv) > 1:
    json_file = sys.argv[1]

bvtypes = ["imperative", "impv-saturated"]

with open(json_file) as f:
    problems = json.load(f)
    for problemType in bvtypes:
        for problem in problems: 
            description = problem['description'] 

            f = open(f"../{problemType}/{problem['name']}.sl","w")
            f.write(gen_file(problem, description, problemType))
