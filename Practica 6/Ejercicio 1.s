;Recibe cadena por teclado y la muestra en terminal

.data
texto: .space 100          ; El mensaje a mostrar
CONTROL: .word 0x10000
DATA: .word 0x10008

.code
    lwu $t6, CONTROL($0)
    lwu $t7, DATA($0)

    daddi $a1, $0, texto     ; posicion de la cadena

    daddi $t0, $0, 6        ; limpiar pantalla alfanumérica
    sd $t0, 0($s1)          ; CONTROL recibe 6 y limpia la pantalla

    jal carga

    jal salida


halt

carga:
    daddi $t2, $0, 0
loop:
    daddi $t0, $zero, 9    ; modo lectura de caracter
    sd $t0, 0($t6)         ; lectura

    lbu $t1, 0($t7)        ; guardo el caracter en t1

    dadd $t4, $a1, $t2     ; guardo en t4 la posicion con corrimiento
    sb $t1, 0($t4)         ; guardo el caracter en la posicion con corrimiento

    daddi $t2, $t2, 1      ; siguiente caracter
    
    daddi $t1, $t1, -48    ;resto el caracter 0 a t1

    bnez $t1, loop         ; si no es cero, continua la carga

    jr $ra

salida:
    sd $a1, 0($t7)         ; guardo la direccion en DATA
    daddi $t0, $zero, 4    ; modo escritura de cadena
    sd $t0, 0($t6)         ; seteo

    jr $ra