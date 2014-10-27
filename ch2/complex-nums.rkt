#lang racket

;; we want to achieve:
;;
;; programs that use complex numbers
;; ----[add-complex mul-complex]------
;;     complex arithmetic package
;;------------------------------------
;;  Rectangular Repr || Polar Repr
;;------------------------------------
;; List structure and primitive machine
;;             arithmetic

(define (square x)
  (* x x))

;; to create tagged data objs we need a method
;; that takes actual content and also type-tag.
(define (attach-tag type-tag contents)
  (cons type-tag contents))

;; retrieves the type-tag
(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))

;; retrieves the content
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))

;; verifies if the complex number is in
;; rectangular notation
(define (rectangular? z)
  (eq? (type-tag z) 'rectangular))

;; verifies if the complex number is in polar
;; notation
(define (polar? z)
  (eq? (type-tag z) 'polar))

;; defining a set of procedures that generate
;; rectangular objs
(define (real-part-rectangular z) (car z))
(define (imag-part-rectangular z) (cdr z))
(define (magnitude-rectangular z)
  (sqrt (+ (square (real-part-rectangular z))
           (square (imag-part-rectangular z)))))
(define (angle-rectangular z)
  (atan (imag-part-rectangular z)
        (real-part-rectangular z)))
(define (make-from-real-imag-rectangular x y)
  (attach-tag 'rectangular (cons x y)))
(define (make-from-mag-ang-rectangular r a) 
  (attach-tag 'rectangular
              (cons (* r (cos a)) (* r (sin a)))))

;; defining a set of procedures that generate
;; polar objs
(define (real-part-polar z)
  (* (magnitude-polar z) (cos (angle-polar z))))
(define (imag-part-polar z)
  (* (magnitude-polar z) (sin (angle-polar z))))
(define (magnitude-polar z) (car z))
(define (angle-polar z) (cdr z))
(define (make-from-real-imag-polar x y) 
  (attach-tag 'polar
               (cons (sqrt (+ (square x) (square y)))
                     (atan y x))))
(define (make-from-mag-ang-polar r a)
  (attach-tag 'polar (cons r a)))

;; But exposing that to the user would be a bad
;; API. As we said earlier, we want to provide
;; some way to have different design choices
;; coexisting in the system seamlessly, i.e,
;; through  a friendly API.

(define (real-part z)
  (cond ((rectangular? z) 
         (real-part-rectangular (contents z)))
        ((polar? z)
         (real-part-polar (contents z)))
        (else (error "Unknown type -- REAL-PART" z))))
(define (imag-part z)
  (cond ((rectangular? z)
         (imag-part-rectangular (contents z)))
        ((polar? z)
         (imag-part-polar (contents z)))
        (else (error "Unknown type -- IMAG-PART" z))))
(define (magnitude z)
  (cond ((rectangular? z)
         (magnitude-rectangular (contents z)))
        ((polar? z)
         (magnitude-polar (contents z)))
        (else (error "Unknown type -- MAGNITUDE" z))))
(define (angle z)
  (cond ((rectangular? z)
         (angle-rectangular (contents z)))
        ((polar? z)
         (angle-polar (contents z)))
        (else (error "Unknown type -- ANGLE" z))))

(define (make-from-real-imag x y)
  (make-from-real-imag-rectangular x y))
(define (make-from-mag-ang r a)
  (make-from-mag-ang-polar r a))

;; for dealing with addition (hence, subtraction)
;; we are better of using the rectangular
;; representation

(define (add-complex z1 z2)
  (make-from-real-imag (+ (real-part z1) (real-part z2))
                       (+ (imag-part z1) (imag-part z2))))

;; for dealing with multiplication (hence,
;; division) we are better of using the polar
;; representation

(define (mul-complex z1 z2)
  (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                     (+ (angle z1) (angle z2))))

;; the system has been decomposed into three
;; relatively independent parts: the complex-
;; number-arithmetic, the polar implementation and
;; the rectangular implementation. Notice that for
;; the developer that was working on a Polar
;; implementation, the notion of types doesn't
;; exists. It will only exist in the frontend,
;; where it needs to decide which underlying
;; implementation to use. This encourages
;; additivity of modules.

;; ps.: notice that this is not TRUE additivity.

;; We are using `dispatching on type` here:
;; chcking the type of a datum and calling an
;; appropriate procedure. The problem here is that
;; we continue with the need to identify with a
;; type a new representation, add a clause to each
;; of the generic interface procedures and also
;; try to guarantee that no two procedures in the
;; entire system have the same name.

;; For evolving on modularity and then having
;; additivity we are going to use `data-directed
;; programming`. We start by modelling our
;; procedures with a two-dimensional table that
;; contains the possible operations on one axis
;; and the possible types on the other. Then, with
;; a single procedure that looks up the
;; combination of the operation name and argument
;; type we find the correct procedure to apply.


;;          |      Polar    | Rectangular
;; ---------|---------------|-------------
;; real-part|real-part-polar|real-part-rectangular
;; imag-part|imag-part-polar|       ..
;; magnitude|magnitude-polar|       ..
;; angle    |angle-polar    |       ..

;; TODO
