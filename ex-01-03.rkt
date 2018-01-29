#lang sicp

#| Exercise 1.3: Define a procedure that takes three numbers as arguments and returns the sum of the
 squares of the two larger numbers.
|#
(define (procedure0 n1 n2 n3)
  (cond [(and (or (>= n1 n2) (>= n1 n3)) ;; f is n1
              (>= n2 n3))                ;; s is n2
         (+ (sqr n1) (sqr n2))]          ;; n1; n2
        [(and (or (>= n1 n2) (>= n1 n3)) ;; f is n1
              (>= n3 n2))                ;; s is n3
         (+ (sqr n1) (sqr n3))]          ;; n1; n3
        [(and (or (>= n2 n1) (>= n2 n3)) ;; f is n2
              (>= n1 n3))                ;; s is n1
         (+ (sqr n2) (sqr n1))]          ;; n2; n1
        [(and (or (>= n2 n1) (>= n2 n3)) ;; f is n2
              (>= n3 n1))                ;; s is n3
         (+ (sqr n2) (sqr n3))]          ;; n2; n3
        [(and (or (>= n3 n1) (>= n3 n2)) ;; f is n3
              (>= n1 n2))                ;; s is n1
         (+ (sqr n3) (sqr n1))]          ;; n3; n1
        [(and (or (>= n3 n1) (>= n3 n2)) ;; f is n3
              (>= n2 n1))                ;; s is n2
         (+ (sqr n3) (sqr n2))]))        ;; n3; n2
