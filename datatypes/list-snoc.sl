
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
    ((I 0) (B 0) (L 0) (F 0))  ; Each term type corresponds to a nonterminal in the default grammar

    ;; Productions
    ((($x) ($match_hd)          ; Productions for term type I
      ($ite_i B I I)
      ($match_I L I I))
     (($t) ($f)                 ; Productions for term type B
      ($not B) ($and B B) ($or B B)
      ($< I I)
      ($match_B L B B))
     (($l) ($match_tl)          ; Productions for term type L
      ($ite_l B L L)
      ($f_snoc L I)
      ($lnil) ($lcons I L)
      ($match_L L L L))
     (($letrec L))))      

;;;
;;; Extract inner expression from a lambda expression
;;;
(define-fun F.Exp ((ft F)) L 
     (match ft ((($letrec lt) lt))))

;;;
;;; Term Semantics
;;;

;; Allows two list inputs (l: List) and (x: Int)
(define-funs-rec
    ((I.Sem ((it I) (ft F) (l List) (x Int) (r Int)) Bool)        
     (B.Sem ((bt B) (ft F) (l List) (x Int) (r Bool)) Bool)       
     (L.Sem ((lt L) (ft F) (l List) (x Int) (r List)) Bool)
     
     ;; Semantics for case 'cons hd tl'
     (I.Sem.cons ((it I) (ft F) (l List) (x Int) (hd Int) (tl List) (r Int)) Bool)        
     (B.Sem.cons ((bt B) (ft F) (l List) (x Int) (hd Int) (tl List) (r Bool)) Bool)       
     (L.Sem.cons ((lt L) (ft F) (l List) (x Int) (hd Int) (tl List) (r List)) Bool))
  
    ;; Bodies
    ;; I.Sem
    ((! (match it
               (($x (= r x)) ($match_hd false)
                (($ite_i bt it1 it2)
                 (exists ((b Bool)) 
                         (and (B.Sem bt ft l x b)
                              (= b true)
                              (I.Sem it1 ft l x r)))
                 (exists ((b Bool))
                         (and (B.Sem bt ft l x b)
                              (= b false)
                              (I.Sem it2 ft l x r))))
                (($match_I lt it1 it2)
                 (exists ((rl List))
                         (and (L.Sem lt ft l x rl)
                              (match rl 
                                     (($nil (I.Sem it1 ft l x r))
                                      (($cons hd tl) (I.Sem.cons it2 ft l x hd tl r)))))))))
      :input (l x) :output (r))                               

     ;; B.Sem
     (! (match bt
               (($t (= r true)) ($f (= r false))
                (($not bt1)
                 (exists ((rb Bool))
                         (and (B.Sem bt1 ft l x rb)
                              (= r (not rb)))))
                (($and bt1 bt2)
                 (exists ((rb1 Bool) (rb2 Bool))
                         (and (B.Sem bt1 ft l x rb1)
                              (B.Sem bt2 ft l x rb2)
                              (= r (and rb1 rb2)))))
                (($or bt1 bt2)
                 (exists ((rb1 Bool) (rb2 Bool))
                         (and (B.Sem bt1 ft l x rb1)
                              (B.Sem bt2 ft l x rb2)
                              (= r (or rb1 rb2)))))
                (($< et1 et2)
                 (exists ((r1 Int) (r2 Int))
                         (and (I.Sem et1 ft l x r1)
                              (I.Sem et2 ft l x r2)
                              (= r (< r1 r2)))))
                (($match_B lt bt1 bt2)
                 (exists ((rl List))
                         (and (L.Sem lt ft l x rl)
                              (match rl 
                                     (($nil (B.Sem bt1 ft l x r))
                                      (($cons hd tl) (B.Sem.cons bt2 ft l x hd tl r)))))))))
      :input (l x) :output (r))

     ;; L.Sem
     (! (match lt
               (($l (= r l)) ($match_tl false)
                (($ite_l bt lt1 lt2)
                 (exists ((b Bool)) 
                         (and (B.Sem bt ft l x b)
                              (= b true)
                              (L.Sem lt1 ft l x r)))
                 (exists ((b Bool))
                         (and (B.Sem bt ft l x b)
                              (= b false)
                              (L.Sem lt2 ft l x r))))
                ($lnil (= r $nil))
                (($lcons it lt1) 
                 (exists ((ri Int) (rl List))
                         (and (I.Sem it ft l x ri)
                              (L.Sem lt1 ft l x rl)
                              (= r ($cons ri rl)))))
                (($f_snoc lt1 it1) 
                 (exists ((rl1 List) (ri1 Int) (flt L))
                         (and (L.Sem lt1 ft l x rl1)
                              (I.Sem it1 ft l x ri1)
                              (= flt (F.Exp ft))
                              (L.Sem flt ft rl1 ri1 r))))
                (($match_L lt lt1 lt2)
                 (exists ((rl List))
                         (and (L.Sem lt ft l x rl)
                              (match rl 
                                     (($nil (L.Sem lt1 ft l x r))
                                      (($cons hd tl) (L.Sem.cons lt2 ft l x hd tl r)))))))))
      :input (l x) :output (r))
      
     ;; I.Sem.cons
     (! (match it
               (($x (= r x)) ($match_hd (= r hd))
                (($ite_i bt it1 it2)
                 (exists ((b Bool)) 
                         (and (B.Sem.cons bt ft l x hd tl b)
                              (= b true)
                              (I.Sem.cons it1 ft l x hd tl r)))
                 (exists ((b Bool))
                         (and (B.Sem.cons bt ft l x hd tl b)
                              (= b false)
                              (I.Sem.cons it2 ft l x hd tl r))))
                (($match_I lt it1 it2)
                 (exists ((rl List))
                         (and (L.Sem lt ft l x rl)
                              (match rl 
                                     (($nil (I.Sem it1 ft l x r))
                                      (($cons hd tl) (I.Sem.cons it2 ft l x hd tl r)))))))))
      :input (l x hd tl) :output (r))                               

     ;; B.Sem.cons
     (! (match bt
               (($t (= r true)) ($f (= r false))
                (($not bt1)
                 (exists ((rb Bool))
                         (and (B.Sem.cons bt1 ft l x hd tl rb)
                              (= r (not rb)))))
                (($and bt1 bt2)
                 (exists ((rb1 Bool) (rb2 Bool))
                         (and (B.Sem.cons bt1 ft l x hd tl rb1)
                              (B.Sem.cons bt2 ft l x hd tl rb2)
                              (= r (and rb1 rb2)))))
                (($or bt1 bt2)
                 (exists ((rb1 Bool) (rb2 Bool))
                         (and (B.Sem.cons bt1 ft l x hd tl rb1)
                              (B.Sem.cons bt2 ft l x hd tl rb2)
                              (= r (or rb1 rb2)))))
                (($< et1 et2)
                 (exists ((r1 Int) (r2 Int))
                         (and (I.Sem.cons et1 ft l x hd tl r1)
                              (I.Sem.cons et2 ft l x hd tl r2)
                              (= r (< r1 r2)))))
                (($match_B lt bt1 bt2)
                 (exists ((rl List))
                         (and (L.Sem lt ft l x rl)
                              (match rl 
                                     (($nil (B.Sem bt1 ft l x r))
                                      (($cons hd tl) (B.Sem.cons bt2 ft l x hd tl r)))))))))
      :input (l x hd tl) :output (r))

     ;; L.Sem.cons
     (! (match lt
               (($l (= r l)) ($match_tl (= r tl))
                (($ite_l bt lt1 lt2)
                 (exists ((b Bool)) 
                         (and (B.Sem.cons bt ft l x hd tl b)
                              (= b true)
                              (L.Sem.cons lt1 ft l x hd tl r)))
                 (exists ((b Bool))
                         (and (B.Sem.cons bt ft l x hd tl b)
                              (= b false)
                              (L.Sem.cons lt2 ft l x hd tl r))))
                ($lnil (= r $nil))
                (($lcons it lt1) 
                 (exists ((ri Int) (rl List))
                         (and (I.Sem.cons it ft l x hd tl ri)
                              (L.Sem.cons lt1 ft l x hd tl rl)
                              (= r ($cons ri rl)))))
                (($f_snoc lt1 it1) 
                 (exists ((rl1 List) (ri1 Int) (flt L))
                         (and (L.Sem.cons lt1 ft l x hd tl rl1)
                              (I.Sem.cons it1 ft l x hd tl ri1)
                              (= flt (F.Exp ft))
                              (L.Sem.cons flt ft rl1 ri1 hd tl r))))
                (($match_L lt lt1 lt2)
                 (exists ((rl List))
                         (and (L.Sem.cons lt ft l x hd tl rl)
                              (match rl 
                                     (($nil (L.Sem lt1 ft l x r))
                                      (($cons hd tl) (L.Sem.cons lt2 ft l x hd tl r)))))))))
      :input (l x hd tl) :output (r))))

;;;
;;; Function to synthesize
;;;
(synth-fun lsnoc() F)


;;;
;;; Constraints 
;;;
(constraint (L.Sem (F.Exp lsnoc) lsnoc $nil 0 ($cons 0 $nil)))
(constraint (L.Sem (F.Exp lsnoc) lsnoc $nil 1 ($cons 1 $nil)))
(constraint (L.Sem (F.Exp lsnoc) lsnoc ($cons 0 $nil) 1 ($cons 0 ($cons 1 $nil))))
(constraint (L.Sem (F.Exp lsnoc) lsnoc ($cons 1 $nil) 0 ($cons 1 ($cons 0 $nil))))

;;;
;;; Expected: match l | nil -> cons x nil | cons hd tl -> cons hd (snoc tl x)
;;; (define-fun lsnoc() F ($letrec ($match_l $l ($lcons $x $lnil) ($lcons $hd ($f_snoc $tl $x)))))
;;;
(check-synth)