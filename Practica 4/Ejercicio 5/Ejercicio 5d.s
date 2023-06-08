;Modificar  el  programa  para  aprovechar  el  ‘Delay  Slot’
;ejecutando  una  instrucción  útil.  Simular  y  comparar  número  de 
;ciclos, instrucciones y CPI obtenidos con los de la versión anterior.

.data 
cant:  .word 8 
datos: .word 1, 2, 3, 4, 5, 6, 7, 8 
res: .word 0 
 .code 
 dadd   r1, r0, r0 
 ld  r2, cant(r0)
 ld  r3, datos(r1)
loop: daddi  r2, r2, -1 
 dsll   r3, r3, 1 
 sd  r3, res(r1) 
 daddi  r1, r1, 8 
 bnez   r2, loop 
 ld  r3, datos(r1)
 halt 


 ;CPI = 1.077
 ;instrucciones = 52
 ;ciclos = 56