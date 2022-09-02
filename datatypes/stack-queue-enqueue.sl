
;;; Metadata
(set-info :format-version "2.0.0")
(set-info :author "Kanghee Park")
(set-info :realizable true)

;;;
;;; Datatypes
;;;
(declare-datatypes
  ((List 0) (Stack 0) (Queue 0)) ; Intger List and Stack (may define generic List/Stack later)

  ((  ; Constructors for List
    ($nil)
    ($cons (head Int) (tail List))
  )
  (   ; Constructor for Stack
    ($stack (list List))
  )
  (   ; Constructor for Queue
    ($queue (pop_stack Stack) (push_stack Stack))
  )) 
)

;;;
;;; Productions
;;;
(declare-term-types  
  ;; Term types  ; Declare terms inductively using syntactic constructors
  ((I 0) (B 0) (ST 0) (Q 0))  ; Each term type corresponds to a nonterminal in the default grammar

    ;; Productions
  (( ; Productions for term type I
    ($x)
    ($0)
    ($1)
    ($+ I I)  ; The $+ production has two child terms of type E
    ($ite B I I)
    ($top ST)
  )
  ( ; Productions for term type B
    ($t) 
    ($f)
    ($not B)
    ($and B B)
    ($or B B)
    ($< I I)
    ($is_empty_stack ST)
  )
  ( ; Productions for term type ST
    ($empty_stack)
    ($push I ST)
    ($pop ST)
    ($push_stack_from_queue Q)
    ($pop_stack_from_queue Q)
  )
  ( ; Productions for term type Q
    ($q)
    ($from_stack ST ST)
  ))
)

;;;
;;; Abstraction function
;;;
(define-funs-rec
  ;; Signatures
  ((stack_to_list ((st Stack) (rl List)) Bool))

  ;; Bodies
  (
    (!
      (match st
        (($stack l) (= rl l)))
      :input (st) :output (rl)
    )
  )
)

;;;
;;; Function Semantics
;;;
(define-funs-rec
  ;; Signatures
  (
    (top.Sem ((st Stack) (ri Int)) Bool)
    (is_empty_stack.Sem ((st Stack) (rb Bool)) Bool)
    (empty_stack.Sem ((rst Stack)) Bool)
    (push.Sem ((x Int) (st Stack) (rst Stack)) Bool)
    (pop.Sem ((st Stack) (rst Stack)) Bool)
  )
  
  ;; Bodies
  (
    (! ; top semantics
      (exists (l List) (tl List)
        (and
          (stack_to_list st l)
          (= l (cons ri tl))))
      :input (st) :output (ri)
    )

    (! ; is_empty_stack semantics
      (exists (l List)
        (and
          (stack_to_list st l)
          (= l nil)
          (= rb true)))
      (exists (l List) (hd Int) 
        (and
          (stack_to_list st l)
          (not (= l nil))
          (= rb false)))
      :input (st) :output (rb)
    )

    (!  ; empty_stack semantics
      (exists (l List)
        (and
          (stack_to_list rst l)
          (= l nil)))
      :input () :output (rst)
    )

    (!  ; pop semantics
      (exists (l List) (rl List) (hd Int)
        (and
          (stack_to_list st l)
          (stack_to_list rst rl)
          (= l (cons hd rl)))
      )
      :input (st) :output (rst)
    ))
)

;;;
;;; Term Semantics
;;;
(define-funs-rec
  ;; Semantic relations and their types
  (
    (I.Sem ((it I) (x Int) (q Queue) (r Int)) Bool)  ; Each relation is declared as a function Sem : (members) -> Bool
    (B.Sem ((bt B) (x Int) (q Queue) (r Bool)) Bool) ; The `_.Sem` names are a naming convention with no special significance.
    (ST.Sem ((stt ST) (x Int) (q Queue) (r Stack)) Bool)
    (Q.Sem ((qt Q) (x Int) (q Queue) (r Queue)) Bool)
  )
  ;; Bodies
  (
    (! ; The `!` expression attaches attributes to its first argument: in this case, the `:in` and `:out` labels below
      (match it ; I.Sem defined inductively through matching
        ($x (= r x))
        ($0 (= r 0))
        ($1 (= r 1))
        (($+ it1 it2)
          (exists ((r1 Int) (r2 Int))
            (and
              (I.Sem it1 x q r1)
              (I.Sem it2 x q r2)
              (= r (+ r1 r2)))))
        (($ite bt it1 it2)
          (exists ((b Bool)) 
            (and
              (B.Sem bt x q b)
              (= b true)
              (I.Sem it1 x q r)))
          (exists ((b Bool))
            (and
              (B.Sem bt x q b)
              (= b false)
              (I.Sem it2 x q r))))
        (($top stt)
          (exists ((rst Stack))
            (and
              (ST.Sem stt x q rst)
              (top.Sem rst r))))
      ) ; end `match it`
      :input (x q) :output (r)
    )                               

    (!(match bt ; B.Sem definitions
        (($t (= r true))
        ($f (= r false))
        (($not bt1)
          (exists ((rb Bool))
            (and
              (B.Sem bt1 x q rb)
              (= r (not rb)))))
        (($and bt1 bt2)
          (exists ((rb1 Bool) (rb2 Bool))
            (and
              (B.Sem bt1 x q rb1)
              (B.Sem bt2 x q rb2)
              (= r (and rb1 rb2)))))
        (($or bt1 bt2)
          (exists ((rb1 Bool) (rb2 Bool))
            (and
              (B.Sem bt1 x q rb1)
              (B.Sem bt2 x q rb2)
              (= r (or rb1 rb2)))))
        (($< et1 et2)
          (exists ((r1 Int) (r2 Int))
            (and
              (E.Sem et1 x q r1)
              (E.Sem et2 x q r2)
              (= r (< r1 r2)))))
        (($is_empty_stack stt)
          (exists ((rst Stack))
            (and
              (ST.Sem stt x q rst)
              (is_empty_stack.Sem rst r)))))
      ) ; end `match bt`
      :input (x q) :output (r)
    )

    (!(match stt ; ST.Sem definitions
          (($empty_stack (empty_stack.Sem r))
          (($push it stt)
            (exists ((ri Int) (rst Stack))
              (and
                (I.Sem it x q ri)
                (ST.Sem stt x q rst)
                (push.Sem it stt r))))
          (($pop stt)
            (exists ((rst Stack))
              (and
                (ST.Sem stt x q rst)
                (pop.Sem stt r))))
          (($push_stack_from_queue qt)
            (exists ((rq Queue))
              (and
                (Q.Sem qt x q rq)
                (= r (push_stack rq)))))
          (($pop_stack_from_queue qt)
            (exists ((rq Queue))
              (and
                (Q.Sem qt x q rq)
                (= r (pop_stack rq)))))
      ) ; end `match stt`
      :input (x q) :output (r)
    )
    
    (!(match qt ; Q.Sem definitions
          (($q (= r q))
          (($from_stack stt1 stt2)
            (exists ((rst1 Stack) (rst2 Stack))
              (and
                (ST.Sem stt1 x q rst1)
                (ST.Sem stt2 x q rst2)
                (= r (queue rst1 rst2)))))
      ) ; end `match qt`
      :input (x q) :output (r)
    ))
)

;;;
;;; Function to synthesize
;;;
(synth-fun enqueue() Q)


;;;
;;; Constraints 
;;;

;;; To-Do