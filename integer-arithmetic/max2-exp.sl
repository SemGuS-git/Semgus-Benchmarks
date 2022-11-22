;;;;
;;;; max2-exp.sl - The max2 example problem encoded in SemGuS
;;;;

;;; Metadata
(set-info :format-version "2.1.0")
(set-info :author("Jinwoo Kim" "Keith Johnson" "Wiley Corning"))
(set-info :realizable true)

;;;
;;; Term types
;;;
(declare-term-types
;; Nonterminals
((E 0) (B 0))

;; Productions
(
    ( ; E productions
        ($x)
        ($y)
        ($0)
        ($1)
        ($+ E E)
        ($ite B E E)
    )
    (  ; B productions
        ($t)
        ($f)
        ($not B)
        ($and B B)
        ($or B B)
        ($< E E)
    )
)
)

;;;
;;; Semantics
;;;
(define-funs-rec
    ;; CHC heads
    ((E.Sem ((et E) (x Int) (y Int) (r Int)) Bool)
     (B.Sem ((bt B) (x Int) (y Int) (r Bool)) Bool))

  ;; Bodies
  ((! (match et ; E.Sem definitions
       (($x (= r x))
        ($y (= r y))
        ($0 (= r 0))
        ($1 (= r 1))
        (($+ et1 et2)
         (exists ((r1 Int) (r2 Int))
             (and
              (E.Sem et1 x y r1)
              (E.Sem et2 x y r2)
              (= r (+ r1 r2)))))
        (($ite t1 t2 t3)
            (exists ((b Bool)) (and
                (B.Sem t1 x y b)
                (= b true)
                (E.Sem t2 x y r)
            ))
            (exists ((b Bool)) (and
                (B.Sem t1 x y b)
                (= b false)
                (E.Sem t3 x y r)
            ))
        )))

    :input (x y) :output (r))

   (! (match bt ; B.Sem definitions
        (($t (= r true))
         ($f(= r false))
         (($not bt1)
          (exists ((rb Bool))
              (and
               (B.Sem bt1 x y rb)
               (= r(not rb)))))
         (($and bt1 bt2)
          (exists ((rb1 Bool) (rb2 Bool))
              (and
               (B.Sem bt1 x y rb1)
               (B.Sem bt2 x y rb2)
               (= r(and rb1 rb2)))))
         (($or bt1 bt2)
          (exists ((rb1 Bool) (rb2 Bool))
              (and
               (B.Sem bt1 x y rb1)
               (B.Sem bt2 x y rb2)
               (= r(or rb1 rb2)))))
         (($< et1 et2)
          (exists ((r1 Int) (r2 Int))
              (and
               (E.Sem et1 x y r1)
               (E.Sem et2 x y r2)
               (= r(< r1 r2)))))))
    :input (x y) :output (r))))


;;;
;;; Function to synthesize - a term rooted at E
;;;
(synth-fun max2() E) ; Using the default universe of terms rooted at E

;;;
;;; Constraints - examples
;;;
(constraint (E.Sem max2 4 2 4))
(constraint (E.Sem max2 2 5 5))
(constraint (E.Sem max2 1 1 1))

;;;
;;; Instruct the solver to find max2
;;;
(check-synth)
