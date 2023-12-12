;; turn off right-most 1 bit

;; (set-info :format-version "2.4.0")
;; (set-info :author("Rahul Krishnan"))
;; (set-info :realizable true)

(declare-term-types
    ((S 0) (E 0))
    (
        (
            ($=o1 E)
            ($seq S S)
        )
        (
            ($xvar)
            ($o1)
            ($1)
            ($bvand E E)
            ($bvsub E E)
        )
    )
)

(define-funs-rec
    ((S.Sem ((st S) (x (_ BitVec 32)) (o1 (_ BitVec 32)) (ro1 (_ BitVec 32))) Bool)
     (E.Sem ((et E) (x (_ BitVec 32)) (o1 (_ BitVec 32)) (result (_ BitVec 32))) Bool))

    ((! (match st
        (
         (($=o1 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 r)
                (= ro1 r)
         )))
         (($seq st1 st2) (exists ((ri1 (_ BitVec 32)) )
            (and
                (S.Sem st1 x o1 ri1)
                (S.Sem st2 x ri1 ro1))))))
         :input ( x o1 ) :output ( ro1 ))
     (! (match et
        (
         ($xvar (= result x))
         ($o1 (= result o1))
         ($1 (= result #x00000001))
         (($bvand et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 r1)
                (E.Sem et2 x o1 r2)
                (= result (bvand r1 r2)))))
         (($bvsub et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x o1 r1)
                (E.Sem et2 x o1 r2)
                ;; 2's complement
                (= result (ite (bvult r1 r2) #x00000000 (bvadd (bvadd r1 (bvnot r2)) #x00000001))))))
          ))
         :input ( x o1 ) :output (result))))

(synth-fun bvformula() S)

(constraint (forall ((x (_ BitVec 32)) (o1 (_ BitVec 32)) (result (_ BitVec 32)))
            (= (S.Sem bvformula x o1 result )
                (= result (bvand x (bvsub x #x00000001)) ))))

(check-synth)