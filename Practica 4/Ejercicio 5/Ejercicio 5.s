;El siguiente  programa  multiplica  por  2  los  elementos  de  un  
;arreglo  llamado  datos  y  genera  un  nuevo  arreglo  llamado  res. 
;Ejecutar el programa en el simulador winmips64 
;con la opción Delay Slot habilitada.

.data 
cant:  .word 8 
datos: .word 1, 2, 3, 4, 5, 6, 7, 8 
res: .word 0 
 .code 
 dadd   r1, r0, r0 
 ld  r2, cant(r0) 
loop:  ld  r3, datos(r1) 
 daddi  r2, r2, -1 
 dsll   r3, r3, 1 
 sd  r3, res(r1) 
 daddi  r1, r1, 8 
 bnez   r2, loop 
 nop
 halt 

 ;¿Qué efecto tiene habilitar la opción Delay Slot (salto retardado)?
 ;el delay slot hace que la instruccion que sigue al salto se ejecute siempre
 ;esto es util si queremos evitar los atascos branch taken, en este caso no
 ;mejora el CPI del programa, pero si mejora la fluidez de este.

 ;¿Con qué fin se incluye la instrucción NOP? ¿Qué sucedería si no estuviera?.
 ;la instruccion NOP sirve como placeholder que no hace nada
 ;si no estuviera se ejecutaria la instruccion siguiente al salto, 
 ;en este caso el halt

 ;Tomar nota de la cantidad de ciclos, la cantidad de instrucciones y los CPI luego de ejecutar el programa.
 ;CPI = 1.06
 ;instrucciones = 59
 ;ciclos = 63
 