

;;; Metadata
;; (set-info :format-version "2.0.0")
;; (set-info :author("Wiley Corning"))
;; (set-info :realizable true)

;;;
;;; Term types
;;;
(declare-term-types
 ;; Nonterminals
 ((E 0))

 ;; Productions
 ((($x); E productions
   ($y)
   ($0)
   ($1)
   ($+ ($+_1 E) ($+_2 E))
   ($* ($*_1 E) ($*_2 E))
   ))
)

;;;
;;; Semantics
;;;
(define-funs-rec
    ;; CHC heads
    ((E.Sem ((et E) (x Int) (y Int) (r Int)) Bool))

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
        (($* et1 et2)
         (exists ((r1 Int) (r2 Int))
             (and
              (E.Sem et1 x y r1)
              (E.Sem et2 x y r2)
              (= r (* r1 r2)))))))

    :input (x y) :output (r)))
)


(synth-fun f() E) 

(set-info :solution (
    (
        f
        ($* ($+ ($+ ($+ $x $x) $y) $1) ($+ ($+ ($+ $x $x) $y) $1))
    )
))

(constraint (E.Sem f 2 3 64))
(constraint (E.Sem f 0 0 1))
(constraint (E.Sem f 1 1 16))
(constraint (E.Sem f 5 3 196))
(constraint (E.Sem f 2 2 49))

(check-synth)
