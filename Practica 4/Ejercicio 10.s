;Escribir un programa que cuente la cantidad de veces que un determinado 
;caracter aparece en una cadena de texto. Observar cómo se almacenan 
;en memoria los códigos ASCII de los caracteres (código de la letra “a” es 61H).
;Utilizar la instrucción lbu (load byte unsigned) para cargar códigos en 
;registros. La inicialización de los datos es la siguiente:  

.data 
cadena: .asciiz "adbdcdedfdgdhdid" ; cadena a analizar 
car: .asciiz "d" ; caracter buscado 
cant: .word 0 ; cantidad de veces que se repite el caracter car en cadena.

.code
main:
    lbu r3, cadena(r0)
    lbu r4, car(r0)
    daddi r2, r0 , 0
    daddi r1, r0 , 0

loop: 
    bne r3, r4, next
    daddi r1, r1, 1
    daddi r2, r2, 1
next:
    bnez r3, loop
    lbu r3, cadena(r1)
    sd r2, cant(r0)
halt