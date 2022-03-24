;PROGRAMA CALCULADORA DE DOS NUMEROS DE UN SOLO DIGITO
;*****************************************************************
.MODEL  SMALL
.386
.STACK          ;DEFINIR SEGMENTO DE PILA

.DATA           ;DEFINIIR SEGMENTO DE DATOS

    mens1 db 10,13,'1) SUMA$'
    mens2 db 10,13,'2) RESTA$'
    mens3 db 10,13,'3) MULTIPLICACION$'
    mens4 db 10,13,'4) DIVISION$'
    mens5 db 10,13,'5) SALIR$'
    mens6 db 10,13,'INGRESE UNA OPCION: $'

    opcion db 0
    dato1 db 1
    dato2 db 2
    dato3 db 3
    dato4 db 4
    dato5 db 5

    peticion db 10,13,'INGRESE NUMERO: $'
    num1 db 0
    num2 db 0
    resultado db 0
    residuo db 0

    mostrar db 10,13,'EL RESULTADO ES: $'
    mostrarsigno db 10,13,'EL RESULTADO ES: -$'
    mostrarres db 10,13,'EL RESIDUO ES: $'
    mostrardiverr db 10,13,'NO SE PUEDE DIVIDIR POR 0$'
    mostrarnonumero db 10,13,'EL VALOR INGRESADO NO ES UN NUMERO$'

.code

        MOV AX,@DATA
        MOV DS,AX

        imprimir:

        MOV AH,09h
        LEA DX,mens1
        INT 21h

        MOV AH,09H
        LEA DX,mens2
        INT 21H

        MOV AH,09H
        LEA DX,mens3
        INT 21H

        MOV AH,09H
        LEA DX,mens4
        INT 21H

        MOV AH,09H
        LEA DX,mens5
        INT 21H

        MOV AH,09H
        LEA DX,mens6
        INT 21H

        obtener:
        MOV AH,01H
        INT 21H
        SUB AL,30H
        MOV opcion,AL

        evaluar:
        CMP AL,dato1
        JE sumar
        JB imprimir

        CMP AL,dato2
        JE restar

        CMP AL,dato3
        JE multiplicar

        CMP AL,dato4
        JE dividir

        CMP AL,dato5
        JE salir
        JA imprimir

        errordivision:
        ;muestra error division
        MOV AH,09H
        LEA DX,mostrardiverr
        INT 21H
        CALL imprimir
        RET

        agregarsigno:
        ; Intercambiar posiciones de los numeros
        MOV BL, num1
        SUB AL,BL  ; resta al contrario
        MOV resultado,AL
        AAM ;desempaquetar
        MOV BX,AX ;mover ax

        ; Concatenar signo antes del resultado
        MOV AH,09H
        LEA DX,mostrarsigno
        INT 21H

        ;muestra primer digito
        MOV AH,02H
        MOV DL,BH
        ADD DL,30H
        INT 21H

        ;muestra segundo digito
        MOV AH,02H
        MOV DL,BL
        ADD DL,30H
        INT 21H

        CALL imprimir

        RET

        noesnumero:

        MOV AH,09H
        LEA DX,mostrarnonumero
        INT 21H

        CALL imprimir

        RET

;------------------------- SUMA -------------------------

        sumar:
        MOV AH,09H
        LEA DX,peticion
        INT 21H

        MOV AH, 01H ; Ingreso de caracter
        INT 21H

        CMP AL, 39H
        JA noesnumero
        CMP AL,30H
        JB noesnumero

        SUB AL, 30H
        MOV num1, AL

        MOV AH,09H
        LEA DX,peticion
        INT 21H

        MOV AH, 01H
        INT 21H

        CMP AL, 39H
        JA noesnumero
        CMP AL,30H
        JB noesnumero

        SUB AL, 30H
        MOV num2, AL

        MOV AL, num1
        ADD AL, num2
        MOV resultado,AL

        MOV AH,09H
        LEA DX,mostrar
        INT 21H

        MOV AL,resultado ;mover el resultado
        AAM ;desempaquetar
        MOV BX,AX ;mover ax

        ;muestra primer digito
        MOV AH,02H
        MOV DL,BH
        ADD DL,30H
        INT 21H

        ;muestra segundo digito
        MOV AH,02H
        MOV DL,BL
        ADD DL,30H
        INT 21H

        CALL imprimir
        .exit
        ;fin de suma

;------------------------- RESTA -------------------------

        restar:
        MOV AH,09H
        LEA DX,peticion
        INT 21H

        MOV AH,01H
        INT 21H

        CMP AL, 39H
        JA noesnumero
        CMP AL,30H
        JB noesnumero

        SUB AL,30H
        MOV num1,AL

        MOV AH,09H
        LEA DX,peticion
        INT 21H

        MOV AH,01H
        INT 21H

        CMP AL, 39H
        JA noesnumero
        CMP AL,30H
        JB noesnumero

        SUB AL,30H
        MOV num2, AL

        CMP AL,num1
        JA agregarsigno

        MOV AL,num1
        SUB AL,num2  ;resta
        MOV resultado,AL

        MOV AH,09H
        LEA DX,mostrar
        INT 21H

        AAM ;desempaquetar
        MOV BX,AX ;mover ax

        ;muestra primer digito
        MOV AH,02H
        MOV DL,BH
        ADD DL,30H
        INT 21H

        ;muestra segundo digito
        MOV AH,02H
        MOV DL,BL
        ADD DL,30H
        INT 21H

        CALL imprimir
        .exit
        ;fin de resta

;------------------------- MULTIPLICACION -------------------------

        multiplicar:
        MOV AH,09H
        LEA DX,peticion
        INT 21H

        MOV AH,01H
        INT 21H

        CMP AL, 39H
        JA noesnumero
        CMP AL,30H
        JB noesnumero

        SUB AL,30H
        MOV num1,AL

        MOV AH,09H
        LEA DX,peticion
        INT 21H

        MOV AH,01H
        INT 21H

        CMP AL, 39H
        JA noesnumero
        CMP AL,30H
        JB noesnumero

        SUB AL,30H
        MOV num2, AL

        MOV AL,num1
        MUL num2
        MOV resultado,AL

        MOV AH,09H
        LEA DX,mostrar
        INT 21H

        MOV AL,resultado ;mover el resultado
        AAM ;desempaquetar
        MOV BX,AX ;mover ax

        ;muestra primer digito
        MOV AH,02H
        MOV DL,BH
        ADD DL,30H
        INT 21H

        ;muestra segundo digito
        MOV AH,02H
        MOV DL,BL
        ADD DL,30H
        INT 21H

        CALL imprimir
        .exit
        ;fin multiplicacion

;------------------------- DIVISION -------------------------

        dividir:
        MOV AH,09H
        LEA DX,peticion
        INT 21H

        MOV AH,01H
        INT 21H

        CMP AL, 39H
        JA noesnumero
        CMP AL,30H
        JB noesnumero

        SUB AL,30H
        MOV num1,AL

        MOV AH,09H
        LEA DX,peticion
        INT 21H

        MOV AH,01H
        INT 21H

        CMP AL, 39H
        JA noesnumero
        CMP AL,30H
        JB noesnumero

        SUB AL,30H
        MOV num2, AL

        CMP num2,0
        JE errordivision

        XOR AX,AX ; Limpiar registro
        MOV AL,num1
        MOV BL,num2
        DIV BL
        MOV resultado,AL
        MOV residuo, AH

        MOV AH,09H
        LEA DX,mostrar
        INT 21H

        MOV AL,resultado ;mover el resultado
        MOV CH, 0
        MOV CL, residuo
        AAM
        MOV BX,AX ;mover ax

        ;muestra primer digito division
        MOV AH,02H
        MOV DL,BH
        ADD DL,30H
        INT 21H

        ;muestra segundo digito division
        MOV AH,02H
        MOV DL,BL
        ADD DL,30H
        INT 21H

        ;muestra residuo
        MOV AH,09H
        LEA DX,mostrarres
        INT 21H

        ;muestra primer digito residuo
        MOV AH,02H
        MOV DL,CH
        ADD DL,30H
        INT 21H

        ;muestra segundo digito residuo
        MOV AH,02H
        MOV DL,CL
        ADD DL,30H
        INT 21H

        CALL imprimir
        .exit
        ;fin division

;------------------------- SALIR -------------------------

        salir:

        .exit

END