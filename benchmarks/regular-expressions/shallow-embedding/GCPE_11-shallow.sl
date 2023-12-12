;; GCPE_11: 0 followed by 1
           
;; (set-info :format-version "2.2.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

(declare-term-types
    ;; Nonterminals
    ((Start 0) (R 0))
    
    ;; Productions
    (
        (($eval R))
    
        (
            ($char_0)         ;; (str.to.re "0")
            ($char_1)         ;; (str.to.re "1")
            ($any)            ;; (re.allchar)
            ($opt R)          ;; (re.opt r1)
            ($or R R)         ;; (re.union r1 r2)
            ($concat R R)     ;; (re.++ r1 r2)
            ($star R)         ;; (re.* r1)
        )
    )
)

(define-funs-rec
    (
        (Start.Sem ((t Start) (str String) (result Bool)) Bool)
        (R.Sem ((t R) (result RegLan)) Bool)
    )
    
    (
        (! (match t (
            (($eval t1) (exists
                ((r1 RegLan))
                (and
                    (R.Sem t1 r1) 
                    (= result (str.in_re str r1))
                )
            ))
        )) :input (str) :output (result))
        (! (match t (
            ($char_0 (= result (str.to_re "0")) )
            ($char_1 (= result (str.to_re "1")) )
            ($any (= result re.allchar) ) 
            (($or t1 t2)
                (exists
                    (
                        (r1 RegLan) 
                        (r2 RegLan) 
                    )
                    (and 
                        (R.Sem t1 r1) 
                        (R.Sem t2 r2) 
                        (= result (re.union r1 r2))
                    )
                )
            )
            (($concat t1 t2)
                (exists
                    (
                        (r1 RegLan)
                        (r2 RegLan)
                    )
                    (and 
                        (R.Sem t1 r1) 
                        (R.Sem t2 r2)
                        (= result (re.++ r1 r2))
                    )
                )
            )
            (($opt t1)
                (exists
                    (
                        (r1 RegLan)
                    )
                    (and 
                        (R.Sem t1 r1)
                        (= result (re.opt r1))
                    )
                )
            )
            (($star t1)
                (exists
                    (
                        (r1 RegLan)
                    )
                    (and 
                        (R.Sem t1 r1) 
                        (= result (re.* r1))
                    )
                )
            )
        )) :input () :output (result))
    )
)

(synth-fun match_regex() Start)
(constraint (Start.Sem match_regex "0" true))
(constraint (Start.Sem match_regex "000" true))
(constraint (Start.Sem match_regex "10" true))
(constraint (Start.Sem match_regex "010" true))
(constraint (Start.Sem match_regex "100" true))
(constraint (Start.Sem match_regex "1010" true))
(constraint (Start.Sem match_regex "10010" true))
(constraint (Start.Sem match_regex "1" false))
(constraint (Start.Sem match_regex "110" false))
(constraint (Start.Sem match_regex "01" false))
(constraint (Start.Sem match_regex "0101" false))
(constraint (Start.Sem match_regex "10101" false))
(constraint (Start.Sem match_regex "100101" false))
(check-synth)
