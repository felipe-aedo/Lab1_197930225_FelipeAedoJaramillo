#lang scheme

(require "main_197930225_AedoJaramillo.rkt")

; 1. Jugadores
(define j1 (jugador 1 "Link" 2500 '() 0 #f 0))
(define j2 (jugador 2 "Zelda" 2500 '() 0 #f 0))


; 2. Propiedades 
(define zlpr1 (propiedad 1 "Villa Kokiri" 1300 400 '() 0 #f #f))
(define zlpr2 (propiedad 2 "Bosque Kokiri" 100 30 '() 0 #f #f))
(define zlpr3 (propiedad 3 "Castillo de Hyrule" 2200 750 '() 0 #f #f))
(define zlpr4 (propiedad 4 "Ciudad de Hyrule" 1800 600 '() 0 #f #f))
(define zlpr5 (propiedad 5 "Templo del Tiempo" 2000 1050 '() 0 #f #f))
(define zlpr6 (propiedad 6 "Gran Árbol Deku" 600 160 '() 0 #f #f))
(define zlpr7 (propiedad 7 "Valle Gerudo" 1800 950 '() 0 #f #f))
(define zlpr8 (propiedad 8 "Fortaleza Gerudo" 2000 1500 '() 0 #f #f))
(define zlpr9 (propiedad 9 "Lago Hylia" 450 200 '() 0 #f #f))
(define zlpr10 (propiedad 10 "Dominio Zora" 900 300 '() 0 #f #f))
(define zlpr11 (propiedad 11 "Fuente de los Zora" 1100 340 '() 0 #f #f))
(define zlpr12 (propiedad 12 "Cañón del Desierto" 1600 550 '() 0 #f #f))
(define zlpr13 (propiedad 13 "Templo del Espíritu" 2000 700 '() 0 #f #f))
(define zlpr14 (propiedad 14 "Templo del Fuego" 2500 1820 '() 0 #f #f))
(define zlpr15 (propiedad 15 "Montaña de la Muerte" 2100 1100 '() 0 #f #f))

; 3. Cartas
(define zlcs1 (carta 1 "suerte" "Encuentras una Rupia grande, ¡recibes 50!" banco-paga))
(define zlcs2 (carta 2 "suerte" "Te pierdes en el bosque." jugador-ir-salida)) 
(define zlcs3 (carta 3 "suerte" "Has caído en el calabozo." jugador-encarcelar))

(define zlcc1 (carta 4 "comunidad" "Te ganaste una tarjeta para escapar del calabozo." jugador-agregar-carta))
(define zlcc2 (carta 5 "comunidad" "Encuentras un fragmento de corazón, ¡recibes 10 de cada jugador!" evento-cumpleaños))
(define zlcc3 (carta 6 "comunidad" "El castillo cobra sus impuestos." evento-impuesto))

; 4. Tablero
(define tablero-vacio
  (tablero '()
          (list zlcs1 zlcs2 zlcs3)
          (list zlcc1 zlcc2 zlcc3)
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
  (cons zlpr1 1)  ; Villa Kokiri
  (cons zlpr2 2)  ; Bosque Kokiri
  (cons zlpr3 4)  ; Castillo de Hyrule
  (cons zlpr4 5)  ; Ciudad de Hyrule
  (cons zlpr5 7)  ; Templo del Tiempo
  (cons zlpr6 8)  ; Gran Árbol Deku
  (cons zlpr7 10) ; Valle Gerudo
  (cons zlpr8 11) ; Fortaleza Gerudo
  (cons zlpr9 13) ; Lago Hylia
  (cons zlpr10 14) ; Dominio Zora
  (cons zlpr11 16) ; Fuente de los Zora
  (cons zlpr12 18) ; Cañón del Desierto
  (cons zlpr13 20) ; Templo del Espíritu
  (cons zlpr14 21) ; Templo del Fuego
  (cons zlpr15 22) ; Montaña de la Muerte
  ))
(define tablero-completo (tablero-agregar-propiedad tablero-vacio lista-props))

; 5. Juego
(define g0 (juego '() tablero-completo 15000 2 1 10 4 1)) ; Inicialmente 2 jugadores, luego agregamos el tercero
(define g1 (juego-agregar-jugador g0 j1))
(define g2 (juego-agregar-jugador g1 j2))

g2
(display "===== CAPITALIA =====\n\n")

; Turno 1: Link
(display "TURNO 1: Link\n")
(define g3 (juego-jugar-turno g2 (juego-lanzar-dados 1 3) #t #f #f #f))
g3

; Turno 2: Zelda
(display "TURNO 2: Zelda\n")
(define g4 (juego-jugar-turno g3 (juego-lanzar-dados 6  3) #t #f #f #f))
g4

; Turno 3: Link
(display "TURNO 3: Link\n")
(define g5 (juego-jugar-turno g4 (juego-lanzar-dados 2 2) #t #f #f #f))
g5

; Turno 4: Zelda
(display "TURNO 4: Zelda\n")
(define g6 (juego-jugar-turno g5 (juego-lanzar-dados 2 5) #t #f #f #f))
g6

; Turno 5: Link
(display "TURNO 5: Link\n")
(define g7 (juego-jugar-turno g6 (juego-lanzar-dados 4 1) #t #f #f #f))
g7

; Turno 6: Zelda
(display "TURNO 6: Zelda\n")
(define g8 (juego-jugar-turno g7 (juego-lanzar-dados 3 3) #t #f #f #f))
g8

; Turno 7: Link
(display "TURNO 7: Link\n")
(define g9 (juego-jugar-turno g8 (juego-lanzar-dados 1 6) #f #f #t #f))
g9

; Turno 8: Zelda
(display "TURNO 8: Zelda\n")
(define g10 (juego-jugar-turno g9 (juego-lanzar-dados 5 2) #t #f #f #f))
g10

; Turno 9: Link
(display "TURNO 9: Link\n")
(define g11 (juego-jugar-turno g10 (juego-lanzar-dados 2 4) #t #f #f #f))
g11

; Turno 10: Zelda
(display "TURNO 10: Zelda\n")
(define g12 (juego-jugar-turno g11 (juego-lanzar-dados 3 1) #t #f #f #f))
g12

; Turno 11: Link
(display "TURNO 11: Link\n")
(define g13 (juego-jugar-turno g12 (juego-lanzar-dados 5 3) #t #f #f #f))
g13

; Turno 12: Zelda
(display "TURNO 12: Zelda\n")
(define g14 (juego-jugar-turno g13 (juego-lanzar-dados 1 2) #t #f #f #f))
g14

; Turno 13: Link
(display "TURNO 13: Link\n")
(define g15 (juego-jugar-turno g14 (juego-lanzar-dados 4 4) #t #f #f #f))
g15

; Turno 14: Zelda
(display "TURNO 14: Zelda\n")
(define g16 (juego-jugar-turno g15 (juego-lanzar-dados 2 5) #t #f #f #f))
g16

; Turno 15: Link
(display "TURNO 15: Link\n")
(define g17 (juego-jugar-turno g16 (juego-lanzar-dados 6 1) #t #f #f #f))
g17

; Turno 16: Zelda
(display "TURNO 16: Zelda\n")
(define g18 (juego-jugar-turno g17 (juego-lanzar-dados 1 1) #t #f #f #f))
g18

; Turno 17: Link
(display "TURNO 17: Link\n")
(define g19 (juego-jugar-turno g18 (juego-lanzar-dados 3 2) #t #f #f #f))
g19

; Turno 18: Zelda
(display "TURNO 18: Zelda\n")
(define g20 (juego-jugar-turno g19 (juego-lanzar-dados 5 4) #t #f #f #f))
g20

; Turno 19: Link
(display "TURNO 19: Link\n")
(define g21 (juego-jugar-turno g20 (juego-lanzar-dados 2 3) #t #f #f #f))
g21

; Turno 20: Zelda
(display "TURNO 20: Zelda\n")
(define g22 (juego-jugar-turno g21 (juego-lanzar-dados 4 1) #t #f #f #f))
g22

; Turno 21: Link
(display "TURNO 21: Link\n")
(define g23 (juego-jugar-turno g22 (juego-lanzar-dados 6 5) #t #f #f #f))
g23

; Turno 22: Zelda
(display "TURNO 22: Zelda\n")
(define g24 (juego-jugar-turno g23 (juego-lanzar-dados 3 3) #t #f #f #f))
g24

; Turno 23: Link
(display "TURNO 23: Link\n")
(define g25 (juego-jugar-turno g24 (juego-lanzar-dados 1 4) #t #f #f #f))
g25

; Turno 24: Zelda
(display "TURNO 24: Zelda\n")
(define g26 (juego-jugar-turno g25 (juego-lanzar-dados 5 2) #t #f #f #f))
g26