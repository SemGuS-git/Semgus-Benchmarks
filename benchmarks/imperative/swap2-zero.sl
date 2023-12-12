; Semgus problem that attempts to synthesize the max function for two variables 
; over imperative terms

(set-info :format-version "2.4.0")
(set-info :author("Rahul Krishnan"))
(set-info :realizable true)

(declare-term-types
  ;; Declare the 'universal grammar' to be used in the Semgus problem
 ((S 0) (E 0))
 ;; Productions for S: S -> x := E | y := E | seq S S 
 ((($=x E)
   ($=y E)
   ($=z E)
   ($seq S S))
    ;; Productions for E: E -> x | y | 0 | 1 | E + E
  (($x)
   ($y)
   ($z)
   ($0)
   ($1)
   ($+ E E))))

(define-funs-rec 
    ;; Define the semantics of the productions of the universal grammar
    ((sem-S ((st S) (x Int) (y Int) (z Int) (rx Int) (ry Int) (rz Int)) Bool)
     (sem-E ((et E) (x Int) (y Int) (z Int) (r Int)) Bool))
    ((! (match st ; Semantics of S
               ((($=x et) (exists ((r Int))
                                  (and (sem-E et x y z r)
                                       (and (= rx r) (= ry y) (= rz z)))))
                (($=y et) (exists ((r Int))
                                  (and (sem-E et x y z r)
                                       (and (= rx x) (= ry r) (= rz z)))))
                (($=z et) (exists ((r Int))
                                  (and (sem-E et x y z r)
                                       (and (= rx x) (= ry y) (= rz r)))))
                (($seq st1 st2) (exists ((xi1 Int) (yi1 Int) (zi1 Int) (xi2 Int) (yi2 Int) (zi2 Int))
                                        (and (sem-S st1 x y z xi1 yi1 zi1)
                                             (sem-S st2 xi1 yi1 zi1 xi2 yi2 zi2)
                                             (and (= rx xi2) (= ry yi2) (= rz zi2)))))))
        :input (x y z) :output (rx ry rz))
     (! (match et ; Semantics of E
               (($x (= r x))
                ($y (= r y))
                ($z (= r z))
                ($0 (= r 0))
                ($1 (= r 1))
                (($+ et1 et2)
                 (exists ((r1 Int) (r2 Int))
                         (and (sem-E et1 x y z r1)
                              (sem-E et2 x y z r2)
                              (= r (+ r1 r2)))))))
        :input (x y z) :output (r))))
                   
(synth-fun swap2() S) 

;; Example-based constraints
(constraint (sem-S swap2 1 2 0 2 1 0))
(constraint (sem-S swap2 3 5 0 5 3 0))
(constraint (sem-S swap2 4 4 0 4 4 0))

(check-synth)
