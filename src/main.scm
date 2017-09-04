(import chicken scheme)

(declare (uses lexer))

(use format)

(define input "test = () -> print('Hello!')

testOne = (x) -> return x + 1

test = ->
  x = testOne(1)
  print(x)
  if x == 1
    return x
  else
    return false
")

(define (main)
 (lexer input))

(print (main))
