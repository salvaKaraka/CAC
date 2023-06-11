;Escribir  un  programa  que  calcule  la  superficie  de  un  triángulo  
;rectángulo  de  base  5,85  cm  y  altura  13,47  cm. 

.data
base: .double 5.85
altura: .double 13.47
resultado: .double 0.0
dos: .double 2.0

.code
main:
    l.d f1, base(r0)
    l.d f2, altura(r0)
    l.d f4, dos(r0)

    mul.d f3, f1, f2
    div.d f3, f3, f4
    
    s.d f3, resultado(r0)
    
    halt

