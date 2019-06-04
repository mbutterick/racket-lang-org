#lang pollen
◊(require xenomorph/util)
◊(define heading-width 20)

◊(define (lines . strs) 
`(@ ,@(for/list ([str (in-list strs)]
#:unless (regexp-match #px"^\\s+$" str))
(string->svg  str))))

◊;{
https://www.deluxe.com/products/promotional/district-threads-short-sleeve-perfect-weight-district-tee-dark-colors/22534/#.XPP8BNNKgo-

navy
}

◊(void (invert? #t))
◊div[#:style "text-align:center;border:0px solid red;width:50%;margin: auto;padding-top:65vw;"]{
◊string->svg{#lang racket
(for-each
 displayln
 '("Racket"
   "Week"
   #x7E3))}
}

