
;;; Metadata
(set-info :format-version "2.0.0")
(set-info :author "Kanghee Park")
(set-info :realizable true)

;;;
;;; Datatypes
;;;
(declare-datatypes
    ((List 0))  ; Intger List and Stack

    ((($nil)                            ; Constructors for List
      ($cons (head Int) (tail List)))))

;;;
;;; Productions
;;;
(declare-term-types  
    ;; Term types  ; Declare terms inductively using syntactic constructors
    ((I 0) (B 0) (L 0))  ; Each term type corresponds to a nonterminal in the default grammar

    ;; Productions
    ((($x)                         ; Productions for term type I
      ($ite_i B I I)
      ($match_I L I I))
     (($t) ($f)                    ; Productions for term type B
      ($not B) ($and B B) ($or B B)
      ($< I I)
      ($match_B L B B))
     (($l)                         ; Productions for term type L
      ($ite_l B L L)
      ($lnil) ($lcons I L)
      ($match_L L L L))))      


;;;
;;; Term Semantics
;;;

;; Allows two list inputs (l: List)
(define-funs-rec
    ((I.Sem ((it I) (l List) (r Int)) Bool)        
     (B.Sem ((bt B) (l List) (r Bool)) Bool)       
     (L.Sem ((lt L) (l List) (r List)) Bool)
     
     ;; Semantics for case 'cons hd tl'
     (I.Sem.cons ((it I) (l List) (hd Int) (tl List) (r Int)) Bool)        
     (B.Sem.cons ((bt B) (l List) (hd Int) (tl List) (r Bool)) Bool)       
     (L.Sem.cons ((lt L) (l List) (hd Int) (tl List) (r List)) Bool))
  
    ;; Bodies
    ;; I.Sem
    ((! (match it
               ((($ite_i bt it1 it2)
                 (exists ((b Bool)) 
                         (and (B.Sem bt l b)
                              (= b true)
                              (I.Sem it1 l r)))
                 (exists ((b Bool))
                         (and (B.Sem bt l b)
                              (= b false)
                              (I.Sem it2 l r))))
                (($match_I lt it1 it2)
                 (exists ((rl List))
                         (and (L.Sem lt l rl)
                              (match rl 
                                     (($nil (I.Sem it1 l r))
                                      (($cons hd tl) (I.Sem.cons it2 l hd tl r)))))))))
      :input (l) :output (r))                               

     ;; B.Sem
     (! (match bt
               (($t (= r true)) ($f (= r false))
                (($not bt1)
                 (exists ((rb Bool))
                         (and (B.Sem bt1 l rb)
                              (= r (not rb)))))
                (($and bt1 bt2)
                 (exists ((rb1 Bool) (rb2 Bool))
                         (and (B.Sem bt1 l rb1)
                              (B.Sem bt2 l rb2)
                              (= r (and rb1 rb2)))))
                (($or bt1 bt2)
                 (exists ((rb1 Bool) (rb2 Bool))
                         (and (B.Sem bt1 l rb1)
                              (B.Sem bt2 l rb2)
                              (= r (or rb1 rb2)))))
                (($< et1 et2)
                 (exists ((r1 Int) (r2 Int))
                         (and (I.Sem et1 l r1)
                              (I.Sem et2 l r2)
                              (= r (< r1 r2)))))
                (($match_B lt bt1 bt2)
                 (exists ((rl List))
                         (and (L.Sem lt l rl)
                              (match rl 
                                     (($nil (B.Sem bt1 l r))
                                      (($cons hd tl) (B.Sem.cons bt2 l hd tl r)))))))))
      :input (l) :output (r))

     ;; L.Sem
     (! (match lt
               (($l (= r l))
                (($ite_l bt lt1 lt2)
                 (exists ((b Bool)) 
                         (and (B.Sem bt l b)
                              (= b true)
                              (L.Sem lt1 l r)))
                 (exists ((b Bool))
                         (and (B.Sem bt l b)
                              (= b false)
                              (L.Sem lt2 l r))))
                ($lnil (= r $nil))
                (($lcons it lt1) 
                 (exists ((ri Int) (rl List))
                         (and (I.Sem it l ri)
                              (L.Sem lt1 l rl)
                              (= r ($cons ri rl)))))
                (($match_L lt lt1 lt2)
                 (exists ((rl List))
                         (and (L.Sem lt l rl)
                              (match rl 
                                     (($nil (L.Sem lt1 l r))
                                      (($cons hd tl) (L.Sem.cons lt2 l hd tl r)))))))))
      :input (l) :output (r))
      
     ;; I.Sem.cons
     (! (match it
               ((($ite_i bt it1 it2)
                 (exists ((b Bool)) 
                         (and (B.Sem.cons bt l hd tl b)
                              (= b true)
                              (I.Sem.cons it1 l hd tl r)))
                 (exists ((b Bool))
                         (and (B.Sem.cons bt l hd tl b)
                              (= b false)
                              (I.Sem.cons it2 l hd tl r))))
                (($match_I lt it1 it2)
                 (exists ((rl List))
                         (and (L.Sem lt l rl)
                              (match rl 
                                     (($nil (I.Sem it1 l r))
                                      (($cons hd tl) (I.Sem.cons it2 l hd tl r)))))))))
      :input (l hd tl) :output (r))                               

     ;; B.Sem.cons
     (! (match bt
               (($t (= r true)) ($f (= r false))
                (($not bt1)
                 (exists ((rb Bool))
                         (and (B.Sem.cons bt1 l hd tl rb)
                              (= r (not rb)))))
                (($and bt1 bt2)
                 (exists ((rb1 Bool) (rb2 Bool))
                         (and (B.Sem.cons bt1 l hd tl rb1)
                              (B.Sem.cons bt2 l hd tl rb2)
                              (= r (and rb1 rb2)))))
                (($or bt1 bt2)
                 (exists ((rb1 Bool) (rb2 Bool))
                         (and (B.Sem.cons bt1 l hd tl rb1)
                              (B.Sem.cons bt2 l hd tl rb2)
                              (= r (or rb1 rb2)))))
                (($< et1 et2)
                 (exists ((r1 Int) (r2 Int))
                         (and (I.Sem.cons et1 l hd tl r1)
                              (I.Sem.cons et2 l hd tl r2)
                              (= r (< r1 r2)))))
                (($match_B lt bt1 bt2)
                 (exists ((rl List))
                         (and (L.Sem lt l rl)
                              (match rl 
                                     (($nil (B.Sem bt1 l r))
                                      (($cons hd tl) (B.Sem.cons bt2 l hd tl r)))))))))
      :input (l hd tl) :output (r))

     ;; L.Sem.cons
     (! (match lt
               (($l (= r l))
                (($ite_l bt lt1 lt2)
                 (exists ((b Bool)) 
                         (and (B.Sem.cons bt l hd tl b)
                              (= b true)
                              (L.Sem.cons lt1 l hd tl r)))
                 (exists ((b Bool))
                         (and (B.Sem.cons bt l hd tl b)
                              (= b false)
                              (L.Sem.cons lt2 l hd tl r))))
                ($lnil (= r $nil))
                (($lcons it lt1) 
                 (exists ((ri Int) (rl List))
                         (and (I.Sem.cons it l hd tl ri)
                              (L.Sem.cons lt1 l hd tl rl)
                              (= r ($cons ri rl)))))
                (($match_L lt lt1 lt2)
                 (exists ((rl List))
                         (and (L.Sem.cons lt l hd tl rl)
                              (match rl 
                                     (($nil (L.Sem lt1 l r))
                                      (($cons hd tl) (L.Sem.cons lt2 l hd tl r)))))))))
      :input (l hd tl) :output (r))))

;;;
;;; Function to synthesize
;;;
(synth-fun lisempty() B)


;;;
;;; Constraints 
;;;
(constraint (B.Sem lisempty $nil true))
(constraint (B.Sem lisempty ($cons 0 $nil) false))
(constraint (B.Sem lisempty ($cons 1 $nil) false))
(constraint (B.Sem lisempty ($cons 0 ($cons 1 $nil)) false))

;;;
;;; Expected: match l | nil -> true | cons hd tl -> false
;;; (define-fun lisempty() B ($match_b l ($t) ($f)))
;;;
(check-synth)