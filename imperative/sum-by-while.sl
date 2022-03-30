;;;;
;;;; sum-by-while.sl - Sum 5 numbers (x, y, z, v, w) and store result in x
;;;;

;;; Metadata
(set-info :format-version "2.0.0")
(set-info :author("Anvay Grover"))
(set-info :realizable true)

;;;
;;; Term types
;;;
(declare-term-types
 ;; Nonterminals
 ((Start 0) (S 0) (E 0) (B 0))

;; Productions
  ((($while ($while_1 B) ($while_2 S))) ; Start productions

  (($assign_x ($assign_x_1 E))) ; S productions
     
  (($x); E productions
   ($y)
   ($z)
   ($v)
   ($w)
   ($0)
   ($1)
   ($+ ($+_1 E) ($+_2 E))
   ($ite($ite_1 B) ($ite_2 E) ($ite_3 E)))

  (($t) ; B productions
   ($f)
   ($! ($!_1 B))
   ($and($and_1 B) ($and_2 B))
   ($or($or_1 B) ($or_2 B))
   ($< ($<_1 E) ($<_2 E)))))

;;;
;;; Semantics
;;;
(define-funs-rec
    ;; CHC heads
    ((Start.Sem ((s Start) (x Int) (y Int) (z Int) (v Int) (w Int) (x2 Int) (y2 Int) (z2 Int) (v2 Int) (w2 Int)) Bool)
     (S.Sem ((st S) (x Int) (y Int) (z Int) (w Int) (v Int) (x2 Int) (y2 Int) (z2 Int) (v2 Int) (w2 Int)) Bool)
     (E.Sem ((et E) (x Int) (y Int) (z Int) (v Int) (w Int) (r Int)) Bool)
     (B.Sem ((bt B) (x Int) (y Int) (z Int) (v Int) (w Int) (r Bool)) Bool))

  ;; Bodies
  ( (! (match s ; Start.Sem definitions
            ((($while b1 s1)
                (exists ((b2 Bool) (x1 Int) (y1 Int) (z1 Int) (v1 Int) (w1 Int))
                    (and
                        (B.Sem b1 x y z v w b2) 
                        (= b2 true)
                        (S.Sem s1 x y z v w x1 y1 z1 v1 w1)
                        (Start.Sem s x1 y1 z1 v1 w1 x2 y2 z2 v2 w2)
                    )
                )
                (exists ((b2 Bool))
                    (and 
                        (B.Sem b1 x y z v w b2)
                        (and
                            (= b2 false)
                            (= x2 x) (= y2 y) (= z2 z) (= v2 v) (= w2 w)
                        )
                    )
                ))
            )
        )
        :input (x y z v w) :output (x2 y2 z2 v2 w2)
    )

    (!  (match st ; S.Sem definitions
            ((($assign_x et1)
                (exists ((et2 Int))
                    (and
                        (E.Sem et1 x y z v w et2)
                        (and
                            (= x2 et2)
                            (= y2 y) (= z2 z) (= v2 v) (= w2 w)
                        )
                    )
                ))
            )
        )
        :input (x y z v w) :output(x2 y2 z2 v2 w2)
    )
    
    (! (match et ; E.Sem definitions
       (($x (= r x))
        ($y (= r y))
        ($z (= r z))
        ($v (= r v))
        ($w (= r w))
        ($0 (= r 0))
        ($1 (= r 1))
        (($+ et1 et2)
         (exists ((r1 Int) (r2 Int))
             (and
              (E.Sem et1 x y z v w r1)
              (E.Sem et2 x y z v w r2)
              (= r (+ r1 r2)))))
        (($ite bt etc eta)
         (exists ((rb Bool) (rc Int) (ra Int))
             (and
              (B.Sem bt x y z v w rb)
              (E.Sem etc x y z v w rc)
              (E.Sem eta x y z v w ra)
              (= r(ite rb rc ra)))))))

    :input (x y z v w) :output (r))

   (! (match bt ; B.Sem definitions
        (($t (= r true))
         ($f (= r false))
         (($! bt)
          (exists ((rb Bool))
              (and
               (B.Sem bt x y z v w rb)
               (= r(not rb)))))
         (($and bt1 bt2)
          (exists ((rb1 Bool) (rb2 Bool))
              (and
               (B.Sem bt1 x y z v w rb1)
               (B.Sem bt2 x y z v w rb2)
               (= r(and rb1 rb2)))))
         (($or bt1 bt2)
          (exists ((rb1 Bool) (rb2 Bool))
              (and
               (B.Sem bt1 x y z v w rb1)
               (B.Sem bt2 x y z v w rb2)
               (= r(or rb1 rb2)))))
         (($< et1 et2)
          (exists ((r1 Int) (r2 Int))
              (and
               (E.Sem et1 x y z v w r1)
               (E.Sem et2 x y z v w r2)
               (= r(< r1 r2)))))))
    :input (x y z v w) :output (r))))

;;;
;;; Function to synthesize - a term rooted at Start
;;;
(synth-fun sum_by_while() Start)

;;;
;;; Constraints - examples
;;;
(constraint (Start.Sem sum_by_while 4 5 1 3 2 15 5 1 3 2)) ; 
(constraint (Start.Sem sum_by_while 13 16 9 11 21 70 16 9 11 21)) ;

;;;
;;; Instruct the solver to find swap
;;;
(check-synth)