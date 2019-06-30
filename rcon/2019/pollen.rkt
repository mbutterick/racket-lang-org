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

(define (name->label fn ln)
  `(label (barcode ,fn) (fn ,fn) (ln ,ln) (week "Racket Week 2019")))

(define-tag-function (root attrs names)
  (define label-names (for/list ([name (in-list names)]
                                 #:unless (equal? name "\n"))
                        (match (string-split name " ")
                          [(cons fn lns) (list fn (string-join lns " "))])))
  (cons
   'lanyard-names
   (for/list ([two-names (in-slice 2 label-names)])
     (match-define labels (map (λ (n) (apply name->label n)) two-names))
     (cons 'labels (append labels (map (λ (label) (attr-set label 'class "invert")) labels))))))

