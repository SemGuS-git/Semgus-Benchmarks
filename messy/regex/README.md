# Fixed-length regex encoding

Running `messy-script.py` will read the JSON-encoded regex problems from `sources/messy-regex.json` and convert them to Semgus files using a fixed-length matrix semantics. These semantics are described in greater detail in [Kim et al. 2021](https://dl.acm.org/doi/pdf/10.1145/3434311), Section 6.4.

To demonstrate the effect that different semantics may have on program efficiency, we provide both *linear* and *logarithmic* implementations of the Kleene star.

Below is a version of `linear/GCPE_01.sem` with enhanced comments.

```lisp
(metadata :format-version "1.0.0")
(metadata :author "Wiley Corning")
(metadata :description "GCPE_01: word starts with 0")

; string length: 3

(declare-term-type Start.Term)
(declare-term-type R.Term)

(synth-term match_regex Start.Term (
    (declare-nt Start Start.Term (Start.Sem (Start.Term Int Int Int Int Bool)))
    (declare-nt R R.Term (R.Sem (R.Term Int Int Int Int Bool Bool Bool Bool Bool Bool Bool Bool Bool Bool )))
    
    (declare-var start.t Start.Term)
    (declare-var (r.t r.t1 r.t2) R.Term)
    
    (declare-var len Int)
    (declare-var (s_0 s_1 s_2 ) Int) ; String entries (length 3)
    (declare-var result Bool)
    (declare-var nxt Int)
    (declare-var (X_0_0 X_0_1 X_0_2 X_0_3 X_1_1 X_1_2 X_1_3 X_2_2 X_2_3 X_3_3 ) Bool) ; Primary output matrix: 4x4 upper triangular
    (declare-var (A_0_0 A_0_1 A_0_2 A_0_3 A_1_1 A_1_2 A_1_3 A_2_2 A_2_3 A_3_3 ) Bool) ; Auxiliary output matrix
    (declare-var (B_0_0 B_0_1 B_0_2 B_0_3 B_1_1 B_1_2 B_1_3 B_2_2 B_2_3 B_3_3 ) Bool) ; Auxiliary output matrix
    
    ; Start symbol
    ((Start start.t) (Start.Sem start.t len s_0 s_1 s_2  (! result :out))
        ; Evaluate regex on all substrings, return corner element based on provided length value
        (($eval (R r.t))
            (and (= len 0) (R.Sem r.t len s_0 s_1 s_2  X_0_0 X_0_1 X_0_2 X_0_3 X_1_1 X_1_2 X_1_3 X_2_2 X_2_3 X_3_3 ) (= result X_0_0) )
            (and (= len 1) (R.Sem r.t len s_0 s_1 s_2  X_0_0 X_0_1 X_0_2 X_0_3 X_1_1 X_1_2 X_1_3 X_2_2 X_2_3 X_3_3 ) (= result X_0_1) )
            (and (= len 2) (R.Sem r.t len s_0 s_1 s_2  X_0_0 X_0_1 X_0_2 X_0_3 X_1_1 X_1_2 X_1_3 X_2_2 X_2_3 X_3_3 ) (= result X_0_2) )
            (and (= len 3) (R.Sem r.t len s_0 s_1 s_2  X_0_0 X_0_1 X_0_2 X_0_3 X_1_1 X_1_2 X_1_3 X_2_2 X_2_3 X_3_3 ) (= result X_0_3) )
        )
    )
    
    ((R r.t) (R.Sem r.t len s_0 s_1 s_2  (! X_0_0 :out) (! X_0_1 :out) (! X_0_2 :out) (! X_0_3 :out) (! X_1_1 :out) (! X_1_2 :out) (! X_1_3 :out) (! X_2_2 :out) (! X_2_3 :out) (! X_3_3 :out) )
        ; --- Epsilon ---
        ; This produces an identity matrix. Note that X_0_0 is true; this matches an empty string.
        ($eps
            (and
                (= X_0_0 true) (= X_0_1 false) (= X_0_2 false) (= X_0_3 false) 
                (= X_1_1 true) (= X_1_2 false) (= X_1_3 false) 
                (= X_2_2 true) (= X_2_3 false) 
                (= X_3_3 true) 
            )
        )
        
        ; --- Any (regex dot) ---
        ; Matrix in which exactly the above-diagonal elements are true.
        ; This matches any single character, including placeholders.
        ($any
            (and
                (= X_0_0 false) (= X_0_1 true) (= X_0_2 false) (= X_0_3 false) 
                (= X_1_1 false) (= X_1_2 true) (= X_1_3 false) 
                (= X_2_2 false) (= X_2_3 true) 
                (= X_3_3 false) 
        ))
        
        ; --- Characters ---
        ; Check whether each character in the string matches the specified value.
        ; This version also checks for a *negative wildcard character* (here, the value 3), which is used to represent wildcards in negative examples.
        ; For example, "r(0_1) = false" will be encoded as 0,3,1,false; then the regex `001` will match `0_1`, so it is not a solution.
        ; By contrast, "r(0_1) = true" will be encoded as 0,2,1,true; then the regex `001` will *not* match `0_1`, so it would not be a solution.

        ; character 0
        ($0
            (and
                (= X_0_0 false) (= X_0_1 (or (= s_0 0) (= s_0 3))) (= X_0_2 false) (= X_0_3 false) 
                (= X_1_1 false) (= X_1_2 (or (= s_1 0) (= s_1 3))) (= X_1_3 false) 
                (= X_2_2 false) (= X_2_3 (or (= s_2 0) (= s_2 3))) 
                (= X_3_3 false) 
            )
        )

        ; character 1
        ($1
            (and
                (= X_0_0 false) (= X_0_1 (or (= s_0 1) (= s_0 3))) (= X_0_2 false) (= X_0_3 false) 
                (= X_1_1 false) (= X_1_2 (or (= s_1 1) (= s_1 3))) (= X_1_3 false) 
                (= X_2_2 false) (= X_2_3 (or (= s_2 1) (= s_2 3))) 
                (= X_3_3 false) 
            )
        )

        
        ; Disjunction
        ; (r+s) is represented by taking the elementwise OR of their respective matrices.
        ; Observe that (eps + .) will match all strings of length 0 or 1.
        (($or (R r.t1) (R r.t2))
            (and
                (R.Sem r.t1 len s_0 s_1 s_2  A_0_0 A_0_1 A_0_2 A_0_3 A_1_1 A_1_2 A_1_3 A_2_2 A_2_3 A_3_3 )
                (R.Sem r.t2 len s_0 s_1 s_2  B_0_0 B_0_1 B_0_2 B_0_3 B_1_1 B_1_2 B_1_3 B_2_2 B_2_3 B_3_3 )
                
                ; X = A+B
                
                (= X_0_0 (or A_0_0 B_0_0))
                (= X_0_1 (or A_0_1 B_0_1))
                (= X_0_2 (or A_0_2 B_0_2))
                (= X_0_3 (or A_0_3 B_0_3))
                (= X_1_1 (or A_1_1 B_1_1))
                (= X_1_2 (or A_1_2 B_1_2))
                (= X_1_3 (or A_1_3 B_1_3))
                (= X_2_2 (or A_2_2 B_2_2))
                (= X_2_3 (or A_2_3 B_2_3))
                (= X_3_3 (or A_3_3 B_3_3))
            )
        )
        
        
        ; Concatenation
        ; (rs) is represented by taking the boolean matrix product of their respective matrices.
        ; Observe that (..) matches any string of length 2, whereas (eps eps) = eps.
        (($concat (R r.t1) (R r.t2))
            (and
                (R.Sem r.t1 len s_0 s_1 s_2  A_0_0 A_0_1 A_0_2 A_0_3 A_1_1 A_1_2 A_1_3 A_2_2 A_2_3 A_3_3 )
                (R.Sem r.t2 len s_0 s_1 s_2  B_0_0 B_0_1 B_0_2 B_0_3 B_1_1 B_1_2 B_1_3 B_2_2 B_2_3 B_3_3 )
                
                ; X = AB
                
                (= X_0_0 (or (and A_0_0 B_0_0)                                                       ))
                (= X_0_1 (or (and A_0_0 B_0_1) (and A_0_1 B_1_1)                                     ))
                (= X_0_2 (or (and A_0_0 B_0_2) (and A_0_1 B_1_2) (and A_0_2 B_2_2)                   ))
                (= X_0_3 (or (and A_0_0 B_0_3) (and A_0_1 B_1_3) (and A_0_2 B_2_3) (and A_0_3 B_3_3) ))
                (= X_1_1 (or                   (and A_1_1 B_1_1)                                     ))
                (= X_1_2 (or                   (and A_1_1 B_1_2) (and A_1_2 B_2_2)                   ))
                (= X_1_3 (or                   (and A_1_1 B_1_3) (and A_1_2 B_2_3) (and A_1_3 B_3_3) ))
                (= X_2_2 (or                                     (and A_2_2 B_2_2)                   ))
                (= X_2_3 (or                                     (and A_2_2 B_2_3) (and A_2_3 B_3_3) ))
                (= X_3_3 (or                                                       (and A_3_3 B_3_3) ))
            )
        )
        
        ; Kleene star
        ; We inductively construct r* = eps + r + rr + rrr... following the above rules for concatenation and epsilon.
        ; The length variable decremented at each step.
        (($star (R r.t1))
            ; Base case
            (and 
                (= 0 len) 
                (= X_0_0 true) (= X_0_1 false) (= X_0_2 false) (= X_0_3 false) 
                (= X_1_1 true) (= X_1_2 false) (= X_1_3 false) 
                (= X_2_2 true) (= X_2_3 false) 
                (= X_3_3 true) 
            )
            ; Inductive case
            (and
                (< 0 len)
                (= nxt (- len 1))
                (R.Sem r.t1 len s_0 s_1 s_2  A_0_0 A_0_1 A_0_2 A_0_3 A_1_1 A_1_2 A_1_3 A_2_2 A_2_3 A_3_3 )
                (R.Sem r.t  nxt s_0 s_1 s_2  B_0_0 B_0_1 B_0_2 B_0_3 B_1_1 B_1_2 B_1_3 B_2_2 B_2_3 B_3_3 )
                
                ; X = (X X_{k-1}) + X_{k-1} = (AB)+B
                
                (= X_0_0 (or B_0_0 (and A_0_0 B_0_0)                                                       ))
                (= X_0_1 (or B_0_1 (and A_0_0 B_0_1) (and A_0_1 B_1_1)                                     ))
                (= X_0_2 (or B_0_2 (and A_0_0 B_0_2) (and A_0_1 B_1_2) (and A_0_2 B_2_2)                   ))
                (= X_0_3 (or B_0_3 (and A_0_0 B_0_3) (and A_0_1 B_1_3) (and A_0_2 B_2_3) (and A_0_3 B_3_3) ))
                (= X_1_1 (or B_1_1                   (and A_1_1 B_1_1)                                     ))
                (= X_1_2 (or B_1_2                   (and A_1_1 B_1_2) (and A_1_2 B_2_2)                   ))
                (= X_1_3 (or B_1_3                   (and A_1_1 B_1_3) (and A_1_2 B_2_3) (and A_1_3 B_3_3) ))
                (= X_2_2 (or B_2_2                                     (and A_2_2 B_2_2)                   ))
                (= X_2_3 (or B_2_3                                     (and A_2_2 B_2_3) (and A_2_3 B_3_3) ))
                (= X_3_3 (or B_3_3                                                       (and A_3_3 B_3_3) ))
            )
        )
    )
))

; GCPE_01: word starts with 0

(constraint (Start.Sem match_regex 1 0 9 9 true))   ; 0   -> true
(constraint (Start.Sem match_regex 2 0 1 9 true))   ; 01  -> true
(constraint (Start.Sem match_regex 2 0 0 9 true))   ; 00  -> true
(constraint (Start.Sem match_regex 3 0 1 1 true))   ; 011 -> true
(constraint (Start.Sem match_regex 3 0 0 0 true))   ; 000 -> true
(constraint (Start.Sem match_regex 3 0 1 0 true))   ; 010 -> true
(constraint (Start.Sem match_regex 3 0 0 1 true))   ; 001 -> true
(constraint (Start.Sem match_regex 1 1 9 9 false))  ; 1   -> false
(constraint (Start.Sem match_regex 2 1 1 9 false))  ; 11  -> false
(constraint (Start.Sem match_regex 2 1 0 9 false))  ; 10  -> false
(constraint (Start.Sem match_regex 3 1 1 1 false))  ; 111 -> false
(constraint (Start.Sem match_regex 3 1 0 0 false))  ; 100 -> false
(constraint (Start.Sem match_regex 3 1 1 0 false))  ; 110 -> false
(constraint (Start.Sem match_regex 3 1 0 1 false))  ; 101 -> false
```