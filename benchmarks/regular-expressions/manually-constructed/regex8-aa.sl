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
            ($char_5)
            ($char_6)
            ($char_7)
            ($char_8)
            ($any)
            ($or R R)
            ($concat R R)
            ($star R)
        )
    )
)

(define-funs-rec
    (
        (Start.Sem ((t Start) (s_0 Int) (s_1 Int) (s_2 Int) (s_3 Int) (s_4 Int) (s_5 Int) (s_6 Int) (s_7 Int) (result Bool)) Bool)
        (R.Sem ((t R) (s_0 Int) (s_1 Int) (s_2 Int) (s_3 Int) (s_4 Int) (s_5 Int) (s_6 Int) (s_7 Int) (X_0_0 Bool) (X_0_1 Bool) (X_0_2 Bool) (X_0_3 Bool) (X_0_4 Bool) (X_0_5 Bool) (X_0_6 Bool) (X_0_7 Bool) (X_0_8 Bool) (X_1_2 Bool) (X_1_3 Bool) (X_1_4 Bool) (X_1_5 Bool) (X_1_6 Bool) (X_1_7 Bool) (X_1_8 Bool) (X_2_3 Bool) (X_2_4 Bool) (X_2_5 Bool) (X_2_6 Bool) (X_2_7 Bool) (X_2_8 Bool) (X_3_4 Bool) (X_3_5 Bool) (X_3_6 Bool) (X_3_7 Bool) (X_3_8 Bool) (X_4_5 Bool) (X_4_6 Bool) (X_4_7 Bool) (X_4_8 Bool) (X_5_6 Bool) (X_5_7 Bool) (X_5_8 Bool) (X_6_7 Bool) (X_6_8 Bool) (X_7_8 Bool) ) Bool)
    )
    
    (
        (! (match t (
            (($eval t1) (exists
                ( (X_0_0 Bool) (X_0_1 Bool) (X_0_2 Bool) (X_0_3 Bool) (X_0_4 Bool) (X_0_5 Bool) (X_0_6 Bool) (X_0_7 Bool) (X_0_8 Bool) (X_1_2 Bool) (X_1_3 Bool) (X_1_4 Bool) (X_1_5 Bool) (X_1_6 Bool) (X_1_7 Bool) (X_1_8 Bool) (X_2_3 Bool) (X_2_4 Bool) (X_2_5 Bool) (X_2_6 Bool) (X_2_7 Bool) (X_2_8 Bool) (X_3_4 Bool) (X_3_5 Bool) (X_3_6 Bool) (X_3_7 Bool) (X_3_8 Bool) (X_4_5 Bool) (X_4_6 Bool) (X_4_7 Bool) (X_4_8 Bool) (X_5_6 Bool) (X_5_7 Bool) (X_5_8 Bool) (X_6_7 Bool) (X_6_8 Bool) (X_7_8 Bool) )
                (and
                    (R.Sem t1 s_0 s_1 s_2 s_3 s_4 s_5 s_6 s_7 X_0_0 X_0_1 X_0_2 X_0_3 X_0_4 X_0_5 X_0_6 X_0_7 X_0_8 X_1_2 X_1_3 X_1_4 X_1_5 X_1_6 X_1_7 X_1_8 X_2_3 X_2_4 X_2_5 X_2_6 X_2_7 X_2_8 X_3_4 X_3_5 X_3_6 X_3_7 X_3_8 X_4_5 X_4_6 X_4_7 X_4_8 X_5_6 X_5_7 X_5_8 X_6_7 X_6_8 X_7_8)
                    (= result X_0_8)
                )
            ))
        )) :input ( s_0 s_1 s_2 s_3 s_4 s_5 s_6 s_7) :output (result))
        (! (match t (
            ($eps (and  (= X_0_0 true) (= X_0_1 false) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) (= X_0_5 false) (= X_0_6 false) (= X_0_7 false) (= X_0_8 false)  (= X_1_2 false) (= X_1_3 false) (= X_1_4 false) (= X_1_5 false) (= X_1_6 false) (= X_1_7 false) (= X_1_8 false)  (= X_2_3 false) (= X_2_4 false) (= X_2_5 false) (= X_2_6 false) (= X_2_7 false) (= X_2_8 false)  (= X_3_4 false) (= X_3_5 false) (= X_3_6 false) (= X_3_7 false) (= X_3_8 false)  (= X_4_5 false) (= X_4_6 false) (= X_4_7 false) (= X_4_8 false)  (= X_5_6 false) (= X_5_7 false) (= X_5_8 false)  (= X_6_7 false) (= X_6_8 false)  (= X_7_8 false) ))
            ($phi (and  (= X_0_0 false) (= X_0_1 false) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) (= X_0_5 false) (= X_0_6 false) (= X_0_7 false) (= X_0_8 false)  (= X_1_2 false) (= X_1_3 false) (= X_1_4 false) (= X_1_5 false) (= X_1_6 false) (= X_1_7 false) (= X_1_8 false)  (= X_2_3 false) (= X_2_4 false) (= X_2_5 false) (= X_2_6 false) (= X_2_7 false) (= X_2_8 false)  (= X_3_4 false) (= X_3_5 false) (= X_3_6 false) (= X_3_7 false) (= X_3_8 false)  (= X_4_5 false) (= X_4_6 false) (= X_4_7 false) (= X_4_8 false)  (= X_5_6 false) (= X_5_7 false) (= X_5_8 false)  (= X_6_7 false) (= X_6_8 false)  (= X_7_8 false) ))
            ($any (and  (= X_0_0 false) (= X_0_1 true) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) (= X_0_5 false) (= X_0_6 false) (= X_0_7 false) (= X_0_8 false)  (= X_1_2 true) (= X_1_3 false) (= X_1_4 false) (= X_1_5 false) (= X_1_6 false) (= X_1_7 false) (= X_1_8 false)  (= X_2_3 true) (= X_2_4 false) (= X_2_5 false) (= X_2_6 false) (= X_2_7 false) (= X_2_8 false)  (= X_3_4 true) (= X_3_5 false) (= X_3_6 false) (= X_3_7 false) (= X_3_8 false)  (= X_4_5 true) (= X_4_6 false) (= X_4_7 false) (= X_4_8 false)  (= X_5_6 true) (= X_5_7 false) (= X_5_8 false)  (= X_6_7 true) (= X_6_8 false)  (= X_7_8 true) ))
                ($char_1 (and  (= X_0_0 false) (= X_0_1 (= s_0 1)) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) (= X_0_5 false) (= X_0_6 false) (= X_0_7 false) (= X_0_8 false)  (= X_1_2 (= s_1 1)) (= X_1_3 false) (= X_1_4 false) (= X_1_5 false) (= X_1_6 false) (= X_1_7 false) (= X_1_8 false)  (= X_2_3 (= s_2 1)) (= X_2_4 false) (= X_2_5 false) (= X_2_6 false) (= X_2_7 false) (= X_2_8 false)  (= X_3_4 (= s_3 1)) (= X_3_5 false) (= X_3_6 false) (= X_3_7 false) (= X_3_8 false)  (= X_4_5 (= s_4 1)) (= X_4_6 false) (= X_4_7 false) (= X_4_8 false)  (= X_5_6 (= s_5 1)) (= X_5_7 false) (= X_5_8 false)  (= X_6_7 (= s_6 1)) (= X_6_8 false)  (= X_7_8 (= s_7 1)) ))
                ($char_2 (and  (= X_0_0 false) (= X_0_1 (= s_0 2)) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) (= X_0_5 false) (= X_0_6 false) (= X_0_7 false) (= X_0_8 false)  (= X_1_2 (= s_1 2)) (= X_1_3 false) (= X_1_4 false) (= X_1_5 false) (= X_1_6 false) (= X_1_7 false) (= X_1_8 false)  (= X_2_3 (= s_2 2)) (= X_2_4 false) (= X_2_5 false) (= X_2_6 false) (= X_2_7 false) (= X_2_8 false)  (= X_3_4 (= s_3 2)) (= X_3_5 false) (= X_3_6 false) (= X_3_7 false) (= X_3_8 false)  (= X_4_5 (= s_4 2)) (= X_4_6 false) (= X_4_7 false) (= X_4_8 false)  (= X_5_6 (= s_5 2)) (= X_5_7 false) (= X_5_8 false)  (= X_6_7 (= s_6 2)) (= X_6_8 false)  (= X_7_8 (= s_7 2)) ))
                ($char_3 (and  (= X_0_0 false) (= X_0_1 (= s_0 3)) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) (= X_0_5 false) (= X_0_6 false) (= X_0_7 false) (= X_0_8 false)  (= X_1_2 (= s_1 3)) (= X_1_3 false) (= X_1_4 false) (= X_1_5 false) (= X_1_6 false) (= X_1_7 false) (= X_1_8 false)  (= X_2_3 (= s_2 3)) (= X_2_4 false) (= X_2_5 false) (= X_2_6 false) (= X_2_7 false) (= X_2_8 false)  (= X_3_4 (= s_3 3)) (= X_3_5 false) (= X_3_6 false) (= X_3_7 false) (= X_3_8 false)  (= X_4_5 (= s_4 3)) (= X_4_6 false) (= X_4_7 false) (= X_4_8 false)  (= X_5_6 (= s_5 3)) (= X_5_7 false) (= X_5_8 false)  (= X_6_7 (= s_6 3)) (= X_6_8 false)  (= X_7_8 (= s_7 3)) ))
                ($char_4 (and  (= X_0_0 false) (= X_0_1 (= s_0 4)) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) (= X_0_5 false) (= X_0_6 false) (= X_0_7 false) (= X_0_8 false)  (= X_1_2 (= s_1 4)) (= X_1_3 false) (= X_1_4 false) (= X_1_5 false) (= X_1_6 false) (= X_1_7 false) (= X_1_8 false)  (= X_2_3 (= s_2 4)) (= X_2_4 false) (= X_2_5 false) (= X_2_6 false) (= X_2_7 false) (= X_2_8 false)  (= X_3_4 (= s_3 4)) (= X_3_5 false) (= X_3_6 false) (= X_3_7 false) (= X_3_8 false)  (= X_4_5 (= s_4 4)) (= X_4_6 false) (= X_4_7 false) (= X_4_8 false)  (= X_5_6 (= s_5 4)) (= X_5_7 false) (= X_5_8 false)  (= X_6_7 (= s_6 4)) (= X_6_8 false)  (= X_7_8 (= s_7 4)) ))
                ($char_5 (and  (= X_0_0 false) (= X_0_1 (= s_0 5)) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) (= X_0_5 false) (= X_0_6 false) (= X_0_7 false) (= X_0_8 false)  (= X_1_2 (= s_1 5)) (= X_1_3 false) (= X_1_4 false) (= X_1_5 false) (= X_1_6 false) (= X_1_7 false) (= X_1_8 false)  (= X_2_3 (= s_2 5)) (= X_2_4 false) (= X_2_5 false) (= X_2_6 false) (= X_2_7 false) (= X_2_8 false)  (= X_3_4 (= s_3 5)) (= X_3_5 false) (= X_3_6 false) (= X_3_7 false) (= X_3_8 false)  (= X_4_5 (= s_4 5)) (= X_4_6 false) (= X_4_7 false) (= X_4_8 false)  (= X_5_6 (= s_5 5)) (= X_5_7 false) (= X_5_8 false)  (= X_6_7 (= s_6 5)) (= X_6_8 false)  (= X_7_8 (= s_7 5)) ))
                ($char_6 (and  (= X_0_0 false) (= X_0_1 (= s_0 6)) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) (= X_0_5 false) (= X_0_6 false) (= X_0_7 false) (= X_0_8 false)  (= X_1_2 (= s_1 6)) (= X_1_3 false) (= X_1_4 false) (= X_1_5 false) (= X_1_6 false) (= X_1_7 false) (= X_1_8 false)  (= X_2_3 (= s_2 6)) (= X_2_4 false) (= X_2_5 false) (= X_2_6 false) (= X_2_7 false) (= X_2_8 false)  (= X_3_4 (= s_3 6)) (= X_3_5 false) (= X_3_6 false) (= X_3_7 false) (= X_3_8 false)  (= X_4_5 (= s_4 6)) (= X_4_6 false) (= X_4_7 false) (= X_4_8 false)  (= X_5_6 (= s_5 6)) (= X_5_7 false) (= X_5_8 false)  (= X_6_7 (= s_6 6)) (= X_6_8 false)  (= X_7_8 (= s_7 6)) ))
                ($char_7 (and  (= X_0_0 false) (= X_0_1 (= s_0 7)) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) (= X_0_5 false) (= X_0_6 false) (= X_0_7 false) (= X_0_8 false)  (= X_1_2 (= s_1 7)) (= X_1_3 false) (= X_1_4 false) (= X_1_5 false) (= X_1_6 false) (= X_1_7 false) (= X_1_8 false)  (= X_2_3 (= s_2 7)) (= X_2_4 false) (= X_2_5 false) (= X_2_6 false) (= X_2_7 false) (= X_2_8 false)  (= X_3_4 (= s_3 7)) (= X_3_5 false) (= X_3_6 false) (= X_3_7 false) (= X_3_8 false)  (= X_4_5 (= s_4 7)) (= X_4_6 false) (= X_4_7 false) (= X_4_8 false)  (= X_5_6 (= s_5 7)) (= X_5_7 false) (= X_5_8 false)  (= X_6_7 (= s_6 7)) (= X_6_8 false)  (= X_7_8 (= s_7 7)) ))
                ($char_8 (and  (= X_0_0 false) (= X_0_1 (= s_0 8)) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) (= X_0_5 false) (= X_0_6 false) (= X_0_7 false) (= X_0_8 false)  (= X_1_2 (= s_1 8)) (= X_1_3 false) (= X_1_4 false) (= X_1_5 false) (= X_1_6 false) (= X_1_7 false) (= X_1_8 false)  (= X_2_3 (= s_2 8)) (= X_2_4 false) (= X_2_5 false) (= X_2_6 false) (= X_2_7 false) (= X_2_8 false)  (= X_3_4 (= s_3 8)) (= X_3_5 false) (= X_3_6 false) (= X_3_7 false) (= X_3_8 false)  (= X_4_5 (= s_4 8)) (= X_4_6 false) (= X_4_7 false) (= X_4_8 false)  (= X_5_6 (= s_5 8)) (= X_5_7 false) (= X_5_8 false)  (= X_6_7 (= s_6 8)) (= X_6_8 false)  (= X_7_8 (= s_7 8)) ))
                (($or t1 t2)
                (exists
                    (
                         (A_0_0 Bool) (A_0_1 Bool) (A_0_2 Bool) (A_0_3 Bool) (A_0_4 Bool) (A_0_5 Bool) (A_0_6 Bool) (A_0_7 Bool) (A_0_8 Bool) (A_1_2 Bool) (A_1_3 Bool) (A_1_4 Bool) (A_1_5 Bool) (A_1_6 Bool) (A_1_7 Bool) (A_1_8 Bool) (A_2_3 Bool) (A_2_4 Bool) (A_2_5 Bool) (A_2_6 Bool) (A_2_7 Bool) (A_2_8 Bool) (A_3_4 Bool) (A_3_5 Bool) (A_3_6 Bool) (A_3_7 Bool) (A_3_8 Bool) (A_4_5 Bool) (A_4_6 Bool) (A_4_7 Bool) (A_4_8 Bool) (A_5_6 Bool) (A_5_7 Bool) (A_5_8 Bool) (A_6_7 Bool) (A_6_8 Bool) (A_7_8 Bool) 
                         (B_0_0 Bool) (B_0_1 Bool) (B_0_2 Bool) (B_0_3 Bool) (B_0_4 Bool) (B_0_5 Bool) (B_0_6 Bool) (B_0_7 Bool) (B_0_8 Bool) (B_1_2 Bool) (B_1_3 Bool) (B_1_4 Bool) (B_1_5 Bool) (B_1_6 Bool) (B_1_7 Bool) (B_1_8 Bool) (B_2_3 Bool) (B_2_4 Bool) (B_2_5 Bool) (B_2_6 Bool) (B_2_7 Bool) (B_2_8 Bool) (B_3_4 Bool) (B_3_5 Bool) (B_3_6 Bool) (B_3_7 Bool) (B_3_8 Bool) (B_4_5 Bool) (B_4_6 Bool) (B_4_7 Bool) (B_4_8 Bool) (B_5_6 Bool) (B_5_7 Bool) (B_5_8 Bool) (B_6_7 Bool) (B_6_8 Bool) (B_7_8 Bool) 
                    )
                    (and 
                        (R.Sem t1 s_0 s_1 s_2 s_3 s_4 s_5 s_6 s_7 A_0_0 A_0_1 A_0_2 A_0_3 A_0_4 A_0_5 A_0_6 A_0_7 A_0_8 A_1_2 A_1_3 A_1_4 A_1_5 A_1_6 A_1_7 A_1_8 A_2_3 A_2_4 A_2_5 A_2_6 A_2_7 A_2_8 A_3_4 A_3_5 A_3_6 A_3_7 A_3_8 A_4_5 A_4_6 A_4_7 A_4_8 A_5_6 A_5_7 A_5_8 A_6_7 A_6_8 A_7_8)
                        (R.Sem t2 s_0 s_1 s_2 s_3 s_4 s_5 s_6 s_7 B_0_0 B_0_1 B_0_2 B_0_3 B_0_4 B_0_5 B_0_6 B_0_7 B_0_8 B_1_2 B_1_3 B_1_4 B_1_5 B_1_6 B_1_7 B_1_8 B_2_3 B_2_4 B_2_5 B_2_6 B_2_7 B_2_8 B_3_4 B_3_5 B_3_6 B_3_7 B_3_8 B_4_5 B_4_6 B_4_7 B_4_8 B_5_6 B_5_7 B_5_8 B_6_7 B_6_8 B_7_8)
                        (and
                            (= X_0_0 (or A_0_0 B_0_0))
                            (= X_0_1 (or A_0_1 B_0_1))
                            (= X_0_2 (or A_0_2 B_0_2))
                            (= X_0_3 (or A_0_3 B_0_3))
                            (= X_0_4 (or A_0_4 B_0_4))
                            (= X_0_5 (or A_0_5 B_0_5))
                            (= X_0_6 (or A_0_6 B_0_6))
                            (= X_0_7 (or A_0_7 B_0_7))
                            (= X_0_8 (or A_0_8 B_0_8))
                            
                            (= X_1_2 (or A_1_2 B_1_2))
                            (= X_1_3 (or A_1_3 B_1_3))
                            (= X_1_4 (or A_1_4 B_1_4))
                            (= X_1_5 (or A_1_5 B_1_5))
                            (= X_1_6 (or A_1_6 B_1_6))
                            (= X_1_7 (or A_1_7 B_1_7))
                            (= X_1_8 (or A_1_8 B_1_8))
                            
                            (= X_2_3 (or A_2_3 B_2_3))
                            (= X_2_4 (or A_2_4 B_2_4))
                            (= X_2_5 (or A_2_5 B_2_5))
                            (= X_2_6 (or A_2_6 B_2_6))
                            (= X_2_7 (or A_2_7 B_2_7))
                            (= X_2_8 (or A_2_8 B_2_8))
                            
                            (= X_3_4 (or A_3_4 B_3_4))
                            (= X_3_5 (or A_3_5 B_3_5))
                            (= X_3_6 (or A_3_6 B_3_6))
                            (= X_3_7 (or A_3_7 B_3_7))
                            (= X_3_8 (or A_3_8 B_3_8))
                            
                            (= X_4_5 (or A_4_5 B_4_5))
                            (= X_4_6 (or A_4_6 B_4_6))
                            (= X_4_7 (or A_4_7 B_4_7))
                            (= X_4_8 (or A_4_8 B_4_8))
                            
                            (= X_5_6 (or A_5_6 B_5_6))
                            (= X_5_7 (or A_5_7 B_5_7))
                            (= X_5_8 (or A_5_8 B_5_8))
                            
                            (= X_6_7 (or A_6_7 B_6_7))
                            (= X_6_8 (or A_6_8 B_6_8))
                            
                            (= X_7_8 (or A_7_8 B_7_8))
                            
                        )
                    )
                )
            )
            (($concat t1 t2)
                (exists
                    (
                         (A_0_0 Bool) (A_0_1 Bool) (A_0_2 Bool) (A_0_3 Bool) (A_0_4 Bool) (A_0_5 Bool) (A_0_6 Bool) (A_0_7 Bool) (A_0_8 Bool) (A_1_2 Bool) (A_1_3 Bool) (A_1_4 Bool) (A_1_5 Bool) (A_1_6 Bool) (A_1_7 Bool) (A_1_8 Bool) (A_2_3 Bool) (A_2_4 Bool) (A_2_5 Bool) (A_2_6 Bool) (A_2_7 Bool) (A_2_8 Bool) (A_3_4 Bool) (A_3_5 Bool) (A_3_6 Bool) (A_3_7 Bool) (A_3_8 Bool) (A_4_5 Bool) (A_4_6 Bool) (A_4_7 Bool) (A_4_8 Bool) (A_5_6 Bool) (A_5_7 Bool) (A_5_8 Bool) (A_6_7 Bool) (A_6_8 Bool) (A_7_8 Bool) 
                         (B_0_0 Bool) (B_0_1 Bool) (B_0_2 Bool) (B_0_3 Bool) (B_0_4 Bool) (B_0_5 Bool) (B_0_6 Bool) (B_0_7 Bool) (B_0_8 Bool) (B_1_2 Bool) (B_1_3 Bool) (B_1_4 Bool) (B_1_5 Bool) (B_1_6 Bool) (B_1_7 Bool) (B_1_8 Bool) (B_2_3 Bool) (B_2_4 Bool) (B_2_5 Bool) (B_2_6 Bool) (B_2_7 Bool) (B_2_8 Bool) (B_3_4 Bool) (B_3_5 Bool) (B_3_6 Bool) (B_3_7 Bool) (B_3_8 Bool) (B_4_5 Bool) (B_4_6 Bool) (B_4_7 Bool) (B_4_8 Bool) (B_5_6 Bool) (B_5_7 Bool) (B_5_8 Bool) (B_6_7 Bool) (B_6_8 Bool) (B_7_8 Bool) 
                    )
                    (and 
                        (R.Sem t1 s_0 s_1 s_2 s_3 s_4 s_5 s_6 s_7 A_0_0 A_0_1 A_0_2 A_0_3 A_0_4 A_0_5 A_0_6 A_0_7 A_0_8 A_1_2 A_1_3 A_1_4 A_1_5 A_1_6 A_1_7 A_1_8 A_2_3 A_2_4 A_2_5 A_2_6 A_2_7 A_2_8 A_3_4 A_3_5 A_3_6 A_3_7 A_3_8 A_4_5 A_4_6 A_4_7 A_4_8 A_5_6 A_5_7 A_5_8 A_6_7 A_6_8 A_7_8)
                        (R.Sem t2 s_0 s_1 s_2 s_3 s_4 s_5 s_6 s_7 B_0_0 B_0_1 B_0_2 B_0_3 B_0_4 B_0_5 B_0_6 B_0_7 B_0_8 B_1_2 B_1_3 B_1_4 B_1_5 B_1_6 B_1_7 B_1_8 B_2_3 B_2_4 B_2_5 B_2_6 B_2_7 B_2_8 B_3_4 B_3_5 B_3_6 B_3_7 B_3_8 B_4_5 B_4_6 B_4_7 B_4_8 B_5_6 B_5_7 B_5_8 B_6_7 B_6_8 B_7_8)
                        (and
                            (= X_0_0 (and A_0_0 B_0_0))
                            (= X_0_1 (or (and A_0_0 B_0_1) (and A_0_1 B_0_0)))
                            (= X_0_2 (or (and A_0_0 B_0_2) (and A_0_1 B_1_2) (and A_0_2 B_0_0)))
                            (= X_0_3 (or (and A_0_0 B_0_3) (and A_0_1 B_1_3) (and A_0_2 B_2_3) (and A_0_3 B_0_0)))
                            (= X_0_4 (or (and A_0_0 B_0_4) (and A_0_1 B_1_4) (and A_0_2 B_2_4) (and A_0_3 B_3_4) (and A_0_4 B_0_0)))
                            (= X_0_5 (or (and A_0_0 B_0_5) (and A_0_1 B_1_5) (and A_0_2 B_2_5) (and A_0_3 B_3_5) (and A_0_4 B_4_5) (and A_0_5 B_0_0)))
                            (= X_0_6 (or (and A_0_0 B_0_6) (and A_0_1 B_1_6) (and A_0_2 B_2_6) (and A_0_3 B_3_6) (and A_0_4 B_4_6) (and A_0_5 B_5_6) (and A_0_6 B_0_0)))
                            (= X_0_7 (or (and A_0_0 B_0_7) (and A_0_1 B_1_7) (and A_0_2 B_2_7) (and A_0_3 B_3_7) (and A_0_4 B_4_7) (and A_0_5 B_5_7) (and A_0_6 B_6_7) (and A_0_7 B_0_0)))
                            (= X_0_8 (or (and A_0_0 B_0_8) (and A_0_1 B_1_8) (and A_0_2 B_2_8) (and A_0_3 B_3_8) (and A_0_4 B_4_8) (and A_0_5 B_5_8) (and A_0_6 B_6_8) (and A_0_7 B_7_8) (and A_0_8 B_0_0)))

                            (= X_1_2 (or (and A_0_0 B_1_2) (and A_1_2 B_0_0)))
                            (= X_1_3 (or (and A_0_0 B_1_3) (and A_1_2 B_2_3) (and A_1_3 B_0_0)))
                            (= X_1_4 (or (and A_0_0 B_1_4) (and A_1_2 B_2_4) (and A_1_3 B_3_4) (and A_1_4 B_0_0)))
                            (= X_1_5 (or (and A_0_0 B_1_5) (and A_1_2 B_2_5) (and A_1_3 B_3_5) (and A_1_4 B_4_5) (and A_1_5 B_0_0)))
                            (= X_1_6 (or (and A_0_0 B_1_6) (and A_1_2 B_2_6) (and A_1_3 B_3_6) (and A_1_4 B_4_6) (and A_1_5 B_5_6) (and A_1_6 B_0_0)))
                            (= X_1_7 (or (and A_0_0 B_1_7) (and A_1_2 B_2_7) (and A_1_3 B_3_7) (and A_1_4 B_4_7) (and A_1_5 B_5_7) (and A_1_6 B_6_7) (and A_1_7 B_0_0)))
                            (= X_1_8 (or (and A_0_0 B_1_8) (and A_1_2 B_2_8) (and A_1_3 B_3_8) (and A_1_4 B_4_8) (and A_1_5 B_5_8) (and A_1_6 B_6_8) (and A_1_7 B_7_8) (and A_1_8 B_0_0)))

                            (= X_2_3 (or (and A_0_0 B_2_3) (and A_2_3 B_0_0)))
                            (= X_2_4 (or (and A_0_0 B_2_4) (and A_2_3 B_3_4) (and A_2_4 B_0_0)))
                            (= X_2_5 (or (and A_0_0 B_2_5) (and A_2_3 B_3_5) (and A_2_4 B_4_5) (and A_2_5 B_0_0)))
                            (= X_2_6 (or (and A_0_0 B_2_6) (and A_2_3 B_3_6) (and A_2_4 B_4_6) (and A_2_5 B_5_6) (and A_2_6 B_0_0)))
                            (= X_2_7 (or (and A_0_0 B_2_7) (and A_2_3 B_3_7) (and A_2_4 B_4_7) (and A_2_5 B_5_7) (and A_2_6 B_6_7) (and A_2_7 B_0_0)))
                            (= X_2_8 (or (and A_0_0 B_2_8) (and A_2_3 B_3_8) (and A_2_4 B_4_8) (and A_2_5 B_5_8) (and A_2_6 B_6_8) (and A_2_7 B_7_8) (and A_2_8 B_0_0)))

                            (= X_3_4 (or (and A_0_0 B_3_4) (and A_3_4 B_0_0)))
                            (= X_3_5 (or (and A_0_0 B_3_5) (and A_3_4 B_4_5) (and A_3_5 B_0_0)))
                            (= X_3_6 (or (and A_0_0 B_3_6) (and A_3_4 B_4_6) (and A_3_5 B_5_6) (and A_3_6 B_0_0)))
                            (= X_3_7 (or (and A_0_0 B_3_7) (and A_3_4 B_4_7) (and A_3_5 B_5_7) (and A_3_6 B_6_7) (and A_3_7 B_0_0)))
                            (= X_3_8 (or (and A_0_0 B_3_8) (and A_3_4 B_4_8) (and A_3_5 B_5_8) (and A_3_6 B_6_8) (and A_3_7 B_7_8) (and A_3_8 B_0_0)))

                            (= X_4_5 (or (and A_0_0 B_4_5) (and A_4_5 B_0_0)))
                            (= X_4_6 (or (and A_0_0 B_4_6) (and A_4_5 B_5_6) (and A_4_6 B_0_0)))
                            (= X_4_7 (or (and A_0_0 B_4_7) (and A_4_5 B_5_7) (and A_4_6 B_6_7) (and A_4_7 B_0_0)))
                            (= X_4_8 (or (and A_0_0 B_4_8) (and A_4_5 B_5_8) (and A_4_6 B_6_8) (and A_4_7 B_7_8) (and A_4_8 B_0_0)))

                            (= X_5_6 (or (and A_0_0 B_5_6) (and A_5_6 B_0_0)))
                            (= X_5_7 (or (and A_0_0 B_5_7) (and A_5_6 B_6_7) (and A_5_7 B_0_0)))
                            (= X_5_8 (or (and A_0_0 B_5_8) (and A_5_6 B_6_8) (and A_5_7 B_7_8) (and A_5_8 B_0_0)))

                            (= X_6_7 (or (and A_0_0 B_6_7) (and A_6_7 B_0_0)))
                            (= X_6_8 (or (and A_0_0 B_6_8) (and A_6_7 B_7_8) (and A_6_8 B_0_0)))

                            (= X_7_8 (or (and A_0_0 B_7_8) (and A_7_8 B_0_0)))

                            
                        )
                    )
                )
            )
            (($star t1)
                (exists
                    (
                         (A_0_0 Bool) (A_0_1 Bool) (A_0_2 Bool) (A_0_3 Bool) (A_0_4 Bool) (A_0_5 Bool) (A_0_6 Bool) (A_0_7 Bool) (A_0_8 Bool) (A_1_2 Bool) (A_1_3 Bool) (A_1_4 Bool) (A_1_5 Bool) (A_1_6 Bool) (A_1_7 Bool) (A_1_8 Bool) (A_2_3 Bool) (A_2_4 Bool) (A_2_5 Bool) (A_2_6 Bool) (A_2_7 Bool) (A_2_8 Bool) (A_3_4 Bool) (A_3_5 Bool) (A_3_6 Bool) (A_3_7 Bool) (A_3_8 Bool) (A_4_5 Bool) (A_4_6 Bool) (A_4_7 Bool) (A_4_8 Bool) (A_5_6 Bool) (A_5_7 Bool) (A_5_8 Bool) (A_6_7 Bool) (A_6_8 Bool) (A_7_8 Bool) 
                    )
                    (and 
                        (R.Sem t1 s_0 s_1 s_2 s_3 s_4 s_5 s_6 s_7 A_0_0 A_0_1 A_0_2 A_0_3 A_0_4 A_0_5 A_0_6 A_0_7 A_0_8 A_1_2 A_1_3 A_1_4 A_1_5 A_1_6 A_1_7 A_1_8 A_2_3 A_2_4 A_2_5 A_2_6 A_2_7 A_2_8 A_3_4 A_3_5 A_3_6 A_3_7 A_3_8 A_4_5 A_4_6 A_4_7 A_4_8 A_5_6 A_5_7 A_5_8 A_6_7 A_6_8 A_7_8)
                        
                        (and
                        (= X_0_0 true)
                        (= X_0_1 A_0_1)
                        (= X_0_2 (or A_0_2 (and A_0_1 A_1_2)))
                        (= X_0_3 (or A_0_3 (and A_0_2 A_2_3) (and A_0_1 A_1_3) (and A_0_1 A_1_2 A_2_3)))
                        (= X_0_4 (or A_0_4 (and A_0_3 A_3_4) (and A_0_2 A_2_4) (and A_0_2 A_2_3 A_3_4) (and A_0_1 A_1_4) (and A_0_1 A_1_3 A_3_4) (and A_0_1 A_1_2 A_2_4) (and A_0_1 A_1_2 A_2_3 A_3_4)))
                        (= X_0_5 (or A_0_5 (and A_0_4 A_4_5) (and A_0_3 A_3_5) (and A_0_3 A_3_4 A_4_5) (and A_0_2 A_2_5) (and A_0_2 A_2_4 A_4_5) (and A_0_2 A_2_3 A_3_5) (and A_0_2 A_2_3 A_3_4 A_4_5) (and A_0_1 A_1_5) (and A_0_1 A_1_4 A_4_5) (and A_0_1 A_1_3 A_3_5) (and A_0_1 A_1_3 A_3_4 A_4_5) (and A_0_1 A_1_2 A_2_5) (and A_0_1 A_1_2 A_2_4 A_4_5) (and A_0_1 A_1_2 A_2_3 A_3_5) (and A_0_1 A_1_2 A_2_3 A_3_4 A_4_5)))
                        (= X_0_6 (or A_0_6 (and A_0_5 A_5_6) (and A_0_4 A_4_6) (and A_0_4 A_4_5 A_5_6) (and A_0_3 A_3_6) (and A_0_3 A_3_5 A_5_6) (and A_0_3 A_3_4 A_4_6) (and A_0_3 A_3_4 A_4_5 A_5_6) (and A_0_2 A_2_6) (and A_0_2 A_2_5 A_5_6) (and A_0_2 A_2_4 A_4_6) (and A_0_2 A_2_4 A_4_5 A_5_6) (and A_0_2 A_2_3 A_3_6) (and A_0_2 A_2_3 A_3_5 A_5_6) (and A_0_2 A_2_3 A_3_4 A_4_6) (and A_0_2 A_2_3 A_3_4 A_4_5 A_5_6) (and A_0_1 A_1_6) (and A_0_1 A_1_5 A_5_6) (and A_0_1 A_1_4 A_4_6) (and A_0_1 A_1_4 A_4_5 A_5_6) (and A_0_1 A_1_3 A_3_6) (and A_0_1 A_1_3 A_3_5 A_5_6) (and A_0_1 A_1_3 A_3_4 A_4_6) (and A_0_1 A_1_3 A_3_4 A_4_5 A_5_6) (and A_0_1 A_1_2 A_2_6) (and A_0_1 A_1_2 A_2_5 A_5_6) (and A_0_1 A_1_2 A_2_4 A_4_6) (and A_0_1 A_1_2 A_2_4 A_4_5 A_5_6) (and A_0_1 A_1_2 A_2_3 A_3_6) (and A_0_1 A_1_2 A_2_3 A_3_5 A_5_6) (and A_0_1 A_1_2 A_2_3 A_3_4 A_4_6) (and A_0_1 A_1_2 A_2_3 A_3_4 A_4_5 A_5_6)))
                        (= X_0_7 (or A_0_7 (and A_0_6 A_6_7) (and A_0_5 A_5_7) (and A_0_5 A_5_6 A_6_7) (and A_0_4 A_4_7) (and A_0_4 A_4_6 A_6_7) (and A_0_4 A_4_5 A_5_7) (and A_0_4 A_4_5 A_5_6 A_6_7) (and A_0_3 A_3_7) (and A_0_3 A_3_6 A_6_7) (and A_0_3 A_3_5 A_5_7) (and A_0_3 A_3_5 A_5_6 A_6_7) (and A_0_3 A_3_4 A_4_7) (and A_0_3 A_3_4 A_4_6 A_6_7) (and A_0_3 A_3_4 A_4_5 A_5_7) (and A_0_3 A_3_4 A_4_5 A_5_6 A_6_7) (and A_0_2 A_2_7) (and A_0_2 A_2_6 A_6_7) (and A_0_2 A_2_5 A_5_7) (and A_0_2 A_2_5 A_5_6 A_6_7) (and A_0_2 A_2_4 A_4_7) (and A_0_2 A_2_4 A_4_6 A_6_7) (and A_0_2 A_2_4 A_4_5 A_5_7) (and A_0_2 A_2_4 A_4_5 A_5_6 A_6_7) (and A_0_2 A_2_3 A_3_7) (and A_0_2 A_2_3 A_3_6 A_6_7) (and A_0_2 A_2_3 A_3_5 A_5_7) (and A_0_2 A_2_3 A_3_5 A_5_6 A_6_7) (and A_0_2 A_2_3 A_3_4 A_4_7) (and A_0_2 A_2_3 A_3_4 A_4_6 A_6_7) (and A_0_2 A_2_3 A_3_4 A_4_5 A_5_7) (and A_0_2 A_2_3 A_3_4 A_4_5 A_5_6 A_6_7) (and A_0_1 A_1_7) (and A_0_1 A_1_6 A_6_7) (and A_0_1 A_1_5 A_5_7) (and A_0_1 A_1_5 A_5_6 A_6_7) (and A_0_1 A_1_4 A_4_7) (and A_0_1 A_1_4 A_4_6 A_6_7) (and A_0_1 A_1_4 A_4_5 A_5_7) (and A_0_1 A_1_4 A_4_5 A_5_6 A_6_7) (and A_0_1 A_1_3 A_3_7) (and A_0_1 A_1_3 A_3_6 A_6_7) (and A_0_1 A_1_3 A_3_5 A_5_7) (and A_0_1 A_1_3 A_3_5 A_5_6 A_6_7) (and A_0_1 A_1_3 A_3_4 A_4_7) (and A_0_1 A_1_3 A_3_4 A_4_6 A_6_7) (and A_0_1 A_1_3 A_3_4 A_4_5 A_5_7) (and A_0_1 A_1_3 A_3_4 A_4_5 A_5_6 A_6_7) (and A_0_1 A_1_2 A_2_7) (and A_0_1 A_1_2 A_2_6 A_6_7) (and A_0_1 A_1_2 A_2_5 A_5_7) (and A_0_1 A_1_2 A_2_5 A_5_6 A_6_7) (and A_0_1 A_1_2 A_2_4 A_4_7) (and A_0_1 A_1_2 A_2_4 A_4_6 A_6_7) (and A_0_1 A_1_2 A_2_4 A_4_5 A_5_7) (and A_0_1 A_1_2 A_2_4 A_4_5 A_5_6 A_6_7) (and A_0_1 A_1_2 A_2_3 A_3_7) (and A_0_1 A_1_2 A_2_3 A_3_6 A_6_7) (and A_0_1 A_1_2 A_2_3 A_3_5 A_5_7) (and A_0_1 A_1_2 A_2_3 A_3_5 A_5_6 A_6_7) (and A_0_1 A_1_2 A_2_3 A_3_4 A_4_7) (and A_0_1 A_1_2 A_2_3 A_3_4 A_4_6 A_6_7) (and A_0_1 A_1_2 A_2_3 A_3_4 A_4_5 A_5_7) (and A_0_1 A_1_2 A_2_3 A_3_4 A_4_5 A_5_6 A_6_7)))
                        (= X_0_8 (or A_0_8 (and A_0_7 A_7_8) (and A_0_6 A_6_8) (and A_0_6 A_6_7 A_7_8) (and A_0_5 A_5_8) (and A_0_5 A_5_7 A_7_8) (and A_0_5 A_5_6 A_6_8) (and A_0_5 A_5_6 A_6_7 A_7_8) (and A_0_4 A_4_8) (and A_0_4 A_4_7 A_7_8) (and A_0_4 A_4_6 A_6_8) (and A_0_4 A_4_6 A_6_7 A_7_8) (and A_0_4 A_4_5 A_5_8) (and A_0_4 A_4_5 A_5_7 A_7_8) (and A_0_4 A_4_5 A_5_6 A_6_8) (and A_0_4 A_4_5 A_5_6 A_6_7 A_7_8) (and A_0_3 A_3_8) (and A_0_3 A_3_7 A_7_8) (and A_0_3 A_3_6 A_6_8) (and A_0_3 A_3_6 A_6_7 A_7_8) (and A_0_3 A_3_5 A_5_8) (and A_0_3 A_3_5 A_5_7 A_7_8) (and A_0_3 A_3_5 A_5_6 A_6_8) (and A_0_3 A_3_5 A_5_6 A_6_7 A_7_8) (and A_0_3 A_3_4 A_4_8) (and A_0_3 A_3_4 A_4_7 A_7_8) (and A_0_3 A_3_4 A_4_6 A_6_8) (and A_0_3 A_3_4 A_4_6 A_6_7 A_7_8) (and A_0_3 A_3_4 A_4_5 A_5_8) (and A_0_3 A_3_4 A_4_5 A_5_7 A_7_8) (and A_0_3 A_3_4 A_4_5 A_5_6 A_6_8) (and A_0_3 A_3_4 A_4_5 A_5_6 A_6_7 A_7_8) (and A_0_2 A_2_8) (and A_0_2 A_2_7 A_7_8) (and A_0_2 A_2_6 A_6_8) (and A_0_2 A_2_6 A_6_7 A_7_8) (and A_0_2 A_2_5 A_5_8) (and A_0_2 A_2_5 A_5_7 A_7_8) (and A_0_2 A_2_5 A_5_6 A_6_8) (and A_0_2 A_2_5 A_5_6 A_6_7 A_7_8) (and A_0_2 A_2_4 A_4_8) (and A_0_2 A_2_4 A_4_7 A_7_8) (and A_0_2 A_2_4 A_4_6 A_6_8) (and A_0_2 A_2_4 A_4_6 A_6_7 A_7_8) (and A_0_2 A_2_4 A_4_5 A_5_8) (and A_0_2 A_2_4 A_4_5 A_5_7 A_7_8) (and A_0_2 A_2_4 A_4_5 A_5_6 A_6_8) (and A_0_2 A_2_4 A_4_5 A_5_6 A_6_7 A_7_8) (and A_0_2 A_2_3 A_3_8) (and A_0_2 A_2_3 A_3_7 A_7_8) (and A_0_2 A_2_3 A_3_6 A_6_8) (and A_0_2 A_2_3 A_3_6 A_6_7 A_7_8) (and A_0_2 A_2_3 A_3_5 A_5_8) (and A_0_2 A_2_3 A_3_5 A_5_7 A_7_8) (and A_0_2 A_2_3 A_3_5 A_5_6 A_6_8) (and A_0_2 A_2_3 A_3_5 A_5_6 A_6_7 A_7_8) (and A_0_2 A_2_3 A_3_4 A_4_8) (and A_0_2 A_2_3 A_3_4 A_4_7 A_7_8) (and A_0_2 A_2_3 A_3_4 A_4_6 A_6_8) (and A_0_2 A_2_3 A_3_4 A_4_6 A_6_7 A_7_8) (and A_0_2 A_2_3 A_3_4 A_4_5 A_5_8) (and A_0_2 A_2_3 A_3_4 A_4_5 A_5_7 A_7_8) (and A_0_2 A_2_3 A_3_4 A_4_5 A_5_6 A_6_8) (and A_0_2 A_2_3 A_3_4 A_4_5 A_5_6 A_6_7 A_7_8) (and A_0_1 A_1_8) (and A_0_1 A_1_7 A_7_8) (and A_0_1 A_1_6 A_6_8) (and A_0_1 A_1_6 A_6_7 A_7_8) (and A_0_1 A_1_5 A_5_8) (and A_0_1 A_1_5 A_5_7 A_7_8) (and A_0_1 A_1_5 A_5_6 A_6_8) (and A_0_1 A_1_5 A_5_6 A_6_7 A_7_8) (and A_0_1 A_1_4 A_4_8) (and A_0_1 A_1_4 A_4_7 A_7_8) (and A_0_1 A_1_4 A_4_6 A_6_8) (and A_0_1 A_1_4 A_4_6 A_6_7 A_7_8) (and A_0_1 A_1_4 A_4_5 A_5_8) (and A_0_1 A_1_4 A_4_5 A_5_7 A_7_8) (and A_0_1 A_1_4 A_4_5 A_5_6 A_6_8) (and A_0_1 A_1_4 A_4_5 A_5_6 A_6_7 A_7_8) (and A_0_1 A_1_3 A_3_8) (and A_0_1 A_1_3 A_3_7 A_7_8) (and A_0_1 A_1_3 A_3_6 A_6_8) (and A_0_1 A_1_3 A_3_6 A_6_7 A_7_8) (and A_0_1 A_1_3 A_3_5 A_5_8) (and A_0_1 A_1_3 A_3_5 A_5_7 A_7_8) (and A_0_1 A_1_3 A_3_5 A_5_6 A_6_8) (and A_0_1 A_1_3 A_3_5 A_5_6 A_6_7 A_7_8) (and A_0_1 A_1_3 A_3_4 A_4_8) (and A_0_1 A_1_3 A_3_4 A_4_7 A_7_8) (and A_0_1 A_1_3 A_3_4 A_4_6 A_6_8) (and A_0_1 A_1_3 A_3_4 A_4_6 A_6_7 A_7_8) (and A_0_1 A_1_3 A_3_4 A_4_5 A_5_8) (and A_0_1 A_1_3 A_3_4 A_4_5 A_5_7 A_7_8) (and A_0_1 A_1_3 A_3_4 A_4_5 A_5_6 A_6_8) (and A_0_1 A_1_3 A_3_4 A_4_5 A_5_6 A_6_7 A_7_8) (and A_0_1 A_1_2 A_2_8) (and A_0_1 A_1_2 A_2_7 A_7_8) (and A_0_1 A_1_2 A_2_6 A_6_8) (and A_0_1 A_1_2 A_2_6 A_6_7 A_7_8) (and A_0_1 A_1_2 A_2_5 A_5_8) (and A_0_1 A_1_2 A_2_5 A_5_7 A_7_8) (and A_0_1 A_1_2 A_2_5 A_5_6 A_6_8) (and A_0_1 A_1_2 A_2_5 A_5_6 A_6_7 A_7_8) (and A_0_1 A_1_2 A_2_4 A_4_8) (and A_0_1 A_1_2 A_2_4 A_4_7 A_7_8) (and A_0_1 A_1_2 A_2_4 A_4_6 A_6_8) (and A_0_1 A_1_2 A_2_4 A_4_6 A_6_7 A_7_8) (and A_0_1 A_1_2 A_2_4 A_4_5 A_5_8) (and A_0_1 A_1_2 A_2_4 A_4_5 A_5_7 A_7_8) (and A_0_1 A_1_2 A_2_4 A_4_5 A_5_6 A_6_8) (and A_0_1 A_1_2 A_2_4 A_4_5 A_5_6 A_6_7 A_7_8) (and A_0_1 A_1_2 A_2_3 A_3_8) (and A_0_1 A_1_2 A_2_3 A_3_7 A_7_8) (and A_0_1 A_1_2 A_2_3 A_3_6 A_6_8) (and A_0_1 A_1_2 A_2_3 A_3_6 A_6_7 A_7_8) (and A_0_1 A_1_2 A_2_3 A_3_5 A_5_8) (and A_0_1 A_1_2 A_2_3 A_3_5 A_5_7 A_7_8) (and A_0_1 A_1_2 A_2_3 A_3_5 A_5_6 A_6_8) (and A_0_1 A_1_2 A_2_3 A_3_5 A_5_6 A_6_7 A_7_8) (and A_0_1 A_1_2 A_2_3 A_3_4 A_4_8) (and A_0_1 A_1_2 A_2_3 A_3_4 A_4_7 A_7_8) (and A_0_1 A_1_2 A_2_3 A_3_4 A_4_6 A_6_8) (and A_0_1 A_1_2 A_2_3 A_3_4 A_4_6 A_6_7 A_7_8) (and A_0_1 A_1_2 A_2_3 A_3_4 A_4_5 A_5_8) (and A_0_1 A_1_2 A_2_3 A_3_4 A_4_5 A_5_7 A_7_8) (and A_0_1 A_1_2 A_2_3 A_3_4 A_4_5 A_5_6 A_6_8) (and A_0_1 A_1_2 A_2_3 A_3_4 A_4_5 A_5_6 A_6_7 A_7_8)))
                        
                        
                        (= X_1_2 A_1_2)
                        (= X_1_3 (or A_1_3 (and A_1_2 A_2_3)))
                        (= X_1_4 (or A_1_4 (and A_1_3 A_3_4) (and A_1_2 A_2_4) (and A_1_2 A_2_3 A_3_4)))
                        (= X_1_5 (or A_1_5 (and A_1_4 A_4_5) (and A_1_3 A_3_5) (and A_1_3 A_3_4 A_4_5) (and A_1_2 A_2_5) (and A_1_2 A_2_4 A_4_5) (and A_1_2 A_2_3 A_3_5) (and A_1_2 A_2_3 A_3_4 A_4_5)))
                        (= X_1_6 (or A_1_6 (and A_1_5 A_5_6) (and A_1_4 A_4_6) (and A_1_4 A_4_5 A_5_6) (and A_1_3 A_3_6) (and A_1_3 A_3_5 A_5_6) (and A_1_3 A_3_4 A_4_6) (and A_1_3 A_3_4 A_4_5 A_5_6) (and A_1_2 A_2_6) (and A_1_2 A_2_5 A_5_6) (and A_1_2 A_2_4 A_4_6) (and A_1_2 A_2_4 A_4_5 A_5_6) (and A_1_2 A_2_3 A_3_6) (and A_1_2 A_2_3 A_3_5 A_5_6) (and A_1_2 A_2_3 A_3_4 A_4_6) (and A_1_2 A_2_3 A_3_4 A_4_5 A_5_6)))
                        (= X_1_7 (or A_1_7 (and A_1_6 A_6_7) (and A_1_5 A_5_7) (and A_1_5 A_5_6 A_6_7) (and A_1_4 A_4_7) (and A_1_4 A_4_6 A_6_7) (and A_1_4 A_4_5 A_5_7) (and A_1_4 A_4_5 A_5_6 A_6_7) (and A_1_3 A_3_7) (and A_1_3 A_3_6 A_6_7) (and A_1_3 A_3_5 A_5_7) (and A_1_3 A_3_5 A_5_6 A_6_7) (and A_1_3 A_3_4 A_4_7) (and A_1_3 A_3_4 A_4_6 A_6_7) (and A_1_3 A_3_4 A_4_5 A_5_7) (and A_1_3 A_3_4 A_4_5 A_5_6 A_6_7) (and A_1_2 A_2_7) (and A_1_2 A_2_6 A_6_7) (and A_1_2 A_2_5 A_5_7) (and A_1_2 A_2_5 A_5_6 A_6_7) (and A_1_2 A_2_4 A_4_7) (and A_1_2 A_2_4 A_4_6 A_6_7) (and A_1_2 A_2_4 A_4_5 A_5_7) (and A_1_2 A_2_4 A_4_5 A_5_6 A_6_7) (and A_1_2 A_2_3 A_3_7) (and A_1_2 A_2_3 A_3_6 A_6_7) (and A_1_2 A_2_3 A_3_5 A_5_7) (and A_1_2 A_2_3 A_3_5 A_5_6 A_6_7) (and A_1_2 A_2_3 A_3_4 A_4_7) (and A_1_2 A_2_3 A_3_4 A_4_6 A_6_7) (and A_1_2 A_2_3 A_3_4 A_4_5 A_5_7) (and A_1_2 A_2_3 A_3_4 A_4_5 A_5_6 A_6_7)))
                        (= X_1_8 (or A_1_8 (and A_1_7 A_7_8) (and A_1_6 A_6_8) (and A_1_6 A_6_7 A_7_8) (and A_1_5 A_5_8) (and A_1_5 A_5_7 A_7_8) (and A_1_5 A_5_6 A_6_8) (and A_1_5 A_5_6 A_6_7 A_7_8) (and A_1_4 A_4_8) (and A_1_4 A_4_7 A_7_8) (and A_1_4 A_4_6 A_6_8) (and A_1_4 A_4_6 A_6_7 A_7_8) (and A_1_4 A_4_5 A_5_8) (and A_1_4 A_4_5 A_5_7 A_7_8) (and A_1_4 A_4_5 A_5_6 A_6_8) (and A_1_4 A_4_5 A_5_6 A_6_7 A_7_8) (and A_1_3 A_3_8) (and A_1_3 A_3_7 A_7_8) (and A_1_3 A_3_6 A_6_8) (and A_1_3 A_3_6 A_6_7 A_7_8) (and A_1_3 A_3_5 A_5_8) (and A_1_3 A_3_5 A_5_7 A_7_8) (and A_1_3 A_3_5 A_5_6 A_6_8) (and A_1_3 A_3_5 A_5_6 A_6_7 A_7_8) (and A_1_3 A_3_4 A_4_8) (and A_1_3 A_3_4 A_4_7 A_7_8) (and A_1_3 A_3_4 A_4_6 A_6_8) (and A_1_3 A_3_4 A_4_6 A_6_7 A_7_8) (and A_1_3 A_3_4 A_4_5 A_5_8) (and A_1_3 A_3_4 A_4_5 A_5_7 A_7_8) (and A_1_3 A_3_4 A_4_5 A_5_6 A_6_8) (and A_1_3 A_3_4 A_4_5 A_5_6 A_6_7 A_7_8) (and A_1_2 A_2_8) (and A_1_2 A_2_7 A_7_8) (and A_1_2 A_2_6 A_6_8) (and A_1_2 A_2_6 A_6_7 A_7_8) (and A_1_2 A_2_5 A_5_8) (and A_1_2 A_2_5 A_5_7 A_7_8) (and A_1_2 A_2_5 A_5_6 A_6_8) (and A_1_2 A_2_5 A_5_6 A_6_7 A_7_8) (and A_1_2 A_2_4 A_4_8) (and A_1_2 A_2_4 A_4_7 A_7_8) (and A_1_2 A_2_4 A_4_6 A_6_8) (and A_1_2 A_2_4 A_4_6 A_6_7 A_7_8) (and A_1_2 A_2_4 A_4_5 A_5_8) (and A_1_2 A_2_4 A_4_5 A_5_7 A_7_8) (and A_1_2 A_2_4 A_4_5 A_5_6 A_6_8) (and A_1_2 A_2_4 A_4_5 A_5_6 A_6_7 A_7_8) (and A_1_2 A_2_3 A_3_8) (and A_1_2 A_2_3 A_3_7 A_7_8) (and A_1_2 A_2_3 A_3_6 A_6_8) (and A_1_2 A_2_3 A_3_6 A_6_7 A_7_8) (and A_1_2 A_2_3 A_3_5 A_5_8) (and A_1_2 A_2_3 A_3_5 A_5_7 A_7_8) (and A_1_2 A_2_3 A_3_5 A_5_6 A_6_8) (and A_1_2 A_2_3 A_3_5 A_5_6 A_6_7 A_7_8) (and A_1_2 A_2_3 A_3_4 A_4_8) (and A_1_2 A_2_3 A_3_4 A_4_7 A_7_8) (and A_1_2 A_2_3 A_3_4 A_4_6 A_6_8) (and A_1_2 A_2_3 A_3_4 A_4_6 A_6_7 A_7_8) (and A_1_2 A_2_3 A_3_4 A_4_5 A_5_8) (and A_1_2 A_2_3 A_3_4 A_4_5 A_5_7 A_7_8) (and A_1_2 A_2_3 A_3_4 A_4_5 A_5_6 A_6_8) (and A_1_2 A_2_3 A_3_4 A_4_5 A_5_6 A_6_7 A_7_8)))
                        
                        
                        (= X_2_3 A_2_3)
                        (= X_2_4 (or A_2_4 (and A_2_3 A_3_4)))
                        (= X_2_5 (or A_2_5 (and A_2_4 A_4_5) (and A_2_3 A_3_5) (and A_2_3 A_3_4 A_4_5)))
                        (= X_2_6 (or A_2_6 (and A_2_5 A_5_6) (and A_2_4 A_4_6) (and A_2_4 A_4_5 A_5_6) (and A_2_3 A_3_6) (and A_2_3 A_3_5 A_5_6) (and A_2_3 A_3_4 A_4_6) (and A_2_3 A_3_4 A_4_5 A_5_6)))
                        (= X_2_7 (or A_2_7 (and A_2_6 A_6_7) (and A_2_5 A_5_7) (and A_2_5 A_5_6 A_6_7) (and A_2_4 A_4_7) (and A_2_4 A_4_6 A_6_7) (and A_2_4 A_4_5 A_5_7) (and A_2_4 A_4_5 A_5_6 A_6_7) (and A_2_3 A_3_7) (and A_2_3 A_3_6 A_6_7) (and A_2_3 A_3_5 A_5_7) (and A_2_3 A_3_5 A_5_6 A_6_7) (and A_2_3 A_3_4 A_4_7) (and A_2_3 A_3_4 A_4_6 A_6_7) (and A_2_3 A_3_4 A_4_5 A_5_7) (and A_2_3 A_3_4 A_4_5 A_5_6 A_6_7)))
                        (= X_2_8 (or A_2_8 (and A_2_7 A_7_8) (and A_2_6 A_6_8) (and A_2_6 A_6_7 A_7_8) (and A_2_5 A_5_8) (and A_2_5 A_5_7 A_7_8) (and A_2_5 A_5_6 A_6_8) (and A_2_5 A_5_6 A_6_7 A_7_8) (and A_2_4 A_4_8) (and A_2_4 A_4_7 A_7_8) (and A_2_4 A_4_6 A_6_8) (and A_2_4 A_4_6 A_6_7 A_7_8) (and A_2_4 A_4_5 A_5_8) (and A_2_4 A_4_5 A_5_7 A_7_8) (and A_2_4 A_4_5 A_5_6 A_6_8) (and A_2_4 A_4_5 A_5_6 A_6_7 A_7_8) (and A_2_3 A_3_8) (and A_2_3 A_3_7 A_7_8) (and A_2_3 A_3_6 A_6_8) (and A_2_3 A_3_6 A_6_7 A_7_8) (and A_2_3 A_3_5 A_5_8) (and A_2_3 A_3_5 A_5_7 A_7_8) (and A_2_3 A_3_5 A_5_6 A_6_8) (and A_2_3 A_3_5 A_5_6 A_6_7 A_7_8) (and A_2_3 A_3_4 A_4_8) (and A_2_3 A_3_4 A_4_7 A_7_8) (and A_2_3 A_3_4 A_4_6 A_6_8) (and A_2_3 A_3_4 A_4_6 A_6_7 A_7_8) (and A_2_3 A_3_4 A_4_5 A_5_8) (and A_2_3 A_3_4 A_4_5 A_5_7 A_7_8) (and A_2_3 A_3_4 A_4_5 A_5_6 A_6_8) (and A_2_3 A_3_4 A_4_5 A_5_6 A_6_7 A_7_8)))
                        
                        
                        (= X_3_4 A_3_4)
                        (= X_3_5 (or A_3_5 (and A_3_4 A_4_5)))
                        (= X_3_6 (or A_3_6 (and A_3_5 A_5_6) (and A_3_4 A_4_6) (and A_3_4 A_4_5 A_5_6)))
                        (= X_3_7 (or A_3_7 (and A_3_6 A_6_7) (and A_3_5 A_5_7) (and A_3_5 A_5_6 A_6_7) (and A_3_4 A_4_7) (and A_3_4 A_4_6 A_6_7) (and A_3_4 A_4_5 A_5_7) (and A_3_4 A_4_5 A_5_6 A_6_7)))
                        (= X_3_8 (or A_3_8 (and A_3_7 A_7_8) (and A_3_6 A_6_8) (and A_3_6 A_6_7 A_7_8) (and A_3_5 A_5_8) (and A_3_5 A_5_7 A_7_8) (and A_3_5 A_5_6 A_6_8) (and A_3_5 A_5_6 A_6_7 A_7_8) (and A_3_4 A_4_8) (and A_3_4 A_4_7 A_7_8) (and A_3_4 A_4_6 A_6_8) (and A_3_4 A_4_6 A_6_7 A_7_8) (and A_3_4 A_4_5 A_5_8) (and A_3_4 A_4_5 A_5_7 A_7_8) (and A_3_4 A_4_5 A_5_6 A_6_8) (and A_3_4 A_4_5 A_5_6 A_6_7 A_7_8)))
                        
                        
                        (= X_4_5 A_4_5)
                        (= X_4_6 (or A_4_6 (and A_4_5 A_5_6)))
                        (= X_4_7 (or A_4_7 (and A_4_6 A_6_7) (and A_4_5 A_5_7) (and A_4_5 A_5_6 A_6_7)))
                        (= X_4_8 (or A_4_8 (and A_4_7 A_7_8) (and A_4_6 A_6_8) (and A_4_6 A_6_7 A_7_8) (and A_4_5 A_5_8) (and A_4_5 A_5_7 A_7_8) (and A_4_5 A_5_6 A_6_8) (and A_4_5 A_5_6 A_6_7 A_7_8)))
                        
                        
                        (= X_5_6 A_5_6)
                        (= X_5_7 (or A_5_7 (and A_5_6 A_6_7)))
                        (= X_5_8 (or A_5_8 (and A_5_7 A_7_8) (and A_5_6 A_6_8) (and A_5_6 A_6_7 A_7_8)))
                        
                        
                        (= X_6_7 A_6_7)
                        (= X_6_8 (or A_6_8 (and A_6_7 A_7_8)))
                        
                        
                        (= X_7_8 A_7_8)
                        
                        
                        
                        )
                    )
                )
            )
        )) :input ( s_0 s_1 s_2 s_3 s_4 s_5 s_6 s_7) :output ( X_0_0 X_0_1 X_0_2 X_0_3 X_0_4 X_0_5 X_0_6 X_0_7 X_0_8 X_1_2 X_1_3 X_1_4 X_1_5 X_1_6 X_1_7 X_1_8 X_2_3 X_2_4 X_2_5 X_2_6 X_2_7 X_2_8 X_3_4 X_3_5 X_3_6 X_3_7 X_3_8 X_4_5 X_4_6 X_4_7 X_4_8 X_5_6 X_5_7 X_5_8 X_6_7 X_6_8 X_7_8))
    )
)

(synth-fun match_regex () Start
    ((nt_Start Start) (nt_R R) (nt_Good R) (nt_Bad R) (t_a R) (t_b R) (t_Kludge R))
    (
        (nt_Start Start (($eval nt_R)))
        (nt_R R (($or t_a t_a) ($concat nt_R nt_R))) ;(($or t_Kludge nt_Good) ($concat t_b nt_Bad)))
        (nt_Good R ($char_1 ($concat t_a nt_Good)))
        (nt_Bad R ($char_1 $char_2 ($concat nt_Bad nt_Bad) ($star nt_Bad) ($or nt_Bad nt_Bad)))
        (t_a R ($char_1))
        (t_b R ($char_2))
        (t_Kludge R ($phi))
    )
)


(constraint (Start.Sem match_regex 1 1 1 1 1 1 1 1 true))
(constraint (Start.Sem match_regex 1 1 1 1 2 1 1 1 false))

(check-synth)

