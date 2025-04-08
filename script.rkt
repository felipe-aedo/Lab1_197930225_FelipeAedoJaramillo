#lang scheme

(require "TDA_tablero.rkt" "TDA_carta.rkt" "TDA_player.rkt" "TDA_propiedad.rkt" "TDA_juego.rkt")

; 1. Creación de jugadores
(define p1 (player 1 "Carlos" 1500 '() 0 #f 0))
(define p2 (player 2 "Ana" 1500 '() 0 #f 0))
(define p3 (player 3 "Luis" 1500 '() 0 #f 0))

; 2. Creación de propiedades para el juego
(define prop1 (propiedad 1 "Paseo Mediterráneo" 60 12 null 0 #f #f))
(define prop2 (propiedad 2 "Avenida Báltica" 60 12 null 0 #f #f))
(define prop3 (propiedad 3 "Avenida Oriental" 100 20 null 0 #f #f))
(define prop4 (propiedad 4 "Avenida Vermont" 100 35 null 0 #f #f))
(define prop5 (propiedad 5 "Avenida Connecticut" 120 38 null 0 #f #f))
(define prop6 (propiedad 6 "Plaza San Carlos" 140 40 null 0 #f #f))

; 3. Creación de cartas de suerte y arca comunal
(define chance1 (carta 1 "suerte" "Avance hasta la casilla de salida" 'go-to-start))
(define chance2 (carta 2 "suerte" "Vaya a la cárcel" 'go-to-jail))
(define chance3 (carta 3 "suerte" "El banco le paga $50" 'bank-pays))
(define community1 (carta 4 "comunidad" "Pague impuestos por $100" 'pay-tax))
(define community2 (carta 5 "comunidad" "Es su cumpleaños, reciba $10 de cada jugador" 'birthday))
(define community3 (carta 6 "comunidad" "Salga de la cárcel gratis" 'get-out-of-jail))

; 4. Creación del tablero inicial
(define empty-board (tablero '() '() '() '()))

; 5. Agregar propiedades y cartas al tablero
(define board1 (tablero-agregar-propiedad empty-board prop1 1))
(define board2 (tablero-agregar-propiedad board1 prop2 3))
(define board3 (tablero-agregar-propiedad board2 prop3 6))
(define board4 (tablero-agregar-propiedad board3 prop4 8))
(define board5 (tablero-agregar-propiedad board4 prop5 9))
(define board6 (tablero-agregar-propiedad board5 prop6 11))
;cartasSuerte
(define board7 (tablero-agregar-cartaSuerte board6 chance1))
(define board8 (tablero-agregar-cartaSuerte board7 chance2))
(define board9 (tablero-agregar-cartaSuerte board8 chance3))
;cartasComunidad
(define board10 (tablero-agregar-cartaComunidad board9 community1))
(define board11 (tablero-agregar-cartaComunidad board10 community2))
(define board12 (tablero-agregar-cartaComunidad board11 community3))

; 6. Creación de un nuevo juego
(define g0 (juego '() board12 20000 2 0 10 4 1 "preparation"))

; 7. Agregar jugadores al juego
(define g1 (juego-agregar-jugador g0 p1))
(define g2 (juego-agregar-jugador g1 p2))
(define g3 (juego-agregar-jugador g2 p3))
