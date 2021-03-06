#lang racket
(require racket/gui graph sugar/coerce sugar/debug)
(define current-cell-size (make-parameter 25))
(define current-dc (make-parameter #f))
(define current-target (make-parameter 'gui))
(define current-stroke-scale (make-parameter 1))
(define char-edge-size 6)


(define (pathify vs)
  (define p (new dc-path%))
  (define pts (map (λ(x) (list (* (current-cell-size) (sub1 (modulo x 10))) (* (current-cell-size) (- 4 (sub1 (floor (/ x 10))))) )) vs))
  (send p move-to (first (car pts)) (second (car pts)))
  (for-each (λ(pt) (send p line-to (first pt) (second pt))) (cdr pts))
  (when (= (first vs) (last vs)) (send p close))
  p)

(struct $glyph (name paths))

(define font-definition 
  '((a (51 54 45 15 12 21 31 33))
    (b (11 51 55 25 14 13) (35 33))
    (c (25 15 11 41 52 55 45))
    (d (31 11 14 25 45 54 51))
    (e (15 11 41 52 55 35 33))
    (E (55 52 41 11 15) (31 35))
    (f (11 41 52 55) (31 35))
    (g (33 35 15 11 41 52 55))
    (h (11 51) (15 55) (31 35))
    (i (11 15) (51 55) (13 53))
    (j (53 55 15 12 21 31))
    (k (11 51) (11 21 54 55) (43 34 25 15))
    (L (51 11 15) (53 33 35))
    (l (25 15 11 41 52))
    (m (11 51 54 45 15) (53 13))
    (n (11 51 54 45 15))
    (N (11 51 52 43 23 14 15 55))
    (O (11 41 52 55 25 14 11))
    (o (51 54 45 15 12 21 51))
    (P (11 51 54 45 35 24 23))
    (p (51 54 45 35 33 13 11 31))
    (p0 (11 51 55 35 24 23))
    (q (33 24 13 11 41 52 55 35 24))
    (r (11 51 53 54 45 35 33 23 14 15))
    (s (11 14 25 35 31 41 52 55))
    (t (31 51 55 35) (53 13) (11 15))
    (T (51 55) (53 13))
    (u (51 21 12 15 55))
    (v (55 35 13 11 51))
    (w (51 21 12 15 55) (53 13))
    (x (51 52 43 23 14 15) (11 12 23 43 54 55))
    (X (51 41 32 34 25 15) (11 21 32 34 45 55))
    (y (51 31 35)(55 25 14 11))
    (z (51 55 45 34 32 21 11 15))
    (♥ (12 21 41 52 43 54 45 25 14 12))
    (0 (51 54 45 15 12 21 31 51))
    (1 (51 53 13) (11 15))
    (2 (51 54 45 35 31 11 15))
    (3 (51 54 45 15 11) (31 35))
    (4 (41 21 25) (54 14))
    (5 (55 51 31 35 25 14 11))
    (6 (31 35 25 14 11 41 52 55))
    (7 (51 55 45 22 12))
    (8 (12 21 51 54 45 15 12) (31 35))
    (9 (11 14 25 55 52 41 31 35))
    (λ (51 52 25 15) (11 21 43))
    (> (51 52 25 15))
    (% (11 51) (12 52) (13 53) (14 54) (15 55))
    (^ (11 51) (12 42) (13 33) (14 24))
    (< (11 21 43))
    (|(| (55 54 43 23 14 15))
    (|)| (51 52 43 23 12 11))))


(define (type str [xoffset 0] [yoffset 0] #:color color-proc #:width width)
  (define glyphs (map (λ(i) ($glyph (->string (car i)) (map pathify (cdr i)))) font-definition))
  (cond
    [(equal? str "") (void)]
    [else
     (define gname (substring str 0 1))
     (define g (findf (λ(g) (equal? ($glyph-name g) gname)) glyphs))
     (when g
       (define pen (make-pen #:color (->string (color-proc)) #:width width #:style 'solid #:cap 'projecting #:join 'miter))
       (send (current-dc) set-pen pen)
       (send (current-dc) set-brush "white" 'transparent)
       (for-each (λ(p) (send (current-dc) draw-path p (+ xoffset (current-cell-size)) (+ yoffset (current-cell-size)))) ($glyph-paths g)))
     (type (substring str 1) (+ xoffset (* (current-cell-size) char-edge-size)) yoffset #:color color-proc #:width width)]))

(define (layer-type str #:xoffset [xoffset 0] #:yoffset [yoffset 0] . attrs)
  (define layers (for/list ([i (in-range 0 (length attrs) 2)]) (list (list-ref attrs i) (list-ref attrs (add1 i)))))
  (for-each (λ(layer) (type str xoffset yoffset #:color (first layer) #:width (* (current-cell-size) (current-stroke-scale) (second layer)))) layers)) 

(define (render text layers [stroke-scale 1] [name (gensym)])
  (define lines (string-split text))
  (define horiz (* (current-cell-size) (apply max (map string-length lines)) char-edge-size))
  (define vert (* (current-cell-size) char-edge-size (length lines)))
  (define target (make-bitmap horiz vert))
  (parameterize ([current-dc (if (equal? 'svg (current-target))
                                 (new svg-dc% [width horiz] [height vert] [output (format "/Users/MB/Desktop/~a.svg" name)] [exists 'replace])
                                 (new bitmap-dc% [bitmap target]))]
                 [current-stroke-scale stroke-scale])
    (when (equal? 'svg (current-target))
        (send (current-dc) start-doc "start")
        (send (current-dc) start-page))
    (send (current-dc) set-smoothing 'smoothed)
    (for* ([(line lineno) (in-indexed lines)][layer (in-list layers)])
          (define layer-color (first layer))
          (define layer-thickness (second layer))
      (layer-type line #:xoffset 0 #:yoffset (* (current-cell-size) char-edge-size lineno) layer-color layer-thickness))
    (cond
      [(equal? 'svg (current-target))
       (make-object image-snip% target)
       (send (current-dc) end-page)
       (send (current-dc) end-doc)]
      [else (make-object image-snip% target)])))

(define-syntax-rule (render-svg arg ...)
  (parameterize ([current-target 'svg])
    (render arg ...)))

(define (random-select xs)
  (list-ref xs (random (length xs))))

(module+ main
  (current-target 'gui)
  (define texts '("siXTh rackET ZZcon" "kEynoTE" "sPEakErs"))
  (define names '(rcon-raw keynote-raw speakers-raw))
  

  (define (do-it text name)
  (define color-choice (λ () (random-select '(LightSkyBlue Crimson))))
  (render-svg text (list (list (λ () 'Black) 5) (list (λ () 'White) 3) (list color-choice 1)) 0.33 name))

  (for-each do-it texts names))