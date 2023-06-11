; El siguiente programa espera usar una subrutina que calcule en forma recursiva el factorial de un número entero:

.data
valor: .word 3
result: .word 0

.text
    daddi $sp, $0, 0x400 ; Inicializa el puntero al tope de la pila (1)
    ld    $a0, valor($0)
    jal   factorial
    sd    $v0, result($0)
    halt

factorial:
    daddi $sp, $sp, -16    ; Reservar espacio en la pila para cuatro registros de 64 bits
    sd $ra, 0($sp)        ; Guardar el valor de retorno en la pila
    sd $a0, 8($sp)        ; Guardar el valor de $a0 en la pila

    ld $t0, 8($sp)        ; Cargar el valor de $a0 desde la pila

    daddi $t1, $zero, 1   ; Inicializar el contador en 1
    daddi $v0, $zero, 1   ; Inicializar el resultado en 1

    loop:
        daddi $t1, $t1, 1      ; Incrementar el contador
        dmul $v0, $v0, $t1     ; Multiplicar el resultado actual por el contador
        slt $t2, $t1, $t0      ; Comparar el contador con el valor original
        bnez $t2, loop         ; Si el contador es menor que el valor original, volver a loop

    ld $ra, 0($sp)        ; Cargar el valor de retorno desde la pila
    daddi $sp, $sp, 16     ; Liberar el espacio reservado en la pila

    jr $ra                ; Retornar a la instrucción de llamada

;¿Es posible escribir la subrutina factorial sin utilizar una pila? Justifique. 
;Si, podemos guardar el numero en un registro a parte e ir restando de a uno y multiplicando por el resultado, hasta que el numero sea 1.