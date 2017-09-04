(import chicken scheme)

(declare (unit lexer))

(use srfi-1 srfi-13)

(define (lexer str-input)
 (let ((input (string->list str-input)))
  (let ((interim-tokens (reverse (foldl create-interim-tokens '() input))))
   (map make-token interim-tokens))))

(define (make-token val)
 (if (list? val)
   (let ((str (list->string val)))
    (check-reserved str))
   val))

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

(define (check-reserved str)
 (let ((filter-func (lambda (res)
                      (string=? str (car res)))))
  (let ((res (filter filter-func reserved)))
   (if (> (length res) 0)
    (cdar res)
    str))))
