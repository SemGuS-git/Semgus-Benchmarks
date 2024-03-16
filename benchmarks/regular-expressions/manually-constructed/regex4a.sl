(declare-term-types
    ;; Nonterminals
    ((Start 0) (R 0))
    
    ;; Productions
    (
        (($eval R))
    
        (
            ($eps)
            ($phi)
            ($char_1)
            ($char_2)
            ($char_3)
            ($char_4)
            ($any)
            ($or R R)
            ($concat R R)
            ($star R)
        )
    )
)

(define-funs-rec
    (
        (Start.Sem ((t Start) (s_0 Int) (s_1 Int) (s_2 Int) (s_3 Int) (result Bool)) Bool)
        (R.Sem ((t R) (s_0 Int) (s_1 Int) (s_2 Int) (s_3 Int) (X_0_0 Bool) (X_0_1 Bool) (X_0_2 Bool) (X_0_3 Bool) (X_0_4 Bool)
               (X_1_2 Bool) (X_1_3 Bool) (X_1_4 Bool) (X_2_3 Bool) (X_2_4 Bool) (X_3_4 Bool)) Bool)
    )
    
    (
        (! (match t (
            (($eval t1) (exists
                ( (X_0_0 Bool) (X_0_1 Bool) (X_0_2 Bool) (X_0_3 Bool) (X_0_4 Bool) 
                  (X_1_2 Bool) (X_1_3 Bool) (X_1_4 Bool) (X_2_3 Bool) (X_2_4 Bool) (X_3_4 Bool))
                (and
                    (R.Sem t1 s_0 s_1 s_2 s_3 X_0_0 X_0_1 X_0_2 X_0_3 X_0_4 X_1_2 X_1_3 X_1_4 X_2_3 X_2_4 X_3_4)
                    (= result X_0_4)
                )
            ))
        )) :input ( s_0 s_1 s_2 s_3) :output (result))
        (! (match t (
            ($eps (and  (= X_0_0 true) (= X_0_1 false) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) 
              (= X_1_2 false) (= X_1_3 false) (= X_1_4 false) (= X_2_3 false) (= X_2_4 false) (= X_3_4 false)))
            ($phi (and  (= X_0_0 false) (= X_0_1 false) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) 
              (= X_1_2 false) (= X_1_3 false) (= X_1_4 false) (= X_2_3 false) (= X_2_4 false) (= X_3_4 false)))
            ($any (and  (= X_0_0 false) (= X_0_1 true) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) (= X_1_2 true) (= X_1_3 false) (= X_1_4 false) (= X_2_3 true) (= X_2_4 false) (= X_3_4 true)))
            ($char_1 (and  (= X_0_0 false) (= X_0_1 (= s_0 1)) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) (= X_1_2 (= s_1 1)) (= X_1_3 false) (= X_1_4 false) (= X_2_3 (= s_2 1)) (= X_2_4 false) (= X_3_4 (= s_3 1))))
            ($char_2 (and  (= X_0_0 false) (= X_0_1 (= s_0 2)) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) (= X_1_2 (= s_1 2)) (= X_1_3 false) (= X_1_4 false) (= X_2_3 (= s_2 2)) (= X_2_4 false) (= X_3_4 (= s_3 2))))
            ($char_3 (and  (= X_0_0 false) (= X_0_1 (= s_0 3)) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) (= X_1_2 (= s_1 3)) (= X_1_3 false) (= X_1_4 false) (= X_2_3 (= s_2 3)) (= X_2_4 false) (= X_3_4 (= s_3 3))))
            ($char_4 (and  (= X_0_0 false) (= X_0_1 (= s_0 4)) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) (= X_1_2 (= s_1 4)) (= X_1_3 false) (= X_1_4 false) (= X_2_3 (= s_2 4)) (= X_2_4 false) (= X_3_4 (= s_3 4))))
            (($or t1 t2)
                (exists
                    (
                         (A_0_0 Bool) (A_0_1 Bool) (A_0_2 Bool) (A_0_3 Bool) (A_0_4 Bool) (A_1_2 Bool) (A_1_3 Bool) (A_1_4 Bool) (A_2_3 Bool) (A_2_4 Bool) (A_3_4 Bool)
                         (B_0_0 Bool) (B_0_1 Bool) (B_0_2 Bool) (B_0_3 Bool) (B_0_4 Bool) (B_1_2 Bool) (B_1_3 Bool) (B_1_4 Bool) (B_2_3 Bool) (B_2_4 Bool) (B_3_4 Bool)
                    )
                    (and 
                        (R.Sem t1 s_0 s_1 s_2 s_3 A_0_0 A_0_1 A_0_2 A_0_3 A_0_4 A_1_2 A_1_3 A_1_4 A_2_3 A_2_4 A_3_4)
                        (R.Sem t2 s_0 s_1 s_2 s_3 B_0_0 B_0_1 B_0_2 B_0_3 B_0_4 B_1_2 B_1_3 B_1_4 B_2_3 B_2_4 B_3_4)
                        (and
                            (= X_0_0 (or A_0_0 B_0_0))
                            (= X_0_1 (or A_0_1 B_0_1))
                            (= X_0_2 (or A_0_2 B_0_2))
                            (= X_0_3 (or A_0_3 B_0_3))
                            (= X_0_4 (or A_0_4 B_0_4))
                            (= X_1_2 (or A_1_2 B_1_2))
                            (= X_1_3 (or A_1_3 B_1_3))
                            (= X_1_4 (or A_1_4 B_1_4))
                            (= X_2_3 (or A_2_3 B_2_3))
                            (= X_2_4 (or A_2_4 B_2_4))
                            (= X_3_4 (or A_3_4 B_3_4))
                        )
                    )
                )
            )
            (($concat t1 t2)
                (exists
                    (
                         (A_0_0 Bool) (A_0_1 Bool) (A_0_2 Bool) (A_0_3 Bool) (A_0_4 Bool) (A_1_2 Bool) (A_1_3 Bool) (A_1_4 Bool) (A_2_3 Bool) (A_2_4 Bool) (A_3_4 Bool)
                         (B_0_0 Bool) (B_0_1 Bool) (B_0_2 Bool) (B_0_3 Bool) (B_0_4 Bool) (B_1_2 Bool) (B_1_3 Bool) (B_1_4 Bool) (B_2_3 Bool) (B_2_4 Bool) (B_3_4 Bool)
                    )
                    (and 
                        (R.Sem t1 s_0 s_1 s_2 s_3 A_0_0 A_0_1 A_0_2 A_0_3 A_0_4 A_1_2 A_1_3 A_1_4 A_2_3 A_2_4 A_3_4)
                        (R.Sem t2 s_0 s_1 s_2 s_3 B_0_0 B_0_1 B_0_2 B_0_3 B_0_4 B_1_2 B_1_3 B_1_4 B_2_3 B_2_4 B_3_4)
                        (and
                            (= X_0_0 (and A_0_0 B_0_0))
                            (= X_0_1 (or (and A_0_0 B_0_1) (and A_0_1 B_0_0)))
                            (= X_0_2 (or (and A_0_0 B_0_2) (and A_0_1 B_1_2) (and A_0_2 B_0_0)))
                            (= X_0_3 (or (and A_0_0 B_0_3) (and A_0_1 B_1_3) (and A_0_2 B_2_3) (and A_0_3 B_0_0)))
                            (= X_0_4 (or (and A_0_0 B_0_4) (and A_0_1 B_1_4) (and A_0_2 B_2_4) (and A_0_3 B_3_4) (and A_0_4 B_0_0)))
                            (= X_1_2 (or (and A_0_0 B_1_2) (and A_1_2 B_0_0)))
                            (= X_1_3 (or (and A_0_0 B_1_3) (and A_1_2 B_2_3) (and A_1_3 B_0_0)))
                            (= X_1_4 (or (and A_0_0 B_1_4) (and A_1_2 B_2_4) (and A_1_3 B_3_4) (and A_1_4 B_0_0)))
                            (= X_2_3 (or (and A_0_0 B_2_3) (and A_2_3 B_0_0)))
                            (= X_2_4 (or (and A_0_0 B_2_4) (and A_2_3 B_3_4) (and A_2_4 B_0_0)))
                            (= X_3_4 (or (and A_0_0 B_3_4) (and A_3_4 B_0_0)))
                            
                        )
                    )
                )
            )
            (($star t1)
                (exists
                    (
                         (A_0_0 Bool) (A_0_1 Bool) (A_0_2 Bool) (A_0_3 Bool) (A_0_4 Bool) (A_1_2 Bool) (A_1_3 Bool) (A_1_4 Bool) (A_2_3 Bool) (A_2_4 Bool) (A_3_4 Bool)
                    )
                    (and 
                        (R.Sem t1 s_0 s_1 s_2 s_3 A_0_0 A_0_1 A_0_2 A_0_3 A_0_4 A_1_2 A_1_3 A_1_4 A_2_3 A_2_4 A_3_4)
                        
                        (and
                        (= X_0_0 true)
                        (= X_0_1 A_0_1)
                        (= X_0_2 (or A_0_2 (and A_0_1 A_1_2)))
                        (= X_0_3 (or A_0_3 (and A_0_2 A_2_3) (and A_0_1 A_1_3) (and A_0_1 A_1_2 A_2_3)))
                        (= X_0_4 (or A_0_4 (and A_0_3 A_3_4) (and A_0_2 A_2_4) (and A_0_1 A_1_4) (and A_0_1 A_1_2 A_2_4) (and A_0_1 A_1_3 A_3_4) (and A_0_2 A_2_3 A_3_4) (and A_0_1 A_1_2 A_2_3 A_3_4)))

                        
                        (= X_1_2 A_1_2)
                        (= X_1_3 (or A_1_3 (and A_1_2 A_2_3)))
                        (= X_1_4 (or A_1_4 (and A_1_3 A_3_4) (and A_1_2 A_2_4) (and A_1_2 A_2_3 A_3_4)))

                        
                        (= X_2_3 A_2_3)
                        (= X_2_4 (or A_2_4 (and A_2_3 A_3_4)))
                        
                        (= X_3_4 A_3_4)
                        
                        )
                    )
                )
            )
        )) :input ( s_0 s_1 s_2 s_3) :output ( X_0_0 X_0_1 X_0_2 X_0_3 X_0_4 X_1_2 X_1_3 X_1_4 X_2_3 X_2_4 X_3_4))
    )
)

(synth-fun match_regex() Start)

(constraint (Start.Sem match_regex 1 1 3 4 true))
(constraint (Start.Sem match_regex 1 2 1 2 true))
(constraint (Start.Sem match_regex 3 4 3 4 true))
(constraint (Start.Sem match_regex 2 1 1 2 false))
(constraint (Start.Sem match_regex 3 4 2 1 false))
(constraint (Start.Sem match_regex 3 4 4 4 false))
(constraint (Start.Sem match_regex 1 1 1 2 false))


(check-synth)
