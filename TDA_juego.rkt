#lang scheme

(require "TDA_player.rkt" "TDA_carta.rkt" "TDA_propiedad.rkt" "TDA_tablero.rkt")
(provide juego juego? juego-agregar-jugador juego-lanzar-dados juego-set-estado juego-actualizar-jugador juego-actualizar-propiedad)

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
(define (juego? game)
  (if (list? game)
      (if (= 9 (length game))
          (if (and (list? (list-ref game 0))
                   (andmap jugador? (list-ref game 0)); jugadores
                   (tablero? (list-ref game 1))              ; tablero
                   (integer? (list-ref game 2))              ; dineroBanco
                   (integer? (list-ref game 3))
                   (integer? (list-ref game 4))
                   (integer? (list-ref game 5))
                   (integer? (list-ref game 6))
                   (integer? (list-ref game 7))
                   (string? (list-ref game 8))
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
(define (juego-get-estadoJuego game)
  (list-ref game 8)
  )

; Descripcion: obtiene jugador turno actual
; Dominio: juego
; Rec: player
(define (juego-obtener-jugador-actual game)
  (car(filter
   (lambda (jugador)
     (= (player-get-id jugador) (juego-get-turnoActual game))
     )
   (juego-get-jugadores game)
   ))
  )

;retorna lista de jugadores que no están de turno
; Dom: game (juego)
; Rec: lista de jugadores
(define (juego-restoJugadores game)
  (filter
   (lambda (jugador)
     (not(= (player-get-id jugador) (juego-get-turnoActual game)))
     )
   (juego-get-jugadores game)
   )
  )

;------SETTERS------

; Descripción: Agrega un jugador a la lista de jugadores
; Dom: juego X jugador
; Rec: juego
(define (juego-agregar-jugador game player)
  (if (and (jugador? player) (juego? game))
      (juego (cons player (juego-get-jugadores game)) (juego-get-tablero game) (juego-get-dineroBanco game) (juego-get-numeroDados game)
             (juego-get-turnoActual game) (juego-get-tasaImpuesto game) (juego-get-maximoCasas game) (juego-get-maximoHoteles game)
             (juego-get-estadoJuego game))
      null
      )
  )

; Actualiza el estado del juego
; Dom: game (juego) X estado (string)
; Rec: game
(define (juego-set-estado game estado)
  (juego (juego-get-jugadores game) (juego-get-tablero game)
         (juego-get-dineroBanco game) (juego-get-numeroDados game)
         (juego-get-turnoActual game) (juego-get-tasaImpuesto game)
         (juego-get-maximoCasas game) (juego-get-maximoHoteles game)
         estado)
  )

; Actualiza una propiedad en el tablero de un juego. retorna juego actualizado
; Dom: game (juego) X prop (propiedad)
; Rec: juego
(define (juego-actualizar-propiedad game prop)
  (juego (juego-get-jugadores game) (tablero-actualizar-propiedad (juego-get-tablero game) prop)
         (juego-get-dineroBanco game) (juego-get-numeroDados game)
         (juego-get-turnoActual game) (juego-get-tasaImpuesto game)
         (juego-get-maximoCasas game) (juego-get-maximoHoteles game)
         (juego-get-estadoJuego game))
  )

;devuelve el juego con el player actualizado
; Dom: game (juego) X player (jugador)
; Rec: juego
(define (juego-actualizar-jugador game player)
  (juego (cons player (juego-restoJugadores game)) (juego-get-tablero game)
         (juego-get-dineroBanco game) (juego-get-numeroDados game)
         (juego-get-turnoActual game) (juego-get-tasaImpuesto game)
         (juego-get-maximoCasas game) (juego-get-maximoHoteles game)
         (juego-get-estadoJuego game))
  )


; Funcion myRandom
(define (myRandom Xn)
  (modulo (+ (* 1103515245 Xn) 12345) 2147483648))
; Funcion getDadoRandom que recibe la semilla y controla los resultados
(define (getDadoRandom seed)                    
  (+ 1 (modulo (myRandom seed) 6)))


; Descripción: Generador de dados
; Dom : seed1 X seed2
; Rec : pair 
(define (juego-lanzar-dados seed1 seed2)
  (cons (getDadoRandom seed1) (getDadoRandom seed2))
  )