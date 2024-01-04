;; cycling through values of the last 3 inputs

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
            ($bvxor E E)
            ($bveq E E)
        )
        (
            ($xvar)
            ($yvar)
            ($zvar)
            ($wvar)
        )
    )
)

(define-funs-rec
    ((Start.Sem ((st Start) (x (_ BitVec 32)) (y (_ BitVec 32)) (z (_ BitVec 32)) (w (_ BitVec 32)) (result (_ BitVec 32))) Bool)
     (E.Sem ((et E) (x (_ BitVec 32)) (y (_ BitVec 32)) (z (_ BitVec 32)) (w (_ BitVec 32)) (result (_ BitVec 32))) Bool)
     (I.Sem ((it I) (x (_ BitVec 32)) (y (_ BitVec 32)) (z (_ BitVec 32)) (w (_ BitVec 32)) (result (_ BitVec 32))) Bool))

    ((! (match st
        ((($bvexpr et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y z w r)
                (= result r))))))
         :input (x y z w) :output (result))
     (! (match et
        ((($var it1) (exists ((r (_ BitVec 32)))
            (and
                (I.Sem it1 x y z w r)
                (= result r))))
         (($bvneg et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y z w r)
                (= result (bvneg r)))))
         (($bvand et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y z w r1)
                (E.Sem et2 x y z w r2)
                (= result (bvand r1 r2)))))
         (($bvxor et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y z w r1)
                (E.Sem et2 x y z w r2)
                (= result (bvxor r1 r2)))))
         (($bveq et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y z w r1)
                (E.Sem et2 x y z w r2)
                (= result (ite (= r1 r2) #x00000001 #x00000000))))) 
          ))
         :input (x y z w) :output (result))
     (! (match it
          (
              ($xvar (= result x))
              ($yvar (= result y))
              ($zvar (= result z))
              ($wvar (= result w))
          ))
          :input (x y z w) :output (result))))

(synth-fun bvformula() Start)

(constraint (forall ((x (_ BitVec 32)) (y (_ BitVec 32)) (z (_ BitVec 32)) (w (_ BitVec 32)) (result (_ BitVec 32)))
            (= (Start.Sem bvformula x y z w result)
                (= result (bvxor (bvxor (bvand (bvneg (ite (= x w) #x00000001 #x00000000)) (bvxor y w)) (bvand (bvneg (ite (= x y) #x00000001 #x00000000)) (bvxor z w))) w) ))))

(check-synth)