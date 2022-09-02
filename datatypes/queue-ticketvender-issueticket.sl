
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
  )
  (   ; Constructor for TicketVender
    ($ticket_vender (num_ticket Int) (waiting_queue Queue))
  )) 
)

;;;
;;; Productions
;;;
(declare-term-types  
  ;; Term types  ; Declare terms inductively using syntactic constructors
  ((I 0) (B 0) (Q 0) (TV 0))  ; Each term type corresponds to a nonterminal in the default grammar

    ;; Productions
  (( ; Productions for term type I
    ($x)
    ($0)
    ($1)
    ($+ I I)  ; The $+ production has two child terms of type E
    ($ite B I I)
    ($front Q)
  )
  ( ; Productions for term type B
    ($t) 
    ($f)
    ($not B)
    ($and B B)
    ($or B B)
    ($< I I)
    ($is_empty_queue Q)
  )
  ( ; Productions for term type Q
    ($empty_queue)
    ($enqueue I ST)
    ($dequeue ST)
    ($waiting_queue Q)
  )
  ( ; Productions for term type TV
    ($vender I Q)
  ))
)

;;;
;;; List Function Semantics
;;;
(define-funs-rec
  ;; Signatures
  (
    (snoc.Sem ((l List) (x Int) (rl List)) Bool)
    (reverse.Sem ((l List) (rl List)) Bool)
    (concat.Sem ((l1 List) (l2 List) (rl List)) Bool)
  )
  ;; Bodies
  (
    (! ; snoc semantics
      (match l
        ($nil (= rl (cons x nil)))
        (($cons hd tl)
          (exists (rsub List)
            (and
              (snoc.Sem tl x rsub)
              (= rl (cons hd rsub)))))
      )
      :input (l x) :output (rl)
    )

    (!  ; reverse semantics
      (match l
        ($nil (= rl nil))
        (($cons hd tl)
          (exists (rsub List)
            (and
              (reverse.Sem tl rsub)
              (snoc.Sem hd rsub rl))))
      )
      :input (l) :output (rl)
    )

    (!  ; append semantics
      (match l1
        ($nil (= rl l2))
        (($cons hd tl)
          (exists (rsub List)
            (and
              (append.Sem tl l2 rsub)
              (= rl (cons hd rsub)))))
      )
      :input (l x) :output (rl)
    ))
)

;;;
;;; Abstraction function
;;;
(define-funs-rec
  ;; Signatures
  (
    (stack_to_list ((st Stack) (rl List)) Bool)
    (queue_to_list ((q Queue) (rl List)) Bool)
  )
  ;; Bodies
  (
    (!
      (match st
        (($stack l) (= rl l)))
      :input (st) :output (rl)    
    )

    (!
      (match q
        (($queue pop_st push_st) 
          (exists (rpop List) (rpush List) (rpush_rev List)
            (and
              (stack_to_list pop_st rpop)
              (stack_to_list push_st rpush)
              (reverse.Sem rpush rpush_rev)
              (append.Sem rpop rpush_rev rl)))))
      :input (q) :output (rl)
    )
  )
)

;;;
;;; Function Semantics
;;;
(define-funs-rec
  ;; Signatures
  (
    (front.Sem ((q Queue) (ri Int)) Bool)
    (is_empty_queue.Sem ((q Stack) (rb Bool)) Bool)
    (empty_queue.Sem ((rq Queue)) Bool)
    (enqueue.Sem ((x Int) (q Queue) (rq Queue)) Bool)
    (dequeue.Sem ((q Queue) (rq Queue)) Bool)
  )
  
  ;; Bodies
  (
    (! ; front semantics
      (exists (l List) (tl List)
        (and
          (queue_to_list q l)
          (= l (cons ri tl))))
      :input (q) :output (ri)
    )

    (! ; is_empty_queue semantics
      (exists (l List)
        (and
          (queue_to_list q l)
          (= l nil)
          (= rb true)))
      (exists (l List) (hd Int) 
        (and
          (queue_to_list q l)
          (not (= l nil))
          (= rb false)))
      :input (q) :output (rb)
    )

    (!  ; empty_queue semantics
      (exists (l List)
        (and
          (queue_to_list rst l)
          (= l nil)))
      :input () :output (rst)
    )

    (!  ; dequeue semantics
      (exists (l List) (rl List) (hd Int)
        (and
          (stack_to_list q l)
          (stack_to_list rq rl)
          (= l (cons hd rl)))
      )
      :input (q) :output (rq)
    ))
)

;;;
;;; Term Semantics
;;;
(define-funs-rec
  ;; Semantic relations and their types
  (
    (I.Sem ((it I) (tv TicketVender) (r Int)) Bool)  ; Each relation is declared as a function Sem : (members) -> Bool
    (B.Sem ((bt B) (tv TicketVender) (r Bool)) Bool) ; The `_.Sem` names are a naming convention with no special significance.
    (Q.Sem ((qt Q) (tv TicketVender) (r Queue)) Bool)
    (TV.Sem ((tvt TV) (tv TicketVender) (r TicketVender)) Bool)
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
              (I.Sem it1 tv r1)
              (I.Sem it2 tv r2)
              (= r (+ r1 r2)))))
        (($ite bt it1 it2)
          (exists ((b Bool)) 
            (and
              (B.Sem bt tv b)
              (= b true)
              (I.Sem it1 tv r)))
          (exists ((b Bool))
            (and
              (B.Sem bt tv b)
              (= b false)
              (I.Sem it2 tv r))))
        (($front qt)
          (exists ((rq Queue))
            (and
              (QT.Sem qt tv rq)
              (front.Sem rq r))))
      ) ; end `match it`
      :input (tv) :output (r)
    )                               

    (!(match bt ; B.Sem definitions
        (($t (= r true))
        ($f (= r false))
        (($not bt1)
          (exists ((rb Bool))
            (and
              (B.Sem bt1 tv rb)
              (= r (not rb)))))
        (($and bt1 bt2)
          (exists ((rb1 Bool) (rb2 Bool))
            (and
              (B.Sem bt1 tv rb1)
              (B.Sem bt2 tv rb2)
              (= r (and rb1 rb2)))))
        (($or bt1 bt2)
          (exists ((rb1 Bool) (rb2 Bool))
            (and
              (B.Sem bt1 tv rb1)
              (B.Sem bt2 tv rb2)
              (= r (or rb1 rb2)))))
        (($< et1 et2)
          (exists ((r1 Int) (r2 Int))
            (and
              (E.Sem et1 tv r1)
              (E.Sem et2 tv r2)
              (= r (< r1 r2)))))
        (($is_empty_stack qt)
          (exists ((rq Stack))
            (and
              (Q.Sem qt tv rq)
              (is_empty_queue.Sem qt r)))))
      ) ; end `match bt`
      :input (tv) :output (r)
    )

    (!(match qt ; Q.Sem definitions
          (($empty_queue (empty_queue.Sem r))
          (($enqueue it qt)
            (exists ((ri Int) (rq Queue))
              (and
                (I.Sem it tv ri)
                (Q.Sem qt tv rq)
                (enqueue.Sem it qt r))))
          (($dequeue qt)
            (exists ((rq Stack))
              (and
                (Q.Sem stt tv rq)
                (dequeue.Sem qt r))))
      ) ; end `match qt`
      :input (tv) :output (r)
    )
    
    (!(match tvt ; TV.Sem definitions
          (($tv (= r tv))
          (($vender it qt)
            (exists ((ri Int) (rq Queue))
              (and
                (I.Sem it tv ri)
                (Q.Sem qt tv rq)
                (= r (ticket_vender ri rq)))))
      ) ; end `match tvt`
      :input (tv) :output (r)
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