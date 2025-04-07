#lang scheme

;-----CONSTRUCTOR-----
; Descripción: Constructor TDA carta
; Dom: id (int) X nombre (string) X descripcion (string) X accion (funcion)
; Rec: carta
; Tipo recursión: No aplica
(define (carta id tipo descripcion accion)
   (list id tipo descripcion accion)
  )