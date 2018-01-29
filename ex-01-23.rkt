#lang sicp

#| Exercise 1.23: The smallest-divisor procedure shown at the start of this section does lots of
needless testing: After it checks to see if the number is divisible by 2, there is no point in
checking to see if it is divisible by any larger even number. This suggests, that the values used
for test-divisor should not be 2, 3, 4, 5, 6, ..., but rather 2, 3, 5, 7, 9, .... To implement this
change, define a procedure next that returns 3 if its input is equal to 2 and otherwise returns its
input plus 2. Modify the smallest-divisor procedure to use (next test-divisor) instead of (+
test-divisor 1). With timed-prime-test incorporating this modified version of smallest-divisor, run
the test for each of the 12 primes found in exercise 1.22. Since this modification halves the number
of test steps, you should expect it to run about twice as fast. Is this expectation confirmed? If
not, what is the observed ratio of the speeds of the two algorithms, and how do you explain the fact
that it is different from 2?

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
|#

(define (next x)
  (cond [(= x 2) 3]
        [else
         (+ x 2)]))

(define (square x)
  (* x x))

;;; La funkciojn kiu estas por provi se la numero estas prima aŭ ne
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) 
         n)
        ((divides? test-divisor n) 
         test-divisor)
        (else (find-divisor 
               n 
               (+ 1 test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

;;; La funkciojn kiu estas por montri la 'bezonatan' tempon
(define (timed-prime-test n)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (* n n)
      (report-prime (- (runtime) 
                       start-time))))

(define (report-prime elapsed-time)
  (display ": ")
  (display elapsed-time)
  (newline))

;;; La funkcion kiu la problemo bezonas min por krei
(define (search-for-primes n t)
  (cond [(= t 0) '()]
        [(prime? n) (cons (timed-prime-test n)
                                         (search-for-primes (+ n 1) (- t 1)))]
        [else
         (search-for-primes (+ n 1) t)]))

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

#| La meznombro de la valoro ke ni nune vidas, montras, ke la proporcio ne estas ekzakte 2,
anstataŭe, la fakta proporcio (de la antaŭa kaj la nuna ŝanĝo) estas el 1,5 al 1,7.

Unue, provu enlistigi la unuajn dudek numerojn ke nia funkcio provas (por la nova valoro de
test-divisor), se ni uzas la (+ 1 test-divisor), kaj se ni uzas (next divisor):

[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21]
[2, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39]
|#

