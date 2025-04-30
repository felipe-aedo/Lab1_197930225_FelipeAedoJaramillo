#lang scheme

(require "TDA_propiedad.rkt")
(provide jugador jugador? jugador-get-id jugador-get-posicion jugador-get-propiedades jugador-get-dinero jugador-estaencarcel
         jugador-comprar-propiedad jugador-set-posicion jugador-pagar-renta)

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
(define (jugador-get-id player)
  (if (jugador? player) (list-ref player 0)
      null
      )
  )

; Descripción: Obtiene el nombre de un player
; Dom: player
; Rec: name (string)
; Tipo recursión: No aplica
(define (jugador-get-nombre player)
  (if (jugador? player) (list-ref player 1)
      null
      )
  )

; Descripción: Obtiene el dinero de un player
; Dom: player
; Rec: dinero (integer)
; Tipo recursión: No aplica
(define (jugador-get-dinero player)
  (if (jugador? player) (list-ref player 2)
      null
      )
  )

; Descripción: Obtiene las propiedades de un player
; Dom: player
; Rec: propiedades (list)
; Tipo recursión: No aplica
(define (jugador-get-propiedades player)
  (if (jugador? player) (list-ref player 3)
      null
      )
  )

; Descripción: Obtiene la posicion de un player
; Dom: player
; Rec: posicion (integer)
; Tipo recursión: No aplica
(define (jugador-get-posicion player)
  (if (jugador? player) (list-ref player 4)
      null
      )
  )

; Descripción: Comprueba si un player esta en carcel
; Dom: player
; Rec: estaencarcel (bool)
; Tipo recursión: No aplica
(define (jugador-estaencarcel player)
  (if (jugador? player) (list-ref player 5)
      null
      )
  )

; Descripción: Obtiene CartasSalirCarcel de un player
; Dom: player
; Rec: TotalCartasSalirCarcel (integer)
; Tipo recursión: No aplica
(define (jugador-get-cartas player)
  (if (jugador? player) (list-ref player 6)
      null
      )
  )

;------SETTERS-------
; Descripción: Establece el dinero que tiene el jugador
; Dom: player X dinero (integer)
; Rec: player (player)
; Tipo recursión: No aplica
(define (jugador-set-dinero player dinero)
  (if (jugador? player)
      (jugador (jugador-get-id player) (jugador-get-nombre player) dinero (jugador-get-propiedades player)
              (jugador-get-posicion player) (jugador-estaencarcel player) (jugador-get-cartas player))
      null
      )
  )

; Descripción: Establece la posicion que tiene el jugador
; Dom: player X posicion (integer)
; Rec: player (player)
; Tipo recursión: No aplica
(define (jugador-set-posicion player posicion)
  (if (jugador? player)
      (jugador (jugador-get-id player) (jugador-get-nombre player) (jugador-get-dinero player) (jugador-get-propiedades player)
              posicion (jugador-estaencarcel player) (jugador-get-cartas player))
      null
      )
  )

; Descripción: Alterna el valor de verdad de EstaEnCarcel para el jugador
; Dom: player
; Rec: player (player)
; Tipo recursión: No aplica
(define (jugador-switch-carcel player)
  (if (jugador? player)
      (jugador (jugador-get-id player) (jugador-get-nombre player) (jugador-get-dinero player) (jugador-get-propiedades player)
              (jugador-get-posicion player) (not (jugador-estaencarcel player)) (jugador-get-cartas player))
      null
      )
  )

; Descripción: Agrega una propiedad a la lista de propiedades del jugador
; Dom: player(integer) X idPropiedad(integer)
; Rec: player (player)
; Tipo de recursión: No aplica
(define (jugador-agregar-propiedad player IdPropiedad)
  (if (jugador? player)
      (jugador (jugador-get-id player) (jugador-get-nombre player) (jugador-get-dinero player) (cons IdPropiedad (jugador-get-propiedades player))
              (jugador-get-posicion player) (jugador-estaencarcel player) (jugador-get-cartas player))
      null
      )
  )

; Descripción: Compra una propiedad si es posible. retorna el player resultante
; Dom : player(jugador) X prop(propiedad)
; rec : player
(define (jugador-comprar-propiedad player prop)
  (if (>= (jugador-get-dinero player) (propiedad-get-precio prop))
      (jugador-agregar-propiedad (jugador-set-dinero player (- (jugador-get-dinero player) (propiedad-get-precio prop))) (propiedad-get-id prop))
      player
      )
  )

; Descripción: Compra una propiedad si es posible. retorna el player resultante
; Dom : pagador(jugador) X receptor(jugador) X monto (int)
; rec : lista de players
(define (jugador-pagar-renta pagador receptor monto)
  (list (jugador (jugador-get-id pagador) (jugador-get-nombre pagador) (- (jugador-get-dinero pagador) monto) (jugador-get-propiedades pagador)
              (jugador-get-posicion pagador) (jugador-estaencarcel pagador) (jugador-get-cartas pagador))
        (jugador (jugador-get-id receptor) (jugador-get-nombre receptor) (+ (jugador-get-dinero receptor) monto) (jugador-get-propiedades receptor)
              (jugador-get-posicion receptor) (jugador-estaencarcel receptor) (jugador-get-cartas receptor)))
  )

;verifica si un jugador está en bancarrota
; Dom: player (jugador)
; Rec: bool
(define (jugador-esta-en-bancarrota player)
 (<= (jugador-get-dinero player) 0)     
  )