;; dnf_8_2: synthesize a dnf from 8 variables

;; (set-info :format-version "2.4.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

(declare-term-types
    ;; Nonterminals
    ((B 0) (C 0) (V 0))

    ;; Productions
    (
        ( ; B productions
            ($clause C)
            ($and B B)
        )
        ( ; C productions
            ($var V)
            ($nvar V)
            ($or C C)
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
        )
    )
)

(define-funs-rec
    ((B.Sem ((bt B) (v0 Bool) (v1 Bool) (v2 Bool) (v3 Bool) (v4 Bool) (v5 Bool) (v6 Bool) (v7 Bool)  (result Bool)) Bool)
     (C.Sem ((ct C) (v0 Bool) (v1 Bool) (v2 Bool) (v3 Bool) (v4 Bool) (v5 Bool) (v6 Bool) (v7 Bool)  (result Bool)) Bool)
     (V.Sem ((vt V) (v0 Bool) (v1 Bool) (v2 Bool) (v3 Bool) (v4 Bool) (v5 Bool) (v6 Bool) (v7 Bool)  (result Bool)) Bool))

    ((! (match bt
        ((($clause ct1) (exists ((r Bool))
            (and
                (C.Sem ct1 v0 v1 v2 v3 v4 v5 v6 v7 r)
                (= result r))))
         (($and bt1 bt2) (exists ((r1 Bool) (r2 Bool))
            (and
                (B.Sem bt1 v0 v1 v2 v3 v4 v5 v6 v7 r1)
                (B.Sem bt2 v0 v1 v2 v3 v4 v5 v6 v7 r2)
                (= result (and r1 r2)))))))
        :input ( v0 v1 v2 v3 v4 v5 v6 v7 ) :output (result))

     (! (match ct
        ((($var vt) (exists ((r Bool))
            (and (V.Sem vt v0 v1 v2 v3 v4 v5 v6 v7 r)
                (= result r))))
         (($nvar vt) (exists ((r Bool))
            (and (V.Sem vt v0 v1 v2 v3 v4 v5 v6 v7 r)
                (= result (not r)))))
         (($or ct1 ct2) (exists ((r1 Bool) (r2 Bool))
            (and
                (C.Sem ct1 v0 v1 v2 v3 v4 v5 v6 v7 r1)
                (C.Sem ct2 v0 v1 v2 v3 v4 v5 v6 v7 r2)
                (= result (or r1 r2)))))))
        :input ( v0 v1 v2 v3 v4 v5 v6 v7 ) :output (result))

     (! (match vt
        (($v0 (= result v0))
         ($v1 (= result v1))
         ($v2 (= result v2))
         ($v3 (= result v3))
         ($v4 (= result v4))
         ($v5 (= result v5))
         ($v6 (= result v6))
         ($v7 (= result v7))
        ))
        :input ( v0 v1 v2 v3 v4 v5 v6 v7 ) :output (result))))
(synth-fun formula() B)

;; solution: ~v3 ^ v6

(constraint (B.Sem formula true false false false true false true false  true))
(constraint (B.Sem formula true false false false false false true false  true))
(constraint (B.Sem formula false false false false false false true true  true))
(constraint (B.Sem formula false false true false true false true false  true))
(constraint (B.Sem formula false true false false false false false true  false))
(constraint (B.Sem formula false false false true false false true true  false))
(constraint (B.Sem formula false false true false false false false false  false))

(check-synth)