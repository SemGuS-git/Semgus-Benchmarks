
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
    ((($match_hd)          ; Productions for term type I
      ($ite_i B I I)
      ($match_I L I I))
     (($t) ($f)                 ; Productions for term type B
      ($not B) ($and B B) ($or B B)
      ($< I I)
      ($match_B L B B))
     (($l) ($match_tl)          ; Productions for term type L
      ($ite_l B L L)
      ($f_snoc L I)
      ($f_reverse L)
      ($lnil) ($lcons I L)
      ($match_L L L L))
     (($letrec L))))      

;;;
;;; Extract inner expression from a lambda expression
;;;
(define-fun F.Exp ((ft F)) L 
     (match ft ((($letrec lt) lt))))

;;;
;;; Function Semantics
;;;

(define-funs-rec
     ;; Function signature
     ((snoc.Sem ((l List) (x Int) (r List)) Bool))

     ;; Function body
     ((! (match l
            (($nil (= r ($cons x $nil)))
             (($cons hd tl) 
              (exists ((rl List))
                      (and (snoc.Sem tl x rl)
                           (= r ($cons hd rl)))))))
     :input (l x) :output (r))))


;;;
;;; Term Semantics
;;;

;; Allows two list inputs (l: List) and (x: Int)
(define-funs-rec
    ((I.Sem ((it I) (ft F) (l List) (r Int)) Bool)        
     (B.Sem ((bt B) (ft F) (l List) (r Bool)) Bool)       
     (L.Sem ((lt L) (ft F) (l List) (r List)) Bool)
     
     ;; Semantics for case 'cons hd tl'
     (I.Sem.cons ((it I) (ft F) (l List) (hd Int) (tl List) (r Int)) Bool)        
     (B.Sem.cons ((bt B) (ft F) (l List) (hd Int) (tl List) (r Bool)) Bool)       
     (L.Sem.cons ((lt L) (ft F) (l List) (hd Int) (tl List) (r List)) Bool))
  
    ;; Bodies
    ;; I.Sem
    ((! (match it
               (($match_hd false)
                (($ite_i bt it1 it2)
                 (exists ((b Bool)) 
                         (and (B.Sem bt ft l b)
                              (= b true)
                              (I.Sem it1 ft l r)))
                 (exists ((b Bool))
                         (and (B.Sem bt ft l b)
                              (= b false)
                              (I.Sem it2 ft l r))))
                (($match_I lt it1 it2)
                 (exists ((rl List))
                         (and (L.Sem lt ft l rl)
                              (match rl 
                                     (($nil (I.Sem it1 ft l r))
                                      (($cons hd tl) (I.Sem.cons it2 ft l hd tl r)))))))))
      :input (l) :output (r))                               

     ;; B.Sem
     (! (match bt
               (($t (= r true)) ($f (= r false))
                (($not bt1)
                 (exists ((rb Bool))
                         (and (B.Sem bt1 ft l rb)
                              (= r (not rb)))))
                (($and bt1 bt2)
                 (exists ((rb1 Bool) (rb2 Bool))
                         (and (B.Sem bt1 ft l rb1)
                              (B.Sem bt2 ft l rb2)
                              (= r (and rb1 rb2)))))
                (($or bt1 bt2)
                 (exists ((rb1 Bool) (rb2 Bool))
                         (and (B.Sem bt1 ft l rb1)
                              (B.Sem bt2 ft l rb2)
                              (= r (or rb1 rb2)))))
                (($< et1 et2)
                 (exists ((r1 Int) (r2 Int))
                         (and (I.Sem et1 ft l r1)
                              (I.Sem et2 ft l r2)
                              (= r (< r1 r2)))))
                (($match_B lt bt1 bt2)
                 (exists ((rl List))
                         (and (L.Sem lt ft l rl)
                              (match rl 
                                     (($nil (B.Sem bt1 ft l r))
                                      (($cons hd tl) (B.Sem.cons bt2 ft l hd tl r)))))))))
      :input (l) :output (r))

     ;; L.Sem
     (! (match lt
               (($l (= r l)) ($match_tl false)
                (($ite_l bt lt1 lt2)
                 (exists ((b Bool)) 
                         (and (B.Sem bt ft l b)
                              (= b true)
                              (L.Sem lt1 ft l r)))
                 (exists ((b Bool))
                         (and (B.Sem bt ft l b)
                              (= b false)
                              (L.Sem lt2 ft l r))))
                ($lnil (= r $nil))
                (($lcons it lt1) 
                 (exists ((ri Int) (rl List))
                         (and (I.Sem it ft l ri)
                              (L.Sem lt1 ft l rl)
                              (= r ($cons ri rl)))))
                (($f_snoc lt1 it)
                 (exists ((ri Int) (rl List))
                         (and (I.Sem it ft l ri)
                              (L.Sem lt1 ft l rl)
                              (snoc.Sem rl ri r))))     
                (($f_reverse lt1) 
                 (exists ((rl List) (flt L))
                         (and (L.Sem lt1 ft l rl)
                              (= flt (F.Exp ft))
                              (L.Sem flt ft rl r))))
                (($match_L lt lt1 lt2)
                 (exists ((rl List))
                         (and (L.Sem lt ft l rl)
                              (match rl 
                                     (($nil (L.Sem lt1 ft l r))
                                      (($cons hd tl) (L.Sem.cons lt2 ft l hd tl r)))))))))
      :input (l) :output (r))
      
     ;; I.Sem.cons
     (! (match it
               (($match_hd (= r hd))
                (($ite_i bt it1 it2)
                 (exists ((b Bool)) 
                         (and (B.Sem.cons bt ft l hd tl b)
                              (= b true)
                              (I.Sem.cons it1 ft l hd tl r)))
                 (exists ((b Bool))
                         (and (B.Sem.cons bt ft l hd tl b)
                              (= b false)
                              (I.Sem.cons it2 ft l hd tl r))))
                (($match_I lt it1 it2)
                 (exists ((rl List))
                         (and (L.Sem lt ft l rl)
                              (match rl 
                                     (($nil (I.Sem it1 ft l r))
                                      (($cons hd tl) (I.Sem.cons it2 ft l hd tl r)))))))))
      :input (l hd tl) :output (r))                               

     ;; B.Sem.cons
     (! (match bt
               (($t (= r true)) ($f (= r false))
                (($not bt1)
                 (exists ((rb Bool))
                         (and (B.Sem.cons bt1 ft l hd tl rb)
                              (= r (not rb)))))
                (($and bt1 bt2)
                 (exists ((rb1 Bool) (rb2 Bool))
                         (and (B.Sem.cons bt1 ft l hd tl rb1)
                              (B.Sem.cons bt2 ft l hd tl rb2)
                              (= r (and rb1 rb2)))))
                (($or bt1 bt2)
                 (exists ((rb1 Bool) (rb2 Bool))
                         (and (B.Sem.cons bt1 ft l hd tl rb1)
                              (B.Sem.cons bt2 ft l hd tl rb2)
                              (= r (or rb1 rb2)))))
                (($< et1 et2)
                 (exists ((r1 Int) (r2 Int))
                         (and (I.Sem.cons et1 ft l hd tl r1)
                              (I.Sem.cons et2 ft l hd tl r2)
                              (= r (< r1 r2)))))
                (($match_B lt bt1 bt2)
                 (exists ((rl List))
                         (and (L.Sem lt ft l rl)
                              (match rl 
                                     (($nil (B.Sem bt1 ft l r))
                                      (($cons hd tl) (B.Sem.cons bt2 ft l hd tl r)))))))))
      :input (l hd tl) :output (r))

     ;; L.Sem.cons
     (! (match lt
               (($l (= r l)) ($match_tl (= r tl))
                (($ite_l bt lt1 lt2)
                 (exists ((b Bool)) 
                         (and (B.Sem.cons bt ft l hd tl b)
                              (= b true)
                              (L.Sem.cons lt1 ft l hd tl r)))
                 (exists ((b Bool))
                         (and (B.Sem.cons bt ft l hd tl b)
                              (= b false)
                              (L.Sem.cons lt2 ft l hd tl r))))
                ($lnil (= r $nil))
                (($lcons it lt1) 
                 (exists ((ri Int) (rl List))
                         (and (I.Sem.cons it ft l hd tl ri)
                              (L.Sem.cons lt1 ft l hd tl rl)
                              (= r ($cons ri rl)))))
                (($f_snoc lt1 it)
                 (exists ((ri Int) (rl List))
                         (and (I.Sem.cons it ft l hd tl ri)
                              (L.Sem.cons lt1 ft l hd tl rl)
                              (snoc.Sem rl ri r))))    
                (($f_reverse lt1) 
                 (exists ((rl List) (flt L))
                         (and (L.Sem.cons lt1 ft l hd tl rl)
                              (= flt (F.Exp ft))
                              (L.Sem.cons flt ft rl hd tl r))))
                (($match_L lt lt1 lt2)
                 (exists ((rl List))
                         (and (L.Sem.cons lt ft l hd tl rl)
                              (match rl 
                                     (($nil (L.Sem lt1 ft l r))
                                      (($cons hd tl) (L.Sem.cons lt2 ft l hd tl r)))))))))
      :input (l hd tl) :output (r))))

;;;
;;; Function to synthesize
;;;
(synth-fun lreverse() F)


;;;
;;; Constraints 
;;;
(constraint (L.Sem (F.Exp lreverse) lreverse $nil $nil))
(constraint (L.Sem (F.Exp lreverse) lreverse ($cons 0 $nil) ($cons 0 $nil)))
(constraint (L.Sem (F.Exp lreverse) lreverse ($cons 1 $nil) ($cons 1 $nil)))
(constraint (L.Sem (F.Exp lreverse) lreverse ($cons 0 ($cons 1 $nil)) ($cons 1 ($cons 0 $nil))))
(constraint (L.Sem (F.Exp lreverse) lreverse 
     ($cons 0 ($cons 1 ($cons 2 $nil))) 
     ($cons 2 ($cons 1 ($cons 0 $nil)))))

;;;
;;; Expected: match l | nil -> nil | cons hd tl -> snoc (reverse tl) hd
;;; (define-fun lreverse() F ($letrec ($match_l $l $lnil ($f_snoc ($f_reverse $tl) $hd))))
;;;
(check-synth)