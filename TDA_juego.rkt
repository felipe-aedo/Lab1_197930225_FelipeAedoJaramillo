#lang scheme

(require "TDA_player.rkt" "TDA_carta.rkt" "TDA_propiedad.rkt" "TDA_tablero.rkt")
(provide juego juego-agregar-jugador)

;------CONSTRUCTOR--------
; Descripción: Constructor TDA juego
; Dom: jugadores(list) X tablero (tablero) X dineroBanco (int) X numeroDados (int) X turnoActual (int) X tasaImpuesto (int) X maximoCasas (int) X maximoHoteles (int) X estadoJuego (string)
; Rec: juego
; Tipo de recursión: no aplica
(define (juego jugadores tablero-x dineroBanco numeroDados turnoActual tasaImpuesto maximoCasas maximoHoteles estadoJuego)
  (list jugadores tablero-x dineroBanco numeroDados turnoActual tasaImpuesto maximoCasas maximoHoteles estadoJuego)
  )


;-----PERTENENCIA-------
; Descripción: Comprueba que pertenece al TDA juego
; Dom: juego (list)
; Rec: Bool
; Tipo de recursión: No aplica
(define (juego? juego-x)
  (if (list? juego-x)
      (if (= 9 (length juego-x))
          (if (and (list? (list-ref juego-x 0))
                   (andmap player? (list-ref juego-x 0)); jugadores
                   (tablero? (list-ref juego-x 1))              ; tablero
                   (integer? (list-ref juego-x 2))              ; dineroBanco
                   (integer? (list-ref juego-x 3))
                   (integer? (list-ref juego-x 4))
                   (integer? (list-ref juego-x 5))
                   (integer? (list-ref juego-x 6))
                   (integer? (list-ref juego-x 7))
                   (string? (list-ref juego-x 8))
                   )
              #t
              #f
              )
          #f
          )
      #f
      )
  )

;-------GETTERS--------

; Descripción: Obtiene la lista de jugadores
; Dom: juego
; Rec: lista de jugadores
(define (juego-get-jugadores juego-x)
  (list-ref juego-x 0)
  )

; Descripción: Obtiene el tablero del juego
; Dom: juego
; Rec: tablero
(define (juego-get-tablero juego-x)
  (list-ref juego-x 1)
  )

; Descripción: Obtiene el dinero del banco
; Dom: juego
; Rec: dineroBanco (int)
(define (juego-get-dineroBanco juego-x)
  (list-ref juego-x 2)
  )

; Descripción: Obtiene el número de dados
; Dom: juego
; Rec: numeroDados (int)
(define (juego-get-numeroDados juego-x)
  (list-ref juego-x 3)
  )

; Descripción: Obtiene el turno actual
; Dom: juego
; Rec: turnoActual (int)
(define (juego-get-turnoActual juego-x)
  (list-ref juego-x 4)
  )

; Descripción: Obtiene la tasa de impuesto
; Dom: juego
; Rec: tasaImpuesto (int)
(define (juego-get-tasaImpuesto juego-x)
  (list-ref juego-x 5)
  )

; Descripción: Obtiene el máximo de casas
; Dom: juego
; Rec: maximoCasas (int)
(define (juego-get-maximoCasas juego-x)
  (list-ref juego-x 6)
  )

; Descripción: Obtiene el máximo de hoteles
; Dom: juego
; Rec: maximoHoteles (int)
(define (juego-get-maximoHoteles juego-x)
  (list-ref juego-x 7)
  )

; Descripción: Obtiene el estado del juego
; Dom: juego
; Rec: estadoJuego (string)
(define (juego-get-estadoJuego juego-x)
  (list-ref juego-x 8)
  )


; Descripción: Agrega un jugador a la lista de jugadores
; Dom: juego X jugador
; Rec: juego
(define (juego-agregar-jugador juego-x jugador-x)
  (if (and (player? jugador-x) (juego? juego-x))
      (juego (cons jugador-x (juego-get-jugadores juego-x)) (juego-get-tablero juego-x) (juego-get-dineroBanco juego-x) (juego-get-numeroDados juego-x)
             (juego-get-turnoActual juego-x) (juego-get-tasaImpuesto juego-x) (juego-get-maximoCasas juego-x) (juego-get-maximoHoteles juego-x)
             (juego-get-estadoJuego juego-x))
      null
      )
  )