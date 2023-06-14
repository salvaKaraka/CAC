            .data
CONTROL:    .word32 0x10000
DATA:       .word32 0x10008
color1:     .word32 0x000405B5      ;Azul
color2:     .word32 0x0000DF00      ;Verde
color3:     .word32 0x00FF00FF      ;Rosa
color4:     .word32 0x0001A8DA      ;Celeste
color5:     .word32 0x00DF0101      ;Rojo
color6:     .word32 0x00F6FF2E      ;Amarillo
color7:     .word32 0x0001FF81      ;Cian
color8:     .word32 0x004B088A      ;Violeta



.code
            lwu $s6, CONTROL($0)
            lwu $s7, DATA($0)
            daddi $sp, $0, 0x400
            daddi $t0, $0, 9        ;Pedir caracter
            daddi $t1, $0, 32       ;Barra espaciadora
            daddi $s0, $0, 0        ;Coordenada X
            daddi $s1, $0, 0        ;Coordenada Y
            daddi $s2, $0, color1   ;Direccion del color inicial
            daddi $s3, $0, 0        ;Modo (0 no pintar, 1 pintar)

loop:       sd $t0, 0($s6)          ;CONTROL -> 9
            lbu $s4, 0($s7)         ;Tomar caracter de DATA
            bne $s4, $t1, sigo      ;Si no es la barra espaciadora sigo comparando
            xori $s3, $s3, 1        ;Cambio el modo
            j loop

sigo:       slti $t6, $s4, 48       ;48 = '0', t6 = 1 -> Caracter mal ingresado
            bnez $t6, loop          ;Salto si el caracter fue mal ingresado
            
            slti $t6, $s4, 57       ;56 = '8', t6 = 1 -> Cambiar color
            beqz $t6, sigo2         ;Salto si no debo cambiar color

            daddi $s2, $0, color1   ;Actualizo el color
            daddi $s4, $s4, -49     ;Resto 49 para obtener la cantidad de colores a desplazar
            daddi $t3, $0, 8        ;Un desplazamiento
            dmul $t3, $t3, $s4      ;Desplazmiento total
            dadd $s2, $s2, $t3      ;Nueva direccion de color
            
            j loop
;Comparo si debo moverme
sigo2:      daddi $t3, $0, 0        ;Corrimiento en X
            daddi $t4, $0, 0        ;Corrimiento en Y
            daddi $t2, $0, 97       ;97 = 'a'
            bne $s4, $t2, no_izq
            daddi $t3, $0, -1
            j moverme

no_izq:     daddi $t2, $0, 100      ;100 = 'd'
            bne $s4, $t2, no_der
            daddi $t3, $0, 1
            j moverme

no_der:     daddi $t2, $0, 115      ;115 = 's'
            bne $s4, $t2, no_abajo
            daddi $t4, $0, -1
            j moverme

no_abajo:   daddi $t2, $0, 119      ;119 = 'w'
            bne $s4, $t2, loop
            daddi $t4, $0, 1

moverme:    beqz $t3, movY          ;Para saber que movimiento hago en X o en Y
            dadd $t5, $s0, $t3
            slti $t6, $t5, 50       ;t6 = 1 -> Si no me pase
            beqz $t6, loop          ;Salto a loop si me pase
            slti $t6, $t5, 0        ;t6 = 0 -> Si no me pase
            bnez $t6, loop          ;Salto a loop si me pase

            dadd $s0, $s0, $t3      ;Nueva posicion en X
            j actualizar

movY:       dadd $t5, $s1, $t4
            slti $t6, $t5, 50       ;t6 = 1 -> Si no me pase
            beqz $t6, loop          ;Salto a loop si me pase
            slti $t6, $t5, 0        ;t6 = 0 -> Si no me pase
            bnez $t6, loop          ;Salto a loop si me pase

            dadd $s1, $s1, $t4      ;Nueva posicion en Y

actualizar: beqz $s3, loop
            daddi $t4, $0, 5
            sb $s0, 5($s7)          ;Pongo la posicion en X
            sb $s1, 4($s7)          ;Pongo la posicion en Y
            lw $t7, 0($s2)          ;Guardo el color
            sw $t7, 0($s7)          ;Mando el color
            sd $t4, 0($s6)

            j loop

            halt