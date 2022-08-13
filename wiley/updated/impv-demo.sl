

;;; Metadata
; (set-info :format-version "2.0.0")
; (set-info :author "Wiley Corning")
; (set-info :realizable true)

;;;
;;; Term types
;;;

(declare-term-types
    ((S 0) (E 0) (B 0))
    
    ;; Productions
    
    (
        ( ; Ss
            ($assign_x ($assign_x_1 E))
            ($assign_y ($assign_y_1 E))
            ($assign_z ($assign_z_1 E))
            ($cons ($cons_1 S) ($cons_2 S))
            ($ite ($ite_1 B) ($ite_2 S) ($ite_3 S))
        )
        ( ; Int expressions
            ($0)
            ($1)
            ($x)
            ($y)
            ($z)
            ($- ($-_1 E) ($-_2 E))
            ($+ ($+_1 E) ($+_2 E))
        )
        ( ; Bool expressions
            ($true)
            ($false)
            ($< ($<_1 E) ($<_2 E))
            ($and ($and_1 B) ($and_2 B))
            ($or ($or_1 B) ($or_2 B))
            ($not ($not_1 B))
        )
    )
)

;;;;
;;;; Semantics
;;;;
(define-funs-rec
    ;; CHC heads
    (
        (S.Sem ((t0 S) (x0 Int) (y0 Int) (z0 Int) (x2 Int) (y2 Int) (z2 Int)) Bool)
        (E.Sem ((t0 E) (x Int) (y Int) (z Int) (r Int)) Bool)
        (B.Sem ((t0 B) (x Int) (y Int) (z Int) (r Bool)) Bool)
    )
    ;; Bodies
    (
        ; Ss
        (! (match t0 (
            (($assign_x t1) (exists ((r1 Int)) (and
                (E.Sem t1 x0 y0 z0 r1)
                (= x2 r1) (= y2 y0) (= z2 z0)
            )))
            (($assign_y t1) (exists ((r1 Int)) (and
                (E.Sem t1 x0 y0 z0 r1)
                (= x2 x0) (= y2 r1) (= z2 z0)
            )))
            (($assign_z t1) (exists ((r1 Int)) (and
                (E.Sem t1 x0 y0 z0 r1)
                (= x2 x0) (= y2 y0) (= z2 r1)
            )))
            (($cons t1 t2) (exists ((x1 Int) (y1 Int) (z1 Int)) (and
                (S.Sem t1 x0 y0 z0 x1 y1 z1)
                (S.Sem t2 x1 y1 z1 x2 y2 z2)
            )))
            (($ite t1 t2 t3)
                (exists ((b Bool) (x_l Int) (y_l Int) (z_l Int) (x_r Int) (y_r Int) (z_r Int)) (and
                    (B.Sem t1 x0 y0 z0 b)
                    (S.Sem t2 x0 y0 z0 x_l y_l z_l)
                    (S.Sem t3 x0 y0 z0 x_r y_r z_r)
                    (= x2 (ite b x_l x_r)) (= y2 (ite b y_l y_r)) (= z2 (ite b z_l z_r))
                ))
            )
        )) :input (x0 y0 z0) :output (x2 y2 z2))
        
        ; Int expressions
        (! (match t0 (
            ($0 (= r 0))
            ($1 (= r 1))
            ($x (= r x))
            ($y (= r y))
            ($z (= r z))
            (($+ t1 t2) (exists ((r1 Int) (r2 Int)) (and
                (E.Sem t1 x y z r1)
                (E.Sem t2 x y z r2)
                (= r (+ r1 r2))
            )))
            (($- t1 t2) (exists ((r1 Int) (r2 Int)) (and
                (E.Sem t1 x y z r1)
                (E.Sem t2 x y z r2)
                (= r (- r1 r2))
            )))
        )) :input (x y z) :output (r))
        
        ; Bool epressions
        (! (match t0 (
            ($true (= r true))
            ($false (= r false))
            (($< t1 t2) (exists ((r1 Int) (r2 Int)) (and
                (E.Sem t1 x y z r1)
                (E.Sem t2 x y z r2)
                (= r (< r1 r2))
            )))
            (($and t1 t2) (exists ((r1 Bool) (r2 Bool)) (and
                (B.Sem t1 x y z r1)
                (B.Sem t2 x y z r2)
                (= r (and r1 r2))
            )))
            (($or t1 t2) (exists ((r1 Bool) (r2 Bool)) (and
                (B.Sem t1 x y z r1)
                (B.Sem t2 x y z r2)
                (= r (or r1 r2))
            )))
            (($not t1) (exists ((r1 Bool)) (and
                (B.Sem t1 x y z r1)
                (= r (not r1))
            )))
        )) :input (x y z) :output (r))
    )
)

;;;
;;; Function to synthesize
;;;
(synth-fun f () S)
;;;
;;; Constraints - examples
;;;

(set-info :solution (
    (
        f
        ($ite ($< $x $y) ($assign_x $y) ($assign_z ($+ $z $1)))
    )
))

(constraint (S.Sem f 0 0 0 0 0 1))
(constraint (S.Sem f 0 1 0 1 1 0))
(constraint (S.Sem f 7 3 4 7 3 5))
(constraint (S.Sem f 3 5 3 5 5 3))
(constraint (S.Sem f 4 8 9 8 8 9))
(constraint (S.Sem f 8 7 2 8 7 3))

(check-synth)