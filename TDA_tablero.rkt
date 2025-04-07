#lang scheme

(require "TDA_propiedad.rkt")

;-----CONSTRUCTOR-----
; Descripción: Constructor TDA tablero
; Dom: propiedades (lista) X cartas-suerte (lista) X cartas-comunidad (lista) X casillas-especiales (lista)
; Rec: tablero
; Tipo recursión: No aplica
(define (tablero propiedades cartas-suerte cartas-comunidad casillas-especiales)
   (list propiedades cartas-suerte cartas-comunidad casillas-especiales)
  )

;-----GETTERS------

(define (tablero-get-propiedades tablero)
  (car tablero)
  )

(define (tablero-get-cartasSuerte tablero)
  (cadr tablero)
  )

(define (tablero-get-cartasComunidad tablero)
  (caddr tablero)
  )

(define (tablero-get-casillasEspeciales)
  (cadddr tablero)
  )

;-----SETTERS-----
; Dom: tablero (tablero) X propiedades con posición (lista de pares (propiedad . posicion))
(define (tablero-agregar-propiedad tablero propiedad)
  )