; lab6_instrucciones.asm — Demostración de categorías de instrucciones x86
; Unidad 6: Instrucciones y Direccionamiento
; Estudiante: Kher — Arquitectura de Computadores 2026
; Compilar: nasm -f bin lab6_instrucciones.asm -o lab6_instrucciones.com

org 100h            ; offset de inicio para archivos .COM (PSP ocupa 0-FFh)

; ── Datos ────────────────────────────────────────────────────────────────
jmp inicio          ; saltar sobre los datos al código

valor_a  dw 45      ; primer operando
valor_b  dw 12      ; segundo operando
resultado dw 0      ; almacena resultado de la suma
contador db 5       ; contador de bucle
mascara  db 0Fh     ; máscara de 4 bits bajos

; ── Código ───────────────────────────────────────────────────────────────
inicio:

; ════════════════════════════════════════════════════════════════════════
; BLOQUE 1: Transferencia de datos
; ════════════════════════════════════════════════════════════════════════

    ; MOV: carga valor de memoria a registro
    mov ax, [valor_a]       ; AX = 45 (contenido de valor_a)
    mov bx, [valor_b]       ; BX = 12 (contenido de valor_b)

    ; MOV entre registros
    mov cx, ax              ; CX = AX = 45
    mov dx, bx              ; DX = BX = 12

    ; LEA: carga la dirección, no el contenido
    lea si, [valor_a]       ; SI = dirección de valor_a (no su valor)
    mov ax, [si]            ; AX = mem[SI] = 45 (acceso indirecto vía SI)

    ; XCHG: intercambio de valores entre registros
    xchg cx, dx             ; CX=12, DX=45
    xchg cx, dx             ; restaurar: CX=45, DX=12

    ; PUSH/POP: preservar y restaurar un registro en la pila
    push ax                 ; guarda AX=45 en la pila
    mov  ax, 0FFFFh         ; modifica AX temporalmente
    pop  ax                 ; restaura AX=45 desde la pila

; ════════════════════════════════════════════════════════════════════════
; BLOQUE 2: Operaciones aritméticas
; ════════════════════════════════════════════════════════════════════════

    ; ADD: suma — actualiza ZF, CF, OF, SF
    mov ax, [valor_a]       ; AX = 45
    add ax, [valor_b]       ; AX = 45 + 12 = 57  (ZF=0, CF=0, OF=0)
    mov [resultado], ax     ; guarda 57 en memoria

    ; SUB: resta — puede activar SF si resultado es negativo
    mov ax, [valor_b]       ; AX = 12
    sub ax, [valor_a]       ; AX = 12 - 45 = -33  (SF=1, OF=0)

    ; INC y DEC: incremento/decremento (NO afectan CF)
    mov ax, [valor_a]       ; AX = 45
    inc ax                  ; AX = 46
    dec ax                  ; AX = 45

    ; MUL: multiplicación sin signo (AX = AL * operando)
    mov al, 10              ; AL = 10
    mov bl, 7               ; BL = 7
    mul bl                  ; AX = AL * BL = 70

    ; DIV: división — AL = cociente, AH = resto
    mov ax, 100             ; AX = 100
    mov bl, 7               ; BL = 7
    div bl                  ; AL = 14, AH = 2  (100 = 7*14 + 2)

; ════════════════════════════════════════════════════════════════════════
; BLOQUE 3: Operaciones lógicas
; ════════════════════════════════════════════════════════════════════════

    mov al, 0B7h            ; AL = 1011 0111b = 0xB7

    ; AND: máscara de limpieza — conserva solo los 4 bits bajos
    and al, [mascara]       ; AL = 0B7h AND 0Fh = 0000 0111b = 07h

    mov al, 0B7h            ; restaurar AL = 0B7h
    ; OR: activar bits — activa los 4 bits altos
    or  al, 0F0h            ; AL = 0B7h OR F0h  = 1111 0111b = F7h

    mov al, 0AAh            ; AL = 1010 1010b
    ; XOR: inversión selectiva de bits
    xor al, 0FFh            ; AL = NOT AL = 0101 0101b = 55h

    ; XOR reg,reg: forma estándar para poner a cero un registro
    xor bx, bx              ; BX = 0 (más eficiente que MOV bx,0)

    ; TEST: AND sin guardar resultado — solo actualiza flags
    mov al, 0B7h
    test al, 01h            ; ZF=0 porque bit 0 = 1 (número impar)
                            ; AL sigue siendo 0B7h (no se modifica)

    ; SHL/SHR: desplazamiento de bits (= multiplicar/dividir por 2)
    mov al, 08h             ; AL = 8
    shl al, 2               ; AL = 8 << 2 = 32 = 0x20
    shr al, 1               ; AL = 32 >> 1 = 16 = 0x10

; ════════════════════════════════════════════════════════════════════════
; BLOQUE 4: Control de flujo — Condicionales y bucle
; ════════════════════════════════════════════════════════════════════════

    ; Estructura if/else: comparar valor_a con valor_b
    mov ax, [valor_a]       ; AX = 45
    cmp ax, [valor_b]       ; AX - valor_b = 45 - 12 = 33 > 0
    jg  .mayor              ; salta si AX > valor_b (con signo)
    je  .igual              ; salta si AX == valor_b

    ; AX < valor_b — caso menor (no se alcanza en este programa)
    xor cx, cx              ; CX = 0 como indicador
    jmp .fin_cmp

.mayor:
    mov cx, 1               ; CX = 1: indica que valor_a > valor_b
    jmp .fin_cmp

.igual:
    mov cx, 2               ; CX = 2: indica igualdad

.fin_cmp:

    ; Bucle: suma acumulada de 1 a 5 (resultado esperado: AX = 15)
    xor ax, ax              ; AX = 0 (acumulador inicializado a 0)
    mov cx, 5               ; CX = contador del bucle (5 iteraciones)
    mov bx, 1               ; BX = valor inicial a sumar

.bucle_suma:
    add ax, bx              ; AX += BX  (acumula 1,2,3,4,5)
    inc bx                  ; BX++ (avanza al siguiente valor)
    loop .bucle_suma        ; DEC CX; si CX != 0 → .bucle_suma
    ; Al terminar: AX = 1+2+3+4+5 = 15

    ; Fin del programa
    int 20h                 ; retornar a DOS
