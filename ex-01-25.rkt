#lang sicp

#| Exercise 1,25: Alyssa P. Hacker plendas, ke ni faris multe da aldona laboro por skribi la expmod
funkcion. Finfine, ŝi diras, ke tial ke ni jam scias kiel kalkuli eksponentojn, ni simple povas
skribi:

(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

Ĉu ŝi ĝustas? Ĉu ĉi tiu funkcio funkcias laŭbone, por nia rapida prima testilo? Klarigu.


Klarigo:

Mi pensas, ke Alyssa estas fakte ĝusta, tial ke, la antaŭa kodskribo de expmod, kaj la antaŭa
kodskribi de fast-expt, estas preskaŭ simila. Vidu:

(define (fast-expt b n)
  (cond ((= n 0) 
         1)
        ((even? n) 
         (square (fast-expt b (/ n 2))))
        (else 
         (* b (fast-expt b (- n 1))))))

(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder 
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder 
          (* base (expmod base (- exp 1) m))
          m))))

Krom la aldona 'm' (kiu ne fakte ŝanĝas ĉie en la kodmalvolvo) en la listo de argumentoj de expmod,
kaj la ŝanĝa nomo de nia funkcia argumento, ni povas vidi, ke la du funkcioj estas simila. Ambaŭ
havas la remainder funkcion kiam la vosta proceduro. Ni eĉ povas reskribi nian funkcion por montri
la kontraston (kaj mian racion):

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder 
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder 
          (* base (expmod base (- exp 1) m))
          m))))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        (else
         (remainder 
          (cond [(even? exp) 
                 (square (expmod base (/ exp 2) m))]
                [else
                 (* base (expmod base (- exp 1) m))]) 
          m))))
|#

