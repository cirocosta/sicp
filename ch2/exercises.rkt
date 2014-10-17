#lang racket

;; utils

(define (list-equal? a b)
  (if (null? (cdr a))
      (= (car a) (car b))
      (list-equal? (cdr a) (cdr b))))

(define (equals a b)
  (cond [(number? a) (= a b)]
        [(null? a) (null? b)]
        [(list? a) (list-equal? a b)]))

(define (map proc items)
  (if (null? items)
      null
      (cons (proc (car items))
            (map proc (cdr items)))))


;; exercise 2.17

(define (last-pair items)
  (if (null? (cdr items))
      (car items)
      (last-pair (cdr items))))

;; exercise 2.18

(define (reverse items)
  (if (null? items)
      '()
      (cons (reverse (cdr items)) (car items))))

;; exercise 2.20


(define (filter pred items)
  (if (null? items)
      null
      (let ([x (car items)])
        (if (pred x)
            (cons x (filter pred (cdr items)))
            (filter pred (cdr items))))))


(filter (λ (x) (< x 3)) '(1 2 3 4 5))
(filter even? '(1 2 3 4 5 6))


(define (same-parity f . l)
  (letrec ([is-even (lambda (x) (= 0 (remainder x 2)))]
           [is-odd (lambda (x) (not (is-even x)))])
    (if (is-even f)
        (filter is-even (cons f l))
        (filter is-odd (cons f l)))))

(same-parity 1 2 3 4 5 6)
(same-parity 10 2 3 4 5 6)



;; Exercise 2.21

(define (square-list items)
  (map (λ (x) (* x x)) items))

(equals '(1 4 9 16) (square-list '(1 2 3 4)))


;; Exercise 2.23

(define (for-each proc items)
  (if (null? items)
      null
      (begin
        (proc (car items))
        (for-each proc (cdr items)))))
  

(for-each (λ (x) (newline) (display x))
          (list 1 2 3 4))



(equals '() (reverse '()))
;; (equals (list null 3 2 1) (reverse (list 1 2 3)))
(equals 34 (last-pair (list 23 72 149 34)))
(equals (list 1 2 3) (list 1 2 3))
(not (equals (list 1 2 3) (list 4 5 6)))












#lang racket

;; Exercises 2.30 2.31

;; the idea of mapping a tree is that we are not only going
;; to recurse linearly, cdr-ing, but will also perform the check
;; in depth, car-ing till we go to a leaf and then actually perform
;; the transformation that we want.
(define (map-tree proc tree)
  (let ([is-leaf (λ (x) (not (pair? x)))])
    (cond [(null? tree) null]
          [(is-leaf tree) (proc tree)]
          [else (cons (map-tree proc (car tree))
                      (map-tree proc (cdr tree)))])))

(define (count-leaves items)
  (let ([is-leaf (λ (x) (not (pair? x)))])
    (cond [(null? items) 0]
          [(is-leaf items) 1]
          [else (+ (count-leaves (car items))
                   (count-leaves (cdr items)))])))

;; not that appending will work as well for trees as we are not 
;; actually taking care of the kind of element that the sequence
;; contains
(define (list-append a b)
  (if (null? a)
      b
      (cons (car a) (list-append (cdr a) b)))) 


(count-leaves (cons (list 1 2) (list 3 4)))

(define x (list 1 (list 2 3)))
(define y (list 4 5 6))

(list-append x y)

;; Exercises 2.32

;; //TODO























