# Laboratorio Post-Contenido 1 — Unidad 6: Instrucciones y Direccionamiento

**Asignatura:** Arquitectura de Computadores  
**Programa:** Ingeniería de Sistemas  
**Universidad:** Francisco de Paula Santander  
**Estudiante:** Juan David Kher  
**Año:** 2026  

---

## Objetivo

Implementar un programa en NASM x86 que demuestre las cuatro categorías fundamentales de instrucciones: transferencia de datos, operaciones aritméticas, manipulaciones lógicas y control de flujo con saltos condicionales y bucles.

---

## Archivos del repositorio

```
kher-post1-u6/
├── lab6_instrucciones.asm    # Programa principal con los 4 bloques
├── lab6_instrucciones.com    # Ejecutable compilado
├── lab6_factorial.asm        # Variante Checkpoint 3: factorial de 5
├── lab6_factorial.com        # Ejecutable compilado de la variante
├── capturas/
│   ├── cp1_compilacion.png   # Checkpoint 1: compilación exitosa
│   ├── cp2_debug_flags.png   # Checkpoint 2: trazado DEBUG con flags
│   └── cp3_factorial.png     # Checkpoint 3: factorial compilado
└── README.md
```

---

## Descripción de cada bloque

### Bloque 1 — Transferencia de datos
Carga valores desde memoria a registros usando `MOV`, obtiene direcciones con `LEA`, intercambia registros con `XCHG`, y preserva valores en la pila con `PUSH`/`POP`.

| Instrucción | Operación | Resultado |
|---|---|---|
| `MOV ax, [valor_a]` | Carga valor de memoria | AX = 45 |
| `MOV bx, [valor_b]` | Carga valor de memoria | BX = 12 |
| `LEA si, [valor_a]` | Carga dirección (no valor) | SI = dirección de valor_a |
| `XCHG cx, dx` | Intercambia registros | CX↔DX |
| `PUSH ax / POP ax` | Preserva en pila | AX restaurado = 45 |

### Bloque 2 — Operaciones aritméticas
Realiza suma, resta, incremento, multiplicación y división verificando el efecto sobre los flags.

| Instrucción | Operación | Resultado | Flags |
|---|---|---|---|
| `ADD ax, [valor_b]` | 45 + 12 | AX = 57 | ZF=0, CF=0, OF=0 |
| `SUB ax, [valor_a]` | 12 - 45 | AX = -33 | SF=1, OF=0 |
| `INC ax` | 45 + 1 | AX = 46 | CF no afectado |
| `MUL bl` | 10 × 7 | AX = 70 | — |
| `DIV bl` | 100 ÷ 7 | AL=14, AH=2 | — |

### Bloque 3 — Operaciones lógicas
Manipula bits individuales con AND, OR, XOR, TEST y desplazamientos SHL/SHR.

| Instrucción | Operación | Resultado | Flags |
|---|---|---|---|
| `AND al, [mascara]` | 0B7h AND 0Fh | AL = 07h | ZF=0 |
| `OR al, 0F0h` | 0B7h OR F0h | AL = F7h | — |
| `XOR al, 0FFh` | NOT 0AAh | AL = 55h | — |
| `TEST al, 01h` | Bit 0 de 0B7h | AL sin cambio | ZF=0 (impar) |
| `SHL al, 2` | 8 << 2 | AL = 20h (32) | — |
| `SHR al, 1` | 32 >> 1 | AL = 10h (16) | — |

### Bloque 4 — Control de flujo
Estructura if/else con `CMP`/`JG`/`JE` y bucle de suma acumulada con `LOOP`.

| Estructura | Resultado |
|---|---|
| `CMP ax, [valor_b]` → `JG .mayor` | CX = 1 (valor_a > valor_b) |
| Bucle LOOP (1+2+3+4+5) | AX = 15 |

---

## Tabla de registros y flags observados en DEBUG

| Instrucción | AX | BX | CX | ZF | SF | CF | OF |
|---|---|---|---|---|---|---|---|
| MOV ax, [valor_a] | 002D | — | — | — | — | — | — |
| ADD ax, [valor_b] | 0039 | — | — | 0 | 0 | 0 | 0 |
| SUB ax, [valor_a] | FFDF | — | — | 0 | 1 | 1 | 0 |
| AND al, [mascara] | — | — | — | 0 | 0 | 0 | 0 |
| CMP ax, [valor_b] | — | — | — | 0 | 0 | 0 | 0 |
| LOOP (fin) | 000F | — | 0000 | — | — | — | — |

*(AX = 002Dh = 45d, AX = 0039h = 57d, AX = 000Fh = 15d)*

---

## Checkpoint 1 — Compilación exitosa
![Compilación](capturas/cp1_compilacion.png)

## Checkpoint 2 — Trazado DEBUG con flags
![DEBUG flags](capturas/cp2_debug_flags.png)

## Checkpoint 3 — Variante factorial
![Factorial](capturas/cp3_factorial.png)

---

## Variante Factorial (Checkpoint 3)

El archivo `lab6_factorial.asm` calcula **5! = 120** reemplazando `ADD` por `MUL` e inicializando `AX = 1`.

### LOOP vs DEC/JNZ

| Característica | LOOP | DEC/JNZ |
|---|---|---|
| Registro contador | Solo CX | Cualquier registro |
| Instrucciones | 1 sola | 2 instrucciones |
| Código | Más compacto | Más flexible |
| Cuándo usar | CX disponible, lógica simple | CX ocupado, necesito otro registro |

---

## Conclusiones

- Las instrucciones de transferencia (`MOV`, `LEA`, `XCHG`) son la base del movimiento de datos entre registros y memoria.
- Las operaciones aritméticas afectan directamente los flags del procesador, que son usados por las instrucciones de salto condicional.
- `XOR reg, reg` es más eficiente que `MOV reg, 0` para poner un registro a cero.
- `TEST` permite verificar bits sin modificar el operando, útil antes de saltos condicionales.
- `LOOP` es conveniente pero solo usa `CX`; `DEC/JNZ` es más flexible para bucles complejos.

---

## Commits

```
chore: estructura inicial del repositorio lab instrucciones x86
feat: agregar bloque transferencia y aritmetico
feat: agregar bloque logico, control de flujo y variante factorial
```
