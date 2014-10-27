#lang racket

;; Exercise 3.1

(define (make-accumulator initial)
  (λ (inc)
    ((λ ()
      (set! initial (+ initial inc))
      initial))))

;; Exercise 3.2

(define (make-monitored func)
  (let ([counter (make-accumulator 0)])
    (λ (inp)
      (if (eq? inp 'how-many-calls?)
          (counter 0)
          ((λ ()
             (counter 1)
             (func inp)))))))



(define balance 1000)
(define (withdraw amount)
  (if (>= balance amount)
      (begin
        (set! balance (- balance amount))
        balance)
      "Insufficient funds!"))

;; instead of relying on instantiate a global variable and
;; then using it from the withdraw (supposing that the name
;; matches), we create a function factory that will generate
;; an apply procedure to be used for withdrawing from its
;; internal balance.
(define (new-withdraw initial-amount)
  (let ([balance initial-amount])
    (λ (amount)
      (if (>= balance amount)
          ((λ ()
             (set! balance (- balance amount))
             balance))
          "Insufficient funds!"))))

;; we don't actually need to rely on let.

(define (new-withd balance)
  (λ (amount)
    (if (>= balance amount)
        ((λ ()
           (set! balance (- balance amount))
           balance))
        "Insufficient funds!")))

;; What if we'd like to actually create somethign that
;; represents an Account (like an object)? We just need
;; a lookup function that will get a method inside its
;; environment.

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        ((λ ()
           (set! balance (- balance amount))
           balance))
        "Insufficient Funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (λ (m)
    (cond [(eq? m 'withdraw) withdraw]
          [(eq? m 'deposit) deposit]
          [else (error "Unknown Request -- MAKE-ACCOUNT" m)])))

;; Exercise 3.3

(define (make-protected-account balance passwd)
  (define (withdraw amount)
    (if (>= balance amount)
        ((λ ()
           (set! balance (- balance amount))
           balance))
        "Insufficient Funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (λ (i-pass i-func)
    (cond [(not (eq? i-pass passwd)) (λ (inp) "Incorrect PWD")]
          [(eq? i-func 'withdraw) withdraw]
          [(eq? i-func 'deposit) deposit]
          [else 
           (error "Unknown Request -- MAKE-ACCOUNT" i-func)])))




