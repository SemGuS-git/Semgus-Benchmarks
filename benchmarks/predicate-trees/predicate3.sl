;; (set-info :format-version "2.4.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

(declare-term-types
    ;; Nonterminals
    ((T 0) (P 0))

    ;; Productions
    (
        ( ; T productions
            ($pred P)
            ($and P T)
        )
        ( ; P productions
            ($x>0)
            ($y>0)
            ($z>0)
        )
    )
)

(define-funs-rec
    ((T.Sem ((tt T) (x Int) (y Int) (z Int) (result Bool)) Bool)
     (P.Sem ((pt P) (x Int) (y Int) (z Int) (result Bool)) Bool))

    ((! (match tt
        ((($pred pt) (exists ((r Bool))
            (and (P.Sem pt x y z r)
                (= result r))))
         (($and pt1 tt2) (exists ((r1 Bool) (r2 Bool))
            (and
                (P.Sem pt1 x y z r1)
                (T.Sem tt2 x y z r2)
                (= result (and r1 r2)))))))
        :input (x y z) :output (result))

     (! (match pt
        (($x>0 (= result (> x 0)))
         ($y>0 (= result (> y 0)))
         ($z>0 (= result (> z 0)))))
         :input (x y z) :output (result))))

(synth-fun tree() T)

(constraint (T.Sem tree 1 1 0 true))
(constraint (T.Sem tree 1 1 1 false))
(constraint (T.Sem tree 0 1 0 false))
(constraint (T.Sem tree 1 0 0 false))

(check-synth)
