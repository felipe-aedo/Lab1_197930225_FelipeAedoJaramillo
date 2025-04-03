#lang scheme


;-----CONSTRUCTOR-----
; Descripción: Constructor TDA player
; Dom: id (int) X nombre (string) X dinero (int) X propiedades (list) X posicion (int) X estaEnCarcel (boolean) X totalCartasSalirCarcel (int)
; Rec: player
; Tipo recursión: No aplica
(define (player id nombre dinero propiedades posicion carcel cartas)
   (list id nombre dinero propiedades posicion carcel cartas)
  )


;-----PERTENENCIA-----
; Descripción: Comprueba si es un player
; Dom: player
; Rec: #t or #f (bool)
; Tipo recursión: No aplica
(define (player? player)
  (if (list? player)
     (if (= (length player) 7)
         (if (and (integer? (list-ref player 0)) (string? (list-ref player 1)) (integer? (list-ref player 2))
                  (list? (list-ref player 3)) (integer? (list-ref player 4)) (boolean? (list-ref player 5))
                  (integer? (list-ref player 6)))
             #t
             #f
             )
         #f
         )
     #f
     )
  )

;-----GETTERS-----

; Descripción: Obtiene el id de un player
; Dom: player
; Rec: id (int)
; Tipo recursión: No aplica
(define (player-get-id player)
  (if (player? player) (list-ref player 0)
      null
      )
  )


; Descripción: Obtiene el nombre de un player
; Dom: player
; Rec: name (string)
; Tipo recursión: No aplica
(define (player-get-nombre player)
  (if (player? player) (list-ref player 1)
      null
      )
  )

; Descripción: Obtiene el dinero de un player
; Dom: player
; Rec: name (string)
; Tipo recursión: No aplica
(define (player-get-dinero player)
  (if (player? player) (list-ref player 2)
      null
      )
  )

; Descripción: Obtiene las propiedades de un player
; Dom: player
; Rec: name (string)
; Tipo recursión: No aplica
(define (player-get-propiedades player)
  (if (player? player) (list-ref player 3)
      null
      )
  )

; Descripción: Obtiene la posicion de un player
; Dom: player
; Rec: name (string)
; Tipo recursión: No aplica
(define (player-get-posicion player)
  (if (player? player) (list-ref player 4)
      null
      )
  )

; Descripción: Comprueba si un player esta en carcel
; Dom: player
; Rec: name (string)
; Tipo recursión: No aplica
(define (player-get-estaencarcel player)
  (if (player? player) (list-ref player 5)
      null
      )
  )

; Descripción: Obtiene CartasSalirCarcel de un player
; Dom: player
; Rec: name (string)
; Tipo recursión: No aplica
(define (player-get-cartas player)
  (if (player? player) (list-ref player 6)
      null
      )
  )