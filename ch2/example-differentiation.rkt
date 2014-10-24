#lang racket

;; the idea will be: decompose the expression into
;; smaller and smaller pieces will eventually
;; produce pieces that are either constants or
;; variables, whose derivatives will be either 0
;; or 1.

#lang racket

;; numbers are not symbols

(define (variable? x)
  (symbol? x))

;; two variables are the same if their symbols match and they
;; actually are variables

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

;; a SUM and a PRODUCT will be lisp lists. These are the constructors

(define (make-sum a b)
  (list '+ a b))

(define (make-product a b)
  (list '* a b))

;; then we need some checkers

(define (sum? expr)
  (and (pair? expr) (eq? (car expr) '+)))

(define (product? expr)
  (and (pair? expr) (eq? (car expr) '*)))

;; and some getters

(define (second s)
  (cadr s))

(define (third s)
  (caddr s))

(define (addend s)
  (second s))

(define (augend s)
  (third s))

(define (multiplier p)
  (second p))

(define (multiplicand p)
  (third p))


;; derivative of a constant is 0
;; derivative of a single variable is 1
;; derivative of the sum is the sum of derivatives
;; derivative(u*v) = u(deriv(v)) + v(deriv(u))

(define (deriv exp var)
  (cond [(number? exp) 0]
        [(variable? exp) 
         (if (same-variable? exp var) 1 0)]
        [(sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var))]
        [(product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp)))]
        [else (error "unknown expression type -- DERIV" exp)]))

(deriv '(+ x 3) 'x)

;; TODO exercises
