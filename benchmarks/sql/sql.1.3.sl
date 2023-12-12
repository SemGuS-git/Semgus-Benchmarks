;; Toy SQL query -- monotonicity shouldn't help here

;; (set-info :format-version "2.4.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

(declare-term-types
    ;; Nonterminals
    ((Start 0) (Q 0) (P 0))

    ;; Productions
    (
        (($select Q))

        (($where P))

        (
            ($>10)
            ($>20)
        )
    )
)

(define-funs-rec
    (
        (Start.Sem ((t Start) (t1 Int) (t2 Int) (t3 Int) (b1 Bool) (b2 Bool) (b3 Bool)) Bool)
        (Q.Sem ((qt Q) (t1 Int) (t2 Int) (t3 Int) (b1 Bool) (b2 Bool) (b3 Bool)) Bool)
        (P.Sem ((pt P) (t1 Int) (t2 Int) (t3 Int) (b1 Bool) (b2 Bool) (b3 Bool)) Bool)
    )
    (
        (! (match t (
            (($select qt1) 
                (Q.Sem qt1 t1 t2 t3 b1 b2 b3))))
            :input (t1 t2 t3) :output (b1 b2 b3))
        (! (match qt (
            (($where pt1)
                (P.Sem pt1 t1 t2 t3 b1 b2 b3))))
            :input (t1 t2 t3) :output (b1 b2 b3))
        (! (match pt (
            ($>10
                (and
                    (= b1 (> t1 10))
                    (= b2 (> t2 10))
                    (= b3 (> t3 10))))
            ($>20
                (and
                    (= b1 (> t1 20))
                    (= b2 (> t2 20))
                    (= b3 (> t3 20))))))
            :input (t1 t2 t3) :output (b1 b2 b3))
    )
)

(synth-fun query () Start)

(constraint (Start.Sem query 10 11 21 false false true))

;; SELECT * WHERE >20

(check-synth)
