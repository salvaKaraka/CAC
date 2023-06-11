; Escriba una subrutina que reciba como parámetros las direcciones del comienzo de dos cadenas terminadas en cero y 
; retorne la posición en la que las dos cadenas difieren. En caso de que las dos cadenas sean idénticas, debe retornar -1.

.data
cad1: .asciiz "hola como estas"
cad2: .asciiz "hola como estan"
pos_diferencia: .word 0

.code
main:
    daddi $a0, $r0, cad1
    daddi $a1, $r0, cad2
    jal diferencias
    daddi $v0, $v0, 1
    sd $v0, pos_diferencia(r0)
    halt

diferencias:
    daddi $t3, $r0, 0           ;contador de posicion
    daddi $v0, $r0, 0           ;resultado
loop:
    dadd $t0, $a0, $t3          ;direccion de la cadena 1
    dadd $t1, $a1, $t3          ;direccion de la cadena 2 
    
    lbu $t5, 0($t0)             ;cargo el valor de la dir $t0
    lbu $t6, 0($t1)             ;cargo el valor de la dir $t1
    
    beqz $t5, chequeo
    beqz $t6, chequeo2

    beq $t5, $t6, siguiente
        dadd $v0, $r0, $t3       ;seteo posicion de diferencia
        j fin

siguiente:
    daddi $t3, $t3, 1           ;aumento la posicion
    j loop                      ;vuelvo a loop

chequeo:
    bnez $t6, diferencia
        daddi $v0, $r0, -1       ;seteo en -1
        j fin

chequeo2:
    bnez $t5, diferencia
        daddi $v0, $r0, -1       ;seteo en -1
        j fin

diferencia:
    dadd $v0, $r0, $t3       ;seteo posicion de diferencia

fin:
    jr $ra

