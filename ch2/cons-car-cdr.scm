#lang scheme

(define (cons x y)
  (lambda (m)
     (cond ((= m 0) x)
           ((= m 1) y)
           (else (error "cons - Argument not 0 or 1" m)))))

(define (car x)
  (x 0))

(define (cdr x)
  (x 1))

; or ...

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q )))
