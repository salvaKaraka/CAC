;Escriba  un  programa  que  utilice  sucesivamente  dos  subrutinas:  La  primera,  denominada  ingreso,  debe  solicitar  el 
;ingreso por teclado de un número entero (de un dígito), verificando que el valor ingresado realmente sea un dígito. La 
;segunda,  denominada  muestra,  deberá  mostrar  en  la  salida  estándar  del  simulador  (ventana  Terminal)  el  valor  del 
;número ingresado expresado en letras (es decir, si se ingresa un 4, deberá mostrar CUATRO). Establezca el pasaje 
;de  parámetros  entre  subrutinas  respetando  las  convenciones  para  el  uso  de  los  registros  y  minimice  las  detenciones del cauce


.data

cero: .asciiz "CERO"
uno: .asciiz "UNO"
dos: .asciiz "DOS"
tres: .asciiz "TRES"
cuatro: .asciiz "CUATRO"
cinco: .asciiz "CINCO"
seis: .asciiz "SEIS"
siete: .asciiz "SIETE"
ocho: .asciiz "OCHO"
nueve: .asciiz "NUEVE"
CONTROL:    .word32 0x10000
DATA:       .word32 0x10008


.code   
main:
    lwu     $s0, CONTROL($0)
    lwu     $s1, DATA($0)

    jal     ingreso

    dadd    $a0, $v0, $0
    daddi   $a1, $0, 8
    daddi   $a2, $0, cero

    jal     muestra
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
    

muestra:
    dmulu   $t1, $a0, $a1   ;corrimiento segun el caracter ingresado

    daddi   $t0, $0, 4      

    dadd    $t1, $t1, $a2   ;direccion de la cadena a imprimir

    sd      $t1, 0($s1)
    sd      $t0, 0($s0)

    jr      $ra
    

