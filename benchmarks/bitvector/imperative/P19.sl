;; Exchanging 2 fields A and B of the same register of first input where second input is mask which identifies field B and third input is number of bits from end of A to start of B

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
            ($=o4 E)
            ($=o5 E)
            ($seq S S)
        )
        (
            ($xvar)
            ($yvar)
            ($zvar)
            ($o1)
            ($o2)
            ($o3)
            ($o4)
            ($o5)
            ($bvand E E)
            ($bvxor E E)
            ($bvlshr E E)
            ($bvshl E E)
        )
    )
)

(define-funs-rec
    ((S.Sem ((st S) (x (_ BitVec 32)) (y (_ BitVec 32)) (z (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (o3 (_ BitVec 32)) (o4 (_ BitVec 32)) (o5 (_ BitVec 32)) (ro1 (_ BitVec 32)) (ro2 (_ BitVec 32)) (ro3 (_ BitVec 32)) (ro4 (_ BitVec 32)) (ro5 (_ BitVec 32))) Bool)
     (E.Sem ((et E) (x (_ BitVec 32)) (y (_ BitVec 32)) (z (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (o3 (_ BitVec 32)) (o4 (_ BitVec 32)) (o5 (_ BitVec 32)) (result (_ BitVec 32))) Bool))

    ((! (match st
        (
         (($=o1 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y z o1 o2 o3 o4 o5 r)
                (= ro1 r)
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 o5) 
         )))
         (($=o2 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y z o1 o2 o3 o4 o5 r)
                (= ro1 o1) 
                (= ro2 r)
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 o5) 
         )))
         (($=o3 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y z o1 o2 o3 o4 o5 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 r)
                (= ro4 o4) 
                (= ro5 o5) 
         )))
         (($=o4 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y z o1 o2 o3 o4 o5 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 r)
                (= ro5 o5) 
         )))
         (($=o5 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y z o1 o2 o3 o4 o5 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 r)
         )))
         (($seq st1 st2) (exists ((ri1 (_ BitVec 32)) (ri2 (_ BitVec 32)) (ri3 (_ BitVec 32)) (ri4 (_ BitVec 32)) (ri5 (_ BitVec 32)) )
            (and
                (S.Sem st1 x y z o1 o2 o3 o4 o5 ri1 ri2 ri3 ri4 ri5)
                (S.Sem st2 x y z ri1 ri2 ri3 ri4 ri5 ro1 ro2 ro3 ro4 ro5))))))
         :input ( x y z o1 o2 o3 o4 o5 ) :output ( ro1 ro2 ro3 ro4 ro5 ))
     (! (match et
        (
         ($xvar (= result x))
         ($yvar (= result y))
         ($zvar (= result z))
         ($o1 (= result o1))
         ($o2 (= result o2))
         ($o3 (= result o3))
         ($o4 (= result o4))
         ($o5 (= result o5))
         (($bvand et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y z o1 o2 o3 o4 o5 r1)
                (E.Sem et2 x y z o1 o2 o3 o4 o5 r2)
                (= result (bvand r1 r2)))))
         (($bvxor et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y z o1 o2 o3 o4 o5 r1)
                (E.Sem et2 x y z o1 o2 o3 o4 o5 r2)
                (= result (bvxor r1 r2)))))
         (($bvlshr et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y z o1 o2 o3 o4 o5 r1)
                (E.Sem et2 x y z o1 o2 o3 o4 o5 r2)
                (= result (bvlshr r1 r2)))))
         (($bvshl et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y z o1 o2 o3 o4 o5 r1)
                (E.Sem et2 x y z o1 o2 o3 o4 o5 r2)
                (= result (bvshl r1 r2)))))
          ))
         :input ( x y z o1 o2 o3 o4 o5 ) :output (result))))

(synth-fun bvformula() S)

(constraint (forall ((x (_ BitVec 32)) (y (_ BitVec 32)) (z (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (o3 (_ BitVec 32)) (o4 (_ BitVec 32)) (o5 (_ BitVec 32)) (result (_ BitVec 32)))
            (= (S.Sem bvformula x y z o1 o2 o3 o4 o5 result #x00000000 #x00000000 #x00000000 #x00000000 )
                (= result (bvxor (bvxor (bvshl (bvand (bvxor x (bvlshr x z)) y) z) (bvand (bvxor x (bvlshr x z)) y)) x) ))))

(check-synth)