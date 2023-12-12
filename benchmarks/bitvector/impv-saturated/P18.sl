;; determine if an integers is a power of 2

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
            ($o1)
            ($o2)
            ($o3)
            ($o4)
            ($o5)
            ($1)
            ($bvnot E)
            ($bvand E E)
            ($bvsub E E)
            ($bvredor E)
        )
    )
)

(define-funs-rec
    ((S.Sem ((st S) (x (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (o3 (_ BitVec 32)) (o4 (_ BitVec 32)) (o5 (_ BitVec 32)) (ro1 (_ BitVec 32)) (ro2 (_ BitVec 32)) (ro3 (_ BitVec 32)) (ro4 (_ BitVec 32)) (ro5 (_ BitVec 32))) Bool)
     (E.Sem ((et E) (x (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (o3 (_ BitVec 32)) (o4 (_ BitVec 32)) (o5 (_ BitVec 32)) (result (_ BitVec 32))) Bool))

    ((! (match st
        (
         (($=o1 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 r)
                (= ro1 r)
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 o5) 
         )))
         (($=o2 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 r)
                (= ro1 o1) 
                (= ro2 r)
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 o5) 
         )))
         (($=o3 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 r)
                (= ro4 o4) 
                (= ro5 o5) 
         )))
         (($=o4 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 r)
                (= ro5 o5) 
         )))
         (($=o5 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 r)
         )))
         (($seq st1 st2) (exists ((ri1 (_ BitVec 32)) (ri2 (_ BitVec 32)) (ri3 (_ BitVec 32)) (ri4 (_ BitVec 32)) (ri5 (_ BitVec 32)) )
            (and
                (S.Sem st1 x o1 o2 o3 o4 o5 ri1 ri2 ri3 ri4 ri5)
                (S.Sem st2 x ri1 ri2 ri3 ri4 ri5 ro1 ro2 ro3 ro4 ro5))))))
         :input ( x o1 o2 o3 o4 o5 ) :output ( ro1 ro2 ro3 ro4 ro5 ))
     (! (match et
        (
         ($xvar (= result x))
         ($o1 (= result o1))
         ($o2 (= result o2))
         ($o3 (= result o3))
         ($o4 (= result o4))
         ($o5 (= result o5))
         ($1 (= result #x00000001))
         (($bvnot et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 r)
                (= result (bvnot r)))))
         (($bvand et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 r1)
                (E.Sem et2 x o1 o2 o3 o4 o5 r2)
                (= result (bvand r1 r2)))))
         (($bvsub et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 r1)
                (E.Sem et2 x o1 o2 o3 o4 o5 r2)
                ;; 2's complement
                (= result (ite (bvult r1 r2) #x00000000 (bvadd (bvadd r1 (bvnot r2)) #x00000001))))))
         (($bvredor et1) (exists ((r1 (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 r1)
                (= result (ite (= r1 #x00000000) #x00000000 #x00000001))))) 
          ))
         :input ( x o1 o2 o3 o4 o5 ) :output (result))))

(synth-fun bvformula() S)

(constraint (forall ((x (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (o3 (_ BitVec 32)) (o4 (_ BitVec 32)) (o5 (_ BitVec 32)) (result (_ BitVec 32)))
            (= (S.Sem bvformula x o1 o2 o3 o4 o5 result #x00000000 #x00000000 #x00000000 #x00000000 )
                (= result (bvand (bvnot (ite (= (bvand (bvsub x #x00000001) x) #x00000000) #x00000000 #x00000001)) (ite (= x #x00000000) #x00000000 #x00000001)) ))))

(check-synth)