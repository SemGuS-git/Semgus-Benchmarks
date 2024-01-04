;;;;
;;;; max3-exp.sl - The max3 example problem encoded in SemGuS
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
        ($z)
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
    ((E.Sem ((et E) (x Int) (y Int) (z Int) (r Int)) Bool)
     (B.Sem ((bt B) (x Int) (y Int) (z Int) (r Bool)) Bool))

  ;; Bodies
  ((! (match et ; E.Sem definitions
       (($x (= r x))
        ($y (= r y))
        ($z (= r z))
        ($0 (= r 0))
        ($1 (= r 1))
        (($+ et1 et2)
         (exists ((r1 Int) (r2 Int))
             (and
              (E.Sem et1 x y z r1)
              (E.Sem et2 x y z r2)
              (= r (+ r1 r2)))))
        (($ite bt1 etc eta)
         (exists ((rb Bool) (rc Int) (ra Int))
             (and
              (B.Sem bt1 x y z rb)
              (E.Sem etc x y z rc)
              (E.Sem eta x y z ra)
              (= r(ite rb rc ra)))))))

    :input (x y z) :output (r))

   (! (match bt ; B.Sem definitions
        (($t (= r true))
         ($f(= r false))
         (($not bt1)
          (exists ((rb Bool))
              (and
               (B.Sem bt1 x y z rb)
               (= r(not rb)))))
         (($and bt1 bt2)
          (exists ((rb1 Bool) (rb2 Bool))
              (and
               (B.Sem bt1 x y z rb1)
               (B.Sem bt2 x y z rb2)
               (= r(and rb1 rb2)))))
         (($or bt1 bt2)
          (exists ((rb1 Bool) (rb2 Bool))
              (and
               (B.Sem bt1 x y z rb1)
               (B.Sem bt2 x y z rb2)
               (= r(or rb1 rb2)))))
         (($< et1 et2)
          (exists ((r1 Int) (r2 Int))
              (and
               (E.Sem et1 x y z r1)
               (E.Sem et2 x y z r2)
               (= r(< r1 r2)))))))
    :input (x y z) :output (r))))


;;;
;;; Function to synthesize - a term rooted at E
;;;
(synth-fun max3 () E) ; Using the default universe of terms rooted at E

;;;
;;; Constraints - examples
;;;
(constraint (E.Sem max3 4 2 1 4))
(constraint (E.Sem max3 2 5 7 7))
(constraint (E.Sem max3 2 3 2 3))
(constraint (E.Sem max3 0 0 0 0))
(constraint (E.Sem max3 2 8 3 8))


;;;
;;; Instruct the solver to find max3
;;;
(check-synth)
