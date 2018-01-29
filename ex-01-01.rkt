#lang sicp

#| Exercise 1.1: Below is a sequence of expressions. What is the result printed by the interpreter
in response to each expression? Assume that the sequence is to be evaluated in the order in which it
is presented.
1.  10
2.  (+ 5 3 4)
3.  (- 9 1)
4.  (/ 6 2)
5.  (+ (* 2 4) (- 4 6))
6.  (define a 3)
7.  (define b (+ a 1))
8.  (+ a b (* a b))
9.  (= a b)
10. (if (and (> b a) (< b (* a b)))
          b
          a)
11. (cond ((= a 4) 6)
          ((= b 4) (+ 6 7 a))
          (else 25))
12. (+ 2 (if (> b a) b a))
13. (* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
       (+ a 1))

1. 10
2. 12
3. 8
4. 3
5. 6
6. 
7. 
8. 19
9. #f
10. 4
11. 16
12. 6
13. 16
|#
