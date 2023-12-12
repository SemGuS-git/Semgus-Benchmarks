;; Semgus problem from Brahma paper to compute the function
;; f(a,b,c) = a * h^2 + b*h + c

(set-info :format-version "2.4.0")
(set-info :author("Rahul Krishnan"))
(set-info :realizable true)

(declare-term-types
 ((Eval 0) (S 0) (E 0))
 ;; Eval production
 ((($eval S))
  ;; Productions for S: S -> x := E | y := E | z := E | seq S S 
  (($=x E)
   ($=y E)
   ($=z E)
   ($seq S S))
  ;; Productions for E: E -> x | y | z | h | E + E | E * E
  (($x)
   ($y)
   ($z)
   ($h)
   ($+ E E)
   ($* E E))))

(define-funs-rec 
    ;; Define the semantics of the productions of the universal grammar
    ((Eval.Sem ((ot Eval) (x Int) (y Int) (z Int) (h Int) (out Int)) Bool)
     (S.Sem ((st S) (x Int) (y Int) (z Int) (h Int) (rx Int) (ry Int) (rz Int)) Bool)
     (E.Sem ((et E) (x Int) (y Int) (z Int) (h Int) (r Int)) Bool))
    ((! (match ot ; Semantics of Eval
               ((($eval st) (exists ((rx Int) (ry Int) (rz Int))
                                   (and (S.Sem st x y z h rx ry rz)
                                        (= out rz))))))
        :input (x y z h) :output (out))
     (! (match st ; Semantics of S
               ((($=x et) (exists ((r Int))
                                  (and (E.Sem et x y z h r)
                                       (and (= rx r) (= ry y) (= rz z)))))
                (($=y et) (exists ((r Int))
                                  (and (E.Sem et x y z h r)
                                       (and (= rx x) (= ry r) (= rz z)))))
                (($=z et) (exists ((r Int))
                                  (and (E.Sem et x y z h r)
                                       (and (= rx x) (= ry y) (= rz r)))))
                (($seq st1 st2) (exists ((xi1 Int) (yi1 Int) (zi1 Int) (xi2 Int) (yi2 Int) (zi2 Int))
                                        (and (S.Sem st1 x y z h xi1 yi1 zi1)
                                             (S.Sem st2 xi1 yi1 zi1 h xi2 yi2 zi2)
                                             (and (= rx xi2) (= ry yi2) (= rz zi2)))))))
        :input (x y z h) :output (rx ry rz))
     (! (match et ; Semantics of E
               (($x (= r x))
                ($y (= r y))
                ($z (= r z))
                ($h (= r h))
                (($+ et1 et2)
                 (exists ((r1 Int) (r2 Int))
                         (and (E.Sem et1 x y z h r1)
                              (E.Sem et2 x y z h r2)
                              (= r (+ r1 r2)))))
                (($* et1 et2)
                 (exists ((r1 Int) (r2 Int))
                         (and (E.Sem et1 x y z h r1)
                              (E.Sem et2 x y z h r2)
                              (= r (* r1 r2)))))))
        :input (x y z h) :output (r))))
                   
(synth-fun quad_poly () Eval) ; synth-fun block: defines term quad_poly to synthesize, of term-type O

;; Example-based constraints, where z denotes output variable
(constraint (Eval.Sem quad_poly 1 1 1 0 1))
(constraint (Eval.Sem quad_poly 1 1 1 1 3))
(constraint (Eval.Sem quad_poly 1 2 1 1 4))
(constraint (Eval.Sem quad_poly 1 1 1 2 7))


(check-synth)
