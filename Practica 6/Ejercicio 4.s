;Escriba  un  programa  que  solicite  el  ingreso  por  teclado  de  una  clave  (sucesión  de  cuatro  caracteres)  utilizando  la 
;subrutina char de ingreso de un carácter. Luego, debe comparar la secuencia ingresada con una cadena almacenada 
;en  la  variable  clave.  Si  las  dos  cadenas  son  iguales  entre  si,  la  subrutina  llamada  respuesta  mostrará  el  texto 
;“Bienvenido” en  la  salida  estándar  del  simulador  (ventana  Terminal).  En  cambio,  si  las  cadenas  no  son  iguales,  la 
;subrutina deberá mostrar “ERROR” y solicitar nuevamente el ingreso de la clave.

.data

CLAVE: .asciiz "code"
INTENTO: .space 4
MENSAJE: .asciiz "Ingrese la clave: "
MENSAJEERROR: .asciiz "ERROR"
MENSAJEBIENVENIDO: .asciiz "Bienvenido"

CONTROL: .word32 0x10000
DATA: .word32 0x10008

.text

    lwu $s0, CONTROL($0)
    lwu $s1, DATA($0)

    daddi $t0, $0, 6    ;limpio la terminal
    sd $t0, 0($s0)

    daddi $t1, $0, MENSAJE   ;imprimo "Ingrese la clave"
    sd $t1, 0($s1)
    daddi $t0, $0, 4
    sd $t0, 0($s0)

    daddi $t3, $0, 0
loop:
    jal char
    sb $v0, INTENTO($t3)
    daddi $t3, $t3, 1
    slti $t4, $t3, 4
    bnez $t4, loop

    daddi $a0, $0, INTENTO
    daddi $a1, $0, CLAVE

    jal  respuesta

halt

char:
    daddi $t0, $0, 9
    sd $t0, 0($s0)
    lbu $v0, 0($s1)
    jr $ra

respuesta:
    daddi $t3, $0, 0
loop2:
    dadd $t4, $a0, $t3
    lbu $t5, 0($t4)
    dadd $t7, $a1, $t3
    lbu $t6, 0($t7)
    daddi $t3, $t3, 1
    slti $t4, $t3, 4
    bne $t5, $t6, error
    bnez $t4, loop2
    daddi $t1, $0, MENSAJEBIENVENIDO
    sd $t1, 0($s1)
    daddi $t0, $0, 4
    sd $t0, 0($s0)
    j fin
error:
    daddi $t1, $0, MENSAJEERROR
    sd $t1, 0($s1)
    daddi $t0, $0, 4
    sd $t0, 0($s0)
fin:
    jr $ra
