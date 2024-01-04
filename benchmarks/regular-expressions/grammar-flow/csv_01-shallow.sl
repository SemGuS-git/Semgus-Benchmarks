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
            ($alphat Alpha)
            ($numt Num)
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
        (Start.Sem ((t Start) (str String) (result Bool)) Bool)
        (Row.Sem ((rt Row) (result RegLan)) Bool)
        (Entry.Sem ((et Entry) (result RegLan)) Bool)
        (Alpha.Sem ((at Alpha) (result RegLan)) Bool)
        (Num.Sem ((nt Num) (result RegLan)) Bool)
    )
    
    (
        (! (match t (
            (($eval t1) (exists
                ((r1 RegLan))
                (and
                    (Row.Sem t1 r1) 
                    (= result (str.in_re str r1))
                )
            ))
        )) :input (str) :output (result))
        (! (match rt (
            (($entry t1)
                (exists ((r1 RegLan))
                    (and
                        (Entry.Sem t1 r1)
                        (= result r1)
                    )
                )
            )
            (($cons t1 t2)
                (exists ((r1 RegLan) (r2 RegLan))
                    (and
                        (Entry.Sem t1 r1)
                        (Row.Sem t2 r2)
                        (= result (re.++ r1 (re.++ (str.to_re ",") r2)))
                    )
                )
            )
        )) :input () :output (result))
        (! (match et (
            (($alphat t1)
                (exists ((r1 RegLan))
                    (and
                        (Alpha.Sem t1 r1)
                        (= result r1)
                    )
                )
            )
            (($numt t1)
                (exists ((r1 RegLan))
                    (and
                        (Num.Sem t1 r1)
                        (= result r1)
                    )
                )
            )
        )) :input () :output (result))
        (! (match at (
            ($alpha (= result (re.range "a" "z"))) 
            (($or-a t1 t2)
                (exists
                    (
                        (r1 RegLan) 
                        (r2 RegLan) 
                    )
                    (and 
                        (Alpha.Sem t1 r1) 
                        (Alpha.Sem t2 r2) 
                        (= result (re.union r1 r2))
                    )
                )
            )
            (($concat-a t1 t2)
                (exists
                    (
                        (r1 RegLan)
                        (r2 RegLan)
                    )
                    (and 
                        (Alpha.Sem t1 r1) 
                        (Alpha.Sem t2 r2)
                        (= result (re.++ r1 r2))
                    )
                )
            )
            (($star-a t1)
                (exists
                    (
                        (r1 RegLan)
                    )
                    (and 
                        (Alpha.Sem t1 r1) 
                        (= result (re.* r1))
                    )
                )
            )
        )) :input () :output (result))
        (! (match nt (
            ($num (= result (re.range "0" "9"))) 
            (($or-n t1 t2)
                (exists
                    (
                        (r1 RegLan) 
                        (r2 RegLan) 
                    )
                    (and 
                        (Num.Sem t1 r1) 
                        (Num.Sem t2 r2) 
                        (= result (re.union r1 r2))
                    )
                )
            )
            (($concat-n t1 t2)
                (exists
                    (
                        (r1 RegLan)
                        (r2 RegLan)
                    )
                    (and 
                        (Num.Sem t1 r1) 
                        (Num.Sem t2 r2)
                        (= result (re.++ r1 r2))
                    )
                )
            )
            (($star-n t1)
                (exists
                    (
                        (r1 RegLan)
                    )
                    (and 
                        (Num.Sem t1 r1) 
                        (= result (re.* r1))
                    )
                )
            )
        )) :input () :output (result))
    )
)

(synth-fun match_regex() Start)

;; [(num)*, (alpha)*]
(constraint (Start.Sem match_regex "9,a" true))
(constraint (Start.Sem match_regex "608,name" true))
(constraint (Start.Sem match_regex "7202,last" true))
(constraint (Start.Sem match_regex "1234" false))
(constraint (Start.Sem match_regex "str,str" false))
(constraint (Start.Sem match_regex "name,512" false))

(check-synth)
