;;; Metadata
(set-info :format-version "2.0.0")
(set-info :author "Kanghee Park")
(set-info :realizable true)

;;;
;;; Productions
;;;
(declare-term-types  
    ;; Term types
    ((I 0) (B 0) (F 0))

    ;; Productions
    ((($x) ($0) ($1) ($2)               ; Term I
      ($+ I I) ($- I I) ($ite B I I)
      ($app_f I))
     (($t) ($f)                         ; Term B
       ($not B) ($and B B) ($or B B)
       ($< I I))
     (($letrec I))))                    ; Term F

(define-fun F.Exp ((ft F)) I 
     (match ft ((($letrec it) it))))

;;;
;;; Term Semantics
;;;
(define-funs-rec
    ;; Semantic relations and their types
    ((I.Sem ((it I) (ft F) (x Int) (r Int)) Bool)       
     (B.Sem ((bt B) (ft F) (x Int) (r Bool)) Bool))
  
    ;; Bodies
    ((! (match it
               (($x (= r x)) 
                ($0 (= r 0)) ($1 (= r 1)) ($2 (= r 2))
                (($+ it1 it2)
                 (exists ((r1 Int) (r2 Int))
                         (and (I.Sem it1 ft x r1)
                              (I.Sem it2 ft x r2)
                              (= r (+ r1 r2)))))
                (($- it1 it2)
                 (exists ((r1 Int) (r2 Int))
                         (and (I.Sem it1 ft x r1)
                              (I.Sem it2 ft x r2)
                              (= r (- r1 r2)))))
                (($ite bt it1 it2)
                 (exists ((b Bool)) 
                         (and (B.Sem bt ft x b)
                              (= b true)
                              (I.Sem it1 ft x r)))
                 (exists ((b Bool))
                         (and (B.Sem bt ft x b)
                              (= b false)
                              (I.Sem it2 ft x r))))
                (($app_f it1)
                 (exists ((r1 Int) (it2 I))
                         (and (= it2 (F.Exp ft))
                              (I.Sem it1 ft x r1)
                              (I.Sem it2 ft r1 r))))))
      :input (x) :output (r))                               

     (! (match bt
               (($t (= r true)) ($f (= r false))
                (($not bt1)
                 (exists ((rb Bool))
                         (and (B.Sem bt1 ft x rb)
                              (= r (not rb)))))
                (($and bt1 bt2)
                 (exists ((rb1 Bool) (rb2 Bool))
                         (and (B.Sem bt1 ft x rb1)
                              (B.Sem bt2 ft x rb2)
                              (= r (and rb1 rb2)))))
                (($or bt1 bt2)
                 (exists ((rb1 Bool) (rb2 Bool))
                         (and (B.Sem bt1 ft x rb1)
                              (B.Sem bt2 ft x rb2)
                              (= r (or rb1 rb2)))))
                (($< et1 et2)
                 (exists ((r1 Int) (r2 Int))
                         (and (I.Sem et1 ft x r1)
                              (I.Sem et2 ft x r2)
                              (= r (< r1 r2)))))))
      :input (x) :output (r))))

;;;
;;; Function to synthesize
;;;
(synth-fun fib() F)

;;;
;;; Constraints
;;;
(constraint (I.Sem (F.Exp fib) fib (- 3) 0))
(constraint (I.Sem (F.Exp fib) fib (- 1) 0))
(constraint (I.Sem (F.Exp fib) fib 0 1))
(constraint (I.Sem (F.Exp fib) fib 1 1))
(constraint (I.Sem (F.Exp fib) fib 3 3))
(constraint (I.Sem (F.Exp fib) fib 4 5))
(constraint (I.Sem (F.Exp fib) fib 6 13))

(check-synth)

;;; Expected: letrec fib x = ite(x < 0, ite(x < 2, ($+ ($app_f ($- $x $1)) ($app_f ($- $x $2))), 1))
