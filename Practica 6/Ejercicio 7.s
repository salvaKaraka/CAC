.data
CONTROL:    .word32 0x10000
DATA:       .word32 0x10008
CERO:       .byte 0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,0,1,1,1,0,0
UNO:        .byte 0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,1,1,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0
DOS:        .byte 0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,1,0,0,1,0,0,0,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0
TRES:       .byte 0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,1,1,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0
CUATRO:     .byte 0,0,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,1,1,1,1,1,1,1,1,1,0,0,1,1,0,0,1,0,0,1,1,0,0,0,1,1,1,1,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0
CINCO:      .byte 0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,1,1,0,0,1,1,0,0,0,0,0,1,1,0,0,0,0,0,1,1,0,1,1,1,1,1,0,0,1,1,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0
SEIS:       .byte 0,0,0,0,0,0,0,0,1,1,1,1,0,0,1,1,0,0,1,1,0,1,1,0,0,1,1,0,1,1,1,1,1,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0
SIETE:      .byte 0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,1,1,0,0,1,1,0,1,1,1,1,1,1,0,0,0,0,0,0,0
OCHO:       .byte 0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,0,1,1,1,0,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,0,1,1,1,0,0
NUEVE:      .byte 0,0,1,1,1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,1,1,1,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0
MENSAJE:    .asciiz "Ingrese un numero(1-9): "
MENSAJE2:   .asciiz "Ingrese un numero valido(1-9): "
BLANCO:     .word32 0x00FFFFFF
NEGRO:      .word32 0x00000000

.code

main:       daddi $sp, $0, 0x400

            lwu     $s0, CONTROL($0)        ;CONTROL DIR
            lwu     $s1, DATA($0)           ;DATA DIR

            daddi   $a0, $0, MENSAJE        ;MENSAJE DIR COMO PARAMETRO
            daddi   $a1, $0, MENSAJE2       ;MENSAJE2 DIR COMO PARAMETRO

            jal     ingreso

            daddi   $a0, $v0, 0
            daddi   $a1, $v0, CERO
            lwu     $a2, BLANCO($0)
            lwu     $a3, NEGRO($0)

            jal     imprimir

            halt


ingreso:    daddi   $sp, $sp, -8            ;GUARDO RETURN ADRESS
            sw      $ra, 0($sp)
            daddi   $t3, $a0, 0

reingresar:
            daddi   $t0, $0, 6              ;LIMPIO LA TERMINAL
            sb      $t0, 0($s0)

            daddi   $t0, $0, 4              ;IMPRIMIR MENSAJE
            sw      $t3, 0($s1)
            sb      $t0, 0($s0)

            daddi   $t0, $0, 8              ;$s0=8 LEER ENTERO
            sb      $t0, 0($s0)

            lb      $v0, 0($s1)

            slti    $t1, $v0, 10            ;COMPRUEBO QUE ESTE EN EL RANGO VALIDO
            slti    $t2, $v0, 0
            beqz    $t1, error
            bnez    $t2, error

            lw      $ra, 0($sp)             ;RECUPERO RETURN ADRESS
            daddi   $sp, $sp, 8

            jr      $ra

error:      daddi   $t3, $a1, 0             ;MENSAJEE DE REINGRESO
            j       reingresar


imprimir:   daddi   $sp, $sp, -8            ;GUARDO RETURN ADRESS
            sw      $ra, 0($sp)

            daddi   $t0, $0, 6              ;LIMPIO LA TERMINAL pt1            
            sb      $t0, 0($s0)             ;LIMPIO LA TERMINAL pt2

            daddi   $t1, $0, CERO           ;CALCULO EL DESPLAZAMIENTO
            daddi   $t0, $0, 64
            dmulu   $t2, $t0, $a0
            dadd    $t1, $t1, $t2           ;DIRECCION CON DESPAZAMIENTO
            

            daddi   $t2, $0, 0              ;POSICION EN Y

filas:      sb      $t2, 4($s1)             ;SETEO Y EN DATA

            daddi   $t3, $0, 0              ;POSICION EN X

columnas:   sb      $t3, 5($s1)             ;SETEO X EN DATA
            lbu     $t5, 0($t1)             ;COLOR DEL PIXEL
            beqz    $t5, blanco             ;SI ES 0 PINTO BLANCO
            sw      $a3, 0($s1)
            j       sig
blanco:     sw      $a2, 0($s1)

sig:        daddi   $t9, $0, 5
            sb      $t9, 0($s0)             ;IMPRIMO PIXEL

            daddi   $t1, $t1, 1             ;INCREMENTO PIXEL DIR
            daddi   $t3, $t3, 1             ;INCREMENTO X
            slti    $t0, $t3, 7             ;COMPRUEBO QUE NO SE PASE DE 7
            bnez    $t0, columnas

            daddi   $t2, $t2, 1             ;INCREMENTO Y
            slti    $t0, $t2, 9             ;COMPRUEBO QUE NO SE PASE DE 9
            bnez    $t0, filas

            lw      $ra, 0($sp)             ;RECUPERO RETURN ADRESS
            daddi   $sp, $sp, 8
            jr $ra




