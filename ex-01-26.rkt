#lang sicp

#| Ekzerco 1,26: Louis Reasoner faras malfacile la Ekzercon 1,24. Lia fast-prime? provo aspektas
kodmalvolvi pli malrapide ol lia prime? provo. Louis vokis lian amikinon Eva Lu Ator por helpi
lin. Kiam ili ekzamenas la kodo de Louis, ili trovas, ke li reskribis la expmod proceduro por uzi
eksplicitan multiplikon, anstataŭ uzi square:

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder 
          (* (expmod base (/ exp 2) m)
             (expmod base (/ exp 2) m))
          m))
        (else
         (remainder 
          (* base 
             (expmod base (- exp 1) m)) m)))) 

“Mi ne vidas la kontrasto ke tiu povas fari,” Louis diras. “Mi povas.” Eva diras. “Per skribi la
procezon simile tiun, vi transformigis la O(log n) procezon al O(n) procezon.” Klarigu.
|#

Eva diras ke la procezo transformigis la O(log n) procezon al O(n) procezon, tial ke, Eva scias, ke
nia programlingvo uzas la applicative-order koda malvolvo, do, se Louis uzis la bagatelan kodan
difinon de la square funkcio anstataŭe, kiu la funkcia argumento (expmod base (/ exp 2) m) estas
unue simpligita (ĉar de applicative-order koda malvolvo) tiam multiplikis la efikon per si mem, la
duplikata rekalkulo de (expmod base (/ exp 2) m) ne ekzistos.
