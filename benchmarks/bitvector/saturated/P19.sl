;; Exchanging 2 fields A and B of the same register of first input where second input is mask which identifies field B and third input is number of bits from end of A to start of B

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
            ($bvxor E E)
            ($bvlshr E E)
            ($bvshl E E)
        )
        (
            ($xvar)
            ($yvar)
            ($zvar)
        )
    )
)

(define-funs-rec
    ((Start.Sem ((st Start) (x (_ BitVec 32)) (y (_ BitVec 32)) (z (_ BitVec 32)) (result (_ BitVec 32))) Bool)
     (E.Sem ((et E) (x (_ BitVec 32)) (y (_ BitVec 32)) (z (_ BitVec 32)) (result (_ BitVec 32))) Bool)
     (I.Sem ((it I) (x (_ BitVec 32)) (y (_ BitVec 32)) (z (_ BitVec 32)) (result (_ BitVec 32))) Bool))

    ((! (match st
        ((($bvexpr et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y z r)
                (= result r))))))
         :input (x y z) :output (result))
     (! (match et
        ((($var it1) (exists ((r (_ BitVec 32)))
            (and
                (I.Sem it1 x y z r)
                (= result r))))
         (($bvand et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y z r1)
                (E.Sem et2 x y z r2)
                (= result (bvand r1 r2)))))
         (($bvxor et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y z r1)
                (E.Sem et2 x y z r2)
                (= result (bvxor r1 r2)))))
         (($bvlshr et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y z r1)
                (E.Sem et2 x y z r2)
                (= result (bvlshr r1 r2)))))
         (($bvshl et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y z r1)
                (E.Sem et2 x y z r2)
                (= result (bvshl r1 r2)))))
          ))
         :input (x y z) :output (result))
     (! (match it
          (
              ($xvar (= result x))
              ($yvar (= result y))
              ($zvar (= result z))
          ))
          :input (x y z) :output (result))))

(synth-fun bvformula() Start)

(constraint (forall ((x (_ BitVec 32)) (y (_ BitVec 32)) (z (_ BitVec 32)) (result (_ BitVec 32)))
            (= (Start.Sem bvformula x y z result)
                (= result (bvxor (bvxor (bvshl (bvand (bvxor x (bvlshr x z)) y) z) (bvand (bvxor x (bvlshr x z)) y)) x) ))))

(check-synth)