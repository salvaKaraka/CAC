;Escriba una subrutina que reciba como parámetros un número positivo M de 64 bits, la dirección del comienzo de una 
;tabla  que  contenga  valores  numéricos  de  64  bits  sin  signo  y  la  cantidad  de  valores  almacenados  en  dicha  tabla. 
;La subrutina debe retornar la cantidad de valores mayores que M contenidos en la tabla.
;con delay slot
.data
M: .word 30
tabla: .word 10, 34, 32, 15, 4, 54, 23, 8, 9, 10
resultado: .word 0

.code
main:
    daddi $a0, $0, tabla
    ld $a1, M($0)
    daddi $a2, $0, 10
    jal mayores
    sd $v0, resultado($0)
    halt

mayores:
    dadd $t0, $0, $a0     ; Guardar la dirección de la tabla en $t0
    dadd $t1, $0, $a2     ; Guardar la cantidad de valores en $t1
    daddi $v0, $0, 0         ; Inicializar contador de valores mayores que M en 0

loop:
    beqz $t1, terminar  ; Si no quedan más valores en la tabla, terminar
    ld $t2, 0($t0)     ; Cargar el valor actual de la tabla
    slt $t3, $t2, $a1  ; Comparar el valor con M
    bnez $t3, siguiente  ; Si es mayor, incrementar contador
        daddi $t1, $t1, -1  ; Decrementar contador de valores restantes
        daddi $v0, $v0, 1  ; Incrementar contador de valores mayores que M
siguiente:
    j loop
    daddi $t0, $t0, 8   ; Avanzar a la siguiente posición de la tabla

terminar:
    jr $ra