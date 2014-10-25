#lang racket

;; the square root of a number might be determined by using Newton's method of
;; successive approximations. We start with a guess Y for the value of the
;; square root of a number X, than perform a simple manipulation to get a better
;; guess by averaging y with x/y.

(define (sqrt x)
  (letrec ([average (λ (x y) (/ (+ x y) 2))]
           [square (λ (x) (* x x))]
           [improve (λ (guess x) (average guess (/ x guess)))]
           [good-enough? (λ (guess x) (< (abs (- x (square guess))) 0.001))])
    (define (sqrt-iter guess x)
      (if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))
    (sqrt-iter 1 x)))

(sqrt 4)

;; as we can see, simple: keep iterating until it gets into a good 
;; enough approximation
