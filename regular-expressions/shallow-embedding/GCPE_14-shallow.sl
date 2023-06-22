;; GCPE_14: 0 start - odd len, 1 start - even len
           
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
(constraint (Start.Sem match_regex "001" true))
(constraint (Start.Sem match_regex "010" true))
(constraint (Start.Sem match_regex "011" true))
(constraint (Start.Sem match_regex "00000" true))
(constraint (Start.Sem match_regex "00001" true))
(constraint (Start.Sem match_regex "00010" true))
(constraint (Start.Sem match_regex "00011" true))
(constraint (Start.Sem match_regex "00100" true))
(constraint (Start.Sem match_regex "00101" true))
(constraint (Start.Sem match_regex "00110" true))
(constraint (Start.Sem match_regex "00111" true))
(constraint (Start.Sem match_regex "01000" true))
(constraint (Start.Sem match_regex "01001" true))
(constraint (Start.Sem match_regex "01010" true))
(constraint (Start.Sem match_regex "01011" true))
(constraint (Start.Sem match_regex "01100" true))
(constraint (Start.Sem match_regex "01101" true))
(constraint (Start.Sem match_regex "01110" true))
(constraint (Start.Sem match_regex "01111" true))
(constraint (Start.Sem match_regex "10" true))
(constraint (Start.Sem match_regex "11" true))
(constraint (Start.Sem match_regex "1000" true))
(constraint (Start.Sem match_regex "1001" true))
(constraint (Start.Sem match_regex "1010" true))
(constraint (Start.Sem match_regex "1011" true))
(constraint (Start.Sem match_regex "1100" true))
(constraint (Start.Sem match_regex "1101" true))
(constraint (Start.Sem match_regex "1110" true))
(constraint (Start.Sem match_regex "1111" true))
(constraint (Start.Sem match_regex "00" false))
(constraint (Start.Sem match_regex "01" false))
(constraint (Start.Sem match_regex "0000" false))
(constraint (Start.Sem match_regex "0001" false))
(constraint (Start.Sem match_regex "0010" false))
(constraint (Start.Sem match_regex "0011" false))
(constraint (Start.Sem match_regex "0100" false))
(constraint (Start.Sem match_regex "0101" false))
(constraint (Start.Sem match_regex "0110" false))
(constraint (Start.Sem match_regex "0111" false))
(constraint (Start.Sem match_regex "1" false))
(constraint (Start.Sem match_regex "100" false))
(constraint (Start.Sem match_regex "101" false))
(constraint (Start.Sem match_regex "110" false))
(constraint (Start.Sem match_regex "111" false))
(constraint (Start.Sem match_regex "10000" false))
(constraint (Start.Sem match_regex "10001" false))
(constraint (Start.Sem match_regex "10010" false))
(constraint (Start.Sem match_regex "10011" false))
(constraint (Start.Sem match_regex "10100" false))
(constraint (Start.Sem match_regex "10101" false))
(constraint (Start.Sem match_regex "10110" false))
(constraint (Start.Sem match_regex "10111" false))
(constraint (Start.Sem match_regex "11000" false))
(constraint (Start.Sem match_regex "11001" false))
(constraint (Start.Sem match_regex "11010" false))
(constraint (Start.Sem match_regex "11011" false))
(constraint (Start.Sem match_regex "11100" false))
(constraint (Start.Sem match_regex "11101" false))
(constraint (Start.Sem match_regex "11110" false))
(constraint (Start.Sem match_regex "11111" false))
(check-synth)
