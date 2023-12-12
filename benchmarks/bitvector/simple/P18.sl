;; determine if an integers is a power of 2

;; (set-info :format-version "2.4.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

(declare-term-types
    ((Start 0) (E 0) (I 0))
    (
        (($bvexpr E))
        (
            ($var I)
            ($bvnot E)
            ($bvand E E)
            ($bvsub E E)
            ($bvredor E)
        )
        (
            ($xvar)
            ($1)
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
         (($bvnot et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x r)
                (= result (bvnot r)))))
         (($bvand et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x r1)
                (E.Sem et2 x r2)
                (= result (bvand r1 r2)))))
         (($bvsub et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x r1)
                (E.Sem et2 x r2)
                ;; 2's complement
                (= result (bvadd (bvadd r1 (bvnot r2)) #x00000001)))))
         (($bvredor et1) (exists ((r1 (_ BitVec 32)))
            (and
                (E.Sem et1 x r1)
                (= result (ite (= r1 #x00000000) #x00000000 #x00000001))))) 
          ))
         :input (x) :output (result))
     (! (match it
          (
              ($xvar (= result x))
              ($1 (= result #x00000001))
          ))
          :input (x) :output (result))))

(synth-fun bvformula() Start)

(constraint (forall ((x (_ BitVec 32)) (result (_ BitVec 32)))
            (= (Start.Sem bvformula x result)
                (= result (bvand (bvnot (ite (= (bvand (bvsub x #x00000001) x) #x00000000) #x00000000 #x00000001)) (ite (= x #x00000000) #x00000000 #x00000001)) ))))

(check-synth)