;; next higher unsigned number with same number of 1 bits

;; (set-info :format-version "2.4.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

(declare-term-types
    ((Start 0) (E 0) (I 0))
    (
        (($bvexpr E))
        (
            ($var I)
            ($bvneg E)
            ($bvand E E)
            ($bvor E E)
            ($bvxor E E)
            ($bvlshr E E)
            ($bvadd E E)
            ($bvdiv E E)
        )
        (
            ($xvar)
            ($2)
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
         (($bvneg et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x r)
                (= result (bvneg r)))))
         (($bvand et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x r1)
                (E.Sem et2 x r2)
                (= result (bvand r1 r2)))))
         (($bvor et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x r1)
                (E.Sem et2 x r2)
                (= result (bvor r1 r2)))))
         (($bvxor et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x r1)
                (E.Sem et2 x r2)
                (= result (bvxor r1 r2)))))
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
         (($bvdiv et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x r1)
                (E.Sem et2 x r2)
                (= result (bvudiv r1 r2)))))
          ))
         :input (x) :output (result))
     (! (match it
          (
              ($xvar (= result x))
              ($2 (= result #x00000002))
          ))
          :input (x) :output (result))))

(synth-fun bvformula() Start)

(constraint (forall ((x (_ BitVec 32)) (result (_ BitVec 32)))
            (= (Start.Sem bvformula x result)
                (= result (bvor (bvudiv (bvlshr (bvxor x (bvand x (bvneg x))) #x00000002) (bvand x (bvneg x))) (bvadd x (bvand x (bvneg x)))) ))))

(check-synth)