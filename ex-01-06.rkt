#lang sicp

#| Exercise 1.6: Alyssa P. Hacker doesn’t see why if needs to be provided as a special form. “Why
can’t I just define it as an ordinary procedure in terms of cond?” she asks. Alyssa’s friend Eva Lu
Ator claims this can indeed be done, and she defines a new version of if:

(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))
Eva demonstrates the program for Alyssa:

(new-if (= 2 3) 0 5)
5

(new-if (= 1 1) 0 5)
0

Delighted, Alyssa uses new-if to rewrite the square-root program:

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))
What happens when Alyssa attempts to use this to compute square roots? Explain.

Answer:

If the “new-if” procedure is used instead of the “special“ form “if” we used before, the program
will go to an endless evaluation of the “else-clause” argument because the language, by default,
uses an applicative-order method of evaluation which means arguments are evaluated first before
they are “substituted” for their appearance in the function body.

A simple test between the difference of these two procedures would be the following:

(if 0 5 (/ 1 0))

versus

(new-if 0 5 (/ 1 0))

The first procedure would output “5” just fine but the second procedure will throw you a “division
by zero” error because it will evaluate or “simplify” the arguments first before proceeding to
the function’s body.
|#
