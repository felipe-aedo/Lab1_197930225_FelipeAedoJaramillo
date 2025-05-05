#lang scheme

(require "TDA_juego_197930225_AedoJaramillo.rkt" "TDA_jugador_197930225_AedoJaramillo.rkt"
         "TDA_carta_197930225_AedoJaramillo.rkt" "TDA_propiedad_197930225_AedoJaramillo.rkt"
         "TDA_tablero_197930225_AedoJaramillo.rkt")

;Exportar todos los módulos
(provide (all-from-out "TDA_jugador_197930225_AedoJaramillo.rkt")
         (all-from-out "TDA_tablero_197930225_AedoJaramillo.rkt")
         (all-from-out "TDA_carta_197930225_AedoJaramillo.rkt")
         (all-from-out "TDA_propiedad_197930225_AedoJaramillo.rkt")
         (all-from-out "TDA_juego_197930225_AedoJaramillo.rkt"))