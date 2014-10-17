(define items (list 1 2 3 4))

;; as everything is a list, including a unique element,
;; the base case is getting the first element, which is n = 0
;; getting the first of a list is just using car
;; what we want is to iterate till we get to there. We do this by
;; cdr-ing down till the list to be evaluated becomes list[n:-1].
(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))

;; When we have an empty list we have 0 as the length.
;; What we need to do is consume the list till we make it
;; empty. During the iteration we maintain the state that 
;; represents how many steps we take till that point. The
;; idea behind the recursive step is that the length of
;; any list is 1 + the cdr of the list.
(define (list-length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))

(define (list-length-iter items count)
  (if (null? items)
      count
      (list-length-iter (cdr items) (+ count 1))))

;; For appending we'll use another strategy: cons-up while
;; cdr-down. We'll keep constructing a list while cdring-down
;; another. Well consume the entire first list and then, when 
;; finished, cons the second list to our construction.
(define (list-append a b)
  (if (null? a)
      b
      (cons (car a) (list-append (cdr a) b))))  


(define (list-equal? a b)
  (if (null? (cdr a))
      (= (car a) (car b))
      (list-equal? (cdr a) (cdr b))))

(define (map proc items)
  (if (null? items)
      null
      (cons (proc (car items))
            (map proc (cdr items)))))

(= 3 (list-ref items 2))
(= 4 (list-length items))
(= 4 (list-length-iter items 0))
(= 8 (list-length (list-append items items)))
