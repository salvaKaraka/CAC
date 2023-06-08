;Escribir un programa que recorra una TABLA de diez números enteros y determine 
;cuántos elementos son mayores que X. El resultado debe  almacenarse  en una  
;dirección etiquetada  CANT. El programa  debe  generar además otro arreglo 
;llamado RES cuyos elementos sean ceros y unos. 
;Un ‘1’ indicará que el entero correspondiente en el  arreglo  TABLA  es  
;mayor  que  X, mientras que un ‘0’ indicará que es menor o igual.

.data

X: .word 5
TABLA: .word 1,2,3,4,5,6,7,8,9,10
CANT: .word 0
RES: .space 80

.code

    dadd r1, r0, r0 
    daddi r2, r0, 10
    ld r4, X(r0)
    ld r3, TABLA(r1)        ; Carga el valor actual de TABLA en r3

loop: 
    slt r5, r3, r4          ;comparo si X es mayor que T[r1], si es asi devuelve 1
    daddi r2, r2, -1      ;decremento en 1 el contador
    bnez r5, else           ;si es 1, salta a else
    
    ld r5, CANT(r0)
    daddi r5, r5, 1
    sd r5, CANT(r0)     ;aumento en 1 cant si T[r1] es mayor que X
    
    daddi r5, r0, 1
    sd r5, RES(r1)      ;guardo 1 en RES[r1] si T[r1] es mayor que X
    j endif

else:
    daddi r5, r0, 0
    sd r5, RES(r1)          ;guardo 0 en RES[r1] si T[r1] es menor o igual que X

endif:
    daddi r1, r1, 8          ;incremento en 8 el puntero de TABLA y RES
    bnez r2, loop           ;si el contador es distinto de 0, salta a loop
    
    ld r3, TABLA(r1)        ;cargo el siguiente valor de TABLA
    
    halt
