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


;; Now with an ORDERED List 

#lang racket

;; as we know that the set is ordered, we no
;; longer need to search through the entire set
;; (not talking about worst case). On the average
;; we are going to take O(n/2)
(define (element-of-set? x set)
  (cond [(null? set) false]
        [(= x (car set)) true]
        [(< x (car set)) false]
        [else (element-of-set? x (cdr set))]))


;; the idea here is somewhat similar to what we do
;; in the merge-sort algorithm where we have some
;; sort of 'two pointers' and then move them
;; acordingly when doing the merge process.

;; from the book:

;; Begin by comparing the initial elements, x1 and
;; x2, of the two sets. If x1 equals x2, then that
;; gives an element of the intersection, and the
;; rest of the intersection is the intersection of
;; the cdrs of the two sets. Suppose, however,
;; that x1 is less than x2. Since x2 is the
;; smallest element in set2, we can immediately
;; conclude that x1 cannot appear anywhere in set2
;; and hence is not in the intersection. Hence,
;; the intersection is equal to the intersection
;; of set2 with the cdr of set1. Similarly, if x2
;; is less than x1, then the intersection is given
;; by the intersection of set1 with the cdr of
;; set2

(define (intersection-set a b)
  (if (or (null? a) (null? b))
      '()
      (let ([x1 (car a)] [x2 (car b)])
        (cond [(= x1 x2)
               (cons x1 (intersection-set (cdr a)
                                          (cdr b)))]
              [(< x1 x2)
               (intersection-set (cdr a) b)]
              [(< x2 x1)
               (intersection-set a (cdr b))]))))

;; such improve! Now we are dealing with o(n) :)


;; sets as binary trees

;; If now we represent our data structure with a
;; binary tree we are not able to reduce even more
;; the look-up time to o(log(n)).

#lang racket

(define (entry tree)
  (car tree))

(define (left-branch tree)
  (cadr tree))

(define (right-branch tree)
  (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

;; the strategy for the look-up of a variable is as follows:
;; if the entry of the tree that we are looking equals the number
;; we are searching, then return true, otherwise, jump to the tree
;; depending if the entry is greater or minor than the x.
(define (element-of-set? x set)
  (cond [(null? set) false]
        [(= x (entry set)) true]
        [(< x (entry set))
         (element-of-set? x (left-branch set))]
        [(> x (entry set))
         (element-of-set? x (right-branch set))]))


;; For adjoining a X to a set is somewhat similar to the element-of-set procedure.
;; Actually, the asymp time is almost equal (o(log n)). The approach is:
;; not considering the trivial case, find in which branch the value will 
;; go and then keep accumulating regarding that (accumulate with make-tree).
(define (adjoin-set x set)
  (cond [(null? set) (make-tree x '() '())]
        [(= x (entry set)) set]
        [(< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set))]
        [(> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set)))]))

;; we need to remember something from DS classes: o(log n) is average time, i.e,
;; for balanced trees. We could use, maybe, B-tress and red-black trees. Let's
;; implement this further ;)
