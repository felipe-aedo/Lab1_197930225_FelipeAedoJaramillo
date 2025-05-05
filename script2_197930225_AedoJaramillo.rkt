#lang scheme

(require "main_197930225_AedoJaramillo.rkt")

; 1. Jugadores
(define j1 (jugador 1 "Luigi" 5000 '() 0 #f 0))
(define j2 (jugador 2 "Mario" 5000 '() 0 #f 0))
(define j3 (jugador 3 "Peach" 5000 '() 0 #f 0))


; 2. Propiedades
(define pr1 (propiedad 1 "ChampiCasa" 1300 400 '() 0 #f #f))
(define pr2 (propiedad 2 "Plaza Yoshi" 100 30 '() 0 #f #f))
(define pr3 (propiedad 3 "Mansion Boo" 2200 750 '() 0 #f #f))
(define pr4 (propiedad 4 "Circuito Mario" 1800 600 '() 0 #f #f))
(define pr5 (propiedad 5 "Castillo Peach" 3500 1250 '() 0 #f #f))
(define pr6 (propiedad 6 "Tubería Secreta" 600 160 '() 0 #f #f))
(define pr7 (propiedad 7 "Senda Arcoíris" 2800 950 '() 0 #f #f))
(define pr8 (propiedad 8 "Fortaleza Bowser" 4000 1500 '() 0 #f #f))
(define pr9 (propiedad 9 "Club Koopa" 750 200 '() 0 #f #f))
(define pr10 (propiedad 10 "Desierto Tostisol" 900 300 '() 0 #f #f))
(define pr11 (propiedad 11 "Montaña Nevada" 1100 340 '() 0 #f #f))
(define pr12 (propiedad 12 "Isla Delfino" 1600 550 '() 0 #f #f))
(define pr13 (propiedad 13 "Ruinas Chomp" 2000 700 '() 0 #f #f))
(define pr14 (propiedad 14 "Nube de Lakitu" 2500 820 '() 0 #f #f))
(define pr15 (propiedad 15 "Mansion de Luigi" 3000 1100 '() 0 #f #f))

; 3. Cartas
(define cs1 (carta 1 "suerte" "El banco te da $50" banco-paga))
(define cs2 (carta 2 "suerte" "Vas a la cárcel" jugador-encarcelar))
(define cs3 (carta 3 "suerte" "Vas hasta la salida" jugador-ir-salida))
(define cc1 (carta 4 "comunidad" "Paga impuesto de $100" evento-impuesto))
(define cc2 (carta 5 "comunidad" "Es tu cumpleaños, recibe $10 de cada jugador" evento-cumpleaños))
(define cc3 (carta 6 "comunidad" "Salga de la cárcel gratis" jugador-agregar-carta))

; 4. Tablero
(define tablero-vacio 
  (tablero '() 
           (list cs1 cs2 cs3) 
           (list cc1 cc2 cc3)
           (list 
              (cons 'salida 0)
              (cons 'suerte 3)
              (cons 'comunidad 6)
              (cons 'suerte 9)
              (cons 'comunidad 12)
              (cons 'suerte 15)
              (cons 'carcel 17)
              (cons 'comunidad 19)
              )))

(define lista-props (list
  (cons pr1 1)  ; ChampiCasa en la posición 1
  (cons pr2 2)  ; Plaza Yoshi en la posición 2
  (cons pr3 4)  ; Mansión Boo en la posición 4
  (cons pr4 5)  ; Circuito Mario en la posición 5
  (cons pr5 7)  ; Castillo Peach en la posición 7
  (cons pr6 8)  ; Tubería Secreta en la posición 8
  (cons pr7 10) ; Senda Arcoíris en la posición 10
  (cons pr8 11) ; Fortaleza Bowser en la posición 11
  (cons pr9 13) ; Club Koopa en la posición 13
  (cons pr10 14) ; Desierto Tostisol en la posición 14
  (cons pr11 16) ; Montaña Nevada en la posición 16
  (cons pr12 18) ; Isla Delfino en la posición 17
  (cons pr13 20) ; Ruinas Chomp en la posición 18
  (cons pr14 21) ; Nube de Lakitu en la posición 19
  (cons pr15 22) ; Mansion de Luigi en la posición 20
  ))
(define tablero-completo (tablero-agregar-propiedad tablero-vacio lista-props))

; 5. Juego
(define g0 (juego '() tablero-completo 40000 2 1 10 4 1))
(define g1 (juego-agregar-jugador g0 j1))
(define g2 (juego-agregar-jugador g1 j2))
(define g3 (juego-agregar-jugador g2 j3))

g3
(display "===== CAPITALIA =====\n\n")

; Turno 1: Luigi
(display "TURNO 1: Luigi\n")
(define g4 (juego-jugar-turno g3 (juego-lanzar-dados 1 3) #t #f #f #f))
g4

; Turno 2: Mario 
(display "TURNO 2: Mario\n")
(define g5 (juego-jugar-turno g4 (juego-lanzar-dados 6  3) #t #f #f #f))
g5

; Turno 3: Peach 
(display "TURNO 3: Peach\n")
(define g6 (juego-jugar-turno g5 (juego-lanzar-dados 2 2) #t #f #f #f))

g6

; Turno 4: Luigi
(display "TURNO 4: Luigi\n")
(define g7 (juego-jugar-turno g6 (juego-lanzar-dados 2 5) #t #f #f #f))
g7

; Turno 5: Mario
(display "TURNO 5: Mario\n")
(define g8 (juego-jugar-turno g7 (juego-lanzar-dados 4 1) #t #f #f #f))
g8

; Turno 6: Peach
(display "TURNO 6: Peach\n")
(define g9 (juego-jugar-turno g8 (juego-lanzar-dados 3 3) #t #f #f #f))
g9

; Turno 7: Luigi
(display "TURNO 7: Luigi\n")
(define g10 (juego-jugar-turno g9 (juego-lanzar-dados 1 6) #t #f #f #f))
g10

; Turno 8: Mario
(display "TURNO 8: Mario\n")
(define g11 (juego-jugar-turno g10 (juego-lanzar-dados 5 2) #f #f #t #f))
g11

; Turno 9: Peach
(display "TURNO 9: Peach\n")
(define g12 (juego-jugar-turno g11 (juego-lanzar-dados 2 4) #t #f #f #f))
g12

; Turno 10: Luigi
(display "TURNO 10: Luigi\n")
(define g13 (juego-jugar-turno g12 (juego-lanzar-dados 3 1) #t #f #f #f))
g13

; Turno 11: Mario
(display "TURNO 11: Mario\n")
(define g14 (juego-jugar-turno g13 (juego-lanzar-dados 5 3) #t #f #f #f))
g14

; Turno 12: Peach
(display "TURNO 12: Peach\n")
(define g15 (juego-jugar-turno g14 (juego-lanzar-dados 1 2) #t #f #f #f))
g15

; Turno 13: Luigi
(display "TURNO 13: Luigi\n")
(define g16 (juego-jugar-turno g15 (juego-lanzar-dados 4 4) #t #f #f #f))
g16

; Turno 14: Mario
(display "TURNO 14: Mario\n")
(define g17 (juego-jugar-turno g16 (juego-lanzar-dados 2 5) #t #f #f #f))
g17

; Turno 15: Peach
(display "TURNO 15: Peach\n")
(define g18 (juego-jugar-turno g17 (juego-lanzar-dados 6 1) #t #f #f #f))
g18

; Turno 16: Luigi
(display "TURNO 16: Luigi\n")
(define g19 (juego-jugar-turno g18 (juego-lanzar-dados 1 1) #t #f #f #f))
g19

; Turno 17: Mario
(display "TURNO 17: Mario\n")
(define g20 (juego-jugar-turno g19 (juego-lanzar-dados 3 2) #t #f #f #f))
g20

; Turno 18: Peach
(display "TURNO 18: Peach\n")
(define g21 (juego-jugar-turno g20 (juego-lanzar-dados 5 4) #t #f #f #f))
g21

; Turno 19: Luigi
(display "TURNO 19: Luigi\n")
(define g22 (juego-jugar-turno g21 (juego-lanzar-dados 2 3) #t #f #f #f))
g22

; Turno 20: Mario
(display "TURNO 20: Mario\n")
(define g23 (juego-jugar-turno g22 (juego-lanzar-dados 4 1) #t #f #f #f))
g23

; Turno 21: Peach
(display "TURNO 21: Peach\n")
(define g24 (juego-jugar-turno g23 (juego-lanzar-dados 6 5) #t #f #f #f))
g24

; Turno 22: Luigi
(display "TURNO 22: Luigi\n")
(define g25 (juego-jugar-turno g24 (juego-lanzar-dados 3 3) #t #f #f #f))
g25

; Turno 23: Mario
(display "TURNO 23: Mario\n")
(define g26 (juego-jugar-turno g25 (juego-lanzar-dados 1 4) #t #f #f #f))
g26

; Turno 24: Peach
(display "TURNO 24: Peach\n")
(define g27 (juego-jugar-turno g26 (juego-lanzar-dados 5 2) #t #f #f #f))
g27

; Turno 25: Luigi
(display "TURNO 25: Luigi\n")
(define g28 (juego-jugar-turno g27 (juego-lanzar-dados 2 1) #t #f #f #f))
g28

; Turno 26: Mario
(display "TURNO 26: Mario\n")
(define g29 (juego-jugar-turno g28 (juego-lanzar-dados 4 6) #t #f #f #f))
g29

; Turno 27: Peach
(display "TURNO 27: Peach\n")
(define g30 (juego-jugar-turno g29 (juego-lanzar-dados 6 3) #t #f #f #f))
g30