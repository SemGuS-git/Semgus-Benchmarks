;; compute the max of two integers

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
            ($seq S S)
        )
        (
            ($xvar)
            ($yvar)
            ($o1)
            ($o2)
            ($o3)
            ($o4)
            ($bvneg E)
            ($bvand E E)
            ($bvxor E E)
            ($bvuge E E)
        )
    )
)

(define-funs-rec
    ((S.Sem ((st S) (x (_ BitVec 32)) (y (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (o3 (_ BitVec 32)) (o4 (_ BitVec 32)) (ro1 (_ BitVec 32)) (ro2 (_ BitVec 32)) (ro3 (_ BitVec 32)) (ro4 (_ BitVec 32))) Bool)
     (E.Sem ((et E) (x (_ BitVec 32)) (y (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (o3 (_ BitVec 32)) (o4 (_ BitVec 32)) (result (_ BitVec 32))) Bool))

    ((! (match st
        (
         (($=o1 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 r)
                (= ro1 r)
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
         )))
         (($=o2 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 r)
                (= ro1 o1) 
                (= ro2 r)
                (= ro3 o3) 
                (= ro4 o4) 
         )))
         (($=o3 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 r)
                (= ro4 o4) 
         )))
         (($=o4 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 r)
         )))
         (($seq st1 st2) (exists ((ri1 (_ BitVec 32)) (ri2 (_ BitVec 32)) (ri3 (_ BitVec 32)) (ri4 (_ BitVec 32)) )
            (and
                (S.Sem st1 x y o1 o2 o3 o4 ri1 ri2 ri3 ri4)
                (S.Sem st2 x y ri1 ri2 ri3 ri4 ro1 ro2 ro3 ro4))))))
         :input ( x y o1 o2 o3 o4 ) :output ( ro1 ro2 ro3 ro4 ))
     (! (match et
        (
         ($xvar (= result x))
         ($yvar (= result y))
         ($o1 (= result o1))
         ($o2 (= result o2))
         ($o3 (= result o3))
         ($o4 (= result o4))
         (($bvneg et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 r)
                (= result (bvneg r)))))
         (($bvand et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 r1)
                (E.Sem et2 x y o1 o2 o3 o4 r2)
                (= result (bvand r1 r2)))))
         (($bvxor et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 r1)
                (E.Sem et2 x y o1 o2 o3 o4 r2)
                (= result (bvxor r1 r2)))))
         (($bvuge et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 r1)
                (E.Sem et2 x y o1 o2 o3 o4 r2)
                (= result (ite (or (= r1 r2) (bvult r2 r1)) #x00000001 #x00000000))))) 
          ))
         :input ( x y o1 o2 o3 o4 ) :output (result))))

(synth-fun bvformula() S)

(constraint (forall ((x (_ BitVec 32)) (y (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (o3 (_ BitVec 32)) (o4 (_ BitVec 32)) (result (_ BitVec 32)))
            (= (S.Sem bvformula x y o1 o2 o3 o4 result #x00000000 #x00000000 #x00000000 )
                (= result (bvxor (bvand (bvxor x y) (bvneg (ite (bvuge x y) #x00000001 #x00000000))) y) ))))

(check-synth)