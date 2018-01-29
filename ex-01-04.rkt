#lang sicp

#| Exercise 1.4: Observe that our model of evaluation allows for combinations whose operators are
compound expressions. Use this observation to describe the behavior of the following procedure:

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

In the given procedure, because the evaluation model tells us to first evaluate sub-expressions, we
first evaluate the left-most one which is the if expression, then depending on b’s value, the if
expression will either evaluate to + or - which will then be applied to a and b.
|#
