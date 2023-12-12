;; next higher unsigned number with same number of 1 bits

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
            ($=o6 E)
            ($seq S S)
        )
        (
            ($xvar)
            ($o1)
            ($o2)
            ($o3)
            ($o4)
            ($o5)
            ($o6)
            ($2)
            ($bvneg E)
            ($bvand E E)
            ($bvor E E)
            ($bvxor E E)
            ($bvlshr E E)
            ($bvadd E E)
            ($bvdiv E E)
        )
    )
)

(define-funs-rec
    ((S.Sem ((st S) (x (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (o3 (_ BitVec 32)) (o4 (_ BitVec 32)) (o5 (_ BitVec 32)) (o6 (_ BitVec 32)) (ro1 (_ BitVec 32)) (ro2 (_ BitVec 32)) (ro3 (_ BitVec 32)) (ro4 (_ BitVec 32)) (ro5 (_ BitVec 32)) (ro6 (_ BitVec 32))) Bool)
     (E.Sem ((et E) (x (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (o3 (_ BitVec 32)) (o4 (_ BitVec 32)) (o5 (_ BitVec 32)) (o6 (_ BitVec 32)) (result (_ BitVec 32))) Bool))

    ((! (match st
        (
         (($=o1 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 o6 r)
                (= ro1 r)
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 o5) 
                (= ro6 o6) 
         )))
         (($=o2 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 o6 r)
                (= ro1 o1) 
                (= ro2 r)
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 o5) 
                (= ro6 o6) 
         )))
         (($=o3 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 o6 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 r)
                (= ro4 o4) 
                (= ro5 o5) 
                (= ro6 o6) 
         )))
         (($=o4 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 o6 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 r)
                (= ro5 o5) 
                (= ro6 o6) 
         )))
         (($=o5 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 o6 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 r)
                (= ro6 o6) 
         )))
         (($=o6 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 o6 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 o5) 
                (= ro6 r)
         )))
         (($seq st1 st2) (exists ((ri1 (_ BitVec 32)) (ri2 (_ BitVec 32)) (ri3 (_ BitVec 32)) (ri4 (_ BitVec 32)) (ri5 (_ BitVec 32)) (ri6 (_ BitVec 32)) )
            (and
                (S.Sem st1 x o1 o2 o3 o4 o5 o6 ri1 ri2 ri3 ri4 ri5 ri6)
                (S.Sem st2 x ri1 ri2 ri3 ri4 ri5 ri6 ro1 ro2 ro3 ro4 ro5 ro6))))))
         :input ( x o1 o2 o3 o4 o5 o6 ) :output ( ro1 ro2 ro3 ro4 ro5 ro6 ))
     (! (match et
        (
         ($xvar (= result x))
         ($o1 (= result o1))
         ($o2 (= result o2))
         ($o3 (= result o3))
         ($o4 (= result o4))
         ($o5 (= result o5))
         ($o6 (= result o6))
         ($2 (= result #x00000002))
         (($bvneg et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 o6 r)
                (= result (bvneg r)))))
         (($bvand et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 o6 r1)
                (E.Sem et2 x o1 o2 o3 o4 o5 o6 r2)
                (= result (bvand r1 r2)))))
         (($bvor et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 o6 r1)
                (E.Sem et2 x o1 o2 o3 o4 o5 o6 r2)
                (= result (bvor r1 r2)))))
         (($bvxor et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 o6 r1)
                (E.Sem et2 x o1 o2 o3 o4 o5 o6 r2)
                (= result (bvxor r1 r2)))))
         (($bvlshr et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 o6 r1)
                (E.Sem et2 x o1 o2 o3 o4 o5 o6 r2)
                (= result (bvlshr r1 r2)))))
         (($bvadd et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 o6 r1)
                (E.Sem et2 x o1 o2 o3 o4 o5 o6 r2)
                (= result (bvadd r1 r2)))))
         (($bvdiv et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 o3 o4 o5 o6 r1)
                (E.Sem et2 x o1 o2 o3 o4 o5 o6 r2)
                (= result (bvudiv r1 r2)))))
          ))
         :input ( x o1 o2 o3 o4 o5 o6 ) :output (result))))

(synth-fun bvformula() S)

(constraint (forall ((x (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (o3 (_ BitVec 32)) (o4 (_ BitVec 32)) (o5 (_ BitVec 32)) (o6 (_ BitVec 32)) (result (_ BitVec 32)))
            (= (S.Sem bvformula x o1 o2 o3 o4 o5 o6 result #x00000000 #x00000000 #x00000000 #x00000000 #x00000000 )
                (= result (bvor (bvudiv (bvlshr (bvxor x (bvand x (bvneg x))) #x00000002) (bvand x (bvneg x))) (bvadd x (bvand x (bvneg x)))) ))))

(check-synth)