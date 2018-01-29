#lang sicp

#| Exercise 1.17: The exponentiation algorithms in this section are based on performing
exponentiation by means of repeated multiplication. In a similar way, one can perform integer
multiplication by means of repeated addition. The following multiplication procedure (in which it is
assumed that our language can only add, not multiply) is analogous to:

(define (* a b)
  (cond [(= b 0) 0]
        [else
         (+ a (* a (- b 1)))]))

This algorithm takes a number of steps that is linear in b. Now suppose we include, together with
addition, operations double, which doubles an integer, and halve, which divides an (even) integer by
2. Using these, design a multiplication procedure analogous to fast-expt that uses a logarithmic
number of steps.
|#

(define (even? n)
  (integer? (/ n 2)))

(define (double n)
  (+ n n))

(define (halve n)
  (/ n 2))


#| Similar to the pattern we dealt with in the previous exercise, one only needs to realize the
mathematical fact that for even-numbered 'b', (a * b) is equal to (a * b/2) + (a * b/2), to come up
with the O(log n) version of the multiplication procedure previously defined: 
|#

(define (* a b)
  (cond [(= b 0) 0]
        [(even? b)
         (double (* a (halve b)))]
        [else
         (+ a (* a (- b 1)))]))

