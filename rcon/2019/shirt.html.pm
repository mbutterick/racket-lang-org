#lang pollen
◊(require xenomorph/util)
◊(define heading-width 20)

◊(define (lines . strs) 
`(@ ,@(for/list ([str (in-list strs)]
#:unless (regexp-match #px"^\\s+$" str))
(string->svg  str))))


◊string->svg{Racket 
Week 2019}