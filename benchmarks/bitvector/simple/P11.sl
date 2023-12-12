;; test if number of leading zeroes is less on first input than the second

;; (set-info :format-version "2.4.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

(declare-term-types
    ((Start 0) (E 0) (I 0))
    (
        (
            ($bvult E E)
            ($bvule E E)
        )
        (
            ($var I)
            ($bvnot E)
            ($bvand E E)
        )
        (
            ($xvar)
            ($yvar)
        )
    )
)

(define-funs-rec
    ((Start.Sem ((st Start) (x (_ BitVec 32)) (y (_ BitVec 32)) (result Bool)) Bool)
     (E.Sem ((et E) (x (_ BitVec 32)) (y (_ BitVec 32)) (result (_ BitVec 32))) Bool)
     (I.Sem ((it I) (x (_ BitVec 32)) (y (_ BitVec 32)) (result (_ BitVec 32))) Bool))

    ((! (match st
        ((($bvule et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y r1)
                (E.Sem et2 x y r2)
                (= result (or (bvult r1 r2) (= r1 r2))))))
          (($bvult et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y r1)
                (E.Sem et2 x y r2)
                (= result (bvult r1 r2)))))
         ))
         :input (x y) :output (result))
     (! (match et
        ((($var it1) (exists ((r (_ BitVec 32)))
            (and
                (I.Sem it1 x y r)
                (= result r))))
         (($bvnot et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y r)
                (= result (bvnot r)))))
         (($bvand et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y r1)
                (E.Sem et2 x y r2)
                (= result (bvand r1 r2)))))
          ))
         :input (x y) :output (result))
     (! (match it
          (
              ($xvar (= result x))
              ($yvar (= result y))
          ))
          :input (x y) :output (result))))

(synth-fun bvformula() Start)

;;(constraint (Start.Sem bvformula #x00000000 #x00000000 false ))
;;(constraint (Start.Sem bvformula #x00000100 #x00000000 true ))
;;(constraint (Start.Sem bvformula #x000001ff #x000000ff true ))
(constraint (forall ((x (_ BitVec 32)) (y (_ BitVec 32)) (result Bool))
            (= (Start.Sem bvformula x y result)
                (= result (bvugt (bvand x (bvnot y)) y) ))))

(check-synth)