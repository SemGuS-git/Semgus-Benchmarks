;; Synthesize a regular expression for a CSV string 
           
;; (set-info :format-version "2.4.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

(declare-term-types
    ;; Nonterminals
    ((Start 0) (Row 0) (Entry 0) (Alpha 0) (Num 0))
    
    ;; Productions
    (
        ;; Start production
        (($eval Row))
        ;; Row productions
        (
            ($entry Entry)
            ($cons Entry Row)
        )
        ;; Entry productions
        (
            ($alpha Alpha)
            ($num Num)
        )
        ;; Alpha productions
        (
            ($alpha)
            ($concat-a Alpha Alpha)
            ($or-a Alpha Alpha)
            ($star-a Alpha)
        )
        ;; Num productions
        (
            ($num)
            ($concat-n Num Num)
            ($or-n Num Num)
            ($star-n Num)
        )
    )
)

(define-funs-rec
    (
        (Start.Sem ((t Start) (s_0 String) (s_1 String) (s_2 String) (s_3 String) (result Bool)) Bool)
        (Row.Sem ((rt Row) (s_0 String) (s_1 String) (s_2 String) (s_3 String) (X_0_0 Bool) (X_0_1 Bool) (X_0_2 Bool) (X_0_3 Bool) (X_0_4 Bool) (X_1_1 Bool) (X_1_2 Bool) (X_1_3 Bool) (X_1_4 Bool) (X_2_2 Bool) (X_2_3 Bool) (X_2_4 Bool) (X_3_3 Bool) (X_3_4 Bool) (X_4_4 Bool)) Bool)
        (Entry.Sem ((et Entry) (s_0 String) (s_1 String) (s_2 String) (s_3 String) (X_0_0 Bool) (X_0_1 Bool) (X_0_2 Bool) (X_0_3 Bool) (X_0_4 Bool) (X_1_1 Bool) (X_1_2 Bool) (X_1_3 Bool) (X_1_4 Bool) (X_2_2 Bool) (X_2_3 Bool) (X_2_4 Bool) (X_3_3 Bool) (X_3_4 Bool) (X_4_4 Bool)) Bool)
        (Alpha.Sem ((at Alpha) (s_0 String) (s_1 String) (s_2 String) (s_3 String) (X_0_0 Bool) (X_0_1 Bool) (X_0_2 Bool) (X_0_3 Bool) (X_0_4 Bool) (X_1_1 Bool) (X_1_2 Bool) (X_1_3 Bool) (X_1_4 Bool) (X_2_2 Bool) (X_2_3 Bool) (X_2_4 Bool) (X_3_3 Bool) (X_3_4 Bool) (X_4_4 Bool)) Bool)
        (Num.Sem ((nt Num) (s_0 String) (s_1 String) (s_2 String) (s_3 String) (X_0_0 Bool) (X_0_1 Bool) (X_0_2 Bool) (X_0_3 Bool) (X_0_4 Bool) (X_1_1 Bool) (X_1_2 Bool) (X_1_3 Bool) (X_1_4 Bool) (X_2_2 Bool) (X_2_3 Bool) (X_2_4 Bool) (X_3_3 Bool) (X_3_4 Bool) (X_4_4 Bool)) Bool)
    )
    
    (
        (! (match t (
            (($eval t1) (exists
                ( (X_0_0 Bool) (X_0_1 Bool) (X_0_2 Bool) (X_0_3 Bool) (X_0_4 Bool) (X_1_1 Bool) (X_1_2 Bool) (X_1_3 Bool) (X_1_4 Bool) (X_2_2 Bool) (X_2_3 Bool) (X_2_4 Bool) (X_3_3 Bool) (X_3_4 Bool) (X_4_4 Bool))
                (and
                    (Row.Sem t1 s_0 s_1 s_2 s_3 X_0_0 X_0_1 X_0_2 X_0_3 X_0_4 X_1_1 X_1_2 X_1_3 X_1_4 X_2_2 X_2_3 X_2_4 X_3_3 X_3_4 X_4_4)
                    (= result X_0_4)
                )
            ))
        )) :input ( s_0 s_1 s_2 s_3) :output (result))
        (! (match rt (
            (($entry t1) 
                (Entry.Sem t1 s_0 s_1 s_2 s_3 X_0_0 X_0_1 X_0_2 X_0_3 X_0_4 X_1_1 X_1_2 X_1_3 X_1_4 X_2_2 X_2_3 X_2_4 X_3_3 X_3_4 X_4_4)
            )
            (($cons t1 t2) (exists
                ( (A_0_0 Bool) (A_0_1 Bool) (A_0_2 Bool) (A_0_3 Bool) (A_0_4 Bool) (A_1_1 Bool) (A_1_2 Bool) (A_1_3 Bool) (A_1_4 Bool) (A_2_2 Bool) (A_2_3 Bool) (A_2_4 Bool) (A_3_3 Bool) (A_3_4 Bool) (A_4_4 Bool) (B_0_0 Bool) (B_0_1 Bool) (B_0_2 Bool) (B_0_3 Bool) (B_0_4 Bool) (B_1_1 Bool) (B_1_2 Bool) (B_1_3 Bool) (B_1_4 Bool) (B_2_2 Bool) (B_2_3 Bool) (B_2_4 Bool) (B_3_3 Bool) (B_3_4 Bool) (B_4_4 Bool))
                (and
                    (Entry.Sem t1 s_0 s_1 s_2 s_3 A_0_0 A_0_1 A_0_2 A_0_3 A_0_4 A_1_1 A_1_2 A_1_3 A_1_4 A_2_2 A_2_3 A_2_4 A_3_3 A_3_4 A_4_4)
                    (Row.Sem t2 s_0 s_1 s_2 s_3 A_0_0 A_0_1 A_0_2 A_0_3 A_0_4 A_1_1 A_1_2 A_1_3 A_1_4 A_2_2 A_2_3 A_2_4 A_3_3 A_3_4 A_4_4)
                    (and
                        (= X_0_0 false) 
                        (= X_0_1 (and A_0_0 (= s_0 ",") B_1_1))
                        (= X_0_2 (or (and A_0_0 (= s_0 ",") B_1_2) (and A_0_1 (= s_1 ",") B_2_2))) 
                        (= X_0_3 (or (and A_0_0 (= s_0 ",") B_1_3) (and A_0_1 (= s_1 ",") B_2_3) (and A_0_2 (= s_2 ",") B_3_3)))
                        (= X_0_4 (or (and A_0_0 (= s_0 ",") B_1_4) (and A_0_1 (= s_1 ",") B_2_4) (and A_0_2 (= s_2 ",") B_3_4) (and A_0_3 (= s_3 ",") B_4_4)))
                        (= X_1_1 false)
                        (= X_1_2 (and A_1_1 (= s_1 ",") B_2_2))
                        (= X_1_3 (or (and A_1_1 (= s_1 ",") B_2_3) (and A_1_2 (= s_2 ",") B_3_3)))
                        (= X_1_4 (or (and A_1_1 (= s_1 ",") B_2_4) (and A_1_2 (= s_2 ",") B_3_4) (and A_1_3 (= s_3 ",") B_4_4)))
                        (= X_2_2 false)
                        (= X_2_3 (and A_2_2 (= s_2 ",") B_3_3))
                        (= X_2_4 (or (and A_2_2 (= s_2 ",") B_3_4) (and A_2_3 (= s_3 ",") B_4_4)))
                        (= X_3_3 false)
                        (= X_3_4 (and A_3_3 (= s_3 ",") B_4_4))
                        (= X_4_4 false)
                    )
                )
            ))
        )) :input ( s_0 s_1 s_2 s_3) :output ( X_0_0 X_0_1 X_0_2 X_0_3 X_0_4 X_1_1 X_1_2 X_1_3 X_1_4 X_2_2 X_2_3 X_2_4 X_3_3 X_3_4 X_4_4))
        (! (match et (
            (($alpha t1) 
                (Alpha.Sem t1 s_0 s_1 s_2 s_3 X_0_0 X_0_1 X_0_2 X_0_3 X_0_4 X_1_1 X_1_2 X_1_3 X_1_4 X_2_2 X_2_3 X_2_4 X_3_3 X_3_4 X_4_4)
            )
            (($num t1) 
                (Num.Sem t1 s_0 s_1 s_2 s_3 X_0_0 X_0_1 X_0_2 X_0_3 X_0_4 X_1_1 X_1_2 X_1_3 X_1_4 X_2_2 X_2_3 X_2_4 X_3_3 X_3_4 X_4_4)
            )
        )) :input ( s_0 s_1 s_2 s_3) :output ( X_0_0 X_0_1 X_0_2 X_0_3 X_0_4 X_1_1 X_1_2 X_1_3 X_1_4 X_2_2 X_2_3 X_2_4 X_3_3 X_3_4 X_4_4))
        (! (match at (
            ($alpha (and  (= X_0_0 false) (= X_0_1 (and (str.<= "a" s_0) (str.<= s_0 "z"))) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) (= X_1_1 false) (= X_1_2 (and (str.<= "a" s_1) (str.<= s_1 "z"))) (= X_1_3 false) (= X_1_4 false) (= X_2_2 false) (= X_2_3 (and (str.<= "a" s_2) (str.<= s_2 "z"))) (= X_2_4 false) (= X_3_3 false) (= X_3_4 (and (str.<= "a" s_3) (str.<= s_3 "z"))) (= X_4_4 false)))
            (($or-a t1 t2)
                (exists
                    (
                         (A_0_0 Bool) (A_0_1 Bool) (A_0_2 Bool) (A_0_3 Bool) (A_0_4 Bool) (A_1_1 Bool) (A_1_2 Bool) (A_1_3 Bool) (A_1_4 Bool) (A_2_2 Bool) (A_2_3 Bool) (A_2_4 Bool) (A_3_3 Bool) (A_3_4 Bool) (A_4_4 Bool)
                         (B_0_0 Bool) (B_0_1 Bool) (B_0_2 Bool) (B_0_3 Bool) (B_0_4 Bool) (B_1_1 Bool) (B_1_2 Bool) (B_1_3 Bool) (B_1_4 Bool) (B_2_2 Bool) (B_2_3 Bool) (B_2_4 Bool) (B_3_3 Bool) (B_3_4 Bool) (B_4_4 Bool)
                    )
                    (and 
                        (Alpha.Sem t1 s_0 s_1 s_2 s_3 A_0_0 A_0_1 A_0_2 A_0_3 A_0_4 A_1_1 A_1_2 A_1_3 A_1_4 A_2_2 A_2_3 A_2_4 A_3_3 A_3_4 A_4_4)
                        (Alpha.Sem t2 s_0 s_1 s_2 s_3 B_0_0 B_0_1 B_0_2 B_0_3 B_0_4 B_1_1 B_1_2 B_1_3 B_1_4 B_2_2 B_2_3 B_2_4 B_3_3 B_3_4 B_4_4)
                        (and
                            (= X_0_0 (or A_0_0 B_0_0))
                            (= X_0_1 (or A_0_1 B_0_1))
                            (= X_0_2 (or A_0_2 B_0_2))
                            (= X_0_3 (or A_0_3 B_0_3))
                            (= X_0_4 (or A_0_4 B_0_4))
                            (= X_1_1 (or A_1_1 B_1_1))
                            (= X_1_2 (or A_1_2 B_1_2))
                            (= X_1_3 (or A_1_3 B_1_3))
                            (= X_1_4 (or A_1_4 B_1_4))
                            (= X_2_2 (or A_2_2 B_2_2))
                            (= X_2_3 (or A_2_3 B_2_3))
                            (= X_2_4 (or A_2_4 B_2_4))
                            (= X_3_3 (or A_3_3 B_3_3))
                            (= X_3_4 (or A_3_4 B_3_4))
                            (= X_4_4 (or A_4_4 B_4_4))
                        )
                    )
                )
            )
            (($concat-a t1 t2)
                (exists
                    (
                         (A_0_0 Bool) (A_0_1 Bool) (A_0_2 Bool) (A_0_3 Bool) (A_0_4 Bool) (A_1_1 Bool) (A_1_2 Bool) (A_1_3 Bool) (A_1_4 Bool) (A_2_2 Bool) (A_2_3 Bool) (A_2_4 Bool) (A_3_3 Bool) (A_3_4 Bool) (A_4_4 Bool)
                         (B_0_0 Bool) (B_0_1 Bool) (B_0_2 Bool) (B_0_3 Bool) (B_0_4 Bool) (B_1_1 Bool) (B_1_2 Bool) (B_1_3 Bool) (B_1_4 Bool) (B_2_2 Bool) (B_2_3 Bool) (B_2_4 Bool) (B_3_3 Bool) (B_3_4 Bool) (B_4_4 Bool)
                    )
                    (and 
                        (Alpha.Sem t1 s_0 s_1 s_2 s_3 A_0_0 A_0_1 A_0_2 A_0_3 A_0_4 A_1_1 A_1_2 A_1_3 A_1_4 A_2_2 A_2_3 A_2_4 A_3_3 A_3_4 A_4_4)
                        (Alpha.Sem t2 s_0 s_1 s_2 s_3 B_0_0 B_0_1 B_0_2 B_0_3 B_0_4 B_1_1 B_1_2 B_1_3 B_1_4 B_2_2 B_2_3 B_2_4 B_3_3 B_3_4 B_4_4)
                        (and
                            (= X_0_0 (and A_0_0 B_0_0))
                            (= X_0_1 (or (and A_0_0 B_0_1) (and A_0_1 B_1_1)))
                            (= X_0_2 (or (and A_0_0 B_0_2) (and A_0_1 B_1_2) (and A_0_2 B_2_2)))
                            (= X_0_3 (or (and A_0_0 B_0_3) (and A_0_1 B_1_3) (and A_0_2 B_2_3) (and A_0_3 B_3_3)))
                            (= X_0_4 (or (and A_0_0 B_0_4) (and A_0_1 B_1_4) (and A_0_2 B_2_4) (and A_0_3 B_3_4) (and A_0_4 B_4_4)))
                            (= X_1_1 (and A_1_1 B_1_1))
                            (= X_1_2 (or (and A_1_1 B_1_2) (and A_1_2 B_2_2)))
                            (= X_1_3 (or (and A_1_1 B_1_3) (and A_1_2 B_2_3) (and A_1_3 B_3_3)))
                            (= X_1_4 (or (and A_1_1 B_1_4) (and A_1_2 B_2_4) (and A_1_3 B_3_4) (and A_1_4 B_4_4)))
                            (= X_2_2 (and A_2_2 B_2_2))
                            (= X_2_3 (or (and A_2_2 B_2_3) (and A_2_3 B_3_3)))
                            (= X_2_4 (or (and A_2_2 B_2_4) (and A_2_3 B_3_4) (and A_2_4 B_4_4)))
                            (= X_3_3 (and A_3_3 B_3_3))
                            (= X_3_4 (or (and A_3_3 B_3_4) (and A_3_4 B_4_4)))
                            (= X_4_4 (and A_4_4 B_4_4))
                            
                        )
                    )
                )
            )
            (($star-a t1)
                (exists
                    (
                         (A_0_0 Bool) (A_0_1 Bool) (A_0_2 Bool) (A_0_3 Bool) (A_0_4 Bool) (A_1_1 Bool) (A_1_2 Bool) (A_1_3 Bool) (A_1_4 Bool) (A_2_2 Bool) (A_2_3 Bool) (A_2_4 Bool) (A_3_3 Bool) (A_3_4 Bool) (A_4_4 Bool)
                    )
                    (and 
                        (Alpha.Sem t1 s_0 s_1 s_2 s_3 A_0_0 A_0_1 A_0_2 A_0_3 A_0_4 A_1_1 A_1_2 A_1_3 A_1_4 A_2_2 A_2_3 A_2_4 A_3_3 A_3_4 A_4_4)
                        
                        (and
                        (= X_0_0 true)
                        (= X_0_1 A_0_1)
                        (= X_0_2 (or A_0_2 (and A_0_1 A_1_2)))
                        (= X_0_3 (or A_0_3 (and A_0_2 A_2_3) (and A_0_1 A_1_3) (and A_0_1 A_1_2 A_2_3)))
                        (= X_0_4 (or A_0_4 (and A_0_3 A_3_4) (and A_0_2 A_2_4) (and A_0_1 A_1_4) (and A_0_1 A_1_2 A_2_4) (and A_0_1 A_1_3 A_3_4) (and A_0_2 A_2_3 A_3_4) (and A_0_1 A_1_2 A_2_3 A_3_4)))

                        
                        (= X_1_1 true)
                        (= X_1_2 A_1_2)
                        (= X_1_3 (or A_1_3 (and A_1_2 A_2_3)))
                        (= X_1_4 (or A_1_4 (and A_1_3 A_3_4) (and A_1_2 A_2_4) (and A_1_2 A_2_3 A_3_4)))

                        
                        (= X_2_2 true)
                        (= X_2_3 A_2_3)
                        (= X_2_4 (or A_2_4 (and A_2_3 A_3_4)))
                        
                        (= X_3_3 true)
                        (= X_3_4 A_3_4)
                        
                        (= X_4_4 true)
                        
                        )
                    )
                )
            )
        )) :input ( s_0 s_1 s_2 s_3) :output ( X_0_0 X_0_1 X_0_2 X_0_3 X_0_4 X_1_1 X_1_2 X_1_3 X_1_4 X_2_2 X_2_3 X_2_4 X_3_3 X_3_4 X_4_4))
        (! (match nt (
            ($num (and  (= X_0_0 false) (= X_0_1 (str.is_digit s_0)) (= X_0_2 false) (= X_0_3 false) (= X_0_4 false) (= X_1_1 false) (= X_1_2 (str.is_digit s_1)) (= X_1_3 false) (= X_1_4 false) (= X_2_2 false) (= X_2_3 (str.is_digit s_2)) (= X_2_4 false) (= X_3_3 false) (= X_3_4 (str.is_digit s_3)) (= X_4_4 false)))
            (($or-n t1 t2)
                (exists
                    (
                         (A_0_0 Bool) (A_0_1 Bool) (A_0_2 Bool) (A_0_3 Bool) (A_0_4 Bool) (A_1_1 Bool) (A_1_2 Bool) (A_1_3 Bool) (A_1_4 Bool) (A_2_2 Bool) (A_2_3 Bool) (A_2_4 Bool) (A_3_3 Bool) (A_3_4 Bool) (A_4_4 Bool)
                         (B_0_0 Bool) (B_0_1 Bool) (B_0_2 Bool) (B_0_3 Bool) (B_0_4 Bool) (B_1_1 Bool) (B_1_2 Bool) (B_1_3 Bool) (B_1_4 Bool) (B_2_2 Bool) (B_2_3 Bool) (B_2_4 Bool) (B_3_3 Bool) (B_3_4 Bool) (B_4_4 Bool)
                    )
                    (and 
                        (Num.Sem t1 s_0 s_1 s_2 s_3 A_0_0 A_0_1 A_0_2 A_0_3 A_0_4 A_1_1 A_1_2 A_1_3 A_1_4 A_2_2 A_2_3 A_2_4 A_3_3 A_3_4 A_4_4)
                        (Num.Sem t2 s_0 s_1 s_2 s_3 B_0_0 B_0_1 B_0_2 B_0_3 B_0_4 B_1_1 B_1_2 B_1_3 B_1_4 B_2_2 B_2_3 B_2_4 B_3_3 B_3_4 B_4_4)
                        (and
                            (= X_0_0 (or A_0_0 B_0_0))
                            (= X_0_1 (or A_0_1 B_0_1))
                            (= X_0_2 (or A_0_2 B_0_2))
                            (= X_0_3 (or A_0_3 B_0_3))
                            (= X_0_4 (or A_0_4 B_0_4))
                            (= X_1_1 (or A_1_1 B_1_1))
                            (= X_1_2 (or A_1_2 B_1_2))
                            (= X_1_3 (or A_1_3 B_1_3))
                            (= X_1_4 (or A_1_4 B_1_4))
                            (= X_2_2 (or A_2_2 B_2_2))
                            (= X_2_3 (or A_2_3 B_2_3))
                            (= X_2_4 (or A_2_4 B_2_4))
                            (= X_3_3 (or A_3_3 B_3_3))
                            (= X_3_4 (or A_3_4 B_3_4))
                            (= X_4_4 (or A_4_4 B_4_4))
                        )
                    )
                )
            )
            (($concat-n t1 t2)
                (exists
                    (
                         (A_0_0 Bool) (A_0_1 Bool) (A_0_2 Bool) (A_0_3 Bool) (A_0_4 Bool) (A_1_1 Bool) (A_1_2 Bool) (A_1_3 Bool) (A_1_4 Bool) (A_2_2 Bool) (A_2_3 Bool) (A_2_4 Bool) (A_3_3 Bool) (A_3_4 Bool) (A_4_4 Bool)
                         (B_0_0 Bool) (B_0_1 Bool) (B_0_2 Bool) (B_0_3 Bool) (B_0_4 Bool) (B_1_1 Bool) (B_1_2 Bool) (B_1_3 Bool) (B_1_4 Bool) (B_2_2 Bool) (B_2_3 Bool) (B_2_4 Bool) (B_3_3 Bool) (B_3_4 Bool) (B_4_4 Bool)
                    )
                    (and 
                        (Num.Sem t1 s_0 s_1 s_2 s_3 A_0_0 A_0_1 A_0_2 A_0_3 A_0_4 A_1_1 A_1_2 A_1_3 A_1_4 A_2_2 A_2_3 A_2_4 A_3_3 A_3_4 A_4_4)
                        (Num.Sem t2 s_0 s_1 s_2 s_3 B_0_0 B_0_1 B_0_2 B_0_3 B_0_4 B_1_1 B_1_2 B_1_3 B_1_4 B_2_2 B_2_3 B_2_4 B_3_3 B_3_4 B_4_4)
                        (and
                            (= X_0_0 (and A_0_0 B_0_0))
                            (= X_0_1 (or (and A_0_0 B_0_1) (and A_0_1 B_1_1)))
                            (= X_0_2 (or (and A_0_0 B_0_2) (and A_0_1 B_1_2) (and A_0_2 B_2_2)))
                            (= X_0_3 (or (and A_0_0 B_0_3) (and A_0_1 B_1_3) (and A_0_2 B_2_3) (and A_0_3 B_3_3)))
                            (= X_0_4 (or (and A_0_0 B_0_4) (and A_0_1 B_1_4) (and A_0_2 B_2_4) (and A_0_3 B_3_4) (and A_0_4 B_4_4)))
                            (= X_1_1 (and A_1_1 B_1_1))
                            (= X_1_2 (or (and A_1_1 B_1_2) (and A_1_2 B_2_2)))
                            (= X_1_3 (or (and A_1_1 B_1_3) (and A_1_2 B_2_3) (and A_1_3 B_3_3)))
                            (= X_1_4 (or (and A_1_1 B_1_4) (and A_1_2 B_2_4) (and A_1_3 B_3_4) (and A_1_4 B_4_4)))
                            (= X_2_2 (and A_2_2 B_2_2))
                            (= X_2_3 (or (and A_2_2 B_2_3) (and A_2_3 B_3_3)))
                            (= X_2_4 (or (and A_2_2 B_2_4) (and A_2_3 B_3_4) (and A_2_4 B_4_4)))
                            (= X_3_3 (and A_3_3 B_3_3))
                            (= X_3_4 (or (and A_3_3 B_3_4) (and A_3_4 B_4_4)))
                            (= X_4_4 (and A_4_4 B_4_4))
                            
                        )
                    )
                )
            )
            (($star-n t1)
                (exists
                    (
                         (A_0_0 Bool) (A_0_1 Bool) (A_0_2 Bool) (A_0_3 Bool) (A_0_4 Bool) (A_1_1 Bool) (A_1_2 Bool) (A_1_3 Bool) (A_1_4 Bool) (A_2_2 Bool) (A_2_3 Bool) (A_2_4 Bool) (A_3_3 Bool) (A_3_4 Bool) (A_4_4 Bool)
                    )
                    (and 
                        (Num.Sem t1 s_0 s_1 s_2 s_3 A_0_0 A_0_1 A_0_2 A_0_3 A_0_4 A_1_1 A_1_2 A_1_3 A_1_4 A_2_2 A_2_3 A_2_4 A_3_3 A_3_4 A_4_4)
                        
                        (and
                        (= X_0_0 true)
                        (= X_0_1 A_0_1)
                        (= X_0_2 (or A_0_2 (and A_0_1 A_1_2)))
                        (= X_0_3 (or A_0_3 (and A_0_2 A_2_3) (and A_0_1 A_1_3) (and A_0_1 A_1_2 A_2_3)))
                        (= X_0_4 (or A_0_4 (and A_0_3 A_3_4) (and A_0_2 A_2_4) (and A_0_1 A_1_4) (and A_0_1 A_1_2 A_2_4) (and A_0_1 A_1_3 A_3_4) (and A_0_2 A_2_3 A_3_4) (and A_0_1 A_1_2 A_2_3 A_3_4)))

                        
                        (= X_1_1 true)
                        (= X_1_2 A_1_2)
                        (= X_1_3 (or A_1_3 (and A_1_2 A_2_3)))
                        (= X_1_4 (or A_1_4 (and A_1_3 A_3_4) (and A_1_2 A_2_4) (and A_1_2 A_2_3 A_3_4)))

                        
                        (= X_2_2 true)
                        (= X_2_3 A_2_3)
                        (= X_2_4 (or A_2_4 (and A_2_3 A_3_4)))
                        
                        (= X_3_3 true)
                        (= X_3_4 A_3_4)
                        
                        (= X_4_4 true)
                        
                        )
                    )
                )
            )
        )) :input ( s_0 s_1 s_2 s_3) :output ( X_0_0 X_0_1 X_0_2 X_0_3 X_0_4 X_1_1 X_1_2 X_1_3 X_1_4 X_2_2 X_2_3 X_2_4 X_3_3 X_3_4 X_4_4))
    )
)

(synth-fun match_regex() Start)

;; [(num)*, alpha]
(constraint (Start.Sem match_regex "1" "2" "," "b" true))
(constraint (Start.Sem match_regex "4" "4" "," "c" true))
(constraint (Start.Sem match_regex "1" "a" "," "a" false))
(constraint (Start.Sem match_regex "1" "," "1" "a" false))
(constraint (Start.Sem match_regex "1" "," "1" "2" false))

(check-synth)
