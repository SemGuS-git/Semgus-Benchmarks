(set-info :format-version "2.0.0")
(set-info :realizable true)
(set-info :pbe true)

(declare-term-types
  ((E 0) (N 0))
  ((($x)      ; E -> x
    ($+ E N)  ;    | E + N
    ($* E N)) ;    | E * N
   (($2)      ; N -> 2
    ($3))))   ;    | 3

(define-funs-rec
  ((E.Sem ((t_e E) (x Int) (y Int)) Bool)
   (N.Sem ((t_n N) (x Int) (y Int)) Bool))

  ((! (match t_e
        (($x (= y x))
         (($+ eta etb)
           (exists ((va Int) (vb Int))
             (and
               (E.Sem eta x va)
               (N.Sem etb x vb)
               (= y (+ va vb)))))
         (($* eta etb)
           (exists ((va Int) (vb Int))
             (and
               (E.Sem eta x va)
               (N.Sem etb x vb)
               (= y (* va vb)))))))
     :input (x) :output (y))

   (! (match t_n
        (($2 (= y 2))
         ($3 (= y 3))))
     :input (x) :output (y))))

(synth-fun f() E)
(constraint (E.Sem f 1 9))
(check-synth)
