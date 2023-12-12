;; test if an unsigned int is of the form 2^{n-1}

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
            ($bvadd E E)
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
         (($bvand et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x r1)
                (E.Sem et2 x r2)
                (= result (bvand r1 r2)))))
         (($bvadd et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x r1)
                (E.Sem et2 x r2)
                (= result (ite (bvult #x00000000 ((_ extract 63 32) (bvadd (concat #x00000000 r1) (concat #x00000000 r2)))) #xffffffff ((_ extract 31 0) (bvadd (concat #x00000000 r1) (concat #x00000000 r2))))))))
          ))
         :input (x) :output (result))
     (! (match it
          (
              ($xvar (= result x))
              ($1 (= result #x00000001))
          ))
          :input (x) :output (result))))

(synth-fun bvformula() Start)

;;(constraint (Start.Sem bvformula #x00000000 #x00000000 ))
;;(constraint (Start.Sem bvformula #xffffffff #x00000000 ))
;;(constraint (Start.Sem bvformula #xf1f1f2ff #xf1f1f200 ))
(constraint (forall ((x (_ BitVec 32)) (result (_ BitVec 32)))
            (= (Start.Sem bvformula x result)
                (= result (bvand x (bvadd x #x00000001)) ))))

(check-synth)