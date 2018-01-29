#lang sicp

#| Exercise 1.7: The good-enough? test used in computing square roots will not be very effective for
finding the square roots of very small numbers. Also, in real computers, arithmetic operations are
almost always performed with limited precision. This makes our test inadequate for very large
numbers. Explain these statements, with examples showing how the test fails for small and large
numbers. An alternative strategy for implementing good-enough? is to watch how guess changes from
one iteration to the next and to stop when the change is a very small fraction of the guess. Design
a square-root procedure that uses this kind of end test. Does this work better for small and large
numbers?

Answer:

The first statement, that the good-enough? test fails for very small numbers, is true (especially
for numbers that go beyond (lower) than the value we set for checking whether a guess is good enough
(0.001)). To test that, we try our sqrt procedure for something we could easily solve off the top
of our heads:

(sqrt 0.0009)

Notice that we deliberately chose a number that is smaller that 0.001 (which is the number we set
for checking whether a guess is good enough) to prove the first statement’s point. This expression
should evaluate to or near to 0.03. When actually running the expression, what we get instead is a
number that is closer to 0.04 hence the first statement’s conclusion that using our good-enough?
test for very small numbers is ineffective.

The second statement, that our test also fails for very large numbers, is also true but it is only
noticeable for the really large numbers (which depends on what number you set as your “threshold” in
the “good-enough?” procedure). 

As an example, we will use a “large” perfect square number as a test. We’ll be using
400000000000000 (that’s with 14 zeroes):

(sqrt 400000000000000)

as expected, will yield the result:

20000000 (with 7 zeroes, of course)

A problem starts to arise when we remove 1 zero from the “large” perfect square number we
provided (which will make it a non-perfect square:

(sqrt 40000000000000)

The computation seems to take an eternity to complete and it’s a smaller number! (but in the
number’s defense, removing 1 zero made it a non-perfect square).

Before we go directly to why this happens, let’s establish some sort of a “pattern” by giving our
sqrt procedure a smaller non-perfect square that DrRacket doesn’t take an eternity to compute:

(sqrt 4000000000) (that’s with 9 zeroes, a non-perfect square)

yields:

63245.553203368094

(sqrt 400000000000) (11 zeroes)

yields:

632455.5320336758

So with (sqrt 40000000000000) (13 zeroes), according to the pattern we just established, the
procedure should be yielding a number close to 6324555.320336758 (I did some math magic and moved
the decimal point one number to the right) but why does our sqrt procedure not output that number?

Let’s go to our good-enough? predicate to see why because it is what checks whether a number is
“worthy” to be displayed or not. By substituting 6324555.320336758 in the body of our function for
g, it will look like this:

(< (abs (- (sqr 6324555.320336758) 40000000000000)) 0.001)

but this will yield:

#f

Why? It’s because evaluating the square of 6324555.320336758 will yield to -0.0078 or, simply,
-0.008. Our good-enough? predicate checks whether the absolute value of that evaluation will turn
out to be less than 0.001. In our case, it does not, so our improve procedure recomputes again but
it will just be regurgitating the same number, which is 6324555.320336758, hence the non-ending
calling of our improve procedure.
|#

;;; “unoptimized” code
(define (my-sqrt n g)
  (if (good-enough? g n)
          g
          (my-sqrt n (improve g n))))

(define (good-enough? g n)
  (< (abs (- (sqr g) n)) 0.001))

(define (improve g n)
  (/ (+ g (/ n g)) 2))

(define (s-sqrt n)
  (my-sqrt n 1.0))

#|Now, let’s proceed to the part where we have to optimize our “good-enough?” test to avoid this
non-ending computation behavior. The alternative strategy suggests that we watch how guess changes
from one iteration to the next one, and to stop when the difference between the guesses is a small
fraction of the guess. By following this proposed alternative strategy, instead of checking whether
our guess’s square is close enough to the number whose square root we’re trying to compute, since
Newton’s formula guarantees that we get closer to the “true” square root as we invoke our improve1
procedure repeatedly, we’ll instead check whether our current guess iteration’s difference between
the “improved” guess is less than a fraction of the guess. This works better because the number it
has to check against has the ability to scale based on the guess.
|#

;;; !!!
(define (my-sqrt1 n g)
  (if (good-enough1? g n)
          g
          (my-sqrt1 n (improve1 g n))))

#| i here is what the strategy refers to as the “next” iteration and we look for the difference
between i and the current iteration’s g and check whether it’s less than a fraction of the guess (we
can use either the current guess iteration or the new guess and I’ll explain in a moment why):
|#
(define (good-enough1? g n)
  (let ([i (improve1 g n)]) ;; i is next iteration, g is current
    (< (abs (- i g)) (* i 0.001))))

#| Upon further testing of above code, We can restructure it to look like the following because
after numerous evaluations of improve1, the next guess and the current guess will eventually be
equal. The previous code is to demonstrate how we followed the suggested approach.

(define (good-enough1? g n)
  (= (- (improve1 g n) g) 0))
|#

(define (improve1 g n)
  (/ (+ g (/ n g)) 2)) ;; outputs new guess

(define (s-sqrt1 n)
  (my-sqrt1 n 1.0))

