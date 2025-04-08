#lang scheme

(provide player player?)

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
; Rec: id (integer)
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
; Rec: dinero (integer)
; Tipo recursión: No aplica
(define (player-get-dinero player)
  (if (player? player) (list-ref player 2)
      null
      )
  )

; Descripción: Obtiene las propiedades de un player
; Dom: player
; Rec: propiedades (list)
; Tipo recursión: No aplica
(define (player-get-propiedades player)
  (if (player? player) (list-ref player 3)
      null
      )
  )

; Descripción: Obtiene la posicion de un player
; Dom: player
; Rec: posicion (integer)
; Tipo recursión: No aplica
(define (player-get-posicion player)
  (if (player? player) (list-ref player 4)
      null
      )
  )

; Descripción: Comprueba si un player esta en carcel
; Dom: player
; Rec: estaencarcel (bool)
; Tipo recursión: No aplica
(define (player-estaencarcel player)
  (if (player? player) (list-ref player 5)
      null
      )
  )

; Descripción: Obtiene CartasSalirCarcel de un player
; Dom: player
; Rec: TotalCartasSalirCarcel (integer)
; Tipo recursión: No aplica
(define (player-get-cartas player)
  (if (player? player) (list-ref player 6)
      null
      )
  )

;------SETTERS-------
; Descripción: Establece el dinero que tiene el jugador
; Dom: player X dinero (integer)
; Rec: player (player)
; Tipo recursión: No aplica
(define (player-set-dinero player-x dinero)
  (if (player? player-x)
      (player (player-get-id player-x) (player-get-nombre player-x) dinero (player-get-propiedades player-x)
              (player-get-posicion player-x) (player-estaencarcel player-x) (player-get-cartas player-x))
      null
      )
  )

; Descripción: Establece la posicion que tiene el jugador
; Dom: player X posicion (integer)
; Rec: player (player)
; Tipo recursión: No aplica
(define (player-set-posicion player-x posicion)
  (if (player? player-x)
      (player (player-get-id player-x) (player-get-nombre player-x) (player-get-dinero player-x) (player-get-propiedades player-x)
              posicion (player-estaencarcel player-x) (player-get-cartas player-x))
      null
      )
  )

; Descripción: Alterna el valor de verdad de EstaEnCarcel para el jugador
; Dom: player
; Rec: player (player)
; Tipo recursión: No aplica
(define (player-switch-carcel player-x)
  (if (player? player-x)
      (player (player-get-id player-x) (player-get-nombre player-x) (player-get-dinero player-x) (player-get-propiedades player-x)
              (player-get-posicion player-x) (not (player-estaencarcel player-x)) (player-get-cartas player-x))
      null
      )
  )


; Descripción: Agrega una propiedad a la lista de propiedades del jugador
; Dom: player X propiedad
; Rec: player (player)
; Tipo de recursión: No aplica
(define (player-agregar-propiedad player-x propiedad)
  (if (player? player-x)
      (player (player-get-id player-x) (player-get-nombre player-x) (player-get-dinero player-x) (cons propiedad (player-get-propiedades player-x))
              (player-get-posicion player-x) (player-estaencarcel player-x) (player-get-cartas player-x))
      null
      )
  )