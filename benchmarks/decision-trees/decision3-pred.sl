;; (set-info :format-version "2.4.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

(declare-term-types
    ;; Nonterminals
    ((T 0) (P 0) (V 0))

    ;; Productions
    (
        ( ; T productions
            ($pred P T T)
            ($true)
            ($false)
        )
        ( ; P productions
            ($< V V)
        )
        ( ; V productions
            ($x)
            ($y)
            ($z)
            ($0)
            ($1)
        )
    )
)

(define-funs-rec
    ((T.Sem ((tt T) (x Int) (y Int) (z Int) (result Bool)) Bool)
     (P.Sem ((pt P) (x Int) (y Int) (z Int) (result Bool)) Bool)
     (V.Sem ((vt V) (x Int) (y Int) (z Int) (result Int)) Bool))

    ((! (match tt
        ((($pred t1 t2 t3) 
            (exists ((b Bool)) (and 
                (P.Sem t1 x y z b)
                (= b true)
                (T.Sem t2 x y z result)))
            (exists ((b Bool)) (and
                (P.Sem t1 x y z b)
                (= b false)
                (T.Sem t3 x y z result))))
          ($true (= result true))
          ($false (= result false))))
        :input (x y z) :output (result))

     (! (match pt
        ((($< vt1 vt2)
         (exists ((r1 Int) (r2 Int))
            (and
                (V.Sem vt1 x y z r1)
                (V.Sem vt2 x y z r2)
                (= result (< r1 r2)))))))
         :input (x y z) :output (result))

     (! (match vt
        (($x (= result x))
         ($y (= result y))
         ($z (= result z))
         ($0 (= result 0))
         ($1 (= result 1))))
         :input (x y z) :output (result))))

(synth-fun tree() T)

(constraint (T.Sem tree 1 1 1 true))
(constraint (T.Sem tree 1 0 1 false))
(constraint (T.Sem tree 0 1 1 false))
(constraint (T.Sem tree 0 1 0 true))

(check-synth)
