;; SQL query -- choose from 3 tables 

;; (set-info :format-version "2.4.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

(declare-term-types
    ;; Nonterminals
    ((F 0) (W 0) (P 0))

    ;; Productions
    (
        (
            ($from_t1 W)
            ($from_t2 W)
            ($from_t3 W)
        )
        (($where P))

        (
            ($>0)
            ($>10)
            ($>20)
            ($>30)
        )
    )
)

(define-funs-rec
    (
        (F.Sem ((ft F) (t_1_1 Int) (t_1_2 Int) (t_1_3 Int) (t_2_1 Int) (t_2_2 Int) (t_2_3 Int) (t_3_1 Int) (t_3_2 Int) (t_3_3 Int) (b_1_1 Bool) (b_1_2 Bool) (b_1_3 Bool) (b_2_1 Bool) (b_2_2 Bool) (b_2_3 Bool) (b_3_1 Bool) (b_3_2 Bool) (b_3_3 Bool)) Bool)
        (W.Sem ((wt W) (t_1_1 Int) (t_1_2 Int) (t_1_3 Int) (t_2_1 Int) (t_2_2 Int) (t_2_3 Int) (t_3_1 Int) (t_3_2 Int) (t_3_3 Int) (b_1_1 Bool) (b_1_2 Bool) (b_1_3 Bool) (b_2_1 Bool) (b_2_2 Bool) (b_2_3 Bool) (b_3_1 Bool) (b_3_2 Bool) (b_3_3 Bool)) Bool)
        (P.Sem ((pt P) (t_1_1 Int) (t_1_2 Int) (t_1_3 Int) (t_2_1 Int) (t_2_2 Int) (t_2_3 Int) (t_3_1 Int) (t_3_2 Int) (t_3_3 Int) (b_1_1 Bool) (b_1_2 Bool) (b_1_3 Bool) (b_2_1 Bool) (b_2_2 Bool) (b_2_3 Bool) (b_3_1 Bool) (b_3_2 Bool) (b_3_3 Bool)) Bool)
    )
    (
        (! (match ft (
            (($from_t1 wt1) (exists ((b1 Bool) (b2 Bool) (b3 Bool) (b4 Bool) (b5 Bool) (b6 Bool) (b7 Bool) (b8 Bool) (b9 Bool))
                (and
                    (W.Sem wt1 t_1_1 t_1_2 t_1_3 t_2_1 t_2_2 t_2_3 t_3_1 t_3_2 t_3_3 b1 b2 b3 b4 b5 b6 b7 b8 b9) 
                    (= b_1_1 b1)
                    (= b_1_2 b2)
                    (= b_1_3 b3)
                    (= b_2_1 false)
                    (= b_2_2 false)
                    (= b_2_3 false)
                    (= b_3_1 false)
                    (= b_3_2 false)
                    (= b_3_3 false)
                )))
            (($from_t2 wt1) (exists ((b1 Bool) (b2 Bool) (b3 Bool) (b4 Bool) (b5 Bool) (b6 Bool) (b7 Bool) (b8 Bool) (b9 Bool))
                (and
                    (W.Sem wt1 t_1_1 t_1_2 t_1_3 t_2_1 t_2_2 t_2_3 t_3_1 t_3_2 t_3_3 b1 b2 b3 b4 b5 b6 b7 b8 b9) 
                    (= b_1_1 false)
                    (= b_1_2 false)
                    (= b_1_3 false)
                    (= b_2_1 b4)
                    (= b_2_2 b5)
                    (= b_2_3 b6)
                    (= b_3_1 false)
                    (= b_3_2 false)
                    (= b_3_3 false)
                )))
            (($from_t3 wt1) (exists ((b1 Bool) (b2 Bool) (b3 Bool) (b4 Bool) (b5 Bool) (b6 Bool) (b7 Bool) (b8 Bool) (b9 Bool)) 
                (and
                    (W.Sem wt1 t_1_1 t_1_2 t_1_3 t_2_1 t_2_2 t_2_3 t_3_1 t_3_2 t_3_3 b1 b2 b3 b4 b5 b6 b7 b8 b9) 
                    (= b_1_1 false)
                    (= b_1_2 false)
                    (= b_1_3 false)
                    (= b_2_1 false)
                    (= b_2_2 false)
                    (= b_2_3 false)
                    (= b_3_1 b7)
                    (= b_3_2 b8)
                    (= b_3_3 b9)
                )))))
            :input (t_1_1 t_1_2 t_1_3 t_2_1 t_2_2 t_2_3 t_3_1 t_3_2 t_3_3) :output (b_1_1 b_1_2 b_1_3 b_2_1 b_2_2 b_2_3 b_3_1 b_3_2 b_3_3))
        (! (match wt (
            (($where pt1) (exists ((b1 Bool) (b2 Bool) (b3 Bool) (b4 Bool) (b5 Bool) (b6 Bool) (b7 Bool) (b8 Bool) (b9 Bool))
                (and
                    (P.Sem pt1 t_1_1 t_1_2 t_1_3 t_2_1 t_2_2 t_2_3 t_3_1 t_3_2 t_3_3 b1 b2 b3 b4 b5 b6 b7 b8 b9)
                    (= b_1_1 b1)
                    (= b_1_2 b2)
                    (= b_1_3 b3)
                    (= b_2_1 b4)
                    (= b_2_2 b5)
                    (= b_2_3 b6)
                    (= b_3_1 b7)
                    (= b_3_2 b8)
                    (= b_3_3 b9))))))
            :input (t_1_1 t_1_2 t_1_3 t_2_1 t_2_2 t_2_3 t_3_1 t_3_2 t_3_3) :output (b_1_1 b_1_2 b_1_3 b_2_1 b_2_2 b_2_3 b_3_1 b_3_2 b_3_3))
        (! (match pt (
            ($>0
                (and
                    (= b_1_1 (> t_1_1 0))
                    (= b_1_2 (> t_1_2 0))
                    (= b_1_3 (> t_1_3 0))
                    (= b_2_1 (> t_2_1 0))
                    (= b_2_2 (> t_2_2 0))
                    (= b_2_3 (> t_2_3 0))
                    (= b_3_1 (> t_3_1 0))
                    (= b_3_2 (> t_3_2 0))
                    (= b_3_3 (> t_3_3 0))))
            ($>10
                (and
                    (= b_1_1 (> t_1_1 10))
                    (= b_1_2 (> t_1_2 10))
                    (= b_1_3 (> t_1_3 10))
                    (= b_2_1 (> t_2_1 10))
                    (= b_2_2 (> t_2_2 10))
                    (= b_2_3 (> t_2_3 10))
                    (= b_3_1 (> t_3_1 10))
                    (= b_3_2 (> t_3_2 10))
                    (= b_3_3 (> t_3_3 10))))
            ($>20
                (and
                    (= b_1_1 (> t_1_1 20))
                    (= b_1_2 (> t_1_2 20))
                    (= b_1_3 (> t_1_3 20))
                    (= b_2_1 (> t_2_1 20))
                    (= b_2_2 (> t_2_2 20))
                    (= b_2_3 (> t_2_3 20))
                    (= b_3_1 (> t_3_1 20))
                    (= b_3_2 (> t_3_2 20))
                    (= b_3_3 (> t_3_3 20))))
            ($>30
                (and
                    (= b_1_1 (> t_1_1 30))
                    (= b_1_2 (> t_1_2 30))
                    (= b_1_3 (> t_1_3 30))
                    (= b_2_1 (> t_2_1 30))
                    (= b_2_2 (> t_2_2 30))
                    (= b_2_3 (> t_2_3 30))
                    (= b_3_1 (> t_3_1 30))
                    (= b_3_2 (> t_3_2 30))
                    (= b_3_3 (> t_3_3 30))))))
            :input (t_1_1 t_1_2 t_1_3 t_2_1 t_2_2 t_2_3 t_3_1 t_3_2 t_3_3) :output (b_1_1 b_1_2 b_1_3 b_2_1 b_2_2 b_2_3 b_3_1 b_3_2 b_3_3))
    )
)

(synth-fun query () F)

(constraint (F.Sem query 1 11 21 11 10 21 31 21 1 false false false false false false true true true))

;; SELECT * FROM t3 WHERE >0

(check-synth)
