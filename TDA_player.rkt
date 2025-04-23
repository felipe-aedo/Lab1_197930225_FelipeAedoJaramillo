#lang scheme

(require "TDA_propiedad.rkt")
(provide jugador jugador? player-get-id player-get-posicion player-get-dinero player-comprar-propiedad jugador-mover)

;-----CONSTRUCTOR-----
; Descripción: Constructor TDA player
; Dom: id (int) X nombre (string) X dinero (int) X propiedades (list id's) X posicion (int) X estaEnCarcel (boolean) X totalCartasSalirCarcel (int)
; Rec: player
; Tipo recursión: No aplica
(define (jugador id nombre dinero propiedades posicion carcel cartas)
   (list id nombre dinero propiedades posicion carcel cartas)
  )


;-----PERTENENCIA-----
; Descripción: Comprueba si es un player
; Dom: player
; Rec: #t or #f (bool)
; Tipo recursión: No aplica
(define (jugador? player)
  (if (list? player)
     (if (= (length player) 7)
         (if (and (integer? (list-ref player 0)) (string? (list-ref player 1)) (integer? (list-ref player 2))
                  (list? (list-ref player 3)) (andmap integer? (list-ref player 3)) (integer? (list-ref player 4)) (boolean? (list-ref player 5))
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
  (if (jugador? player) (list-ref player 0)
      null
      )
  )


; Descripción: Obtiene el nombre de un player
; Dom: player
; Rec: name (string)
; Tipo recursión: No aplica
(define (player-get-nombre player)
  (if (jugador? player) (list-ref player 1)
      null
      )
  )

; Descripción: Obtiene el dinero de un player
; Dom: player
; Rec: dinero (integer)
; Tipo recursión: No aplica
(define (player-get-dinero player)
  (if (jugador? player) (list-ref player 2)
      null
      )
  )

; Descripción: Obtiene las propiedades de un player
; Dom: player
; Rec: propiedades (list)
; Tipo recursión: No aplica
(define (player-get-propiedades player)
  (if (jugador? player) (list-ref player 3)
      null
      )
  )

; Descripción: Obtiene la posicion de un player
; Dom: player
; Rec: posicion (integer)
; Tipo recursión: No aplica
(define (player-get-posicion player)
  (if (jugador? player) (list-ref player 4)
      null
      )
  )

; Descripción: Comprueba si un player esta en carcel
; Dom: player
; Rec: estaencarcel (bool)
; Tipo recursión: No aplica
(define (player-estaencarcel player)
  (if (jugador? player) (list-ref player 5)
      null
      )
  )

; Descripción: Obtiene CartasSalirCarcel de un player
; Dom: player
; Rec: TotalCartasSalirCarcel (integer)
; Tipo recursión: No aplica
(define (player-get-cartas player)
  (if (jugador? player) (list-ref player 6)
      null
      )
  )

;------SETTERS-------
; Descripción: Establece el dinero que tiene el jugador
; Dom: player X dinero (integer)
; Rec: player (player)
; Tipo recursión: No aplica
(define (player-set-dinero player dinero)
  (if (jugador? player)
      (jugador (player-get-id player) (player-get-nombre player) dinero (player-get-propiedades player)
              (player-get-posicion player) (player-estaencarcel player) (player-get-cartas player))
      null
      )
  )

; Descripción: Establece la posicion que tiene el jugador
; Dom: player X posicion (integer)
; Rec: player (player)
; Tipo recursión: No aplica
(define (player-set-posicion player posicion)
  (if (jugador? player)
      (jugador (player-get-id player) (player-get-nombre player) (player-get-dinero player) (player-get-propiedades player)
              posicion (player-estaencarcel player) (player-get-cartas player))
      null
      )
  )

; Descripción: Mueve al jugador tras lanzar dados, retorna el player con posicion actualizada
; Dom: jugador X par de dados X juego
; Rec: jugador
(define (jugador-mover player pair game)
  (player-set-posicion player (+ (car pair) (cdr pair)))
  )

; Descripción: Alterna el valor de verdad de EstaEnCarcel para el jugador
; Dom: player
; Rec: player (player)
; Tipo recursión: No aplica
(define (player-switch-carcel player)
  (if (jugador? player)
      (jugador (player-get-id player) (player-get-nombre player) (player-get-dinero player) (player-get-propiedades player)
              (player-get-posicion player) (not (player-estaencarcel player)) (player-get-cartas player))
      null
      )
  )


; Descripción: Agrega una propiedad a la lista de propiedades del jugador
; Dom: player(integer) X idPropiedad(integer)
; Rec: player (player)
; Tipo de recursión: No aplica
(define (player-agregar-propiedad player IdPropiedad)
  (if (jugador? player)
      (jugador (player-get-id player) (player-get-nombre player) (player-get-dinero player) (cons IdPropiedad (player-get-propiedades player))
              (player-get-posicion player) (player-estaencarcel player) (player-get-cartas player))
      null
      )
  )


; Descripción: Compra una propiedad si es posible. retorna el player resultante
; Dom : player(jugador) X prop(propiedad)
; rec : player
(define (player-comprar-propiedad player prop)
  (if (>= (player-get-dinero player) (propiedad-get-precio prop))
      (player-agregar-propiedad (player-set-dinero player (- (player-get-dinero player) (propiedad-get-precio prop))) (propiedad-get-id prop))
      player
      )
  )