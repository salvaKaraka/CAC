;Escribir un programa que multiplique dos números enteros utilizando
;sumas repetidas (similar al Ejercicio  7 de la Práctica 1). 
;El programa debe estar optimizado para su ejecución con la opción Delay Slot

.data
a: .word 2
b: .word 3
res: .word 0

.code

ld r1, a(r0)
ld r2, b(r0)
dadd r3, r0, r0

loop: daddi r2, r2, -1
      dadd r3, r3, r1
      bnez r2, loop

sd r3, res(r0)
halt

