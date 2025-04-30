#lang scheme

(require "TDA_player.rkt" "TDA_carta.rkt" "TDA_propiedad.rkt" "TDA_tablero.rkt")
(provide juego juego? juego-agregar-jugador juego-lanzar-dados juego-set-estado juego-actualizar-jugador juego-actualizar-jugadores
         juego-actualizar-propiedad juego-get-tablero jugador-mover juego-set-turno propiedad-calcular-renta jugador-calcular-renta
         propiedad-construir-casa propiedad-construir-hotel)

;------CONSTRUCTOR--------
; Descripción: Constructor TDA juego
; Dom: jugadores(list) X tablero (tablero) X dineroBanco (int) X numeroDados (int)
;      X turnoActual (int) X tasaImpuesto (int) X maximoCasas (int) X maximoHoteles (int) X estadoJuego (string)
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
(define (juego-get-jugadores game)
  (list-ref game 0)
  )

; Descripción: Obtiene el tablero del juego
; Dom: juego
; Rec: tablero
(define (juego-get-tablero game)
  (list-ref game 1)
  )

; Descripción: Obtiene el dinero del banco
; Dom: juego
; Rec: dineroBanco (int)
(define (juego-get-dineroBanco game)
  (list-ref game 2)
  )

; Descripción: Obtiene el número de dados
; Dom: juego
; Rec: numeroDados (int)
(define (juego-get-numeroDados game)
  (list-ref game 3)
  )

; Descripción: Obtiene el turno actual
; Dom: juego
; Rec: turnoActual (int)
(define (juego-get-turnoActual game)
  (list-ref game 4)
  )

; Descripción: Obtiene la tasa de impuesto
; Dom: juego
; Rec: tasaImpuesto (int)
(define (juego-get-tasaImpuesto game)
  (list-ref game 5)
  )

; Descripción: Obtiene el máximo de casas
; Dom: juego
; Rec: maximoCasas (int)
(define (juego-get-maximoCasas game)
  (list-ref game 6)
  )

; Descripción: Obtiene el máximo de hoteles
; Dom: juego
; Rec: maximoHoteles (int)
(define (juego-get-maximoHoteles game)
  (list-ref game 7)
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
     (= (jugador-get-id jugador) (juego-get-turnoActual game))
     )
   (juego-get-jugadores game)
   ))
  )

;retorna lista de jugadores que no coincidan con el id
; Dom: game (juego) X id (int)
; Rec: lista de jugadores
(define (juego-restoJugadores game id)
  (filter
   (lambda (jugador)
     (not(= (jugador-get-id jugador) id))
     )
   (juego-get-jugadores game)
   )
  )


;retorna la ultima posicion del tablero
; Dom: game (juego)
; Rec: posicion (int)
(define (juego-get-ultimaPosicion game)
  (apply max
         (append
          (map cdr (tablero-get-propiedades (juego-get-tablero game)))
          (map cdr (tablero-get-casillasEspeciales (juego-get-tablero game)))))
  )

;------SETTERS------

; Descripción: Agrega un jugador a la lista de jugadores
; Dom: juego X jugador
; Rec: juego
(define (juego-agregar-jugador game player)
  (if (and (jugador? player) (juego? game))
      (juego (cons player (juego-get-jugadores game)) (juego-get-tablero game) (juego-get-dineroBanco game)
             (juego-get-numeroDados game) (juego-get-turnoActual game) (juego-get-tasaImpuesto game)
             (juego-get-maximoCasas game) (juego-get-maximoHoteles game) (juego-get-estadoJuego game))
      null
      )
  )

; Actualiza el turno del juego
; Dom: game (juego) X turno (int)
; Rec: juego
(define (juego-set-turno game turno)
  (juego (juego-get-jugadores game) (juego-get-tablero game)
         (juego-get-dineroBanco game) (juego-get-numeroDados game)
         turno (juego-get-tasaImpuesto game)
         (juego-get-maximoCasas game) (juego-get-maximoHoteles game)
         (juego-get-estadoJuego game)
         )
  )

; Actualiza el estado del juego
; Dom: game (juego) X estado (string)
; Rec: juego
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
  (juego (cons player (juego-restoJugadores game (jugador-get-id player))) (juego-get-tablero game)
         (juego-get-dineroBanco game) (juego-get-numeroDados game)
         (juego-get-turnoActual game) (juego-get-tasaImpuesto game)
         (juego-get-maximoCasas game) (juego-get-maximoHoteles game)
         (juego-get-estadoJuego game))
  )

;Actualiza una lista de jugadores en el juego (se usa cuando hay una transacción y cambian dos players de forma simultanea)
; Dom : game (juego) X lista jugadores (list)
; Rec : juego
(define (juego-actualizar-jugadores game players)
  (juego-actualizar-jugador (juego-actualizar-jugador game (car players)) (cadr players))
  )


; Descripcion: Agrega una casa a la propiedad (de ser posible)
; Dom: prop (propiedad) X game (juego)
; Rec: propiedad
(define (propiedad-construir-casa prop game)
  (if (< (propiedad-get-casas prop) (juego-get-maximoCasas game))
      (propiedad (propiedad-get-id prop) (propiedad-get-nombre prop) (propiedad-get-precio prop)
                 (propiedad-get-renta prop) (propiedad-get-dueño prop) (+ 1 (propiedad-get-casas prop))
                 (propiedad-esHotel prop) (propiedad-estaHipotecada prop))
      prop
      )
  )

; Descripcion: construye un hotel en la propiedad (de ser posible)
; Dom: prop (propiedad) X game (juego)
; Rec: propiedad
(define (propiedad-construir-hotel prop game)
  (if (= (propiedad-get-casas prop) (juego-get-maximoCasas game))
      (propiedad (propiedad-get-id prop) (propiedad-get-nombre prop) (propiedad-get-precio prop) (propiedad-get-renta prop)
                 (propiedad-get-dueño prop) 0 #t (propiedad-estaHipotecada prop))
      prop
      )
  )

; Descripcion: calcula la renta de una propiedad considerando todas las casas y si es hotel
;              Es necesario el juego al que pertenece para acceder al máximo de casas y así calcular la renta en caso de ser hotel
; Dom: prop (propiedad) X game (juego)
; Rec: int
(define (propiedad-calcular-renta prop game)
  (if (propiedad-estaHipotecada prop)
      0 ;si esta hipotecada no hay renta
      (if (propiedad-esHotel prop)
          (* 2 (+ (propiedad-get-renta prop) (* 0.2 (propiedad-get-renta prop) (juego-get-maximoCasas game))))
          (+ (propiedad-get-renta prop) (* 0.2 (propiedad-get-renta prop) (propiedad-get-casas prop)))
          )
      )
  )

; Calcula la renta de un jugador considerando todas las propiedades en su poder
; Dom: player (jugador) X game (juego)
; Rec: monto (int)
(define (jugador-calcular-renta player game)
  (apply + ;sumar toda las rentas
         (map ;calcular renta a cada propiedad
          (lambda(pair) (propiedad-calcular-renta (car pair) game))
          (filter
           (lambda(pair) ;filtrar las propiedades que posea el player
             (member (propiedad-get-id (car pair))
             (jugador-get-propiedades player))
             )
             (tablero-get-propiedades (juego-get-tablero game)) ;todas las propiedades
             )
           )
          )
         )

; Descripción: Mueve al jugador tras lanzar dados, retorna el player con posicion actualizada
; Dom: jugador X par de dados X juego
; Rec: jugador
(define (jugador-mover player parDados game)
  (if (>= (juego-get-ultimaPosicion game) (+ (jugador-get-posicion player) (apply + parDados))) ;verificar si completa una vuelta
      (jugador-set-posicion player (+ (jugador-get-posicion player) (apply + parDados))) ;no ha completado vuelta
      (jugador-set-posicion player (- (+ (jugador-get-posicion player) (apply + parDados)) (+ 1 (juego-get-ultimaPosicion game))))
      ;reajustar posicion
      )
  )

; Extrae una carta aleatoriamente
; Dom: game(juego) X tipo(string)
; Rec: carta
(define (juego-extraer-carta game tipo)
  (if (string=? tipo "suerte")
      (list-ref
       (tablero-get-cartasSuerte (juego-get-tablero game)) (random (length (tablero-get-cartasSuerte (juego-get-tablero game)))))
      (list-ref
       (tablero-get-cartasComunidad (juego-get-tablero game)) (random (length (tablero-get-cartasSuerte (juego-get-tablero game)))))
      )
  )

; Funcion myRandom
(define (myRandom Xn)
  (modulo (+ (* 1103515245 Xn) 12345) 2147483648)
  )

; Funcion getDadoRandom que recibe la semilla y controla los resultados
(define (getDadoRandom seed)                    
  (+ 1 (modulo (myRandom seed) 6))
  )


; Descripción: Generador de dados, recibe dos semillas, devuelve un par 
; Dom : seed1 X seed2
; Rec : list
(define (juego-lanzar-dados seed1 seed2)
  (begin
    (display "Dado 1: ") (display (getDadoRandom seed1)) (display " | ")
    (display "Dado 2: ") (display (getDadoRandom seed2)) (display "\n")
    (list (getDadoRandom seed1) (getDadoRandom seed2))
    )
  )