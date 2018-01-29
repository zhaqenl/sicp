#lang sicp

#| Exercise 1.16: Design a procedure that evolved an iterative exponentiation process that uses
successive squaring and uses a logarithmic number of steps, as does fast-expt. (Hint: Using the
observation that (b^(/ n 2)^2) = (b^2)^(/ n 2), keep, along with the exponent n and the base b, an
additional state variable a, and define the state transformation in such a way that the product ab^n
is unchanged from state to state. At the beginning of the process a is taken to be 1, and the answer
is given by the value of a at the end of the process. In general, the technique of defining an
invariant quantity that remains unchanged from state to state is a powerful way to think about the
design of an iterative algorithms.)

Ekzerco 1,16: Dizajnu proceduron ke, evoluis iteracian potencigan procezon ke, uzas intersekvan
kvarobligadon kaj uzas logaritman nombron da paŝoj, kiam faras /fast-expt/. (Konsileto: Uzi la
observadon ke (b^(/ n 2)^2) = (b^2)^(/ n 2), tenu, kune kun la eksponenta /n/ kaj la potencigato
/b/, aldonan statan variablon /a/, kaj precizigu la statan aliiĝon tiel ke, la produta /ab^n/ estas
senŝanĝa el stato al stato. Al la deveno de la procezo, /a/ estas 1, kaj la respondo estas donita
per la valoro de /a/ al la fino de procezo. Ĝenerale, la teĥniko de precizigi invariantan nombron
kiu restas nesanĝita de stato al stato, estas potenca maniero por pensi pri la aspektigon de
iteracia algoritmo.)  
|#

#|As a starter, let’s layout the code structure of the previous versions of the exponent function
under 1.2.4.: 
|#

;;; Recursive with O(n) of growth (in both space and steps)
(define (my-exp b n)
  (cond [(= n 0) 1]
        [else
         (* b (my-exp b (- n 1)))]))

;;; Iterative with O(n) of growth in steps and O(1) of growth in space 
(define (i-my-exp b n)
  (define (i-exp b n a)
    (cond [(= n 0) a]
          [else
           (i-exp b 
                  (- n 1)
                  (* b a))]))
  (i-exp b n 1))

(define (square s)
  (* s s))

(define (even? n)
  (integer? (/ n 2)))

;;; Recursive with O(log n) of growth
(define (my-f-exp b n)
  (cond [(= n 0) 1]
        [(even? n)
         (square (my-f-exp b (/ n 2)))]
        [else
         (* b (my-f-exp b (- n 1)))]))

#| According to the problem statement, we are tasked to create the iterative version of the above
recursive version. Immediately, one of the first options that pops to mind is to take the iterative
version of the initial expt function, then proceed from there:

(define (i-my-exp b n)
  (define (i-exp b n a)
    (cond [(= n 0) a]
          [else
           (i-exp b
                  (- n 1)
                  (* b a))]))
  (i-exp b n 1))

What makes the iterative version of the initial expt function to have O(log n) of growth is, it uses
the fact that, 5^n is equal to the square of 5^n/2, if n is an even number. Therefore, adding a
check for even-numbered exponents is ideal to reduce the growth of space to O(log n):

(define (i-my-exp b n)
  (define (i-exp b n a)
    (cond [(= n 0) a]
          [(even? n)
           ...]
          [else
           (i-exp b
                  (- n 1)
                  (* b a))]))
  (i-exp b n 1))

Our next task is to fill in the blanks of '...'. Looking at how the iterative version of the
previous expt functions were derived, one might be tempted to go for:

(i-exp b
       (/ n 2)
       (square a))

However, it won’t be that simple, and one would realize quickly because giving the function an
even-numbered 'n' argument (initially) simply will not work because the supposed-to-be new value of
'a' didn’t change at all because the square of '1' is still 1 (it will work for odd-numbered
arguments because the state change of the third argument is a multiplication of 'b' by the initial
value of 'a' which is '1').

However, again, through reading the problem statement carefully, one can find the solution to the
problem rather quickly. The hint is that, (b ^ 2) ^ (/ n 2) is equal to (b ^ (/ n 2)) ^ 2. Our
initial approach sort of utilized the latter one. However, we realized that when given an even
number as an 'n' argument initially, we find out it doesn’t increment the 'a' argument the way we
want it to, for the next iteration. So, the problem now is how to increment the 'a' argument for the
next iteration. Let’s look again at the fact that, (b ^ 2) ^ (/ n 2) is equal to (b ^ (/ n 2)) ^
2. The next step is to translate into code the former approach:

(i-exp (square b)
       (/ n 2)
       a)

We return the 'a' as-is for the third argument, because for even-numbered 'n' arguments, the
essential information needed for the next iteration is already fulfilled, namely the squaring of the
base number and the division by 2 of the exponent, and we leave the rest (odd-numbered n's) to the
'else' clause of our function:

(define (i-my-exp b n)
  (define (i-exp b n a)
    (cond [(= n 0) a]
          [(even? n)
           (i-exp (square b)
                  (/ n 2)
                  a)]
          [else
           (i-exp b
                  (- n 1)
                  (* b a))]))
  (i-exp b n 1))

|#

;;; Iterative with O(log n) of growth of space and steps
(define (i-f-exp b n)
  (define (i-exp b n a)
    (cond [(= n 0) a]
          [(even? n)
           (i-exp (square b)
                  (/ n 2)
                  a)]
          [else
           (i-exp b
                  (- n 1)
                  (* b a))]))
  (i-exp b n 1))


