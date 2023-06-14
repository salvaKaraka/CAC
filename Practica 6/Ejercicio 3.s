;Escriba un programa que realice la suma de dos números enteros (de un dígito cada uno) utilizando dos subrutinas: La 
;denominada ingreso del ejercicio anterior (ingreso por teclado de un dígito numérico) y otra  denominada 
;resultado, que muestre en la salida estándar del simulador (ventana Terminal) el resultado numérico de la suma de 
;los dos números ingresados

.data
CONTROL:    .word32 0x10000
DATA:       .word32 0x10008

.text
main:
    lwu      $s0, CONTROL($0)
    lwu      $s1, DATA($0)

    jal     ingreso
    daddi   $a1, $v0, 0
    jal     ingreso
    daddi   $a2, $v0, 0
    jal     resultado
halt

ingreso:
    daddi   $t0, $0, 8
    sd      $t0, 0($s0)
    daddi   $t0, $0, 6
    lbu     $v0, 0($s1)
    slti    $t1, $v0, 10
    beqz    $t1, ingreso
    slti    $t1, $v0, -1
    bnez    $t1, ingreso
    sd      $t0, 0($s0)
    jr      $ra

resultado:
    dadd    $t1, $a1, $a2
    sd      $t1, 0($s1)
    daddi   $t0, $0, 1
    sd      $t0, 0($s0)
    jr      $ra