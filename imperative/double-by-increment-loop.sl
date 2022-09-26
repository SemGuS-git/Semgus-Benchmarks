(set-info :format-version "2.0.0")
(set-info :realizable true)
(set-info :pbe true)

(declare-term-types
  ((L 0) (S 0) (E 0) (B 0))
  ((($while B S))
   (($x++)
    ($x--)
    ($y++)
    ($y--)
    ($seq S S))
   (($x)
    ($y)
    ($0))
   (($> E E)
    ($true)
    ($false))))

(define-funs-rec
  ((L.Sem ((t_l L) (xi Int) (yi Int) (xo Int) (yo Int)) Bool)
   (S.Sem ((t_s S) (xi Int) (yi Int) (xo Int) (yo Int)) Bool)
   (E.Sem ((t_e E) (xi Int) (yi Int) (o Int)) Bool)
   (B.Sem ((t_b B) (xi Int) (yi Int) (o Bool)) Bool))

  ((! (match t_l
        ((($while ltc ltb)
           (exists ((vc Bool) (xt Int) (yt Int))
             (and
               (B.Sem ltc xi yi vc)
               (S.Sem ltb xi yi xt yt)
               (L.Sem t_l xt yt xo yo)
               vc))
           (exists ((vc Bool))
             (and
               (B.Sem ltc xi yi vc)
               (and (not vc) (= xo xi) (= yo yi)))))))
     :input (xi yi) :output (xo yo))

   (! (match t_s
        (($x++ (and (= xo (+ xi 1)) (= yo yi)))
         ($x-- (and (= xo (- xi 1)) (= yo yi)))
         ($y++ (and (= xo xi) (= yo (+ yi 1))))
         ($y-- (and (= xo xi) (= yo (- yi 1))))
         (($seq sta stb)
           (exists ((xt Int) (yt Int))
             (and
               (S.Sem sta xi yi xt yt)
               (S.Sem stb xt yt xo yo))))))
     :input (xi yi) :output (xo yo))

   (! (match t_e
        (($x (= o xi))
         ($y (= o yi))
         ($0 (= o 0))))
     :input (xi yi) :output (o))

   (! (match t_b
        ((($> btl btr)
           (exists ((vl Int) (vr Int))
             (and
               (E.Sem btl xi yi vl)
               (E.Sem btr xi yi vr)
               (= o (> vl vr)))))
         ($true o)
         ($false (not o))))
     :input (xi yi) :output (o))))

(synth-fun doublex() L)
(constraint (L.Sem doublex 0 0 0 0))
(constraint (L.Sem doublex 2 0 0 4))
(check-synth)
