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
            ($nvar V)
            ($and B B)
        )
        ( ; V productions
            ($v1)
            ($v2)
            ($v3)
            ($v4)
        )
    )
)

(define-funs-rec
    ((B.Sem ((bt B) (v1 Bool) (v2 Bool) (v3 Bool) (v4 Bool) (result Bool)) Bool)
     (V.Sem ((vt V) (v1 Bool) (v2 Bool) (v3 Bool) (v4 Bool) (result Bool)) Bool))

    ((! (match bt
        ((($var vt) (exists ((r Bool))
            (and (V.Sem vt v1 v2 v3 v4 r)
                (= result r))))
         (($nvar vt) (exists ((r Bool))
            (and (V.Sem vt v1 v2 v3 v4 r)
                (= result (not r)))))
         (($and bt1 bt2) (exists ((r1 Bool) (r2 Bool))
            (and
                (B.Sem bt1 v1 v2 v3 v4 r1)
                (B.Sem bt2 v1 v2 v3 v4 r2)
                (= result (and r1 r2)))))))
        :input (v1 v2 v3 v4) :output (result))

     (! (match vt
        (($v1 (= result v1))
         ($v2 (= result v2))
         ($v3 (= result v3))
         ($v4 (= result v4))))
         :input (v1 v2 v3 v4) :output (result))))

(synth-fun twoandthree() B)

;; solution: ~v1 ^ v2 ^ v3

(constraint (B.Sem twoandthree false true true false true))
(constraint (B.Sem twoandthree false true false false false))
(constraint (B.Sem twoandthree true true true false false))
(constraint (B.Sem twoandthree false false true false false))

(check-synth)
