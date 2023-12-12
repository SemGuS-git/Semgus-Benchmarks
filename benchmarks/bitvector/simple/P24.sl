;; round up to next highest power of 2

;; (set-info :format-version "2.4.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

(declare-term-types
    ((Start 0) (E 0) (I 0))
    (
        (($bvexpr E))
        (
            ($var I)
            ($bvor E E)
            ($bvlshr E E)
            ($bvadd E E)
            ($bvsub E E)
        )
        (
            ($xvar)
            ($1)
            ($2)
            ($4)
            ($8)
            ($16)
        )
    )
)

(define-funs-rec
    ((Start.Sem ((st Start) (x (_ BitVec 32)) (result (_ BitVec 32))) Bool)
     (E.Sem ((et E) (x (_ BitVec 32)) (result (_ BitVec 32))) Bool)
     (I.Sem ((it I) (x (_ BitVec 32)) (result (_ BitVec 32))) Bool))

    ((! (match st
        ((($bvexpr et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x r)
                (= result r))))))
         :input (x) :output (result))
     (! (match et
        ((($var it1) (exists ((r (_ BitVec 32)))
            (and
                (I.Sem it1 x r)
                (= result r))))
         (($bvor et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x r1)
                (E.Sem et2 x r2)
                (= result (bvor r1 r2)))))
         (($bvlshr et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x r1)
                (E.Sem et2 x r2)
                (= result (bvlshr r1 r2)))))
         (($bvadd et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x r1)
                (E.Sem et2 x r2)
                (= result (bvadd r1 r2)))))
         (($bvsub et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x r1)
                (E.Sem et2 x r2)
                ;; 2's complement
                (= result (bvadd (bvadd r1 (bvnot r2)) #x00000001)))))
          ))
         :input (x) :output (result))
     (! (match it
          (
              ($xvar (= result x))
              ($1 (= result #x00000001))
              ($2 (= result #x00000002))
              ($4 (= result #x00000004))
              ($8 (= result #x00000008))
              ($16 (= result #x00000010))
          ))
          :input (x) :output (result))))

(synth-fun bvformula() Start)

(define-fun co1 ((x (_ BitVec 32))) (_ BitVec 32) (bvsub x #x00000001))
(define-fun co2 ((x (_ BitVec 32))) (_ BitVec 32) (bvlshr (co1 x) #x00000001))
(define-fun co3 ((x (_ BitVec 32))) (_ BitVec 32) (bvor (co1 x) (co2 x)))
(define-fun co4 ((x (_ BitVec 32))) (_ BitVec 32) (bvlshr (co3 x) #x00000002))
(define-fun co5 ((x (_ BitVec 32))) (_ BitVec 32) (bvor (co3 x) (co4 x)))
(define-fun co6 ((x (_ BitVec 32))) (_ BitVec 32) (bvlshr (co5 x) #x00000004))
(define-fun co7 ((x (_ BitVec 32))) (_ BitVec 32) (bvor (co5 x) (co6 x)))
(define-fun co8 ((x (_ BitVec 32))) (_ BitVec 32) (bvlshr (co7 x) #x00000008))
(define-fun co9 ((x (_ BitVec 32))) (_ BitVec 32) (bvor (co7 x) (co8 x)))
(define-fun co10 ((x (_ BitVec 32))) (_ BitVec 32) (bvlshr (co9 x) #x00000010))
(define-fun co11 ((x (_ BitVec 32))) (_ BitVec 32) (bvor (co9 x) (co10 x)))
(constraint (forall ((x (_ BitVec 32)) (result (_ BitVec 32)))
            (= (Start.Sem bvformula x result)
                (= result (bvadd (co10 x) #x00000001) ))))

(check-synth)