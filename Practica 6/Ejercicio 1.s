;modifique el programa para recibir una cadena por teclado

.data 
texto: .space 1   ; El mensaje a mostrar 
CONTROL: .word32  0x10000 
DATA: .word32  0x10008 
  
 .text 
 lwu $s0, DATA(r0) ; $s0 = dirección de DATA 
 daddi  $t0, $0, texto ; $t0 = dirección del mensaje a mostrar 
 

 recibir:
 lwu $s1, CONTROL(r0) ; $s1 = dirección de CONTROL 
 daddi  $t0, $0, 9 
 sd $t0, 0($s1) 

 lbu $t1, DATA($0)
 sd $t1, 0($t0)
 sd $t0, DATA($0)

 daddi  $t0, $0, 4 ; $t0 = 4 -> función 4: salida de una cadena ASCII 
 sd $t0, 0($s1) ; CONTROL recibe 4 y produce la salida del mensaje 
 
 bnez $t1, recibir
 
 
 lwu $s1, CONTROL(r0) ; $s1 = dirección de CONTROL 
 daddi  $t0, $0, 6 ; $t0 = 6 -> función 6: limpiar pantalla alfanumérica 
 sd $t0, 0($s1) ; CONTROL recibe 6 y limpia la pantalla 
 
 daddi  $t0, $0, 4 ; $t0 = 4 -> función 4: salida de una cadena ASCII 
 sd $t0, 0($s1) ; CONTROL recibe 4 y produce la salida del mensaje 
 halt