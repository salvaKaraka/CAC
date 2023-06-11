;Modificar  el  programa  agregando  la  instrucción  mul.d f1, f2, f1  entre  
;las  instrucciones  add.d  y  mul.d. 
;Repetir la ejecución y observar los resultados. 
;¿Por qué aparece un atasco tipo WAR?

.data 
n1: .double 9.13 
n2: .double 6.58 
res1: .double 0.0 
res2: .double 0.0 
 
 .code 
 l.d   f1, n1(r0) 
 l.d   f2, n2(r0) 
 nop
 add.d  f3, f2, f1 
 mul.d f1, f2, f1
 mul.d  f4, f2, f1 
 s.d   f3, res1(r0) 
 s.d   f4, res2(r0) 
 halt

 ;aparece porque  mul.d f1, f2, f1 tiene que modificar f1 
 ;pero add.d  f3, f2, f1 todavia no lo leyo

 ;Explicar  por  qué  colocando  un  NOP  antes  de  la  suma,  se  soluciona  
 ;el  RAW  de  la  instrucción  ADD  y  como consecuencia se elimina el WAR.
 ;el RAW del ADD se soluciona porque el add utiliza f2 y ahora le da tiempo
 ;a llegar a la salida de la ALU

 ;el WAR se elimina porque al add alcanza a leer f1 antes de que
 ;mul.d lo utilice
 