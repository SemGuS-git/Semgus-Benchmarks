;; compute higher order half of product of inputs

;; (set-info :format-version "2.4.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

(declare-term-types
    ((Start 0) (E 0) (I 0))
    (
        (($bvexpr E))
        (
            ($var I)
            ($bvand E E)
            ($bvlshr E E)
            ($bvadd E E)
            ($bvmul E E)
        )
        (
            ($xvar)
            ($yvar)
            ($65535)
            ($16)
        )
    )
)

(define-funs-rec
    ((Start.Sem ((st Start) (x (_ BitVec 32)) (y (_ BitVec 32)) (result (_ BitVec 32))) Bool)
     (E.Sem ((et E) (x (_ BitVec 32)) (y (_ BitVec 32)) (result (_ BitVec 32))) Bool)
     (I.Sem ((it I) (x (_ BitVec 32)) (y (_ BitVec 32)) (result (_ BitVec 32))) Bool))

    ((! (match st
        ((($bvexpr et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y r)
                (= result r))))))
         :input (x y) :output (result))
     (! (match et
        ((($var it1) (exists ((r (_ BitVec 32)))
            (and
                (I.Sem it1 x y r)
                (= result r))))
         (($bvand et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y r1)
                (E.Sem et2 x y r2)
                (= result (bvand r1 r2)))))
         (($bvlshr et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y r1)
                (E.Sem et2 x y r2)
                (= result (bvlshr r1 r2)))))
         (($bvadd et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y r1)
                (E.Sem et2 x y r2)
                (= result (bvadd r1 r2)))))
         (($bvmul et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y r1)
                (E.Sem et2 x y r2)
                (= result (bvmul r1 r2)))))
          ))
         :input (x y) :output (result))
     (! (match it
          (
              ($xvar (= result x))
              ($yvar (= result y))
              ($65535 (= result #x0000ffff))
              ($16 (= result #x00000010))
          ))
          :input (x y) :output (result))))

(synth-fun bvformula() Start)

(define-fun co1 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvand x #x0000ffff))
(define-fun co2 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvlshr x #x00000010))
(define-fun co3 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvand y #x0000ffff))
(define-fun co4 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvlshr y #x00000010))
(define-fun co5 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvmul (co1 x y) (co3 x y)))
(define-fun co6 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvmul (co2 x y) (co3 x y)))
(define-fun co7 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvmul (co1 x y) (co4 x y)))
(define-fun co8 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvmul (co2 x y) (co4 x y)))
(define-fun co9 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvlshr (co5 x y) #x00000010))
(define-fun co10 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvadd (co6 x y) (co9 x y)))
(define-fun co11 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvand (co10 x y) #x0000ffff))
(define-fun co12 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvlshr (co10 x y) #x00000010))
(define-fun co13 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvadd (co7 x y) (co11 x y)))
(define-fun co14 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvlshr (co13 x y) #x00000010))
(define-fun co15 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvadd (co14 x y) (co12 x y)))
(constraint (forall ((x (_ BitVec 32)) (y (_ BitVec 32)) (result (_ BitVec 32)))
            (= (Start.Sem bvformula x y result)
                (= result (bvadd (co15 x y) (co8 x y)) ))))

(check-synth)