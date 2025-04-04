#lang scheme

(provide propiedad propiedad-set-dueño)

;------CONSTRUCTOR--------
; Dom: id (int) X nombre (string) X precio (int) X renta (int) X dueño (jugador/null) X casas (int) X esHotel (boolean) X estaHipotecada (boolean)
(define (propiedad id nombre precio renta dueño casas esHotel estaHipotecada)
  (list id nombre precio renta dueño casas esHotel estaHipotecada)
  )

;-------GETTERS--------
(define (propiedad-get-id propiedad-x)
  (list-ref propiedad-x 0)
  )

(define (propiedad-get-nombre propiedad-x)
  (list-ref propiedad-x 1)
  )

(define (propiedad-get-precio propiedad-x)
  (list-ref propiedad-x 2)
  )

(define (propiedad-get-renta propiedad-x)
  (list-ref propiedad-x 3)
  )

(define (propiedad-get-dueño propiedad-x)
  (list-ref propiedad-x 4)
  )

(define (propiedad-get-casas propiedad-x)
  (list-ref propiedad-x 5)
  )

(define (propiedad-esHotel propiedad-x)
  (list-ref propiedad-x 6)
  )

(define (propiedad-estaHipotecada propiedad-x)
  (list-ref propiedad-x 7)
  )


(define (propiedad-set-dueño propiedad-x dueño)
  (propiedad (propiedad-get-id propiedad-x) (propiedad-get-nombre propiedad-x) (propiedad-get-precio propiedad-x)
             (propiedad-get-renta propiedad-x) dueño (propiedad-get-casas propiedad-x) (propiedad-esHotel propiedad-x)
             (propiedad-estaHipotecada propiedad-x))
  )