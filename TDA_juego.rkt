#lang scheme

(require "TDA_player.rkt" "TDA_carta.rkt" "TDA_propiedad.rkt" "TDA_tablero.rkt")
(provide juego juego? juego-agregar-jugador juego-lanzar-dados juego-actualizar-jugador juego-actualizar-jugadores juego-obtener-jugador-i
         juego-actualizar-propiedad juego-get-tablero jugador-mover juego-set-turno propiedad-calcular-renta jugador-calcular-renta
         propiedad-construir-casa propiedad-construir-hotel juego-jugar-turno)

;------CONSTRUCTOR--------
; Descripción: Constructor TDA juego
; Dom: jugadores(list) X tablero (tablero) X dineroBanco (int) X numeroDados (int)
;      X turnoActual (int) X tasaImpuesto (int) X maximoCasas (int) X maximoHoteles (int) X estadoJuego (string)
; Rec: juego
; Tipo de recursión: no aplica
(define (juego jugadores tablero-x dineroBanco numeroDados turnoActual tasaImpuesto maximoCasas maximoHoteles)
  (list jugadores tablero-x dineroBanco numeroDados turnoActual tasaImpuesto maximoCasas maximoHoteles)
  )


;-----PERTENENCIA-------
; Descripción: Comprueba que pertenece al TDA juego
; Dom: juego (list)
; Rec: Bool
; Tipo de recursión: No aplica
(define (juego? game)
  (if (list? game)
      (if (= 8 (length game))
          (if (and (list? (list-ref game 0))
                   (andmap jugador? (list-ref game 0)); jugadores
                   (tablero? (list-ref game 1))              ; tablero
                   (integer? (list-ref game 2))              ; dineroBanco
                   (integer? (list-ref game 3))
                   (integer? (list-ref game 4))
                   (integer? (list-ref game 5))
                   (integer? (list-ref game 6))
                   (integer? (list-ref game 7))                  
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

; Obtiene el jugador con el id ingresado
; Dom: game(juego) X i (integer)
; Rec: jugador
(define (juego-obtener-jugador-i game i)
  (car (filter (lambda(player) (= i(jugador-get-id player))) (juego-get-jugadores game)))
  )

;obtiene una propiedad de un juego dada una posicion
; Dom: game (juego) X posicion (integer)
; rec: propiedad
(define (juego-obtener-propiedad game posicion)
  (tablero-obtener-propiedad (juego-get-tablero game) posicion)
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
  (apply max ;busca la mayor posicion
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
             (juego-get-maximoCasas game) (juego-get-maximoHoteles game))
      null
      )
  )

; Descripción: Actualiza el turno del juego
; Dom: game (juego) X turno (int)
; Rec: juego
(define (juego-set-turno game turno)
  (juego (juego-get-jugadores game) (juego-get-tablero game)
         (juego-get-dineroBanco game) (juego-get-numeroDados game)
         turno (juego-get-tasaImpuesto game)
         (juego-get-maximoCasas game) (juego-get-maximoHoteles game)
         )
  )


; Actualiza una propiedad en el tablero de un juego. retorna juego actualizado
; Dom: game (juego) X prop (propiedad)
; Rec: juego
(define (juego-actualizar-propiedad game prop)
  (if (null? prop) game
      (juego (juego-get-jugadores game) (tablero-actualizar-propiedad (juego-get-tablero game) prop)
             (juego-get-dineroBanco game) (juego-get-numeroDados game)
             (juego-get-turnoActual game) (juego-get-tasaImpuesto game)
             (juego-get-maximoCasas game) (juego-get-maximoHoteles game)
             )
      )
  )

;devuelve el juego con el player actualizado
; Dom: game (juego) X player (jugador)
; Rec: juego
(define (juego-actualizar-jugador game player)
  (juego (cons player (juego-restoJugadores game (jugador-get-id player))) (juego-get-tablero game)
         (juego-get-dineroBanco game) (juego-get-numeroDados game)
         (juego-get-turnoActual game) (juego-get-tasaImpuesto game)
         (juego-get-maximoCasas game) (juego-get-maximoHoteles game)
  )
  )
  

; Actualiza una lista de jugadores en el juego (se usa cuando hay una transacción y cambian dos players de forma simultanea)
; Dom : game (juego) X lista jugadores (list)
; Rec : juego
(define (juego-actualizar-jugadores game players)
  (juego-actualizar-jugador (juego-actualizar-jugador game (car players)) (cadr players))
  )


; Funcion para facilitar la lógica del bucle principal
; Actualiza jugador y propiedad en un juego. Recibe un "mode" para diferenciar si el player interactúa con la propiedad
; Dom: game(juego) X player(jugador) X prop(propiedad) X mode (integer)
; Rec: juego
(define (juego-actualizar game player prop mode)
  (cond
    ((= 0 mode) ;modo 0: actualiza el player y la propiedad en el juego
      (juego-actualizar-propiedad ;actualizar propiedad y jugador
       (juego-actualizar-jugador game player) prop)
       )
    ((and (= 1 mode) (null? (propiedad-get-dueño prop)) (jugador-puede-comprar? player prop))
     ;modo 1: si es posible comprar la propiedad, actualiza player y propiedad efectuando compra de la propiedad
      (juego-actualizar-propiedad ;actualizar propiedad y jugador
       (juego-actualizar-jugador game (jugador-comprar-propiedad player prop))
       (propiedad-set-dueño prop (jugador-get-id player))
       )
      )
    ((and (propiedad? prop) (= 2 mode) (jugador-posee-propiedad? player prop) (jugador-puede-comprar? player prop))
     ;modo 2: si es posible, construye una casa y actualiza player y propiedad
      (juego-actualizar-propiedad ;actualizar propiedad y jugador
       (juego-actualizar-jugador game (jugador-comprar-casa player prop))
       (propiedad-construir-casa prop game)
       )
      )
    ((and (propiedad? prop) (= 3 mode) (jugador-posee-propiedad? player prop))
     ;modo 3: si es posible, construye hotel y actualiza player y propiedad.
     (juego-actualizar-propiedad ;actualizar propiedad
      game
       (propiedad-construir-hotel prop game)
       )
     )
    (else
      game) ;no se hace nada
    )
  )
  

; Descripcion: Agrega una casa a la propiedad (de ser posible)
; Dom: prop (propiedad) X game (juego)
; Rec: propiedad
(define (propiedad-construir-casa prop game)
  (if (and (< (propiedad-get-casas prop) (juego-get-maximoCasas game))
           (>= (jugador-get-dinero (juego-obtener-jugador-actual game)) (propiedad-get-precio prop))
           (propiedad? prop))
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
; Dom: jugador X juego x lista de dados
; Rec: jugador
(define (jugador-mover player game dados)
  (if (>= (juego-get-ultimaPosicion game) (+ (jugador-get-posicion player) (apply + dados))) ;verificar si completa una vuelta
      (jugador-set-posicion player (+ (jugador-get-posicion player) (apply + dados))) ;no ha completado vuelta
      (jugador-set-posicion player (- (+ (jugador-get-posicion player) (apply + dados)) (+ 1 (juego-get-ultimaPosicion game))))
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
; Dom: Xn (integer)
; Rec: integer
(define (myRandom Xn)
  (modulo (+ (* 1103515245 Xn) 12345) 2147483648)
  )

; Funcion getDadoRandom que recibe la semilla y controla los resultados
; Dom: seed (int)
; Rec: dado (int)
(define (getDadoRandom seed)                    
  (+ 1 (modulo (myRandom seed) 6))
  )


; Descripción: Generador de dados, recibe una cantidad indefinida de semillas, retorna lista de dados resultantes.
; Dom : seed1 X seed2 .... seedN.
; Rec : list
; Tipo de recursión: Natural
(define (juego-lanzar-dados . seedlist)
  (if (null? seedlist)
      '() ;fin de la lista de semillas
      (begin ;para retornar solo la ultima funcion
        (display "Dado: ") (display (getDadoRandom (car seedlist))) (display "\n") ;mostrar dado
        (cons (getDadoRandom (car seedlist)) ;colocar el dado en la lista a retornar
              (apply juego-lanzar-dados (cdr seedlist))) ;llamada recursiva con apply para evitar anidacion de la lista
        )
      )
  )

; Verifica si todos los dados son iguales
; Dom : lista de dados (list)
; Rec: bool
(define (jugada-perfecta? dados)
  (apply =  dados)
  )

;Maneja la logica de turnos, para que se complete un ciclo despues de que juega el jugador de mayor id
; Dom: game(juego)
; Rec: juego
(define (juego-avanzar-turno game)
  (if (= (apply max (map (lambda(player) (jugador-get-id player)) (juego-get-jugadores game))) (juego-get-turnoActual game))
      (juego-set-turno game 1)
      (juego-set-turno game (+ 1 (juego-get-turnoActual game)))
      )
  )

;En curso
(define (juego-jugar-turno game listaDados compCons? consHotel? pagarMc usarTsc)
  (if (not(jugador-estaencarcel (juego-obtener-jugador-actual game))) ;si no esta en la carcel el jugador de turno, se mueve libremente.
      (cond
        ;//////////RAMA 1, cae en una propiedad
        ((propiedad? (tablero-get-posicionX (juego-get-tablero game) (jugador-get-posicion (jugador-mover (juego-obtener-jugador-actual game) game listaDados))))
         (cond ;///// RAMIFICAR RAMA 1 CON LAS FLAGS
           (compCons?  (if (jugador-posee-propiedad? (juego-obtener-jugador-actual game)
                                                     (juego-obtener-propiedad game (jugador-get-posicion (jugador-mover (juego-obtener-jugador-actual game) game listaDados))))
                           ;construir casa
                           (juego-avanzar-turno
                            (juego-actualizar game
                                              (jugador-mover (juego-obtener-jugador-actual game) game listaDados)
                                              (juego-obtener-propiedad game (jugador-get-posicion (jugador-mover
                                                                                                   (juego-obtener-jugador-actual game) game listaDados)) game) 2) ;modo consCasa
                            )
                       
                           (if (null? (propiedad-get-dueño (juego-obtener-propiedad game (jugador-get-posicion (jugador-mover (juego-obtener-jugador-actual game) game listaDados)))))
                               ;propiedad disponible para ser comprada
                               (juego-avanzar-turno 
                                (juego-actualizar game
                                                  (jugador-mover (juego-obtener-jugador-actual game) game listaDados)
                                                  (juego-obtener-propiedad game (jugador-get-posicion (jugador-mover
                                                                                                       (juego-obtener-jugador-actual game) game listaDados))) 1) ;modo compra
                                )
                               ;propiedad con dueño, pagar renta
                               (juego-avanzar-turno (juego-actualizar-jugadores game
                                                                                (jugador-pagar-renta (jugador-mover (juego-obtener-jugador-actual game) game listaDados)
                                                                                                     (juego-obtener-jugador-i game (propiedad-get-dueño (juego-obtener-propiedad game (jugador-get-posicion (jugador-mover (juego-obtener-jugador-actual game) game listaDados)))))
                                                                                                     (propiedad-get-renta (juego-obtener-propiedad game (jugador-get-posicion (jugador-mover (juego-obtener-jugador-actual game) game listaDados)))))
                                                                                )
                                                    )
                               )
                           )
                       )
           ((consHotel?) (if (jugador-posee-propiedad? (juego-obtener-jugador-actual game)
                                                       (juego-obtener-propiedad game (jugador-get-posicion (jugador-mover (juego-obtener-jugador-actual game) game listaDados))))
                             ;construir hotel si posee la propiedad y cumple
                             (juego-avanzar-turno (juego-actualizar-propiedad game
                                                                              (propiedad-construir-hotel (juego-obtener-propiedad game
                                                                                                                                  (jugador-get-posicion (jugador-mover (juego-obtener-jugador-actual game) game listaDados))) game)))
                             ;Verificar si corresponde pagar renta
                             (if (null? (propiedad-get-dueño (juego-obtener-propiedad game (jugador-get-posicion (jugador-mover (juego-obtener-jugador-actual game) game listaDados)))))
                                 (juego-avanzar-turno (juego-actualizar-jugador game (jugador-mover (juego-obtener-jugador-actual game) game listaDados))) ;avanzar sin consecuencias
                                 (juego-avanzar-turno (juego-actualizar-jugadores game ;pagar renta
                                                                                  (jugador-pagar-renta (jugador-mover (juego-obtener-jugador-actual game) game listaDados)
                                                                                                       (juego-obtener-jugador-i game (propiedad-get-dueño (juego-obtener-propiedad game (jugador-get-posicion (jugador-mover (juego-obtener-jugador-actual game) game listaDados)))))
                                                                                                       (propiedad-get-renta (juego-obtener-propiedad game (jugador-get-posicion (jugador-mover (juego-obtener-jugador-actual game) game listaDados)))))
                                                                                  ))
                                 )
                             )
                         )
           (else ;Verificar si corresponde pagar renta
            (if (null? (propiedad-get-dueño (juego-obtener-propiedad game (jugador-get-posicion (jugador-mover (juego-obtener-jugador-actual game) game listaDados))))) 
                                 (juego-avanzar-turno (juego-actualizar-jugador game (jugador-mover (juego-obtener-jugador-actual game) game listaDados))) ;avanzar sin consecuencias
                                 (juego-avanzar-turno (juego-actualizar-jugadores game ;pagar renta
                                                                                  (jugador-pagar-renta (jugador-mover (juego-obtener-jugador-actual game) game listaDados)
                                                                                                       (juego-obtener-jugador-i game (propiedad-get-dueño (juego-obtener-propiedad game (jugador-get-posicion (jugador-mover (juego-obtener-jugador-actual game) game listaDados)))))
                                                                                                       (propiedad-get-renta (juego-obtener-propiedad game (jugador-get-posicion (jugador-mover (juego-obtener-jugador-actual game) game listaDados)))))
                                                                                  ))
                                 )
            )
           )
         )
        ;///////RAMA 2, cae en la salida
        ((eq? (tablero-get-posicionX (juego-get-tablero game) (jugador-get-posicion (jugador-mover (juego-obtener-jugador-actual game) game listaDados))) 'salida)
         (juego-avanzar-turno (juego-actualizar-jugador game (jugador-mover (juego-obtener-jugador-actual game) game listaDados))) ;mover sin consecuencias
         )

        ;////////RAMA 3, cae en carcel 
        ((eq? (tablero-get-posicionX (juego-get-tablero game) (jugador-get-posicion (jugador-mover (juego-obtener-jugador-actual game) game listaDados))) 'carcel)
         (juego-avanzar-turno (juego-actualizar-jugador game (jugador-switch-carcel (jugador-mover (juego-obtener-jugador-actual game) game listaDados)))) ;mover y encarcelar
         )
        (else ;////RAMA 4, cae en una carta
         (juego-avanzar-turno (juego-actualizar-jugador game (jugador-mover (juego-obtener-jugador-actual game) game listaDados))) ;mover sin consecuencias (de momento)
         )
        )
      ;el jugador estaba encarcelado, evaluar si usa carta para salir o paga la multa.
      (cond ; si no puede pagar multa, se queda sin cambios.
        (pagarMc (juego-avanzar-turno (juego-actualizar-jugador game (jugador-pagar-multa-carcel (juego-obtener-jugador-actual game)))))
        (usarTsc (if (> (jugador-get-cartas (juego-obtener-jugador-actual game)) 0) ;intentar usar tarjeta
                     (juego-avanzar-turno (juego-actualizar-jugador game (jugador-switch-carcel (jugador-gastar-carta (juego-obtener-jugador-actual game))))) ;desencarcelar y usar tarjeta
                     (juego-avanzar-turno game)
                     )
                 )
        (else ;aqui falta revisar si saca dobles, triples, cuadruples ,etc (sale de la carcel si saca la jugada perfecta, sigue encarcelado en caso contrario)
         (juego-avanzar-turno game))
        )
      )
  )

