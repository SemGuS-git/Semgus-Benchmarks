;; cube_4_2: synthesize a cube from 4 variables

;; (set-info :format-version "2.4.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

(declare-term-types
    ;; Nonterminals
    ((B 0) (V 0))

    ;; Productions
    (
        ( ; B productions
            ($var V)
            ($and B B)
        )
        ( ; V productions
            ($v0)
            ($v1)
            ($v2)
            ($v3)
        )
    )
)

(define-funs-rec
    ((B.Sem ((bt B) (v0 Bool) (v1 Bool) (v2 Bool) (v3 Bool)  (result Bool)) Bool)
     (V.Sem ((vt V) (v0 Bool) (v1 Bool) (v2 Bool) (v3 Bool)  (result Bool)) Bool))

    ((! (match bt
        ((($var vt) (exists ((r Bool))
            (and (V.Sem vt v0 v1 v2 v3 r)
                (= result r))))
         (($and bt1 bt2) (exists ((r1 Bool) (r2 Bool))
            (and
                (B.Sem bt1 v0 v1 v2 v3 r1)
                (B.Sem bt2 v0 v1 v2 v3 r2)
                (= result (and r1 r2)))))))
        :input ( v0 v1 v2 v3 ) :output (result))

     (! (match vt
        (($v0 (= result v0))
         ($v1 (= result v1))
         ($v2 (= result v2))
         ($v3 (= result v3))
        ))
        :input ( v0 v1 v2 v3 ) :output (result))))
(synth-fun formula() B)

;; solution: v2 ^ v3

(constraint (B.Sem formula false true true false  true))
(constraint (B.Sem formula false true false false  false))
(constraint (B.Sem formula true false true false  false))

(check-synth)