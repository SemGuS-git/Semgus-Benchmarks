from io import StringIO
import sys
import json

def gen_file(problem, description, bvtype):
    name = problem['name']
    numInputs = problem['inputs']
    prods = problem['prods']
    consts = problem['consts']
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

    out = StringIO()
    out.write(f""";; {description}

;; (set-info :format-version "2.4.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

""")
    
    out.write(f"""(declare-term-types
    ((Start 0) (E 0) (I 0))
""")

    if isBool:
        out.write(f"""    (
        (
            ($bvult E E)
            ($bvule E E)
        )
        (
            ($var I)
""")

    else:
        out.write(f"""    (
        (($bvexpr E))
        (
            ($var I)
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
    if "bveq" in prods:
        remainingProds.remove("bveq")
        out.write(f"""            ($bveq E E)
""")
    if "bvuge" in prods:
        remainingProds.remove("bvuge")
        out.write(f"""            ($bvuge E E)
""")
    if "bvredor" in prods:
        remainingProds.remove("bvredor")
        out.write(f"""            ($bvredor E)
""")

    if len(remainingProds) > 0:
       return "bad result: no support for: " + str(remainingProds)
    

    out.write(f"""        )
""")

    out.write(f"""        (
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
    for c in consts:
        out.write(f"""            (${c})
""")
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
    ((Start.Sem ((st Start) {typesString} {resultString}) Bool)
     (E.Sem ((et E) {typesString} (result (_ BitVec 32))) Bool)
     (I.Sem ((it I) {typesString} (result (_ BitVec 32))) Bool))
""")
    
    if isBool:
        out.write(f"""
    ((! (match st
        ((($bvule et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y r1)
                (E.Sem et2 x y r2)
                (= result (or (bvult r1 r2) (= r1 r2))))))
          (($bvult et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y r1)
                (E.Sem et2 x y r2)
                (= result (bvult r1 r2)))))
         ))
""")
    else:
        out.write(f"""
    ((! (match st
        ((($bvexpr et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r)
                (= result r))))))
""")

    out.write(f"""         :input ({inputsString}) :output (result))
     (! (match et
        ((($var it1) (exists ((r (_ BitVec 32)))
            (and
                (I.Sem it1 {inputsString} r)
                (= result r))))
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
        if bvtype == "simple":
            out.write(f"""         (($bvadd et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r1)
                (E.Sem et2 {inputsString} r2)
                (= result (bvadd r1 r2)))))
""")
        elif bvtype == "saturated":
            out.write(f"""         (($bvadd et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r1)
                (E.Sem et2 {inputsString} r2)
                (= result (ite (bvult #x00000000 ((_ extract 63 32) (bvadd (concat #x00000000 r1) (concat #x00000000 r2)))) #xffffffff ((_ extract 31 0) (bvadd (concat #x00000000 r1) (concat #x00000000 r2))))))))
""")
    if "bvsub" in prods:
        if bvtype == "simple":
            out.write(f"""         (($bvsub et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r1)
                (E.Sem et2 {inputsString} r2)
                ;; 2's complement
                (= result (bvadd (bvadd r1 (bvnot r2)) #x00000001)))))
""")
        elif bvtype == "saturated":
            out.write(f"""         (($bvsub et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 {inputsString} r1)
                (E.Sem et2 {inputsString} r2)
                ;; 2's complement
                (= result (ite (bvult r1 r2) #x00000000 (bvadd (bvadd r1 (bvnot r2)) #x00000001))))))
""")
    if "bvmul" in prods:
        if bvtype == "simple":
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
         :input ({inputsString}) :output (result))
""")
    
    out.write(f"""     (! (match it
          (
""")
    # variable semantics 
    if numInputs >= 1:
        out.write(f"""              ($xvar (= result x))
""")
    if numInputs >= 2:
        out.write(f"""              ($yvar (= result y))
""")
    if numInputs >= 3:
        out.write(f"""              ($zvar (= result z))
""")
    if numInputs >= 4:
        out.write(f"""              ($wvar (= result w))
""")

    for c in consts:
        hexv = f"#x{c:08x}"
        out.write(f"""              (${c} (= result {hexv}))
""")
    out.write(f"""          ))
          :input ({inputsString}) :output (result))""")

    out.write(f"""))

(synth-fun bvformula() Start)

""")

    # constraints
    isComment = ""
    if isLogical:
        isComment = ";;"
    if "constraints" in problem:
        constraintList = problem['constraints']
        for c in constraintList:
            out.write(f"""{isComment}(constraint (Start.Sem bvformula {c} ))
""")

    if isSubterms:
        subterms = problem['subterms']
        for key in subterms:
            out.write(f"""(define-fun {key} ({typesString}) (_ BitVec 32) {subterms[key]})
""")
    
    if isLogical:
        out.write(f"""(constraint (forall ({typesString} {resultString})
            (= (Start.Sem bvformula {inputsString} result)
                (= result {problem['logical']} ))))
""")

    out.write(f"""
(check-synth)""")
    
    return out.getvalue()

json_file = "brahma.json"
if len(sys.argv) > 1:
    json_file = sys.argv[1]

bvtypes = ["simple", "saturated"]

with open(json_file) as f:
    problems = json.load(f)
    for problemType in bvtypes:
        for problem in problems:
            description = problem['description'] 

            f = open(f"../{problemType}/{problem['name']}.sl","w")
            f.write(gen_file(problem, description, problemType))
