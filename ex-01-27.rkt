#lang sicp

#| Ekzerco 1,27: Demonstru ke la Carmichael numeroj kiu estas listigita en la Piednoto 47 fakte
mistifikas la Fermat provon. Nome, skribu funkcion ke akceptas entjeron 'n' kaj provas se (expt a n)
estas kongrua po (modulo a n) dum (< a n), kaj provu vian proceduron per la donitaj Carmichael
numeroj.
|#

;;; Eligu #t se la donita n estas prima, #f se ne
(define (funkcion? n)
  (define a
    (+ 1 (random (- n 1))))
  (if (= (remainder (expt a n) n) (modulo a n))
      #t
      #f))

;;; Provoj por la Carmichael numeroj
(funkcion? 561)
(funkcion? 1105)
(funkcion? 1729)
(funkcion? 2465)
(funkcion? 2821)
(funkcion? 6601)
(display "\n")

;;; Aliaj provoj por la numeroj ke ne tute estas prima
(funkcion? 562)
(funkcion? 1104)
(funkcion? 1730)
(funkcion? 2466)
(funkcion? 2822)
(funkcion? 6602)
