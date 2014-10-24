#lang racket

;; informally a set is simply a collection of
;; distinct objects. Its interface might be
;; represented by:
;; - union-set
;; - intersection-set
;; - element-of-set
;; - adjoin-set


;; For any set S and any object X, 
;;	(element-of-set? x (adjoint-set x S)) true.

;; For any set S and T and any object x,
;; (element-of-set? x (union-set S T)) equals
;; (or (element-of-set? x S) (element-of-set? x T))

;; For any object x,
;; (element-of-set? x '()) false.

#lang racket

;; Sets using Unordered Lists

(define (element-of-set? x set)
  (cond [(null? set) false]
        [(equal? x (car set)) true]
        [else (element-of-set? x (cdr set))]))

;; (define (adjoin-set x set)   ;; NOOO! DRY!!!!!
;;  (λ (x new-set)
;;    (cond [(null? set) (cons new-set x)]
;;          [(equal? (car new-set) x) set]
;;          [else (adjoin-set x (cdr new-set))])) x set)
  
(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

;; for intersection-set the idea is that we have a
;; base  case for the recursion (one of the sets
;; are empty), and a well defined iterative step.

(define (intersection-set a b)
  (cond [(or (null? a) (null? b)) '()]
        [(element-of-set? (car a) b)
         (cons (car a)
               (intersection-set (cdr a) b))]
        [else (intersection-set (cdr a) b)]))


;; Exercise 2.59 - Implement union-set


(define (append a b)
  (if (null? a)
      b   
      (cons (car a) 
            (append (cdr a) b))))

(define (union-set a b)
  (letrec ([c (append a b)]
           [uset (λ (set)
                   (if (null? set)
                       '()
                       (adjoin-set (car set) (uset (cdr set)))))])
    (uset c)))
           

(union-set '(1 2) '(3 2 5))


;; Exercise 2.60 What if we don't care about
;; duplicates?

;; If we don't care about duplicates we are then
;; dealing not more with set, but a vectors.
;; Addind something to the vector would take O(1)
;; while intersection-set would continue with
;; O(N^2) as we would maintain the element-of-set
;; iterator.


;; conclusion - THIS IS BAD: it takes O(n^2) for
;; intersection-set and union-set, O(n) for
;; element-of-set and also for adding (adjoin-
;; set). We could make this better.



(element-of-set? 'a '(1 2 a 3))
(adjoin-set 'a '(1 2 a 3))
