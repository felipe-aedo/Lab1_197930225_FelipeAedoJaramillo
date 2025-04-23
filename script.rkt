#lang scheme

(require "TDA_tablero.rkt" "TDA_carta.rkt" "TDA_player.rkt" "TDA_propiedad.rkt" "TDA_juego.rkt")

; 1. Creación de jugadores
(define p1 (jugador 1 "Carlos" 1500 '() 0 #f 0))
(define p2 (jugador 2 "Ana" 1500 '() 0 #f 0))
(define p3 (jugador 3 "Luis" 1500 '() 0 #f 0))

; 2. Creación de propiedades para el juego
(define prop1 (propiedad 1 "Paseo Mediterráneo" 60 12 null 0 #f #f))
(define prop2 (propiedad 2 "Avenida Báltica" 60 12 null 0 #f #f))
(define prop3 (propiedad 3 "Avenida Oriental" 100 20 null 0 #f #f))
(define prop4 (propiedad 4 "Avenida Vermont" 100 35 null 0 #f #f))
(define prop5 (propiedad 5 "Avenida Connecticut" 120 38 null 0 #f #f))
(define prop6 (propiedad 6 "Plaza San Carlos" 140 40 null 0 #f #f))
(define prop7 (propiedad 7 "Avenida St. James" 180 14 #f 0 #f #f))
(define prop8 (propiedad 8 "Avenida Tennessee" 180 14 #f 0 #f #f))

(define lista-propiedades (list (cons prop1 1) (cons prop2 3) (cons prop3 6) (cons prop4 8) (cons prop5 9) (cons prop6 11) (cons prop7 13) (cons prop8 14)))

; 3. Creación de cartas de suerte y arca comunal
(define chance1 (carta 1 "suerte" "Avance hasta la casilla de salida" 'go-to-start))
(define chance2 (carta 2 "suerte" "Vaya a la cárcel" 'go-to-jail))
(define chance3 (carta 3 "suerte" "El banco le paga $50" 'bank-pays))
(define lista-suerte (list chance1 chance2 chance3))

(define community1 (carta 4 "comunidad" "Pague impuestos por $100" 'pay-tax))
(define community2 (carta 5 "comunidad" "Es su cumpleaños, reciba $10 de cada jugador" 'birthday))
(define community3 (carta 6 "comunidad" "Salga de la cárcel gratis" 'get-out-of-jail))
(define lista-comunidad (list community1 community2 community3))

; 4. Creación del tablero
(define empty-board (tablero '() '() '() (list (cons 'salida 0) (cons 'carcel 10) (cons 'suerte 7) (cons 'comunidad 17))))

(define board0 (tablero-agregar-propiedad empty-board lista-propiedades))
;cartasSuerte
(define board1 (tablero-agregar-cartaSuerte board0 lista-suerte))
;cartasComunidad
(define board2 (tablero-agregar-cartaComunidad board1 lista-comunidad))

; 5. Creación de un nuevo juego
(define g0 (juego '() board2 20000 2 1 10 4 1 "preparation"))

; 6. Agregar jugadores al juego
(define g1 (juego-agregar-jugador g0 p1))
(define g2 (juego-agregar-jugador g1 p2))
(define g3 (juego-agregar-jugador g2 p3))

; 7. Jugar
(display "===== CAPITALIA =====\n\n")
;actualizar estado
(define g4(juego-set-estado g3 "playing"))

; Turno 1: Carlos
(display "TURNO 1: Carlos\n")

(define semilla-1 12345)
(define semilla-2 51234)
(define dados-carlos (juego-lanzar-dados semilla-1 semilla-2))

(define p1-movido (jugador-mover p1 dados-carlos g2))

(define posicion-carlos (player-get-posicion p1-movido))
(define prop-carlos (tablero-obtener-propiedad board2 posicion-carlos))

(define p1-actualizado (player-comprar-propiedad p1-movido prop-carlos))
(define prop-carlos-actualizada (propiedad-set-dueño prop-carlos 1))

(define g5 (juego-actualizar-jugador g4 p1-actualizado))
(define g6 (juego-actualizar-propiedad g5 prop-carlos-actualizada))

