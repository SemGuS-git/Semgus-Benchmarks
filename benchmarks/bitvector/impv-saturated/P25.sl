;; compute higher order half of product of inputs

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
            ($=o7 E)
            ($=o8 E)
            ($=o9 E)
            ($=o10 E)
            ($=o11 E)
            ($=o12 E)
            ($=o13 E)
            ($=o14 E)
            ($=o15 E)
            ($seq S S)
        )
        (
            ($xvar)
            ($yvar)
            ($o1)
            ($o2)
            ($o3)
            ($o4)
            ($o5)
            ($o6)
            ($o7)
            ($o8)
            ($o9)
            ($o10)
            ($o11)
            ($o12)
            ($o13)
            ($o14)
            ($o15)
            ($65535)
            ($16)
            ($bvand E E)
            ($bvlshr E E)
            ($bvadd E E)
            ($bvmul E E)
        )
    )
)

(define-funs-rec
    ((S.Sem ((st S) (x (_ BitVec 32)) (y (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (o3 (_ BitVec 32)) (o4 (_ BitVec 32)) (o5 (_ BitVec 32)) (o6 (_ BitVec 32)) (o7 (_ BitVec 32)) (o8 (_ BitVec 32)) (o9 (_ BitVec 32)) (o10 (_ BitVec 32)) (o11 (_ BitVec 32)) (o12 (_ BitVec 32)) (o13 (_ BitVec 32)) (o14 (_ BitVec 32)) (o15 (_ BitVec 32)) (ro1 (_ BitVec 32)) (ro2 (_ BitVec 32)) (ro3 (_ BitVec 32)) (ro4 (_ BitVec 32)) (ro5 (_ BitVec 32)) (ro6 (_ BitVec 32)) (ro7 (_ BitVec 32)) (ro8 (_ BitVec 32)) (ro9 (_ BitVec 32)) (ro10 (_ BitVec 32)) (ro11 (_ BitVec 32)) (ro12 (_ BitVec 32)) (ro13 (_ BitVec 32)) (ro14 (_ BitVec 32)) (ro15 (_ BitVec 32))) Bool)
     (E.Sem ((et E) (x (_ BitVec 32)) (y (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (o3 (_ BitVec 32)) (o4 (_ BitVec 32)) (o5 (_ BitVec 32)) (o6 (_ BitVec 32)) (o7 (_ BitVec 32)) (o8 (_ BitVec 32)) (o9 (_ BitVec 32)) (o10 (_ BitVec 32)) (o11 (_ BitVec 32)) (o12 (_ BitVec 32)) (o13 (_ BitVec 32)) (o14 (_ BitVec 32)) (o15 (_ BitVec 32)) (result (_ BitVec 32))) Bool))

    ((! (match st
        (
         (($=o1 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r)
                (= ro1 r)
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 o5) 
                (= ro6 o6) 
                (= ro7 o7) 
                (= ro8 o8) 
                (= ro9 o9) 
                (= ro10 o10) 
                (= ro11 o11) 
                (= ro12 o12) 
                (= ro13 o13) 
                (= ro14 o14) 
                (= ro15 o15) 
         )))
         (($=o2 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r)
                (= ro1 o1) 
                (= ro2 r)
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 o5) 
                (= ro6 o6) 
                (= ro7 o7) 
                (= ro8 o8) 
                (= ro9 o9) 
                (= ro10 o10) 
                (= ro11 o11) 
                (= ro12 o12) 
                (= ro13 o13) 
                (= ro14 o14) 
                (= ro15 o15) 
         )))
         (($=o3 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 r)
                (= ro4 o4) 
                (= ro5 o5) 
                (= ro6 o6) 
                (= ro7 o7) 
                (= ro8 o8) 
                (= ro9 o9) 
                (= ro10 o10) 
                (= ro11 o11) 
                (= ro12 o12) 
                (= ro13 o13) 
                (= ro14 o14) 
                (= ro15 o15) 
         )))
         (($=o4 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 r)
                (= ro5 o5) 
                (= ro6 o6) 
                (= ro7 o7) 
                (= ro8 o8) 
                (= ro9 o9) 
                (= ro10 o10) 
                (= ro11 o11) 
                (= ro12 o12) 
                (= ro13 o13) 
                (= ro14 o14) 
                (= ro15 o15) 
         )))
         (($=o5 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 r)
                (= ro6 o6) 
                (= ro7 o7) 
                (= ro8 o8) 
                (= ro9 o9) 
                (= ro10 o10) 
                (= ro11 o11) 
                (= ro12 o12) 
                (= ro13 o13) 
                (= ro14 o14) 
                (= ro15 o15) 
         )))
         (($=o6 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 o5) 
                (= ro6 r)
                (= ro7 o7) 
                (= ro8 o8) 
                (= ro9 o9) 
                (= ro10 o10) 
                (= ro11 o11) 
                (= ro12 o12) 
                (= ro13 o13) 
                (= ro14 o14) 
                (= ro15 o15) 
         )))
         (($=o7 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 o5) 
                (= ro6 o6) 
                (= ro7 r)
                (= ro8 o8) 
                (= ro9 o9) 
                (= ro10 o10) 
                (= ro11 o11) 
                (= ro12 o12) 
                (= ro13 o13) 
                (= ro14 o14) 
                (= ro15 o15) 
         )))
         (($=o8 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 o5) 
                (= ro6 o6) 
                (= ro7 o7) 
                (= ro8 r)
                (= ro9 o9) 
                (= ro10 o10) 
                (= ro11 o11) 
                (= ro12 o12) 
                (= ro13 o13) 
                (= ro14 o14) 
                (= ro15 o15) 
         )))
         (($=o9 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 o5) 
                (= ro6 o6) 
                (= ro7 o7) 
                (= ro8 o8) 
                (= ro9 r)
                (= ro10 o10) 
                (= ro11 o11) 
                (= ro12 o12) 
                (= ro13 o13) 
                (= ro14 o14) 
                (= ro15 o15) 
         )))
         (($=o10 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 o5) 
                (= ro6 o6) 
                (= ro7 o7) 
                (= ro8 o8) 
                (= ro9 o9) 
                (= ro10 r)
                (= ro11 o11) 
                (= ro12 o12) 
                (= ro13 o13) 
                (= ro14 o14) 
                (= ro15 o15) 
         )))
         (($=o11 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 o5) 
                (= ro6 o6) 
                (= ro7 o7) 
                (= ro8 o8) 
                (= ro9 o9) 
                (= ro10 o10) 
                (= ro11 r)
                (= ro12 o12) 
                (= ro13 o13) 
                (= ro14 o14) 
                (= ro15 o15) 
         )))
         (($=o12 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 o5) 
                (= ro6 o6) 
                (= ro7 o7) 
                (= ro8 o8) 
                (= ro9 o9) 
                (= ro10 o10) 
                (= ro11 o11) 
                (= ro12 r)
                (= ro13 o13) 
                (= ro14 o14) 
                (= ro15 o15) 
         )))
         (($=o13 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 o5) 
                (= ro6 o6) 
                (= ro7 o7) 
                (= ro8 o8) 
                (= ro9 o9) 
                (= ro10 o10) 
                (= ro11 o11) 
                (= ro12 o12) 
                (= ro13 r)
                (= ro14 o14) 
                (= ro15 o15) 
         )))
         (($=o14 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 o5) 
                (= ro6 o6) 
                (= ro7 o7) 
                (= ro8 o8) 
                (= ro9 o9) 
                (= ro10 o10) 
                (= ro11 o11) 
                (= ro12 o12) 
                (= ro13 o13) 
                (= ro14 r)
                (= ro15 o15) 
         )))
         (($=o15 et1) (exists ((r (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r)
                (= ro1 o1) 
                (= ro2 o2) 
                (= ro3 o3) 
                (= ro4 o4) 
                (= ro5 o5) 
                (= ro6 o6) 
                (= ro7 o7) 
                (= ro8 o8) 
                (= ro9 o9) 
                (= ro10 o10) 
                (= ro11 o11) 
                (= ro12 o12) 
                (= ro13 o13) 
                (= ro14 o14) 
                (= ro15 r)
         )))
         (($seq st1 st2) (exists ((ri1 (_ BitVec 32)) (ri2 (_ BitVec 32)) (ri3 (_ BitVec 32)) (ri4 (_ BitVec 32)) (ri5 (_ BitVec 32)) (ri6 (_ BitVec 32)) (ri7 (_ BitVec 32)) (ri8 (_ BitVec 32)) (ri9 (_ BitVec 32)) (ri10 (_ BitVec 32)) (ri11 (_ BitVec 32)) (ri12 (_ BitVec 32)) (ri13 (_ BitVec 32)) (ri14 (_ BitVec 32)) (ri15 (_ BitVec 32)) )
            (and
                (S.Sem st1 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 ri1 ri2 ri3 ri4 ri5 ri6 ri7 ri8 ri9 ri10 ri11 ri12 ri13 ri14 ri15)
                (S.Sem st2 x y ri1 ri2 ri3 ri4 ri5 ri6 ri7 ri8 ri9 ri10 ri11 ri12 ri13 ri14 ri15 ro1 ro2 ro3 ro4 ro5 ro6 ro7 ro8 ro9 ro10 ro11 ro12 ro13 ro14 ro15))))))
         :input ( x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 ) :output ( ro1 ro2 ro3 ro4 ro5 ro6 ro7 ro8 ro9 ro10 ro11 ro12 ro13 ro14 ro15 ))
     (! (match et
        (
         ($xvar (= result x))
         ($yvar (= result y))
         ($o1 (= result o1))
         ($o2 (= result o2))
         ($o3 (= result o3))
         ($o4 (= result o4))
         ($o5 (= result o5))
         ($o6 (= result o6))
         ($o7 (= result o7))
         ($o8 (= result o8))
         ($o9 (= result o9))
         ($o10 (= result o10))
         ($o11 (= result o11))
         ($o12 (= result o12))
         ($o13 (= result o13))
         ($o14 (= result o14))
         ($o15 (= result o15))
         ($65535 (= result #x0000ffff))
         ($16 (= result #x00000010))
         (($bvand et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r1)
                (E.Sem et2 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r2)
                (= result (bvand r1 r2)))))
         (($bvlshr et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r1)
                (E.Sem et2 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r2)
                (= result (bvlshr r1 r2)))))
         (($bvadd et1 et2) (exists ((r1 (_ BitVec 32)) (r2 (_ BitVec 32)))
            (and
                (E.Sem et1 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r1)
                (E.Sem et2 x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 r2)
                (= result (ite (bvult #x00000000 ((_ extract 63 32) (bvadd (concat #x00000000 r1) (concat #x00000000 r2)))) #xffffffff ((_ extract 31 0) (bvadd (concat #x00000000 r1) (concat #x00000000 r2))))))))
          ))
         :input ( x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 ) :output (result))))

(synth-fun bvformula() S)

(define-fun co1 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvand x #x0000ffff))
(define-fun co2 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvlshr x #x00000010))
(define-fun co3 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvand y #x0000ffff))
(define-fun co4 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvlshr y #x00000010))
(define-fun co5 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvmul (co1 x y) (co3 x y)))
(define-fun co6 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvmul (co2 x y) (co3 x y)))
(define-fun co7 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvmul (co1 x y) (co4 x y)))
(define-fun co8 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvmul (co2 x y) (co4 x y)))
(define-fun co9 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvlshr (co5 x y) #x00000010))
(define-fun co10 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvadd (co6 x y) (co9 x y)))
(define-fun co11 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvand (co10 x y) #x0000ffff))
(define-fun co12 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvlshr (co10 x y) #x00000010))
(define-fun co13 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvadd (co7 x y) (co11 x y)))
(define-fun co14 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvlshr (co13 x y) #x00000010))
(define-fun co15 ((x (_ BitVec 32)) (y (_ BitVec 32))) (_ BitVec 32) (bvadd (co14 x y) (co12 x y)))
(constraint (forall ((x (_ BitVec 32)) (y (_ BitVec 32)) (o1 (_ BitVec 32)) (o2 (_ BitVec 32)) (o3 (_ BitVec 32)) (o4 (_ BitVec 32)) (o5 (_ BitVec 32)) (o6 (_ BitVec 32)) (o7 (_ BitVec 32)) (o8 (_ BitVec 32)) (o9 (_ BitVec 32)) (o10 (_ BitVec 32)) (o11 (_ BitVec 32)) (o12 (_ BitVec 32)) (o13 (_ BitVec 32)) (o14 (_ BitVec 32)) (o15 (_ BitVec 32)) (result (_ BitVec 32)))
            (= (S.Sem bvformula x y o1 o2 o3 o4 o5 o6 o7 o8 o9 o10 o11 o12 o13 o14 o15 result #x00000000 #x00000000 #x00000000 #x00000000 #x00000000 #x00000000 #x00000000 #x00000000 #x00000000 #x00000000 #x00000000 #x00000000 #x00000000 #x00000000 )
                (= result (bvadd (co15 x y) (co8 x y)) ))))

(check-synth)