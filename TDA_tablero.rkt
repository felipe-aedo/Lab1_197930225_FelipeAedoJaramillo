#lang scheme

(require "TDA_propiedad.rkt" "TDA_player.rkt" "TDA_carta.rkt")
(provide tablero tablero? tablero-agregar-propiedad tablero-actualizar-propiedad tablero-agregar-cartaSuerte
         tablero-agregar-cartaComunidad tablero-obtener-propiedad tablero-get-propiedades tablero-get-casillasEspeciales
         tablero-get-cartasSuerte tablero-get-cartasComunidad tablero-get-posicionX)

;-----CONSTRUCTOR-----
; Descripción: Constructor TDA tablero
; Dom: propiedades (lista) X cartas-suerte (lista) X cartas-comunidad (lista) X casillas-especiales (lista)
; Rec: tablero
; Tipo recursión: No aplica
(define (tablero propiedades cartas-suerte cartas-comunidad casillas-especiales)
   (list propiedades cartas-suerte cartas-comunidad casillas-especiales)
  )


;-----PERTENENCIA-----
; Descripción: Comprueba si pertenece al TDA tablero
; Dom: tablero (list)
; Rec: Bool
; Tipo de recursión: No aplica
(define (tablero? tab)
  (and (list? tab)
       (= 4 (length tab))
       (list? (list-ref tab 0)) ; propiedades
       (list? (list-ref tab 1)) ; cartas-suerte
       (list? (list-ref tab 2)) ; cartas-comunidad
       (list? (list-ref tab 3)) ; casillas-especiales
       (andmap pair? (list-ref tab 0))
       (andmap carta? (list-ref tab 1))
       (andmap carta? (list-ref tab 2))
       (andmap pair? (list-ref tab 3))
       )
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

; Descripcion: obtiene la propiedad que coincide con la posicion ingresada
; Dom: tab (tablero) X pos (int)
; rec: propiedad
(define (tablero-obtener-propiedad tab pos)
  (if (null? (filter (lambda(p) (= pos (cdr p))) (tablero-get-propiedades tab)))
      null
      (caar(filter (lambda(p) (= pos (cdr p))) (tablero-get-propiedades tab)))
      )
  )

; Obtiene el item (propiedad o casillaEspecial) que exista en la posicion X
; Dom: tab (tablero) X pos (int)
; Rec: casillaEspecial o propiedad (pair)
(define (tablero-get-posicionX tab pos)
  (if (tablero? tab)
      (caar(filter (lambda(par) (= pos (cdr par))) (append (tablero-get-propiedades tab) (tablero-get-casillasEspeciales tab))))
      '()
      )
  )

;-----SETTERS-----
; Descripción: agrega una propiedad a la lista de propiedades del tablero
; Dom: tablero (tablero) X lista de pares (propiedad , posicion)
; Rec: tablero
; Tipo de recursión: no aplica
(define (tablero-agregar-propiedad tab propiedades)
  (tablero propiedades (tablero-get-cartasSuerte tab) (tablero-get-cartasComunidad tab) (tablero-get-casillasEspeciales tab))
  )

; actualiza una propiedad en la lista de propiedades. retorna el tablero actualizado
; Dom: tab (tablero) X prop (propiedad)
; Rec: tablero
(define (tablero-actualizar-propiedad tab prop)
  (tablero
  (map (lambda (p) (if (= (propiedad-get-id prop) (propiedad-get-id (car p))) (cons prop (cdr p)) p)) (tablero-get-propiedades tab))
  (tablero-get-cartasSuerte tab)
  (tablero-get-cartasComunidad tab)
  (tablero-get-casillasEspeciales tab)
  )
  )

; Descripción: agrega una carta a la lista de cartasSuerte
; Dom: tablero (tablero) X listaCartas (list)
; Rec: tablero
; Tipo de recursión: no aplica
(define (tablero-agregar-cartaSuerte tab listaSuerte)
  (tablero (tablero-get-propiedades tab) listaSuerte
           (tablero-get-cartasComunidad tab) (tablero-get-casillasEspeciales tab))
  )

; Descripción: agrega una carta a la lista de cartasComunidad
; Dom: tablero (tablero) X listaCartas (list)
; Rec: tablero
; Tipo de recursión: no aplica
(define (tablero-agregar-cartaComunidad tab listaComunidad)
  (tablero (tablero-get-propiedades tab) (tablero-get-cartasSuerte tab)
           listaComunidad (tablero-get-casillasEspeciales tab))
  )