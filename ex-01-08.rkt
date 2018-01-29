#lang sicp

#| Exercise 1.8: Newton’s method for cube roots is based on the fact that if y is an approximation
to the cube root of x, then a better approximation is given by the value

(/ (+ (/ x (sqr y)) (* 2 y)) 3)

Use this formula to implement a cube-root procedure analogous to the square-root procedure. (In
1.3.4 we will see how to implement Newton’s method in general as an abstraction of these square-root
and cube-root procedures.)

Answer:

(define (my-cbrt n g)
  (if (good-enough? g n)
          g
          (my-cbrt n (improve g n))))

(define (good-enough? g n)
  (< (abs (- (* g g g) n)) 0.001))

(define (improve g n)
  (/ (+ (/ n (sqr g)) (* 2 g)) 3))

(define (cbrt n)
  (my-cbrt n 1.0))
|#
