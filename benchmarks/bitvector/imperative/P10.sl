;; test if number of leading zeroes is same on both inputs

;; (set-info :format-version "2.4.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

(declare-term-types
    ((Start 0) (S 0) (E 0))
    (
        (
            ($bvult S S)
            ($bvule S S)
        )
        (
            ($=o1 E)
            ($=o2 E)
            ($seq S S)
        )
        (
            ($xvar)
            ($yvar)
            ($o1)
            ($o2)
            ($bvand E E)
            ($bvxor E E)
        )
    )
)

(define-funs-rec
    ((Start.Sem ((t Start) (x (_ BitVec 32)) (y (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (result Bool)) Bool)
     (S.Sem ((st S) (x (_ BitVec 32)) (y (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (ro1 (_ BitVec 32)) (ro2 (_ BitVec 32))) Bool)
     (E.Sem ((et E) (x (_ BitVec 32)) (y (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (result (_ BitVec 32))) Bool))

    ((! (match t
        ((($bvule et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)) (ro1 (_ BitVec 32)) (ro2 (_ BitVec 32)))
            (and
                (S.Sem et1 x y o1 o2 ro1 ro2)
                (= result (or (bvult ro1 ro2) (= ro1 ro2))))))
          (($bvult et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)) (ro1 (_ BitVec 32)) (ro2 (_ BitVec 32)))
            (and
                (S.Sem et1 x y o1 o2 ro1 ro2)
                (= result (bvult ro1 ro2)))))
         ))
         :input (x y o1 o2) :output (result))
     (! (match st
        (
         (($=o1 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 r)
                (= ro1 r)
                (= ro2 o2) 
         )))
         (($=o2 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 r)
                (= ro1 o1) 
                (= ro2 r)
         )))
         (($seq st1 st2) (exists ((ri1 (_ BitVec 32)) (ri2 (_ BitVec 32)) )
            (and
                (S.Sem st1 x y o1 o2 ri1 ri2)
                (S.Sem st2 x y ri1 ri2 ro1 ro2))))))
         :input ( x y o1 o2 ) :output ( ro1 ro2 ))
     (! (match et
        (
         ($xvar (= result x))
         ($yvar (= result y))
         ($o1 (= result o1))
         ($o2 (= result o2))
         (($bvand et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 r1)
                (E.Sem et2 x y o1 o2 r2)
                (= result (bvand r1 r2)))))
         (($bvxor et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 r1)
                (E.Sem et2 x y o1 o2 r2)
                (= result (bvxor r1 r2)))))
          ))
         :input ( x y o1 o2 ) :output (result))))

(synth-fun bvformula() Start)

(constraint (forall ((x (_ BitVec 32)) (y (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (result Bool))
            (= (Start.Sem bvformula x y o1 o2 result )
                (= result (bvule (bvxor x y) (bvand x y)) ))))

(check-synth)