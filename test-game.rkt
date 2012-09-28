#lang racket
(require 2htdp/image)
(require 2htdp/universe)
(require net/url)

(define SERVER "http://129.10.188.47:1337/") 
(define-struct player (x y))

(define (get-stuff site key)
  (let ([x (symbol->string (read (get-pure-port (string->url (string-append site key)))))])
        (let ([pair (car (regexp-match-positions #rx"&" x))]) 
       (make-player (string->number (substring x 0 (car pair))) 
                    (string->number (substring x (cdr pair)))))))

(define (tick player)
  (get-stuff SERVER ""))

(define (draw player)
  (place-image (rectangle 50 50 "solid" "red") 
               (player-x player)
               (player-y player)
               (empty-scene 500 500)))

(define (handle-key player key)
  (get-stuff SERVER key))

(define PLAYER0 (make-player 150 150))
(big-bang PLAYER0
          (on-tick tick 0.25)
          (to-draw draw)
          (on-key handle-key))