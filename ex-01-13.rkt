#| Prove that Fib(n) is the closest integer to X^n/(sqrt 5), where X = (1 + (sqrt 5))/2. Hint: Let Y
= (1 - (sqrt 5))/2. Use induction and the definition of the Fibonacci numbers (see 1.2.2) to prove
that Fib(n) = (X^n - Y^n)/(sqrt 5).

Firstly, how do we prove the above through induction, or to be much simpler, how do we prove
anything through induction?

Proving through induction looks like a domino of proofs. I say that because in induction proofing,
it mainly involves 4 components: the problem to be proved, the base case that needs to be proved
first, the assumption step, then the induction step. The previously mentioned components can then be
roughly boiled down to two main steps:

1. Prove the problem to be true using the base case.
2. Use 'induction' aka prove the problem to be true for 'base case + 1'.

(Note: What we’re trying to accomplish through induction proofing is to prove that the problem is
true for all natural numbers through proving the base case (which is 1) and building up from
there (adding 1))

In step 2 above, what it tries to say is that, if the 'problem' is proven true for the base case,
then proceed to assume that it will also be true for 'base case + 1' (and when 'base case + 1' is
also proven to be true, then 'base case + 1' + 1, should also be true):

Let’s proceed to step 1, which is to prove the base case, in our case, 1:

Fib(n) = (X^n - Y^n)/(sqrt 5) (where X is ≃ 1.618, and Y is ≃ -0.618)

Fib(1) = ((expt 1.618 1) - (expt -0.618 1))/(sqrt 5)

Fib(1) = 2.236/(sqrt 5)

Fib(1) = 1

According to the given definition of fib, then:

1 = 1

So, what’s next? We now proceed to step 2 of our induction proofing which is the actual induction
step itself (which I previously said was a 'rough boiling down' of some smaller components which
I'll discuss). For now, let’s assume that 'n' is a different number, let’s assume it to be 'r', and
'r' is also true in the same way that fib(n) is, which looks like:

Fib(r) = (X^r - Y^r)/(sqrt 5) 

Let’s proceed to the 'induction' step, and see what happens when we try our Fib function for (r +
1):

Fib (r + 1) = (X^(r + 1) - Y^(r + 1))/(sqrt 5)

Fib (2) = (X^2 - Y^2)/(sqrt 5)

Fib (2) = (2.618 - 0.382)/(sqrt 5)

Fib (2) = 2.236/(sqrt 5)

Fib (2) = 1

(+ (Fib 1)
   (Fib 0)) = 1

(+ 1
   0) = 1

1 = 1

If you’re not yet convinced, let’s assume that (r + 1) is d, then try the above for (d + 1):

Fib (d + 1) = (X^(d + 1) - Y^(d + 1))/(sqrt 5)

Fib (d + 1) = (X^3 - Y^3)/(sqrt 5)

Fib (d + 1) = (4.236 - -0.236)/(sqrt 5)

Fib (d + 1) = 4.472/(sqrt 5)

Fib (d + 1) = 2

(+ (Fib 2)
   (Fib 1)) = 2

(+ 1
   1) = 2

2 = 2

So, the main takeaway from the induction proofing is that, once the base case is proven to be true,
and if 'base case + 1' is proven to be true too, then rinse and repeat the process, and then you
have proof that the problem is true for all natural numbers.
|#

#lang sicp

(define (Fib n)
  (cond [(= n 0) 0]
        [(= n 1) 1]
        [else
         (+ (Fib (- n 1))
            (Fib (- n 2)))]))

(define (sqr n)
  (* n n))
