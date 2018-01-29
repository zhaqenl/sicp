#lang sicp

#| Ekzerco 1,24: Ŝanĝu la timed-prime-test proceduro de Ekzerco 1,22 por uzi la fast-prime? (la
Fermat metodo), kaj provu la dekdu primojn ke vi trovis en tiu ekzerco. Tial ke la Fermat provo
havas O(log n) de kreskado, kiel vi anticipas la tempo por provi primojn kiu estas proksime
1,000,000 por kompari per la tempo kiu estas bezonata por provi primojn kiu estas proksime 1000? Ĉu
via datao konstatas ĉi tiun? Ĉu vi povas klarigi ia anomalion ke vi trovas?  
|#

(define (square n)
  (* n n))


(define (timed-prime-test n)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 50)
      (report-prime (- (runtime) 
                       start-time))))

(define (report-prime elapsed-time)
  (display ": ")
  (display elapsed-time)
  (newline))

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

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) 
         (fast-prime? n (- times 1)))
        (else false)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) 
         n)
        ((divides? test-divisor n) 
         test-divisor)
        (else (find-divisor 
               n 
               (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

;;; Provojn
(timed-prime-test 1009)
(timed-prime-test 1013)
(timed-prime-test 1019)
(timed-prime-test 10007)
(timed-prime-test 10009)
(timed-prime-test 10037)
(timed-prime-test 100003)
(timed-prime-test 100019)
(timed-prime-test 100043)
(timed-prime-test 1000003)
(timed-prime-test 1000033)
(timed-prime-test 1000037)

#| La nova algoritmo havas O(log n) kreskadon, do, kiam ni akiras la valoro de (log 1000) kaj (log
1000000), ni povas vidi, ke la valoro de (log 1000000) estas ekzakte duoble la valoro de (log 1000),
ĉar 1000 estas la kvadrata radiko de 1000000.  
|#

