#lang scheme

(require "TDA_propiedad.rkt" "TDA_player.rkt" "TDA_carta.rkt")
(provide tablero tablero-agregar-propiedad)

;-----CONSTRUCTOR-----
; Descripción: Constructor TDA tablero
; Dom: propiedades (lista) X cartas-suerte (lista) X cartas-comunidad (lista) X casillas-especiales (lista)
; Rec: tablero
; Tipo recursión: No aplica
(define (tablero propiedades cartas-suerte cartas-comunidad casillas-especiales)
   (list propiedades cartas-suerte cartas-comunidad casillas-especiales)
  )

;-----GETTERS------

; Descripción: obtiene las propiedades del tablero
; Dom: tablero
; Rec: propiedades (list)
; Tipo de recursión: No aplica
(define (tablero-get-propiedades tablero-x)
  (car tablero-x)
  )

; Descripción: obtiene las cartas suerte del tablero
; Dom: tablero
; Rec: cartas suerte (list)
; Tipo de recursión: No aplica
(define (tablero-get-cartasSuerte tablero-x)
  (cadr tablero-x)
  )

; Descripción: obtiene las cartas comunidad del tablero
; Dom: tablero
; Rec: cartas comunidad (list)
; Tipo de recursión: No aplica
(define (tablero-get-cartasComunidad tablero-x)
  (caddr tablero-x)
  )

; Descripción: obtiene las casillas especiales del tablero
; Dom: tablero
; Rec: casillas especiales(list)
; Tipo de recursión: No aplica
(define (tablero-get-casillasEspeciales tablero-x)
  (cadddr tablero-x)
  )

;-----SETTERS-----
; Descripción: agrega una propiedad a la lista de propiedades del tablero
; Dom: tablero (tablero) X propiedad X posicion
; Rec: tablero
; Tipo de recursión: no aplica
(define (tablero-agregar-propiedad tablero-x propiedad-x posicion)
  (tablero (cons (cons propiedad-x posicion) (tablero-get-propiedades tablero-x)) (tablero-get-cartasSuerte tablero-x)
           (tablero-get-cartasComunidad tablero-x) (tablero-get-casillasEspeciales tablero-x))
  )
