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

(define-tag-function (lanyard-names attrs names)
  (define label-names
    (for/list ([name (in-list names)]
               #:unless (equal? name "\n"))
      (match (string-split name " ")
        [(cons fn lns) (list fn (string-join lns " "))])))
  (cons
   'lanyard-names
   (for/list ([2-label-names (in-slice 2 label-names)])
     (match-define (list (list fn1 ln1) (list fn2 ln2)) 2-label-names)
     (define label-1 (name->label fn1 ln1))
     (define label-2 (name->label fn2 ln2))
     (list 'labels
           label-1
           label-2
           (attr-set label-1 'class "invert")
           (attr-set label-2 'class "invert")))))

(define root lanyard-names)

(define-tag-function (label attrs items)
  (decode `(label ,attrs ,@items)
          #:txexpr-elements-proc (λ (es) (decode-paragraphs es #:force? #t))))

