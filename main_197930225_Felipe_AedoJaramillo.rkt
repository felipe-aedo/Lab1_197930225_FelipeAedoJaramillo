#lang scheme

(require "TDA_juego.rkt" "TDA_player.rkt" "TDA_carta.rkt" "TDA_propiedad.rkt" "TDA_tablero.rkt")

;Exportar todos los módulos
(provide (all-from-out "TDA_player.rkt")
         (all-from-out "TDA_tablero.rkt")
         (all-from-out "TDA_carta.rkt")
         (all-from-out "TDA_propiedad.rkt")
         (all-from-out "TDA_juego.rkt"))