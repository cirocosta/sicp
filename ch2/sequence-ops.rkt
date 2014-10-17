#lang racket

(define (map proc items)
  (if (null? items)
      null
      (cons (proc (car items)) 
            (map proc (cdr items)))))

(define (map-tree proc tree)
  (let ([is-leaf (λ (x) (not (pair? x)))])
    (cond [(null? tree) null]
          [(is-leaf tree) (proc tree)]
          [else (cons (map-tree proc (car tree))
                      (map-tree proc (cdr tree)))])))

(define (filter pred items)
  (if (null? items)
      null
      (if (pred (car items))
          (cons (car items) (filter pred (cdr items)))
          (filter pred (cdr items)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-range from to)
  (

(map  (λ (x) (* x x)) '(1 2 3))
(map-tree  (λ (x) (* x x)) (list 1 (list 2 3)))
(filter even? '(1 2 3 4))
(accumulate + 0 '(1 2 3 4))











