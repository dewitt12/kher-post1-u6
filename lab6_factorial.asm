; lab6_factorial.asm — Variante Checkpoint 3: Factorial de 5
; Unidad 6: Instrucciones y Direccionamiento
; Estudiante: Kher — Arquitectura de Computadores 2026
; Compilar: nasm -f bin lab6_factorial.asm -o lab6_factorial.com
;
; Calcula 5! = 5 x 4 x 3 x 2 x 1 = 120
; Diferencia respecto al bucle de suma:
;   - Se reemplaza ADD por MUL
;   - AX se inicializa en 1 (elemento neutro de la multiplicacion)
;   - BX empieza en 5 y decrementa hasta 1

org 100h

; ── Datos ────────────────────────────────────────────────────────────────
jmp inicio

; ── Código ───────────────────────────────────────────────────────────────
inicio:

; ════════════════════════════════════════════════════════════════════════
; Variante con LOOP: calcula 5! usando LOOP
; LOOP decrementa CX automáticamente y salta si CX != 0
; Ventaja: código más compacto
; Desventaja: solo funciona con CX como contador
; ════════════════════════════════════════════════════════════════════════

    mov ax, 1               ; AX = 1 (acumulador, neutro para multiplicacion)
    mov cx, 5               ; CX = 5 (contador: 5 iteraciones)
    mov bx, 5               ; BX = 5 (primer multiplicador)

.bucle_factorial_loop:
    mul bx                  ; AX = AX * BX  (AX se expande a DX:AX en 16-bit)
                            ; Iteracion 1: AX = 1*5 = 5
                            ; Iteracion 2: AX = 5*4 = 20
                            ; Iteracion 3: AX = 20*3 = 60
                            ; Iteracion 4: AX = 60*2 = 120
                            ; Iteracion 5: AX = 120*1 = 120
    dec bx                  ; BX-- (siguiente multiplicador)
    loop .bucle_factorial_loop
                            ; DEC CX; si CX != 0 → .bucle_factorial_loop
    ; Al terminar: AX = 120 = 5!

; ════════════════════════════════════════════════════════════════════════
; Variante equivalente con DEC/JNZ (alternativa a LOOP)
; Ventaja: puede usar cualquier registro como contador, no solo CX
; Desventaja: requiere dos instrucciones en lugar de una
; Cuándo usar DEC/JNZ: cuando CX ya está siendo usado para otro propósito
;   o cuando se necesita más control sobre el flujo del bucle
; ════════════════════════════════════════════════════════════════════════

    ; Mismo calculo con DEC/JNZ usando BX como contador alternativo
    mov ax, 1               ; AX = 1 (reiniciar acumulador)
    mov dx, 5               ; DX = 5 (contador — usamos DX en vez de CX)
    mov bx, 5               ; BX = 5 (primer multiplicador)

.bucle_factorial_jnz:
    mul bx                  ; AX = AX * BX
    dec bx                  ; BX--
    dec dx                  ; DX-- (contador manual)
    jnz .bucle_factorial_jnz
                            ; si DX != 0 → .bucle_factorial_jnz
    ; Al terminar: AX = 120 = 5!

    int 20h                 ; retornar a DOS
