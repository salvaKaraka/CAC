; 2) El siguiente programa intercambia el contenido de dos palabras de la memoria de datos, etiquetadas A y B.

	.data
A: .word 1
B: .word 2
	.code
	ld r1, A(r0)
	ld r2, B(r0)
	sd r2, A(r0)
	sd r1, B(r0)
	halt

; a) Ejecutarlo en el simulador con la opción Configure/Enable Forwarding deshabilitada. Analizar paso a paso su 
; funcionamiento, examinar las distintas ventanas que se muestran en el simulador y responder:
; - ¿Qué instrucción está generando atascos (stalls) en el cauce (ó pipeline) y por qué?

;	ld r2, B(r0) es la instruccion que causa los stalls porque genera un dato que es demandado por una istruccion posterior antes de que este este cargado en el banco de registros.
	
; - ¿Qué tipo de ‘stall’ es el que aparece?

;	es un stall por dependencia de datos de tipo RAW (dependencia verdadera)

;- ¿Cuál es el promedio de Ciclos Por Instrucción (CPI) en la ejecución de este programa bajo esta configuración?

;	Hay un promedio de 2.2 ciclos.

;b) Una forma de solucionar los atascos por dependencia de datos es utilizando el Adelantamiento de Operandos o Forwarding. 
;Ejecutar nuevamente el programa anterior con la opción Enable Forwarding habilitada y responder:
;- ¿Por qué no se presenta ningún atasco en este caso? Explicar la mejora.


;	No se presenta ningun atasco debido a la configuracion del procesador en forwarding. Esta opcion hace que el procesador no espere a la escritura del dato en memoria
;	y lo lleve directamente a la entrada de la etapa correspondiente.

;- ¿Qué indica el color de los registros en la ventana Register durante la ejecución?

;	Gris: proceso de ser escrito
;	Color: es el color de la etapa de ejecucion en la que se realizo la peticion de forwarding

;- ¿Cuál es el promedio de Ciclos Por Instrucción (CPI) en este caso? Comparar con el anterior.

;	1.8 ciclos por instruccion