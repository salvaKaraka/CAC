; Modificar el programa para que almacene en un arreglo en memoria de datos los contenidos parciales del registro  r1 ¿Qué 
; significado tienen los elementos de la tabla que se genera?

.data
A: .word 1
B: .word 6
RESULTADOS_PARCIALES: .word 0

.code
ld r1, A(r0)
ld r2, B(r0)

daddi r3, r0, 0

loop: dsll r1, r1, 1
daddi r2, r2, -1

sd r1, RESULTADOS_PARCIALES(r3)

daddi r3, r3, 8

bnez r2, loop
halt