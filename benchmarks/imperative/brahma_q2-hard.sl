;; Semgus problem from Brahma paper to compute the function
;; f(x) = x^31 

(set-info :format-version "2.4.0")
(set-info :author("Rahul Krishnan"))
(set-info :realizable true)

(declare-term-types
 ((Eval 0) (S 0) (E 0))
 ((($eval S))
  (($=o1 E)
   ($=o2 E)
   ($=o3 E)
   ($=o4 E)
   ($=o5 E)
   ($=o6 E)
   ($seq S S))
  (($x)
   ($o1)
   ($o2)
   ($o3)
   ($o4)
   ($o5)
   ($o6)
   ($* E E))))

(define-funs-rec 
    ((Eval.Sem ((ot Eval) (x Int) (out Int)) Bool)
     (S.Sem ((st S) (x Int) (v1 Int) (v2 Int) (v3 Int) (v4 Int) (v5 Int) (v6 Int) (r1 Int) (r2 Int) (r3 Int) (r4 Int) (r5 Int) (r6 Int)) Bool)
     (E.Sem ((et E) (x Int) (v1 Int) (v2 Int) (v3 Int) (v4 Int) (v5 Int) (v6 Int) (r Int)) Bool))
    ((! (match ot 
               ((($eval st) (exists ((r1 Int) (r2 Int) (r3 Int) (r4 Int) (r5 Int) (r6 Int))
                                   (and (S.Sem st x 0 0 0 0 0 0 r1 r2 r3 r4 r5 r6)
                                        (= out r6))))))
        :input (x) :output (out))
     (! (match st
               ((($=o1 et) (exists ((r Int))
                                  (and (E.Sem et x v1 v2 v3 v4 v5 v6 r)
                                       (and (= r1 r) (= r2 v2) (= r3 v3) (= r4 v4) (= r5 v5) (= r6 v6)))))
                (($=o2 et) (exists ((r Int))
                                  (and (E.Sem et x v1 v2 v3 v4 v5 v6 r)
                                       (and (= r1 v1) (= r2 r) (= r3 v3) (= r4 v4) (= r5 v5) (= r6 v6)))))
                (($=o3 et) (exists ((r Int))
                                  (and (E.Sem et x v1 v2 v3 v4 v5 v6 r)
                                       (and (= r1 v1) (= r2 v2) (= r3 r) (= r4 v4) (= r5 v5) (= r6 v6)))))
                (($=o4 et) (exists ((r Int))
                                  (and (E.Sem et x v1 v2 v3 v4 v5 v6 r)
                                       (and (= r1 v1) (= r2 v2) (= r3 v3) (= r4 r) (= r5 v5) (= r6 v6)))))
                (($=o5 et) (exists ((r Int))
                                  (and (E.Sem et x v1 v2 v3 v4 v5 v6 r)
                                       (and (= r1 v1) (= r2 v2) (= r3 v3) (= r4 v4) (= r5 r) (= r6 v6)))))
                (($=o6 et) (exists ((r Int))
                                  (and (E.Sem et x v1 v2 v3 v4 v5 v6 r)
                                       (and (= r1 v1) (= r2 v2) (= r3 v3) (= r4 v4) (= r5 v5) (= r6 r)))))
                (($seq st1 st2) (exists ((r11 Int) (r21 Int) (r31 Int) (r41 Int) (r51 Int) (r61 Int) (r12 Int) (r22 Int) (r32 Int) (r42 Int) (r52 Int) (r62 Int))
                                        (and (S.Sem st1 x v1 v2 v3 v4 v5 v6 r11 r21 r31 r41 r51 r61)
                                             (S.Sem st2 x r11 r21 r31 r41 r51 r61 r12 r22 r32 r42 r52 r62)
                                             (and (= r1 r12) (= r2 r22) (= r3 r32) (= r4 r42) (= r5 r52) (= r6 r62)))))))
        :input (x v1 v2 v3 v4 v5 v6) :output (r1 r2 r3 r4 r5 r6))
     (! (match et
               (($x (= r x))
                ($o1 (= r v1))
                ($o2 (= r v2))
                ($o3 (= r v3))
                ($o4 (= r v4))
                ($o5 (= r v5))
                ($o6 (= r v6))
                (($* et1 et2)
                 (exists ((r1 Int) (r2 Int))
                         (and (E.Sem et1 x v1 v2 v3 v4 v5 v6 r1)
                              (E.Sem et2 x v1 v2 v3 v4 v5 v6 r2)
                              (= r (* r1 r2)))))))
        :input (x v1 v2 v3 v4 v5 v6) :output (r))))
                   
(synth-fun poly () Eval)

(constraint (Eval.Sem poly 0 0))
(constraint (Eval.Sem poly 1 1))
(constraint (Eval.Sem poly 2 2147483648))

(check-synth)