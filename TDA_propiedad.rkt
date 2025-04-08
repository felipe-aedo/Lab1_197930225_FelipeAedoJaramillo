#lang scheme

(require "TDA_player.rkt")
(provide propiedad propiedad? propiedad-set-dueño)

;------CONSTRUCTOR--------
; Descripción: Constructor TDA propiedad
; Dom: id (int) X nombre (string) X precio (int) X renta (int) X dueño (jugador/null) X casas (int) X esHotel (boolean) X estaHipotecada (boolean)
; Rec: propiedad
; Tipo de recursión: no aplica
(define (propiedad id nombre precio renta dueño casas esHotel estaHipotecada)
  (list id nombre precio renta dueño casas esHotel estaHipotecada)
  )


;-----PERTENENCIA-------
; Descripción: Comprueba que pertenece al tda propiedad
; Dom: Propiedad (list)
; Rec: Bool
; tipo de recursión: No aplica
(define (propiedad? propiedad-x)
  (if (list? propiedad-x)
      (if (= 8 (length propiedad-x))
          (if (and (integer? (list-ref propiedad-x 0)) (string? (list-ref propiedad-x 1)) (integer? (list-ref propiedad-x 2))
                   (integer? (list-ref propiedad-x 3)) (or (null? (list-ref propiedad-x 4)) (player? (list-ref propiedad-x 4)))
                   (integer? (list-ref propiedad-x 5)) (boolean? (list-ref propiedad-x 6)) (boolean? (list-ref propiedad-x 7)))
              #t
              #f
              )
          #f
          )
      #f
      )
  )

;-------GETTERS--------
; Descripción: Obtiene el id de una propiedad
; Dom: propiedad
; Rec: id (int)
; Tipo de recursión: no aplica
(define (propiedad-get-id propiedad-x)
  (list-ref propiedad-x 0)
  )

; Descripción: Obtiene el nombre da la propiedad
; Dom: propiedad
; Rec: nombre (string)
; Tipo de recursión: no aplica
(define (propiedad-get-nombre propiedad-x)
  (list-ref propiedad-x 1)
  )

; Descripción: Obtiene el precio de la propiedad
; Dom: propiedad
; Rec: precio (int)
; Tipo de recursión: no aplica
(define (propiedad-get-precio propiedad-x)
  (list-ref propiedad-x 2)
  )

; Descripción: Obtiene la renta de la propiedad
; Dom: propiedad
; Rec: renta (int)
; Tipo de recursión: no aplica
(define (propiedad-get-renta propiedad-x)
  (list-ref propiedad-x 3)
  )

; Descripción: Obtiene el dueño de la propiedad
; Dom: propiedad
; Rec: dueño (o null)
; Tipo de recursión: no aplica
(define (propiedad-get-dueño propiedad-x)
  (list-ref propiedad-x 4)
  )

; Descripción: Obtiene el numero de casas en la propiedad
; Dom: propiedad
; Rec: casas (int)
; Tipo de recursión: no aplica
(define (propiedad-get-casas propiedad-x)
  (list-ref propiedad-x 5)
  )

; Descripción: Comprueba si es hotel
; Dom: propiedad
; Rec: bool
; Tipo de recursión: no aplica
(define (propiedad-esHotel propiedad-x)
  (list-ref propiedad-x 6)
  )

; Descripción: Comprueba si esta hipotecada la propiedad
; Dom: propiedad
; Rec: bool
; Tipo de recursión: no aplica
(define (propiedad-estaHipotecada propiedad-x)
  (list-ref propiedad-x 7)
  )

;--------SETTERS------
; Descripción: Establece el dueño de una propiedad
; Dom: propiedad X dueño
; Rec: propiedad
; Tipo de recursión: no aplica
(define (propiedad-set-dueño propiedad-x dueño)
  (propiedad (propiedad-get-id propiedad-x) (propiedad-get-nombre propiedad-x) (propiedad-get-precio propiedad-x)
             (propiedad-get-renta propiedad-x) dueño (propiedad-get-casas propiedad-x) (propiedad-esHotel propiedad-x)
             (propiedad-estaHipotecada propiedad-x))
  )