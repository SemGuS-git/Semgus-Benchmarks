(declare-datatypes
  ((List 0)) ; May define parametric List or Stack

  ((; Constructors for List
    ($nil)
    ($cons (hd Int) (tl List))
  )) 
)

(declare-term-types  
    ;; Term types  ; Declare terms inductively using syntactic constructors
    ((I 0) (B 0) (L 0) (ST 0))  ; Each term type corresponds to a nonterminal in the default grammar

    ;; Productions
    (( ; Productions for term type E
        ($x)
        ($0)
        ($1)
        ($+ I I)  ; The $+ production has two child terms of type E
        ($ite B I I)
    )
    ( ; Productions for term type B
        ($t) 
        ($f)
        ($not B)
        ($and B B)
        ($or B B)
        ($< I I)
    )
    ( ; Productions for term type L
        ($lnil)
        ($lcons I L)
        ($snoc L I)
        ($reverse L)
        ($concat L L)
    )
    ( ; Productions for term type ST
        ($st)
    )
  )
)

((define-funs-rec
  ;; Semantic relations and their types
  (
    (I.Sem ((it I) (x Int) (st Stack) (r Int)) Bool)  ; Each relation is declared as a function Sem : (members) -> Bool
    (B.Sem ((bt B) (x Int) (st Stack) (r Bool)) Bool) ; The `_.Sem` names are a naming convention with no special significance.
    (L.Sem ((lt L) (x Int) (st Stack) (r List)) Bool)
    (ST.Sem ((stt L) (x Int) (st Stack) (r Stack)) Bool)
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
              (I.Sem it1 x st r1)
              (I.Sem it2 x st r2)
              (= r (+ r1 r2)))))
        (($ite bt it1 it2)
          (exists ((b Bool)) 
            (and
              (B.Sem bt x st b)
              (= b true)
              (I.Sem it1 x st r)))
          (exists ((b Bool))
            (and
              (B.Sem bt x st b)
              (= b false)
              (I.Sem it2 x st r))))
      ) ; end `match it`
      :input (x st) :output (r)
    )                               

    (! (match bt ; B.Sem definitions
          (($t (= r true))
          ($f (= r false))
          (($not bt1)
            (exists ((rb Bool))
                (and
                (B.Sem bt1 x y rb)
                (= r(not rb)))))
          (($and bt1 bt2)
            (exists ((rb1 Bool) (rb2 Bool))
                (and
                (B.Sem bt1 x y rb1)
                (B.Sem bt2 x y rb2)
                (= r(and rb1 rb2)))))
          (($or bt1 bt2)
            (exists ((rb1 Bool) (rb2 Bool))
                (and
                (B.Sem bt1 x y rb1)
                (B.Sem bt2 x y rb2)
                (= r (or rb1 rb2)))))
          (($< et1 et2)
            (exists ((r1 Int) (r2 Int))
                (and
                (E.Sem et1 x y r1)
                (E.Sem et2 x y r2)
                (= r (< r1 r2)))))))
      :input (x st) :output (r)
    )

    (! (match lt ; L.Sem definitions
          (($lnil (= r nil))
          (($lcons it lt1) 
            (exists ((ri Int) (rl List))
              (and
                (I.Sem it x st ri)
                (L.Sem lt1 x st rl)
                (= r (cons ri rl))
              )))
          ;;; ...
      :input (x st) :output (r)
    )

    (! (match stt ; ST.Sem definitions
          (($st (= r st))
      :input (x st) :output (r)
    ))
)