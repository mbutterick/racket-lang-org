#lang debug br
(require racket/sequence racket/match racket/string pollen/tag)

(define label (default-tag-function 'label))
(define root (default-tag-function 'root))

(define (lanyard-names . names)
   (define label-names
     (for/list ([name names]
                #:unless (equal? name "\n"))
       (match-define (cons fn lns) (string-split name " "))
       (list fn (string-join lns " "))))
   `(lanyard-names
     (labels
         ,@(for/list ([label-name (in-list label-names)])
           (match-define (list fn ln) label-name)
             `(label (barcode ,fn) (fn ,fn) (ln ,ln) (caption "Racket Week 2019"))))))
(define doc
  ◊root{
◊lanyard-names{
 Wanderley Guimaraes da Silva
 Matthew Flatt
 Jay McCarthy
 Wei Li
}})

(provide doc)