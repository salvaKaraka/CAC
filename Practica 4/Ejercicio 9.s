;Escribir un programa que implemente el siguiente fragmento escrito en un 
;lenguaje de alto nivel:  
; while a > 0 do begin 
;  x := x + y; 
;  a := a - 1; 
; end; 
;Ejecutar con la opción Delay Slot habilitada.

.data
x: .word 0
y: .word 1
a: .word 10

.code
ld r1, x(r0)
ld r2, y(r0)
ld r3, a(r0)

loop: 
    daddi r3, r3, -1
    dadd r1, r1, r2
    bnez r3, loop

sd r1, x(r0)
halt