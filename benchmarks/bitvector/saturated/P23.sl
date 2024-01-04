;; counting number of bits

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
            ($bvsub E E)
        )
        (
            ($xvar)
            ($1)
            ($1431655765)
            ($858993459)
            ($4)
            ($252645135)
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
         (($bvand et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x r1)
                (E.Sem et2 x r2)
                (= result (bvand r1 r2)))))
         (($bvlshr et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x r1)
                (E.Sem et2 x r2)
                (= result (bvlshr r1 r2)))))
         (($bvadd et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x r1)
                (E.Sem et2 x r2)
                (= result (ite (bvult #x00000000 ((_ extract 63 32) (bvadd (concat #x00000000 r1) (concat #x00000000 r2)))) #xffffffff ((_ extract 31 0) (bvadd (concat #x00000000 r1) (concat #x00000000 r2))))))))
         (($bvsub et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x r1)
                (E.Sem et2 x r2)
                ;; 2's complement
                (= result (ite (bvult r1 r2) #x00000000 (bvadd (bvadd r1 (bvnot r2)) #x00000001))))))
          ))
         :input (x) :output (result))
     (! (match it
          (
              ($xvar (= result x))
              ($1 (= result #x00000001))
              ($1431655765 (= result #x55555555))
              ($858993459 (= result #x33333333))
              ($4 (= result #x00000004))
              ($252645135 (= result #x0f0f0f0f))
          ))
          :input (x) :output (result))))

(synth-fun bvformula() Start)

(define-fun co1 ((x (_ BitVec 32))) (_ BitVec 32) (bvlshr x #x00000001))
(define-fun co2 ((x (_ BitVec 32))) (_ BitVec 32) (bvand (co1 x) #x55555555))
(define-fun co3 ((x (_ BitVec 32))) (_ BitVec 32) (bvsub x (co2 x)))
(define-fun co4 ((x (_ BitVec 32))) (_ BitVec 32) (bvand (co3 x) #x33333333))
(define-fun co5 ((x (_ BitVec 32))) (_ BitVec 32) (bvlshr (co3 x) #x00000002))
(define-fun co6 ((x (_ BitVec 32))) (_ BitVec 32) (bvand (co3 x) #x33333333))
(define-fun co7 ((x (_ BitVec 32))) (_ BitVec 32) (bvadd (co4 x) (co6 x)))
(define-fun co8 ((x (_ BitVec 32))) (_ BitVec 32) (bvlshr (co7 x) #x00000004))
(define-fun co9 ((x (_ BitVec 32))) (_ BitVec 32) (bvadd (co8 x) (co7 x)))
(constraint (forall ((x (_ BitVec 32)) (result (_ BitVec 32)))
            (= (Start.Sem bvformula x result)
                (= result (bvand (co9 x) #x0f0f0f0f) ))))

(check-synth)