;; computes the floor of the average of two integers without overflowing

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
            ($bvadd E E)
        )
        (
            ($xvar)
            ($yvar)
            ($1)
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
         (($bvxor et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y r1)
                (E.Sem et2 x y r2)
                (= result (bvxor r1 r2)))))
         (($bvlshr et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y r1)
                (E.Sem et2 x y r2)
                (= result (bvlshr r1 r2)))))
         (($bvadd et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y r1)
                (E.Sem et2 x y r2)
                (= result (ite (bvult #x00000000 ((_ extract 63 32) (bvadd (concat #x00000000 r1) (concat #x00000000 r2)))) #xffffffff ((_ extract 31 0) (bvadd (concat #x00000000 r1) (concat #x00000000 r2))))))))
          ))
         :input (x y) :output (result))
     (! (match it
          (
              ($xvar (= result x))
              ($yvar (= result y))
              ($1 (= result #x00000001))
          ))
          :input (x y) :output (result))))

(synth-fun bvformula() Start)

(constraint (forall ((x (_ BitVec 32)) (y (_ BitVec 32)) (result (_ BitVec 32)))
            (= (Start.Sem bvformula x y result)
                (= result (bvadd (bvand x y) (bvlshr (bvxor x y) #x00000001)) ))))

(check-synth)