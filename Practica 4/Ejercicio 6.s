;Escribir un programa que lea tres números enteros A, B y C de la memoria de datos y determine cuántos de ellos son iguales 
;entre sí (0, 2 o 3). El resultado debe quedar almacenado en la dirección de memoria D.

.data

A: .word 10
B: .word 10
C: .word 20
D: .word 0

.code

main:
    ld r1, A(r0)
    ld r2, B(r0)
    ld r3, C(r0)
    dadd r4, r0, r0

loop:
    dsub r4, r1, r2
    beqz r4, check_c

    dsub r4, r1, r3
    beqz r4, two_equal

    dsub r4, r2, r3
    beqz r4, two_equal

    j end

check_c:
    dsub r4, r1, r3
    beqz r4, three_equal

two_equal:
    daddi r4, r0, 2
    sd r4, D(r0)
    j end

three_equal:
    daddi r4, r0, 3
    sd r4, D(r0)

end:
    halt
