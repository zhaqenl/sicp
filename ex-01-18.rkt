#lang sicp

#| Exercise 1.18: Using the results of Exercise 1.16 and Exercise 1.17, devise a procedure that
generates an iterative process for multiplying two integers in terms of adding, doubling, and
halving and uses a logarithmic number of steps.

Similar to how we derived the iterative version of fast-expt, for even-numbered 'b', one need not
touch the state of the accumulator because the work is done through the previous two state changes
namely the doubling of 'a' and the halving of 'b':
|#

(define (even? n)
  (integer? (/ n 2)))

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))

(define (* a b)
  (define (h* a b c)
    (cond [(= b 0) c]
          [(even? b)
           (h* (double a)
               (halve b)
               c)]
          [else
           (h* a
               (- b 1)
               (+ a c))]))
  (h* a b 0))
