#lang sicp

#| Exercise 1.22: Most Lisp implementations include a primitive called runtime that returns an
integer that specifies the amount of time the system has been running (measured, for example, in
microseconds). The following timed-prime-test procedure, when called with an integer n, prints n and
checks if n is prime. If n is prime, the procedure prints three asterisks followed by the amount of
time used in performing the test.

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) 
                       start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

Using this procedure, write a procedure search-for-primes that checks the primality of consecutive
odd integers in a specified range. Use your procedure to find the three smallest primes larger than
1000; larger than 10,000; larger than 100,000; larger than 1,000,000. Note the time needed to test
each prime. Since the testing algorithm has order of growth of O((sqrt n)), you should expect that
testing for primes around 10,000 should take about (sqrt 10) times as long as testing for primes
around 1000. Do your timing data bear this out? How well do the data for 100,000 and 1,000,000
support the O((sqrt n)) prediction? Is your result compatible with the notion that programs on your
machine run in time proportional to the number of steps required for the computation?

|#

(define (timed-prime-test n)
  (display n)
  (start-prime-test n (runtime)))

(define (empty? x)
  (equal? '() x))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) 
                       start-time))))

(define (report-prime elapsed-time)
  (display ": ")
  (display elapsed-time)
  (newline))

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

(define (square n)
  (* n n))

(define (search-for-primes n t)
  (cond [(= t 0) '()]
        [(prime? n) (cons (timed-prime-test n)
                                         (search-for-primes (+ n 1) (- t 1)))]
        [else
         (search-for-primes (+ n 1) t)]))

(search-for-primes 1000 3)
(search-for-primes 10000 3)
(search-for-primes 100000 3)
(search-for-primes 1000000 3)

#| La meznombra eligo de la antaŭaj funkciaj provoj montras, ke se numero estas dekfoje pli granda,
tiam, la tempo ke estas bezonata (por provi se la numero estas prima), estas ankaŭ la kvadrata
radiko de dek (kiu estas tri). Do, se la numero estas centfoje pli granda (do, la kvadrata radiko de
cent estas dek), vi povas anticipi, ke la tempo ke estas bezonata estas preskaŭ dekfoje pli granda.
|#

