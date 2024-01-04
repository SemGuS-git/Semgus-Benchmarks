;; computes the floor of the average of two integers without overflowing

;; (set-info :format-version "2.4.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

(declare-term-types
    ((S 0) (E 0))
    (
        (
            ($=o1 E)
            ($=o2 E)
            ($=o3 E)
            ($seq S S)
        )
        (
            ($xvar)
            ($yvar)
            ($o1)
            ($o2)
            ($o3)
            ($1)
            ($bvand E E)
            ($bvxor E E)
            ($bvlshr E E)
            ($bvadd E E)
        )
    )
)

(define-funs-rec
    ((S.Sem ((st S) (x (_ BitVec 32)) (y (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (o3 (_ BitVec 32)) (ro1 (_ BitVec 32)) (ro2 (_ BitVec 32)) (ro3 (_ BitVec 32))) Bool)
     (E.Sem ((et E) (x (_ BitVec 32)) (y (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (o3 (_ BitVec 32)) (result (_ BitVec 32))) Bool))

    ((! (match st
        (
         (($=o1 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 r)
                (= ro1 r)
                (= ro2 o2) 
                (= ro3 o3) 
         )))
         (($=o2 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 r)
                (= ro1 o1) 
                (= ro2 r)
                (= ro3 o3) 
         )))
         (($=o3 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 r)
         )))
         (($seq st1 st2) (exists ((ri1 (_ BitVec 32)) (ri2 (_ BitVec 32)) (ri3 (_ BitVec 32)) )
            (and
                (S.Sem st1 x y o1 o2 o3 ri1 ri2 ri3)
                (S.Sem st2 x y ri1 ri2 ri3 ro1 ro2 ro3))))))
         :input ( x y o1 o2 o3 ) :output ( ro1 ro2 ro3 ))
     (! (match et
        (
         ($xvar (= result x))
         ($yvar (= result y))
         ($o1 (= result o1))
         ($o2 (= result o2))
         ($o3 (= result o3))
         ($1 (= result #x00000001))
         (($bvand et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 r1)
                (E.Sem et2 x y o1 o2 o3 r2)
                (= result (bvand r1 r2)))))
         (($bvxor et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 r1)
                (E.Sem et2 x y o1 o2 o3 r2)
                (= result (bvxor r1 r2)))))
         (($bvlshr et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 r1)
                (E.Sem et2 x y o1 o2 o3 r2)
                (= result (bvlshr r1 r2)))))
         (($bvadd et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 r1)
                (E.Sem et2 x y o1 o2 o3 r2)
                (= result (bvadd r1 r2)))))
          ))
         :input ( x y o1 o2 o3 ) :output (result))))

(synth-fun bvformula() S)

(constraint (forall ((x (_ BitVec 32)) (y (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (o3 (_ BitVec 32)) (result (_ BitVec 32)))
            (= (S.Sem bvformula x y o1 o2 o3 result #x00000000 #x00000000 )
                (= result (bvadd (bvand x y) (bvlshr (bvxor x y) #x00000001)) ))))

(check-synth)