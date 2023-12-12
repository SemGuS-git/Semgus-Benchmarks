;; isolate the right-most 0 bit

;; (set-info :format-version "2.4.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

(declare-term-types
    ((S 0) (E 0))
    (
        (
            ($=o1 E)
            ($=o2 E)
            ($seq S S)
        )
        (
            ($xvar)
            ($o1)
            ($o2)
            ($1)
            ($bvnot E)
            ($bvand E E)
            ($bvadd E E)
        )
    )
)

(define-funs-rec
    ((S.Sem ((st S) (x (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (ro1 (_ BitVec 32)) (ro2 (_ BitVec 32))) Bool)
     (E.Sem ((et E) (x (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (result (_ BitVec 32))) Bool))

    ((! (match st
        (
         (($=o1 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 r)
                (= ro1 r)
                (= ro2 o2) 
         )))
         (($=o2 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 r)
                (= ro1 o1) 
                (= ro2 r)
         )))
         (($seq st1 st2) (exists ((ri1 (_ BitVec 32)) (ri2 (_ BitVec 32)) )
            (and
                (S.Sem st1 x o1 o2 ri1 ri2)
                (S.Sem st2 x ri1 ri2 ro1 ro2))))))
         :input ( x o1 o2 ) :output ( ro1 ro2 ))
     (! (match et
        (
         ($xvar (= result x))
         ($o1 (= result o1))
         ($o2 (= result o2))
         ($1 (= result #x00000001))
         (($bvnot et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 r)
                (= result (bvnot r)))))
         (($bvand et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 r1)
                (E.Sem et2 x o1 o2 r2)
                (= result (bvand r1 r2)))))
         (($bvadd et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 o2 r1)
                (E.Sem et2 x o1 o2 r2)
                (= result (ite (bvult #x00000000 ((_ extract 63 32) (bvadd (concat #x00000000 r1) (concat #x00000000 r2)))) #xffffffff ((_ extract 31 0) (bvadd (concat #x00000000 r1) (concat #x00000000 r2))))))))
          ))
         :input ( x o1 o2 ) :output (result))))

(synth-fun bvformula() S)

(constraint (forall ((x (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (result (_ BitVec 32)))
            (= (S.Sem bvformula x o1 o2 result #x00000000 )
                (= result (bvand (bvnot x) (bvadd x #x00000001)) ))))

(check-synth)