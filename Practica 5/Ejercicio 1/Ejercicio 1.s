;Simular el siguiente programa de suma de números en punto flotante y analizar 
;minuciosamente la ejecución paso a paso. 
;Inhabilitar Delay Slot y mantener habilitado Forwarding.

.data 
n1: .double 9.13 
n2: .double 6.58 
res1: .double 0.0 
res2: .double 0.0 
 
 .code 
 l.d   f1, n1(r0) 
 l.d   f2, n2(r0) 
 add.d  f3, f2, f1 
 mul.d  f4, f2, f1 
 s.d   f3, res1(r0) 
 s.d   f4, res2(r0) 
 halt

; Tomar nota de la cantidad de ciclos, instrucciones y CPI.
; sin delay slot: 16 ciclos, 7 instrucciones, 2.285 CPI

;¿Cuántos atascos por dependencia  de  datos se  generan?  
;Observar en cada  caso cuál es el dato en conflicto y las instrucciones involucradas.
;4 RAW
;Las instrucciones involucradas son: 
;l.d   f2, n2(r0) 
;add.d  f3, f2, f1
;mul.d  f4, f2, f1
;s.d   f3, res1(r0) 
;s.d   f4, res2(r0) 

;¿Por  qué  se  producen  los  atascos  estructurales?  Observar  cuales  son  las  instrucciones  que  los  generan  y  en  qué 
;etapas del pipeline aparecen
;se dan porque dos instrucciones quieren acceder a memoria, una para 
;leer y otra para escribir, en el mismo ciclo.
;los generan las instrucciones:
;add.d  f3, f2, f1
;s.d   f4, res2(r0) 
;halt