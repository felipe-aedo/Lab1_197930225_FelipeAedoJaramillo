#lang scheme


(provide carta carta?)

;-----CONSTRUCTOR-----
; Descripción: Constructor TDA carta
; Dom: id (int) X nombre (string) X descripcion (string) X accion (funcion)
; Rec: carta
; Tipo recursión: No aplica
(define (carta id tipo descripcion accion)
   (list id tipo descripcion accion)
  )


;-----PERTENENCIA-----
; Descripción: Comprueba que pertenece al TDA carta
; Dom: carta (list)
; Rec: Bool
; Tipo de recursión: No aplica
(define (carta? carta-x)
  (and (list? carta-x)
       (= 4 (length carta-x))
       (integer? (list-ref carta-x 0))
       (string? (list-ref carta-x 1))
       (string? (list-ref carta-x 2))
       ;(procedure? (list-ref carta-x 3))
       )
  )