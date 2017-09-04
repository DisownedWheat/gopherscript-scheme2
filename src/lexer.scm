(import chicken scheme)

(declare (unit lexer))

(use srfi-1 srfi-13 data-structures)

(define (lexer str-input)
 (let ((input (string->list str-input)))
  (let ((interim-tokens (reverse (foldl create-interim-tokens '() input))))
   (map make-token interim-tokens))))

(define (make-token val)
 ;(if (char? (car val))
 ; (print (char=? (car val) #\space)))
 (if (list? val)
   (list->string val)))

(define (create-interim-tokens acc x)
 (if (char-whitespace? x)
   (let ((all-var (filter char? acc)))
    (cons (reverse all-var) (filter (lambda (val) (not (char? val))) acc)))
   (cons x acc)))

(define reserved
 '(("->" . "func")
   ("==" . "eq")
   ("=" . "assign")
   (">" . "gt")
   ("<" . "lt")))
