#lang sicp

#| Exercise 1.12: The following pattern of numbers is called a Pascal’s Triangle:

     1
    1 1
   1 2 1
  1 3 3 1
 1 4 6 4 1

The numbers at the edge of the triangle are all 1, and each number inside the triangle is the sum of
the two numbers above it. Write a procedure that computes elements of Pascal’s triangle by means of
a recursive process.

Before proceeding to the elaboration of the solution itself, let’s present the code itself to act as
a primer for the code elaboration.
|#

(define (pascal n)
  (cond [(= n 1) '((1))]
        
        [else
         (cons-tail (next-pascal (car (my-reverse (pascal (- n 1)))))
                    (pascal (- n 1)))]))

(define (empty? n)
  (equal? '() n))

(define (my-reverse l)
  (if (empty? l)
      '()
      (cons-tail (car l)
                 (my-reverse (cdr l)))))

(define (next-pascal l)
  (define mod-list1 (cons-head-0 l))
  (define mod-list2 (cons-tail-0 l))
  (define (list-pair-add m1 m2)
    (if (empty? m1)
        '()
        (cons (+ (car m1) (car m2))
              (list-pair-add (cdr m1) (cdr m2)))))
  (list-pair-add mod-list1 mod-list2))

(define (cons-head-0 l)
  (cons 0 l))

(define (cons-tail-0 l)
  (if (empty? l)
      (cons 0 '())
      (cons (car l)
            (cons-tail-0 (cdr l)))))

(define (cons-tail n l)
  (if (empty? l)
      (cons n '())
      (cons (car l)
            (cons-tail n (cdr l)))))

#| From the problem statement, one could wonder about the appearance of the supposed computed
elements. Luckily, the problem provided us with a visualization plus the fact that 'inside' numbers
are formed through getting the sum of the two numbers above it.

Observe, again, the following structure:

     1
    1 1
   1 2 1
  1 3 3 1
 1 4 6 4 1

Notice that on the third row of the triangle we have this non-1 digit and that is the case because
the number is an 'inside' number. However, one could infer that the 1's from the second row onwards,
are also a sum of two numbers above it, and that is because on the first row, one could think, that
there are invisible 0's to the left and right of the 1, although that inferrence doesn’t apply to
the first 1 on the first row (and that'll now serve as the base case of our code).

Before we proceed to the actual code elaboration, let’s look at the problem from another
perspective. In the problem statement, it is stated that an inside number is the sum of the two
numbers above it. Remember that in the previous paragraph, I stated that one could infer that the
1's, from the second row onwards, are also the sum of the two numbers above them (the 1 and the
invisible 0).

Let's look at the second row of the triangle, for example. The first 1 is the sum of the 0 and 1,
respectively, that are above it, while the second 1 is the sum of 1 and 0. If we then add the first
pair of 0 and 1 to their counter-pair, 1 and 0, we ultimately get 1 and 1. Let’s illustrate that
process in the same way the pascal’s triangle in the original problem statement was illustrated:

  ? ?
+ ? ?
-----
  1 1

These two 1's are the result of the additions of some numbers, but what numbers are these? In the
first row of the triangle, there is only a single visible digit which is 1, but I also said that one
could infer that there are invisible 0's surrounding it. Knowing that, filling in the question marks
are now simply a task of replacing them with the 'above' numbers, hence:

  0 1
+ 1 0
-----
  1 1

So, for the next row, take the previous 'level' then plot them in a similar manner as above:

  0 1 1
+ 1 1 0
-------
  1 2 1

Now that we've established the 'other' perspective, let’s proceed to the actual elaboration of the
code. The first function takes an integer as an input and that integer is treated as the deepest
row-depth that the function will compute to. For simplicity we will be using lists, specifically
nested lists, to display our output in this manner (when main function is given 3 as an argument):

'((1) (1 1) (1 2 1))

or in #lang sicp:

(mcons (mcons 1 '()) (mcons (mcons 1 (mcons 1 '())) (mcons (mcons 1 (mcons 2 (mcons 1 '()))) '())))

The main helper functions we defined, which are built due to the previous inferrences, are a
function that appends a 0 to the head of the list (cons-head-0), a function that will append a 0 to
the tail of the list (cons-tail-0), and the function that will compute the next row (next-pascal)
based on the results of the previous row.

The other two functions not mentioned, cons-tail and my-reverse, are utility functions that adds an
element to the tail of the list (instead of cons’s normal behavior of appending it to the head) and
a function that reverses the order of the elements of the list (which we used to reverse the order
of (pascal (- n 1)) to get the first element of its result, which we then get its '(next-pascal)).
|#
