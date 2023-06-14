.data
    coorX:   .byte   0    ; coordenada X de un punto
    coorY:   .byte   0    ; coordenada Y de un punto
    color:   .byte   0, 0, 0, 0    ; R,G,B,A
    CONTROL: .word32 0x10000
    DATA:    .word32 0x10008

.text
    lwu $s6, CONTROL($0)    ; $s6 = dirección de CONTROL
    lwu $s7, DATA($0)       ; $s7 = dirección de DATA

    daddi $a0, $0, coorX    ; $a0 = dirección de coorX
    daddi $a1, $0, coorY    ; $a1 = dirección de coorY
    daddi $a2, $0, color    ; $a2 = dirección de color

    jal ingreso             ; llamada a la función ingreso

    daddi $t0, $0, 7        ; $t0 = 7 -> función 7: limpiar pantalla gráfica
    sd $t0, 0($s6)          ; CONTROL recibe 7 y limpia la pantalla gráfica

    lbu $s0, coorX($0)      ; $s0 = valor de coordenada X
    sb $s0, 5($s7)          ; DATA+5 recibe el valor de coordenada X
    lbu $s1, coorY($0)      ; $s1 = valor de coordenada Y
    sb $s1, 4($s7)          ; DATA+4 recibe el valor de coordenada Y
    lwu $s2, color($0)      ; $s2 = valor de color a pintar
    sw $s2, 0($s7)          ; DATA recibe el valor del color a pintar

    daddi $t0, $0, 5        ; $t0 = 5 -> función 5: salida gráfica
    sd $t0, 0($s6)          ; CONTROL recibe 5 y produce el dibujo del punto

    halt

ingreso:
    daddi $t0, $0, 8
    sd $t0, 0($s6)          ; CONTROL recibe 8 y produce la lectura de coordenada X
    lb $t1, 0($s7)          ; $t1 = DATA recibe el valor de coordenada X
    sb $t1, coorX($0)       ; coorX recibe el valor de coordenada X

    sd $t0, 0($s6)          ; CONTROL recibe 8 y produce la lectura de coordenada Y
    lb $t1, 0($s7)          ; $t1 = DATA recibe el valor de coordenada Y
    sb $t1, coorY($0)       ; coorY recibe el valor de coordenada Y

    sd $t0, 0($s6)          ; CONTROL recibe 8 y produce la lectura de colorR
    lb $t1, 0($s7)          ; $t1 = DATA recibe el valor de colorR
    sb $t1, color($0)       ; colorR recibe el valor de colorR

    sd $t0, 0($s6)          ; CONTROL recibe 8 y produce la lectura de colorG
    lb $t1, 0($s7)          ; $t1 = DATA recibe el valor de colorG
    sb $t1, color+1($0)     ; colorG recibe el valor de colorG

    sd $t0, 0($s6)          ; CONTROL recibe 8 y produce la lectura de colorB
    lb $t1, 0($s7)          ; $t1 = DATA recibe el valor de colorB
    sb $t1, color+2($0)     ; colorB recibe el valor de colorB

    jr $ra

    