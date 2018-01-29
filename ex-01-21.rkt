#lang sicp

#| Exercise 1.21: Uzu la /smallest-divisor/ proceduron por serĉi la plej malgrandan dividanto de ĉiu
de la sekvaj numeroj: 199, 1999, 19999.

(smallest-divisor 199)

(find-divisor 199 2)

(find-divisor 199 3)

(find-divisor 199 4)

(find-divisor 199 5)

(find-divisor 199 6)

(find-divisor 199 7)

(find-divisor 199 8)

(find-divisor 199 9)

(find-divisor 199 10)

(find-divisor 199 11)

(find-divisor 199 12)

(find-divisor 199 13)

(find-divisor 199 14)

(find-divisor 199 15)

(cond ((> (square 15) 199) 
       199)
      ((divides? 15 199) 
       15)
      (else (find-divisor
             199 
               (+ 15 1))))

(cond ((> 225 199) 
       199)
      ((divides? 15 199) 
       15)
      (else (find-divisor
             199 
               (+ 15 1))))

199


(smallest-divisor 1999)

(find-divisor 1999 2)

(find-divisor 1999 3)

(find-divisor 1999 4)

(find-divisor 1999 5)

(find-divisor 1999 6)

(find-divisor 1999 7)

(find-divisor 1999 8)

(find-divisor 1999 9)

(find-divisor 1999 10)

(find-divisor 1999 11)

(find-divisor 1999 12)

(find-divisor 1999 13)

(find-divisor 1999 14)

(find-divisor 1999 15)

(find-divisor 1999 16)

(find-divisor 1999 17)

(find-divisor 1999 18)

(find-divisor 1999 19)

(find-divisor 1999 20)

(find-divisor 1999 21)

(find-divisor 1999 22)

(find-divisor 1999 23)

(find-divisor 1999 24)

(find-divisor 1999 25)

(find-divisor 1999 26)

(find-divisor 1999 27)

(find-divisor 1999 28)

(find-divisor 1999 29)

(find-divisor 1999 30)

(find-divisor 1999 31)

(find-divisor 1999 32)

(find-divisor 1999 33)

(find-divisor 1999 34)

(find-divisor 1999 35)

(find-divisor 1999 36)

(find-divisor 1999 37)

(find-divisor 1999 38)

(find-divisor 1999 39)

(find-divisor 1999 40)

(find-divisor 1999 41)

(find-divisor 1999 42)

(find-divisor 1999 43)

(find-divisor 1999 44)

(find-divisor 1999 45)

(cond ((> (square 45) 1999) 
       1999)
      ((divides? 45 1999) 
         45)
        (else (find-divisor 
               1999 
               (+ 45 1))))

(cond ((> 2025 1999) 
       1999)
      ((divides? 45 1999) 
         45)
        (else (find-divisor 
               1999 
               (+ 45 1))))

(cond ((> 2025 1999) 
       1999)
      ((divides? 45 1999) 
         45)
        (else (find-divisor 
               1999 
               (+ 45 1))))

(cond (#t
       1999)
      ((divides? 45 1999) 
         45)
        (else (find-divisor 
               1999 
               (+ 45 1))))

1999


(smallest-divisor 19999)

(find-divisor 19999 2)

(find-divisor 19999 3)

(find-divisor 19999 4)

(find-divisor 19999 5)

(find-divisor 19999 6)

(find-divisor 19999 7)

(cond ((> (square 7) 19999) 
         19999)
        ((divides? 7 19999) 
         7)
        (else (find-divisor 
               19999 
               (+ 7 1))))

(cond ((> 49 19999) 
         19999)
        ((divides? 7 19999) 
         7)
        (else (find-divisor 
               19999 
               (+ 7 1))))

(cond ((> 49 19999) 
         19999)
        ((divides? 7 19999) 
         7)
        (else (find-divisor 
               19999 
               (+ 7 1))))

(cond (#f 
         19999)
        ((divides? 7 19999) 
         7)
        (else (find-divisor 
               19999 
               (+ 7 1))))

(cond (#f 
         19999)
      ((= (remainder 19999 7) 0)
         7)
        (else (find-divisor 
               19999 
               (+ 7 1))))

(cond (#f 
         19999)
      ((= 0 0)
         7)
        (else (find-divisor 
               19999 
               (+ 7 1))))

(cond (#f 
         19999)
      (#t
         7)
        (else (find-divisor 
               19999 
               (+ 7 1))))

7

|#

(define (r n)
  (remainder 1999 n))

(define (square n)
  (* n n))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) 
         n)
        ((divides? test-divisor n) 
         test-divisor)
        (else (find-divisor 
               n 
               (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

