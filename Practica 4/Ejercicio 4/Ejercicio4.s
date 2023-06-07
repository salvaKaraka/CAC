.data
tabla: .word 20, 1, 14, 3, 2, 58, 18, 7, 12, 11 
num: .word 7 
long:  .word 10 
 .code 
 ld  r1, long(r0) 
 ld  r2, num(r0) 
 dadd   r3, r0, r0 
 dadd   r10, r0, r0 
loop:  ld  r4, tabla(r3) 
 beq  r4, r2, listo 
 daddi  r1, r1, -1 
 daddi  r3, r3, 8 
 bnez   r1, loop 
 j  fin 
listo: daddi  r10, r0, 1 
fin: halt

; Ejecutar en simulador con Forwarding habilitado. ¿Qué tarea realiza? ¿Cuál es el resultado y dónde queda indicado?
; el programa busca el numero 7 en la tabla y si lo encuentra pone en r10 un 1, si no lo encuentra pone un 0
; el resultado es 1 y queda indicado en r10

; Re-Ejecutar el programa con la opción Configure/Enable Branch Target Buffer habilitada. Explicar la ventaja de usar este 
; método y cómo trabaja.
; Este metodo permite que el procesador sepa que instruccion va a ejecutar despues de un salto basandose en la desicion que se tomo previamente, de esta manera puede
; ejecutar la instruccion siguiente sin tener que esperar a que se ejecute el salto y se tenga un veredicto.
; eso si, la primera vez no podra predecirlo y tendra que esperar a que se ejecute el salto para saber que instruccion ejecutar despues. 
; tambian pasa cuando se cambia repentinamente el desenlace del salto

;Confeccionar una tabla que compare número de ciclos, CPI, RAWs y Branch Taken Stalls para los dos casos anteriores.
;
;
;