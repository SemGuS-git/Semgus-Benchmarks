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
            ($leaf V)
        )
        ( ; P productions
            ($x>0)
            ($y>0)
            ($z>0)
        )
        ( ; V productions
            ($true)
            ($false)
        )
    )
)

(define-funs-rec
    ((T.Sem ((tt T) (x Int) (y Int) (z Int) (result Bool)) Bool)
     (P.Sem ((pt P) (x Int) (y Int) (z Int) (result Bool)) Bool)
     (V.Sem ((vt V) (result Bool)) Bool))

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
         (($leaf t1)
            (exists ((b Bool)) 
                (V.Sem t1 result)))))
        :input (x y z) :output (result))

     (! (match pt
        (($x>0 (= result (> x 0)))
         ($y>0 (= result (> y 0)))
         ($z>0 (= result (> z 0)))))
         :input (x y z) :output (result))

     (! (match vt
        (($true (= result true))
         ($false (= result false))))
         :input ( ) :output (result))))

(synth-fun tree() T)

;; solution: (x > 0 ^ y > 0) v (x <= 0 ^ z <= 0)

(constraint (T.Sem tree 1 1 1 true))
(constraint (T.Sem tree 1 0 1 false))
(constraint (T.Sem tree 0 1 1 false))
(constraint (T.Sem tree 0 1 0 true))

(check-synth)
