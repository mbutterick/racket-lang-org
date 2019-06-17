#lang pollen
◊(require racket/sequence racket/match racket/string)
◊(define (lanyard-names . names)
   (define label-names
     (for/list ([name names]
                #:unless (equal? name "\n"))
       (match-define (list fn ln) (string-split name " "))
       (svgs (string->svg fn) (string->svg ln))))
   `(lanyard-names
         ,@(for/list ([label-name-duo (in-slice 2 label-names)])
           (match-define (list fn ln) label-name-duo)
           (labels
            ◊label[#:class "a1"]{◊fn}
            ◊label[#:class "b1"]{◊ln}
            ◊label[#:class "a2"]{◊fn}
            ◊label[#:class "b2"]{◊ln}
            ))))

◊lanyard-names{
 Robby Findler
 Matthew Flatt
 Jay McCarthy
 Wei Li
}