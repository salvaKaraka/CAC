.data 
valor1: .word 16 
valor2: .word 4 
result: .word 0 
  
 .text 
 ld    $a0, valor1($0) 
 ld    $a1, valor2($0) 
 jal   a_la_potencia 
 sd    $v0, result($0) 
 halt 
 
a_la_potencia:  daddi $v0, $0, 1 
lazo: slt   $t1, $a1, $0 
 bnez  $t1, terminar 
 daddi $a1, $a1, -1 
 dmul  $v0, $v0, $a0 
 j     lazo 
terminar: jr    $ra

; ¿Qué hace el programa? ¿Cómo está estructurado el código del mismo?
; saca la 4ta potencia de 16 utilizando una subrutina

; ¿Qué acciones produce la instrucción jal? ¿Y la instrucción jr?
; jal salta a la subrutina y guarda la direccion del pc en el registro return adress
; jl salta a la dirrecion almacenada en el registro indicado

; ¿Qué valor se almacena en el registro $ra? ¿Qué función cumplen los registros $a0 y $a1? ¿Y el registro $v0? 
; en ra se guarda la direccion de retorno, a0 y a1 son los operandos, v0 es el resultado

; ¿Qué sucedería si la subrutina a_la_potencia necesitara invocar a otra subrutina para realizar la multiplicación, 
; por  ejemplo,  en  lugar  de  usar  la  instrucción  dmul?  ¿Cómo  sabría  cada  una  de  las  subrutinas  a  que  dirección  de 
; memoria deben retornar?
; antes de llamar a a subrutina podemos guardar el registro ra y recuperarlo tras su ejecucion

