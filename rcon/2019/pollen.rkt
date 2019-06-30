#lang racket
(require (for-syntax racket/syntax)
         racket/runtime-path
         pollen/tag
         txexpr
         pollen/decode)
(provide (all-defined-out))

(define-syntax (ffd/rp stx)
  (syntax-case stx ()
    [(_ fam file kwargs ...)
     (with-syntax ([rp-name (generate-temporary)])
       #'(begin
           (require racket/runtime-path css-tools/font-face)
           (define-runtime-path rp-name (expand-user-path file))
           (font-face-declaration fam rp-name kwargs ...)))]))

(define (name->label fnln)
  (match fnln
    [(cons fn ln)
     `(label (barcode ,fn)
             (fn ,fn)
             (ln ,ln)
             (week "Racket Week 2019"))]))

(define (invert tx) (attr-set tx 'style "transform: rotate(180deg);"))

(define-tag-function (root attrs names)
  (define label-names
    (for/list ([name (in-list names)]
               #:unless (equal? name "\n"))
      (match (string-split name " ")
        [(cons fn rest) (cons fn (string-join rest " "))])))
  (cons
   'lanyard-names
   (for/list ([names (in-slice 2 label-names)])
     `(labels
           ,@(match (map name->label names)
             [(list label) (list label '(div) (invert label) '(div))]
             [labels (append labels (map invert labels))])
           (div ((class "crop1")))
           (div ((class "crop2")))
           (div ((class "crop3")))
           (div ((class "crop4")))
           (div ((class "crop5")))
           (div ((class "crop6")))
           (div ((class "crop7")))
           (div ((class "crop8")))))))

