(set-info :format-version "2.0.0")
(set-info :realizable false)
(set-info :pbe true)

(declare-term-types
  ((A 0) (B 0) (C 0))
  ((($a B C)) ; A -> a B C
   (($b))     ; B -> b
   (($c))))   ; C -> c

(define-funs-rec
  ((A.Sem ((t_a A) (x Int) (y Int)) Bool)
   (B.Sem ((t_b B) (x Int) (p Int)) Bool)
   (C.Sem ((t_c C) (p Int) (q Int)) Bool))

  ((! (match t_a
        ((($a etb etc)
           (exists ((p Int) (q Int))
             (and
               (B.Sem etb x p)            ; asserts p can be anything
               (C.Sem etc p q)            ; asserts p < q
               (and (> p q) (= y 1))))))) ; asserts p > q
     :input (x) :output (y))

   (! (match t_b
        (($b true))) ; p is unconstrained
     :input (x) :output (p))

   (! (match t_c
        (($c (< p q)))) ; q must be something greater than p
      :input (p) :output (q))))

(synth-fun f() A)
(constraint (A.Sem f 0 1)) ; since the only term "(a b c)" gets stuck, this is unrealizable
(check-synth)
