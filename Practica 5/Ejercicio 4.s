;Escriba  un  programa  que  dado  el  peso  y  la  estatura  de  una  persona  calcule  su  IMC  y  lo  guarde  en  la  dirección 
;etiquetada IMC. También deberá guardar en la dirección etiquetada estado un valor según la siguiente tabla: 
;                        IMC         Clasificación       Valor guardado 
;                      < 18,5          Infrapeso               1 
;                      < 25              Normal                2 
;                      < 30            Sobrepeso               3 
;                      ≥ 30              Obeso                 4

.data

peso: .double 80.0
altura: .double 1.80
imc: .double 0.0
estado: .double 0.0
Infrapeso: .double 18.5, 1.0
Normal: .double 25.0, 2.0
Sobrepeso: .double 30, 3.0
Obeso: .double 4.0

.code
main:
    l.d f1, peso(r0)
    l.d f2, altura(r0)

    div.d f3, f1, f2

    s.d f3, imc(r0)

    l.d f4, Infrapeso(r0)

    daddi r5, r0, 8

    c.lt.d f3, f4
    bc1t infrapeso

    l.d f4, Normal(r0)
    bc1t normal

    l.d f4, Sobrepeso(r0)
    bc1t sobrepeso

    l.d f4, Obeso(r0)
    s.d f4, estado(r0)

    j fin

infrapeso:
    l.d f4, Infrapeso(r5)
    s.d f4, estado(r0)
    j fin

normal:
    l.d f4, Infrapeso(r5)
    s.d f4, estado(r0)
    j fin

sobrepeso:
    l.d f4, Infrapeso(r5)
    s.d f4, estado(r0)
    j fin

fin:
    halt