#lang scheme

(provide propiedad propiedad? propiedad-set-dueño propiedad-get-precio propiedad-get-id propiedad-get-casas propiedad-get-nombre propiedad-set-dueño propiedad-calcular-renta propiedad-construir-casa)

;------CONSTRUCTOR--------
; Descripción: Constructor TDA propiedad
; Dom: id (int) X nombre (string) X precio (int) X renta (int) X dueño (Idjugador/null) X casas (int) X esHotel (boolean) X estaHipotecada (boolean)
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
(define (propiedad? prop)
  (if (list? prop)
      (if (= 8 (length prop))
          (if (and (integer? (list-ref prop 0)) (string? (list-ref prop 1)) (integer? (list-ref prop 2))
                   (integer? (list-ref prop 3)) (or (null? (list-ref prop 4)) (integer? (list-ref prop 4))) (integer? (list-ref prop 5))
                   (boolean? (list-ref prop 6)) (boolean? (list-ref prop 7)))
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
(define (propiedad-get-id prop)
  (list-ref prop 0)
  )

; Descripción: Obtiene el nombre da la propiedad
; Dom: propiedad
; Rec: nombre (string)
; Tipo de recursión: no aplica
(define (propiedad-get-nombre prop)
  (list-ref prop 1)
  )

; Descripción: Obtiene el precio de la propiedad
; Dom: propiedad
; Rec: precio (int)
; Tipo de recursión: no aplica
(define (propiedad-get-precio prop)
  (list-ref prop 2)
  )

; Descripción: Obtiene la renta de la propiedad
; Dom: propiedad
; Rec: renta (int)
; Tipo de recursión: no aplica
(define (propiedad-get-renta prop)
  (list-ref prop 3)
  )

; Descripción: Obtiene el dueño de la propiedad
; Dom: propiedad
; Rec: dueño (o null)
; Tipo de recursión: no aplica
(define (propiedad-get-dueño prop)
  (list-ref prop 4)
  )

; Descripción: Obtiene el numero de casas en la propiedad
; Dom: propiedad
; Rec: casas (int)
; Tipo de recursión: no aplica
(define (propiedad-get-casas prop)
  (list-ref prop 5)
  )

; Descripción: Comprueba si es hotel
; Dom: propiedad
; Rec: bool
; Tipo de recursión: no aplica
(define (propiedad-esHotel prop)
  (list-ref prop 6)
  )

; Descripción: Comprueba si esta hipotecada la propiedad
; Dom: propiedad
; Rec: bool
; Tipo de recursión: no aplica
(define (propiedad-estaHipotecada prop)
  (list-ref prop 7)
  )

; Descripcion: calcula la renta de una propiedad considerando casas
; Dom: prop (propiedad)
; Rec: int
(define (propiedad-calcular-renta prop)
  (if (propiedad-estaHipotecada prop)
      0
      (if (not(propiedad-esHotel prop))
          (+ (propiedad-get-renta prop) (* 0.2 (propiedad-get-renta prop) (propiedad-get-casas prop)))
          (* 2 (+ (propiedad-get-renta prop) (* 0.2 (propiedad-get-renta prop))))
          )
      )
  )

;--------SETTERS------
; Descripción: Establece el dueño de una propiedad
; Dom: propiedad(propiedad) X idDueño(int)
; Rec: propiedad
; Tipo de recursión: no aplica
(define (propiedad-set-dueño prop dueño)
  (propiedad (propiedad-get-id prop) (propiedad-get-nombre prop) (propiedad-get-precio prop)
             (propiedad-get-renta prop) dueño (propiedad-get-casas prop) (propiedad-esHotel prop)
             (propiedad-estaHipotecada prop))
  )

; Descripcion: Agrega una casa a la propiedad (de ser posible)
; Dom: prop (propiedad) X game (juego)
; Rec: propiedad
(define (propiedad-construir-casa prop game)
  (if (< (propiedad-get-casas prop) (list-ref game 6))
      (propiedad (propiedad-get-id prop) (propiedad-get-nombre prop) (propiedad-get-precio prop) (propiedad-get-renta prop) (propiedad-get-dueño prop) (+ 1 (propiedad-get-casas prop))
                 (propiedad-esHotel prop) (propiedad-estaHipotecada prop))
      prop
      )
  )

; Descripcion: construye un hotel en la propiedad (de ser posible)
; Dom: prop (propiedad) X game (juego)
; Rec: propiedad
(define (propiedad-construir-hotel prop game)
  (if (= (propiedad-get-casas prop) (list-ref game 6))
      (propiedad (propiedad-get-id prop) (propiedad-get-nombre prop) (propiedad-get-precio prop) (propiedad-get-renta prop)
                 (propiedad-get-dueño prop) 0 #f (propiedad-estaHipotecada prop))
      prop
      )
  )

; Descripcion: hipoteca la propiedad
; Dom: prop (propiedad)
; Rec: propiedad
(define (propiedad-hipotecar prop)
  (if (not (propiedad-estaHipotecada prop))
      (propiedad (propiedad-get-id prop) (propiedad-get-nombre prop) (propiedad-get-precio prop)
                 (propiedad-get-renta prop) (propiedad-get-dueño prop) (propiedad-get-casas prop)
                 (propiedad-esHotel prop) #t)
      prop
      )
  )
