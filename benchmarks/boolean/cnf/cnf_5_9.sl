;; cnf_5_9: synthesize a cnf from 5 variables

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
            ($and C B)
        )
        ( ; C productions
            ($var V)
            ($nvar V)
            ($or V C)
        )
        ( ; V productions
            ($v0)
            ($v1)
            ($v2)
            ($v3)
            ($v4)
        )
    )
)

(define-funs-rec
    ((B.Sem ((bt B) (v0 Bool) (v1 Bool) (v2 Bool) (v3 Bool) (v4 Bool)  (result Bool)) Bool)
     (C.Sem ((ct C) (v0 Bool) (v1 Bool) (v2 Bool) (v3 Bool) (v4 Bool)  (result Bool)) Bool)
     (V.Sem ((vt V) (v0 Bool) (v1 Bool) (v2 Bool) (v3 Bool) (v4 Bool)  (result Bool)) Bool))

    ((! (match bt
        ((($clause ct1) (exists ((r Bool))
            (and
                (C.Sem ct1 v0 v1 v2 v3 v4 r)
                (= result r))))
         (($and ct1 bt2) (exists ((r1 Bool) (r2 Bool))
            (and
                (C.Sem ct1 v0 v1 v2 v3 v4 r1)
                (B.Sem bt2 v0 v1 v2 v3 v4 r2)
                (= result (and r1 r2)))))))
        :input ( v0 v1 v2 v3 v4 ) :output (result))

     (! (match ct
        ((($var vt) (exists ((r Bool))
            (and (V.Sem vt v0 v1 v2 v3 v4 r)
                (= result r))))
         (($nvar vt) (exists ((r Bool))
            (and (V.Sem vt v0 v1 v2 v3 v4 r)
                (= result (not r)))))
         (($or vt1 ct2) (exists ((r1 Bool) (r2 Bool))
            (and
                (V.Sem vt1 v0 v1 v2 v3 v4 r1)
                (C.Sem ct2 v0 v1 v2 v3 v4 r2)
                (= result (or r1 r2)))))))
        :input ( v0 v1 v2 v3 v4 ) :output (result))

     (! (match vt
        (($v0 (= result v0))
         ($v1 (= result v1))
         ($v2 (= result v2))
         ($v3 (= result v3))
         ($v4 (= result v4))
        ))
        :input ( v0 v1 v2 v3 v4 ) :output (result))))
(synth-fun formula() B)

;; solution: (v1 v v2) ^ (~v3 v v5) ^ (v1 v ~v2 v v3) ^ (v4 v v5)

(constraint (B.Sem formula false true true false true  true))
(constraint (B.Sem formula false true true true true  true))
(constraint (B.Sem formula true false false false true  true))
(constraint (B.Sem formula true false false true false  true))
(constraint (B.Sem formula true false false true true  true))
(constraint (B.Sem formula true false true false true  true))
(constraint (B.Sem formula true false true true true  true))
(constraint (B.Sem formula true true false false true  true))
(constraint (B.Sem formula true true false true false  true))
(constraint (B.Sem formula true true false true true  true))
(constraint (B.Sem formula true true true false true  true))
(constraint (B.Sem formula true true true true true  true))
(constraint (B.Sem formula false false false false false  false))
(constraint (B.Sem formula false false false false true  false))
(constraint (B.Sem formula false false false true false  false))
(constraint (B.Sem formula false false false true true  false))
(constraint (B.Sem formula false false true false false  false))
(constraint (B.Sem formula false false true false true  false))
(constraint (B.Sem formula false false true true false  false))
(constraint (B.Sem formula false false true true true  false))
(constraint (B.Sem formula false true false false false  false))
(constraint (B.Sem formula false true false false true  false))
(constraint (B.Sem formula false true false true false  false))
(constraint (B.Sem formula false true false true true  false))
(constraint (B.Sem formula false true true false false  false))
(constraint (B.Sem formula false true true true false  false))
(constraint (B.Sem formula true false false false false  false))
(constraint (B.Sem formula true false true false false  false))
(constraint (B.Sem formula true false true true false  false))
(constraint (B.Sem formula true true false false false  false))
(constraint (B.Sem formula true true true false false  false))
(constraint (B.Sem formula true true true true false  false))

(check-synth)