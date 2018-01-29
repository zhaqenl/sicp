#lang sicp

#| Exercise 1.11: A function f is defined by the rule that (f n) = n, if n < 3, and (f n) = f(n - 1)
+ 2f(n - 2) + 3f(n - 3) if n >= 3. Write a procedure that computes f by means of a recursive
process. Write a procedure that computes f by means of an iterative process.

The recursive process can be derived straight from translating the mathematical definition to code,
through converting it from infix notation to prefix notation, while respecting the rules of
syntax and semantics of the programming language in use, in our case, Scheme:

(define (f n)
  (cond [(< n 3) n]
        [(>= n 3)
         (+ (f (- n 1))
            (* 2 (f (- n 2)))
            (* 3 (f (- n 3))))]))

Before we get to the actual refactoring of the recursive process of the previously presented example
to an iterative process version, let’s discuss first a simpler example that aims to set the stage
for thinking “iteratively”. 

The iterative version of the function in the question, however, requires a bit more degree of focus
and pattern recognition in order for it to materialize because simply refactoring the recursive
process version of the code to an iterative one based on the refactoring of the example I’m about to
show you will lead to a nested recursion that defeats the purpose of refactoring the code in the
first place. To start off, we’ll use a generic example for demonstrating an iterative process:

(define (f n)
  (define (f1 n acc)
    (cond [(= n 0) acc]
          [else
           (f1 (- n 1) (* n acc))]))
  (f1 n 1))

As you may or may not recognize at first sight, this is the factorial function’s iterative version.
Evaluating (f 5) shows the following behavior (I’ll just show the values that are passed to the next
iteration):

(f 5)

(f1 5 1)

(f1 4 5)

(f1 3 20)

(f1 2 60)

(f1 1 120)

(f1 0 120)

120

In the refactoring from a recursive process to an iterative one, we’ll provide an additional
argument to a function which will store the previous iteration’s values (because the main difference
between a recursive process and an iterative one is the absence of deferred calculations or
calculations which need to be suspended later until the recursive process’s base case is reached; we
instead pass a premature value as the next iteration’s stepping stone) and now use that
“newly-stored” value as the next iteration’s acc argument (or as its new base case, to be
specific). 

In our case, we provided 1 as the acc argument to f1. The 1 we pass to f1 as the second argument
acts as the function’s base case (because in the original recursive process of factorial, we
decrement the n argument until n reaches 0, which will then return 1 as base case because 0! is 1).

Now back to our factorial’s iterative version, one tip is to visualize what the iteration steps are
going to look like and observing the evaluation of its recursive process counterpart. In the
recursive process, evaluating (f 5) looks like: (* 5 (* 4 (* 3 (* 2 (* 1 (f 0)))))) where (f 0) is
equal to 1. Both processes look similar in a way because instead of the recursive process’s
inside-out multiplication, the iterative process goes from the outside to the inside when comparing
how both processes get to the point where they return 120 (speaking from a commutative property of
multiplication’s perspective).

In the else clause of f1, in its second argument, this is where we build the number we’ll
return. Similar to the recursive process, the reason why we provide 1 as f1’s default second
argument is because in the recursive process, if you set the base case as anything aside from 1,
what you’re essentially doing is changing the mathematical fact that the factorial of 0 is anything
but 1. What also happens is, the second to the last number (the one before reaching the base case) will get
multiplied by the modified base case (in (f 5)’s case, instead of 120, you will get 240 if you set
the base case as 2 (120 * 2) instead of multiplying 120 by 1 at the last step (when taken a look at
from the commutative property’s perspective)(and because that’s just how the factorial mathematical
function works, (f 0) is 1, no matter what.)).

So, to summarize what happens on the two quite different forms of process, in (* 5 (* 4 (* 3 (* 2 (*
1 (f 0)))))), we have to evaluate *’s arguments first to become operands the primitive function can
utilize because of the applicative order of evaluation.

(* 5 (* 4 (* 3 (* 2 (* 1 (f 0))))))

(* 5 (* 4 (* 3 (* 2 (* 1 1)))))

(* 5 (* 4 (* 3 (* 2 1))))

(* 5 (* 4 (* 3 2)))

(* 5 (* 4 6))

(* 5 24)

120

Compare the above to the evaluation of the iterative version and you’ll quickly notice that they’re
quite doing the same thing but in reverse order. It multiplies 5 and 4 first then multiplies the
result of that to 3 then so on (hence the (* n acc) in the else clause of f1, check it).

Let’s proceed to discussing the refactoring of the function in the question to an iterative version.
To make things easier, let’s re-state the hints in the problem. It states that in (f n), if the
given n is less than 3, then give back n as a result (this means (f 0) is 0, (f 1) is 1, and (f 2)
is 2). However, if n is anything but < 3, it goes like (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n
3)))). As previously discussed, attempting to refactor the recursive process version of the code to
the iterative version just by looking at how the factorial iterative process was extracted from the
recursive process version, you’re going to end up pretty much frustrated because of nested
recursions inside the arguments of the function even though it’s at tail position. 

How do we, then, compute (f n) if the given n is not < 3? For example, how do we compute (f 3)?
Let’s try evaluating it by substituting it inside the body of the previously defined function:

(f 3)

(+ (f (- 3 1)) (* 2 (f (- 3 2))) (* 3 (f (- 3 3))))

(+ (f 2) (* 2 (f (- 3 2))) (* 3 (f (- 3 3))))

(+ (f 2) (* 2 (f 1)) (* 3 (f (- 3 3))))

(+ (f 2) (* 2 (f 1)) (* 3 (f 0)))

Hm, let’s stop right here for a moment. Notice that before we stopped, somewhere inside the parens,
we somehow ended up with (f 2), (f 1), and (f 0), which are the cases for when n is < 3. This means
that to compute (f 3), all that’s left to do is to get the sum of (f 2), (* 2 (f 1)), and (* 3 (f
0)). Since the stage is set and the crucial hints are discussed, here is the final form of the code,
which should be less tricky to understand and absorb now:

(define (f n)
  (define (my-f2 a b c acc)
    (cond [(< a 3) acc]
          [else
           (my-f2 (- a 1)
                  c
                  acc
                  (+ acc (* 2 c) (* 3 b)))]))
  (cond [(< n 3) n]
        [else
         (my-f2 n 0 1 2)]))

First, when we give my-f1 an argument that is less than 3, it will return that argument back. If the
argument is greater than or equal to 3, we proceed to our else clause that sends us to our helper
function, whose arguments contain the n we give it and the cases for when (f (< n 3)). As a
refresher, why do we do that again? Remember that evaluating (f 3) will give us (f 2), (f 1), and (f
0) whose results we pass as arguments to our helper function and to compute (f 4) and larger
numbers, at the very least, we have to compute (f 3).

Inside our helper function, we have to provide a termination case that when n dips below 3 (which it
will, eventually, because we will be decrementing it by 1 per iteration), we now give back our
accumulated value. Now, why do you ask that we check if a < 3 if we’re already checking beforehand
whether n is less than 3? That is just to force us to go to our helper’s else clause initially, and
more importantly, as I said previously, it will serve as our termination case. Before we proceed
further, let’s evaluate (f 3):

(f 3)

(my-f2 3 0 1 2)

(my-f2 2 1 2 4)

4

As we give my-f2 3 as the n argument, alongside it are 0, 1, and 2, which we will be needing to
increment our acc argument through (+ acc (* 2 c) (* 3 b)) which is just translated from (+ (f 2) (*
2 (f 1)) (* 3 (f 0))).

(Notice that before we yield the result 4, the arguments of my-f2 after 2 are 1, 2, and 4
respectively, and you’ll also notice that substituting them inside (+ acc (* 2 c) (* 3 b)) will
yield to 11, which is the result of evaluating (f 4) because what happens is, for every iteration,
the initial values 0, 1, and 2, increase (through a behavior similar to bit shifting as you can
observe in the else clause of my-f2), so that it could accomodate for the larger n values but in our
example, as we only used 3, so we only iterated once)

Evaluating (f 4) yields the following:

(my-f2 4 0 1 2)

(my-f2 3 1 2 4)

(my-f2 2 2 4 11)

11
|#






