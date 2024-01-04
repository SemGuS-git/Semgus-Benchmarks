;; cube_10_8: synthesize a cube from 10 variables

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
            ($v4)
            ($v5)
            ($v6)
            ($v7)
            ($v8)
            ($v9)
        )
    )
)

(define-funs-rec
    ((B.Sem ((bt B) (v0 Bool) (v1 Bool) (v2 Bool) (v3 Bool) (v4 Bool) (v5 Bool) (v6 Bool) (v7 Bool) (v8 Bool) (v9 Bool)  (result Bool)) Bool)
     (V.Sem ((vt V) (v0 Bool) (v1 Bool) (v2 Bool) (v3 Bool) (v4 Bool) (v5 Bool) (v6 Bool) (v7 Bool) (v8 Bool) (v9 Bool)  (result Bool)) Bool))

    ((! (match bt
        ((($var vt) (exists ((r Bool))
            (and (V.Sem vt v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 r)
                (= result r))))
         (($and bt1 bt2) (exists ((r1 Bool) (r2 Bool))
            (and
                (B.Sem bt1 v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 r1)
                (B.Sem bt2 v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 r2)
                (= result (and r1 r2)))))))
        :input ( v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 ) :output (result))

     (! (match vt
        (($v0 (= result v0))
         ($v1 (= result v1))
         ($v2 (= result v2))
         ($v3 (= result v3))
         ($v4 (= result v4))
         ($v5 (= result v5))
         ($v6 (= result v6))
         ($v7 (= result v7))
         ($v8 (= result v8))
         ($v9 (= result v9))
        ))
        :input ( v0 v1 v2 v3 v4 v5 v6 v7 v8 v9 ) :output (result))))
(synth-fun formula() B)

;; solution: v2 ^ v3 ^ v4 ^ v5 ^ v6 ^ v7 ^ v8 ^ v9

(constraint (B.Sem formula false false true true true true true true true true  true))
(constraint (B.Sem formula false false false true true true true true true true  false))
(constraint (B.Sem formula false false true false true true true true true true  false))
(constraint (B.Sem formula false false true true false true true true true true  false))
(constraint (B.Sem formula false false true true true false true true true true  false))
(constraint (B.Sem formula false false true true true true false true true true  false))
(constraint (B.Sem formula false false true true true true true false true true  false))
(constraint (B.Sem formula false false true true true true true true false true  false))
(constraint (B.Sem formula false false true true true true true true true false  false))

(check-synth)