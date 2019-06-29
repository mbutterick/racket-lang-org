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
         ,@(for*/list ([2-label-names (in-slice 2 label-names)])
           (match-define (list (list fn1 ln1) (list fn2 ln2)) 2-label-names)
             `(labels
             (label (barcode ,fn1) (fn ,fn1) (ln ,ln1) (week "Racket Week 2019"))
             (label (barcode ,fn2) (fn ,fn2) (ln ,ln2) (week "Racket Week 2019"))
             (label ((class "invert")) (barcode ,fn1) (fn ,fn1) (ln ,ln1) (week "Racket Week 2019"))
             (label ((class "invert")) (barcode ,fn2) (fn ,fn2) (ln ,ln2) (week "Racket Week 2019"))))))
(define doc
  ◊root{
◊lanyard-names{
Anders Pitman
James Moody
Guy Watson
Jordan Johnson
Albert Chae
Oliver Flatt
James McCoy
Wanderley Guimaraes da Silva
Kieron Hardy
Dionna Glaze
Sean Kanaley
Wei Li
}})

(provide doc)