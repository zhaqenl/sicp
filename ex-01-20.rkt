#lang sicp

#| Exercise 1.20: The process that a procedure generates is of course dependent on the rules used by
the interpreter. As an example, consider the iterative gcd procedure given above. Suppose we were to
interpret this procedure using normal-order evaluation, as discussed in 1.1.5. (The
                                                                                normal-order-evaluation rule for if is described in Exercise 1.5.) Using the substitution method
(for normal order), illustrate the process generated in evaluating (gcd 206 40) and indicate the
remainder operations that are actually performed. How many remainder operations are actually
performed in the normal-order evaluation of (gcd 206 40)? In the applicative-order evaluation?


(define (gcd a b) 
  (if (= b 0) 
      a 
      (gcd b (remainder a b))))

(gcd 206 40)

(if (= 40 0) 
    206 
    (gcd 40 
         (remainder 206 
                    40)))

;1
(gcd 40 
     (remainder 206 
                40))

(gcd 40 6)

(if (= 6 0) 
    40 
    (gcd 6 
         (remainder 40 
                    6)))

;2
(gcd 6 
     (remainder 40 
                6))

(gcd 6 4)

(if (= 4 0) 
    6 
    (gcd 2 
         (remainder 6 
                    4)))

;3                                        
(gcd 2 
     (remainder 6 
                4))

(gcd 2 0)

(if (= 0 0) 
    2 
    (gcd 0 
         (remainder 2 
                    0)))

2


En la ekzemplo supre, kiam ni provis la /applicative-order/ version, ni povas vidi, ke mi faris la
`remainder` funkcion ekzakte trifoje.

Sekve, ni nun provos elvolvi la saman funkcion, tamen, nun, ni elvolvos la funkcion dum uzas la
/normal-order/ version de nia koda elvolvo:


(gcd 206 40)

(if (= 40 0) 
    206 
    (gcd 40 
         (remainder 206 
                    40)))

(gcd 40 
     (remainder 206 
                40))

;1                                        
(if (= (remainder 206 
                  40) 0)
    40 
    (gcd (remainder 206 
                    40) 
         (remainder 40 
                    (remainder 206 
                               40))))

(if (= 6 0) 
    40 
    (gcd (remainder 206 
                    40) 
         (remainder 40 
                    (remainder 206 
                               40))))

(if #f 
    40 
    (gcd (remainder 206 
                    40) 
         (remainder 40 
                    (remainder 206 
                               40))))

(gcd (remainder 206 
                40) 
     (remainder 40 
                (remainder 206 
                           40)))

;2                                        
(if (= (remainder 40 
                  (remainder 206 
                             40)) 0)
    (remainder 206 
               40) 
    (gcd (remainder 40 
                    (remainder 206 
                               40))
         (remainder (remainder 206 
                               40) 
                    (remainder 40 
                               (remainder 206 
                                          40)))))

;3                                        
(if (= (remainder 40 
                  6) 0)
    (remainder 206 
               40) 
    (gcd (remainder 40 
                    (remainder 206 
                               40)) 
         (remainder (remainder 206 
                               40) 
                    (remainder 40 
                               (remainder 206 
                                          40)))))

(if (= 4 0) 
    (remainder 206 
               40) 
    (gcd (remainder 40 
                    (remainder 206 
                               40)) 
         (remainder (remainder 206 
                               40)
                    (remainder 40 
                               (remainder 206 
                                          40)))))

(if #f 
    (remainder 206 
               40) 
    (gcd (remainder 40 
                    (remainder 206 
                               40)) 
         (remainder (remainder 206 
                               40)
                    (remainder 40 
                               (remainder 206 
                                          40)))))

(gcd (remainder 40 
                (remainder 206 
                           40)) 
     (remainder (remainder 206 
                           40) 
                (remainder 40 
                           (remainder 206
                                      40))))

;4                                        
(if (= (remainder (remainder 206 
                             40) 
                  (remainder 40 
                             (remainder 206 
                                        40))) 0)
    (remainder 40
               (remainder 206 
                          40)) 
    (gcd (remainder (remainder 206 
                               40) 
                    (remainder 40 
                               (remainder 206 
                                          40))) 
         (remainder (remainder 40 
                               (remainder 206 
                                          40)) 
                    (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206
                                                     40))))))

;5                                        
(if (= (remainder 6 
                  (remainder 40 
                             (remainder 206 
                                        40))) 0)
    (remainder 40 
               (remainder 206 
                          40)) 
    (gcd (remainder (remainder 206 
                               40) 
                    (remainder 40 
                               (remainder 206 
                                          40))) 
         (remainder (remainder 40 
                               (remainder 206 
                                          40)) 
                    (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206 
                                                     40))))))

;6                                        
(if (= (remainder 6 
                  (remainder 40 
                             6)) 0)  
    (remainder 40 
               (remainder 206 
                          40)) 
    (gcd (remainder (remainder 206 
                               40) 
                    (remainder 40 
                               (remainder 206 
                                          40))) 
         (remainder (remainder 40 
                               (remainder 206 
                                          40))
                    (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206 
                                                     40))))))

;7                                        
(if (= (remainder 6 
                  4) 0) 
    (remainder 40 
               (remainder 206 
                          40)) 
    (gcd (remainder (remainder 206 
                               40)
                    (remainder 40 
                               (remainder 206 
                                          40))) 
         (remainder (remainder 40 
                               (remainder 206 
                                          40)) 
                    (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206 
                                                     40))))))

(if (= 2 0) 
    (remainder 40 
               (remainder 206 
                          40)) 
    (gcd (remainder (remainder 206 
                               40) 
                    (remainder 40
                               (remainder 206 
                                          40))) 
         (remainder (remainder 40 
                               (remainder 206 
                                          40)) 
                    (remainder (remainder 206 
                                          40)
                               (remainder 40 
                                          (remainder 206 
                                                     40))))))

(if #f 
    (remainder 40 
               (remainder 206 
                          40)) 
    (gcd (remainder (remainder 206 
                               40) 
                    (remainder 40 
                               (remainder 206 
                                          40))) 
         (remainder (remainder 40 
                               (remainder 206 
                                          40)) 
                    (remainder (remainder 206 
                                          40) 
                               (remainder 40
                                          (remainder 206 
                                                     40))))))

(gcd (remainder (remainder 206 
                           40) 
                (remainder 40 
                           (remainder 206 
                                      40))) 
     (remainder (remainder 40
                           (remainder 206 
                                      40)) 
                (remainder (remainder 206 
                                      40) 
                           (remainder 40 
                                      (remainder 206 
                                                 40)))))

;8                                        
(if (= (remainder (remainder 40 
                             (remainder 206 
                                        40)) 
                  (remainder (remainder 206 
                                        40) 
                             (remainder 40
                                        (remainder 206 
                                                   40)))) 0) 
    (remainder (remainder 206 
                          40) 
               (remainder 40 
                          (remainder 206 
                                     40))) 
    (gcd (remainder (remainder 40 
                               (remainder 206 
                                          40)) 
                    (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206 
                                                     40)))) 
         (remainder (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206 
                                                     40))) 
                    (remainder (remainder 40 
                                          (remainder 206 
                                                     40)) 
                               (remainder (remainder 206 
                                                     40) 
                                          (remainder 40 
                                                     (remainder 206
                                                                40)))))))
;9 
(if (= (remainder (remainder 40 
                             6) 
                  (remainder (remainder 206 
                                        40) 
                             (remainder 40 
                                        (remainder 206 
                                                   40)))) 0) 
    (remainder (remainder 206 
                          40) 
               (remainder 40 
                          (remainder 206 
                                     40))) 
    (gcd (remainder (remainder 40
                               (remainder 206 
                                          40)) 
                    (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206 
                                                     40)))) 
         (remainder (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206 
                                                     40))) 
                    (remainder (remainder 40 
                                          (remainder 206 
                                                     40)) 
                               (remainder (remainder 206 
                                                     40) 
                                          (remainder 40 
                                                     (remainder 206 
                                                                40)))))))

;10
(if (= (remainder 4 
                  (remainder (remainder 206 
                                        40) 
                             (remainder 40 
                                        (remainder 206 
                                                   40)))) 0) 
    (remainder (remainder 206 
                          40) 
               (remainder 40 
                          (remainder 206 
                                     40))) 
    (gcd (remainder (remainder 40
                               (remainder 206 
                                          40)) 
                    (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206 
                                                     40)))) 
         (remainder (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206 
                                                     40))) 
                    (remainder (remainder 40 
                                          (remainder 206 
                                                     40)) 
                               (remainder (remainder 206 
                                                     40) 
                                          (remainder 40 
                                                     (remainder 206 
                                                                40)))))))
;11
(if (= (remainder 4 
                  (remainder 6 
                             (remainder 40 
                                        (remainder 206 
                                                   40)))) 0)  
    (remainder (remainder 206 
                          40) 
               (remainder 40 
                          (remainder 206 
                                     40))) 
    (gcd (remainder (remainder 40 
                               (remainder 206 
                                          40))
                    (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206 
                                                     40)))) 
         (remainder (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206 
                                                     40))) 
                    (remainder (remainder 40 
                                          (remainder 206 
                                                     40)) 
                               (remainder (remainder 206 
                                                     40) 
                                          (remainder 40 
                                                     (remainder 206 
                                                                40)))))))

;12
(if (= (remainder 4 
                  (remainder 6 
                             (remainder 40 
                                        6))) 0)  
    (remainder (remainder 206 
                          40) (remainder 40 
                                         (remainder 206 
                                                    40))) 
    (gcd (remainder (remainder 40 
                               (remainder 206 
                                          40))
                    (remainder (remainder 206
                                          40) (remainder 40 
                                                         (remainder 206 
                                                                    40)))) 
         (remainder (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206 
                                                     40))) 
                    (remainder (remainder 40 
                                          (remainder 206 
                                                     40))
                               (remainder (remainder 206 
                                                     40) 
                                          (remainder 40 
                                                     (remainder 206 
                                                                40)))))))

;13
(if (= (remainder 4 
                  (remainder 6 
                             4)) 0)  
    (remainder (remainder 206 
                          40) 
               (remainder 40 (remainder 206 
                                        40))) 
    (gcd (remainder (remainder 40 
                               (remainder 206 
                                          40)) 
                    (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206 
                                                     40)))) 
         (remainder (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206 
                                                     40)))
                    (remainder (remainder 40 
                                          (remainder 206 
                                                     40)) 
                               (remainder (remainder 206 
                                                     40) 
                                          (remainder 40 
                                                     (remainder 206 
                                                                40)))))))

;14
(if (= (remainder 4 
                  2) 0)  
    (remainder (remainder 206 
                          40) 
               (remainder 40 
                          (remainder 206 
                                     40))) 
    (gcd (remainder (remainder 40 
                               (remainder 206 
                                          40)) 
                    (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206 
                                                     40))))
         (remainder (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206 
                                                     40)))
                    (remainder (remainder 40 
                                          (remainder 206 
                                                     40)) 
                               (remainder (remainder 206 
                                                     40) 
                                          (remainder 40 
                                                     (remainder 206 
                                                                40)))))))

(if (= 0 0) (remainder (remainder 206 
                                  40) (remainder 40 
                                                 (remainder 206 
                                                            40))) 
    (gcd (remainder (remainder 40 
                               (remainder 206 
                                          40)) 
                    (remainder (remainder 206 
                                          40) (remainder 40 
                                                         (remainder 206 
                                                                       40))))
         (remainder (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206 
                                                     40))) 
                    (remainder (remainder 40 
                                          (remainder 206 
                                                     40)) 
                               (remainder (remainder 206 
                                                     40) 
                                          (remainder 40 
                                                     (remainder 206 
                                                                40)))))))

(if #t 
    (remainder (remainder 206 
                          40) 
               (remainder 40 
                          (remainder 206 
                                     40)))
    (gcd (remainder (remainder 40 
                               (remainder 206 
                                          40))
                    (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206 
                                                     40)))) 
         (remainder (remainder (remainder 206 
                                          40) 
                               (remainder 40 
                                          (remainder 206 
                                                     40))) 
                    (remainder (remainder 40 
                                          (remainder 206 
                                                     40)) 
                               (remainder (remainder 206 
                                                     40)
                                          (remainder 40 
                                                     (remainder 206 
                                                                40)))))))

;15
(remainder (remainder 206 
                      40) 
           (remainder 40 
                      (remainder 206 
                                 40))) 

;16
(remainder 6 
           (remainder 40 
                      (remainder 206 
                                 40))) 

;17
(remainder 6 
           (remainder 40 
                      6)) 

;18
(remainder 6 
           4) 

2

Kiam vi povas vidi en la alia ekzemplo supre, ni povas vidi, ke ni bezonas fari la `remainder`
funckio dekok-foje, por akiri la finan rezulton de nia funkcio.
|#
