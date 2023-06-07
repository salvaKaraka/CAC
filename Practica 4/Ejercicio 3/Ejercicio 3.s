.data
A: .word 1
B: .word 6
.code
ld r1, A(r0)
ld r2, B(r0)
loop: dsll r1, r1, 1
daddi r2, r2, -1
bnez r2, loop
halt


;con forwarding:

; ¿Por qué se presentan atascos tipo RAW ?
; Porque la instruccion de la linea 5 depende del resultado de la de la linea 4 y este aun no se encuentra en la salida de la ALU,
; que es el punto desde el que la tecnica forwarding rescata los datos para evitar un ciiclo de espera.

; Branch Taken es otro tipo de atasco que aparece. ¿Qué significa? ¿Por qué se produce?
; Este atasco es el que se produce cuando se ejecuta un salto condicional. el compilador predice que el salto no se va a producir y
; ejecuta siempre la instruccion posterior a este, por lo que esta instruccion demora la ejecucion de la instruccion que se ejecutaria 
; en caso de haceerse el salto.

; ¿Cuántos CPI tiene la ejecución de este programa? Tomar nota del número de ciclos, cantidad de instrucciones y CPI.
; Nro de ciclos: 36
; Cant de instruccioones: 21
; CPI: 1.714


; Sin forwarding:

; ¿Qué instrucciones generan los atascos tipo RAW y por qué? ¿En qué etapa del cauce se produce el atasco en cada caso y durante cuántos ciclos?
; la instruccion en la primera linea genera un atasco RAW porque de su resultado depende la ejecucion de la instruccion de la linea 3 .
; esto retrasa la ejecucion de la linea 4, por lo que la linea 2 alcanza a devolver el resultado antes de provocar otro atasco. 
; Sin embargo, la linea 4 si proovoca un reetraso en la ejecucion de la 5.
; Todos estos atascos se dan porque aun no se realizo el writeback de una istruccion que devuelve un dato utilizado posteriormente en una
; instruccion que ya se encuentra en su etapa de ejecucion.

; Los  Branch  Taken  Stalls  se  siguen generando.  ¿Qué  cantidad  de  ciclos  dura  este  atasco en  cada  vuelta  del  lazo  ‘loop’? 
; Comparar con la ejecución con Forwarding y explicar la diferencia. 
; El atasco dura 3 ciclos y con forwarding duraria 2. Esto se debe a que la instrruccion de la que depende el salto para ejecutarse aun no realizo
; el writeback, por lo que el salto se ejecuta y se predice que no se va a realizar, por lo que se ejecuta la instruccion posterior a este durante 
; un ciclo mas que con forwarding (en el caso del forwarding no se precisaria esperar el writeback).

; ¿Cuántos CPI tiene la ejecución del programa en este caso? Comparar número de ciclos, cantidad de instrucciones y CPI 
; con el caso con Forwarding
; Nro de ciclos: 43  // con forwarding: 36
; Cant de instruccioones: 21 // con forwarding: 21
; CPI: 2.048 // con forwarding: 1.714