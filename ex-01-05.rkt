#lang sicp

#| Exercise 1.5: Ben Bitdiddle has invented a test to determine whether the interpreter he is faced
with is using applicative-order evaluation or normal-order evaluation. He defines the following two
procedures:

(define (p) (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))
Then he evaluates the expression

(test 0 (p))
What behavior will Ben observe with an interpreter that uses applicative-order evaluation? What
behavior will he observe with an interpreter that uses normal-order evaluation? Explain your answer.
(Assume that the evaluation rule for the special form if is the same whether the interpreter is
using normal or applicative order: The predicate expression is evaluated first, and the result
determines whether to evaluate the consequent or the alternative expression.)

With an applicative-order of evaluation, the arguments are evauluated “up-front“ which means that
even before the arguments provided to the procedure are substituted for its occurence inside the
function body, it is first evaluated.

In Ben’s case, he wants to evaluate the expression “(test 0 (p))”. Following the applicative-order
evaluation, we will first evaluate its arguments, but there’s a problem, and that is the infinite
evaluation of “(p)” because it is recursive and there’s no “case” that will make it stop.

On the other hand, if the interpreter is using a normal-order evaluation method, it won’t evaluate
the arguments up-front, instead, it will “prioritize” arguments substitution for the function body
and will only evaluate when forced to (when it comes across primitive expressions). So in a normal
evaluation interpreter, the expression “(test 0 (p))” will go like:

(define (test 0 (p))
  (if (= 0 0)
      0
      (p)))

The if expression then evaluates the predicate then decides whether to return 0 or evaluate “(p)”
further but in this case, it will return 0 because the predicate returns true.
|#
