# ============================================================
# GUIA DE COMANDOS — Laboratorio Post-Contenido 1 Unidad 5
# Sigue este orden exacto para completar el laboratorio
# ============================================================

# ─── PASO 1: En tu PC (PowerShell / Terminal) ───────────────
# (Ya tienes la carpeta si descargaste los archivos)
# Si la creas desde cero:
#   mkdir apellido-post1-u5
#   cd apellido-post1-u5
#   mkdir src bin capturas

# Inicializar Git
git init
git checkout -b main

# Captura de pantalla → checkpoint1_estructura.png
# (muestra el árbol de carpetas con: ls -la o dir /s)


# ─── PASO 2: Configurar DOSBox ──────────────────────────────
# 1. Edita dosbox.conf y ajusta la ruta en [autoexec]:
#    mount c "RUTA_COMPLETA_A_TU_CARPETA"
#
# 2. Copia nasm.exe a la carpeta raíz del proyecto
#
# 3. Inicia DOSBox:
#    Windows:      dosbox.exe -conf dosbox.conf
#    Linux/macOS:  dosbox -conf dosbox.conf
#
# 4. Dentro de DOSBox, verifica NASM:
#    C:\> nasm -v
#
# Captura de pantalla → checkpoint2_dosbox_nasm.png


# ─── PASO 3: Programa saludo.com ────────────────────────────
# En DOSBox:
#   C:\> cd src
#   C:\src> nasm -f bin saludo.asm -o ../bin/saludo.com
#   C:\src> cd ..
#   C:\> bin\saludo
#
# IMPORTANTE: En saludo.asm reemplaza [TU APELLIDO] con tu apellido real
#
# Captura de pantalla → checkpoint3_saludo.png


# ─── PASO 4: Programa entrada.com ───────────────────────────
# En DOSBox:
#   C:\> cd src
#   C:\src> nasm -f bin entrada.asm -o ../bin/entrada.com
#   C:\src> cd ..
#   C:\> bin\entrada
#   (presiona una tecla y observa el carácter y código hex)
#
# Captura de pantalla → checkpoint4_entrada.png


# ─── PASO 5: Depuración con DEBUG ───────────────────────────
# En DOSBox:
#   C:\> debug bin\saludo.com
#   -r
#   -u 100 10F
#   -t
#   -t
#   -t
#   -g
#   -q
#
# Captura de pantalla → checkpoint5_debug.png


# ─── PASO 6: Commits y subida a GitHub ──────────────────────
# En tu PC, desde la carpeta apellido-post1-u5:

git add README.md dosbox.conf
git commit -m "chore: estructura inicial del laboratorio DOSBox"

git add src/saludo.asm bin/saludo.com capturas/checkpoint1_estructura.png capturas/checkpoint2_dosbox_nasm.png capturas/checkpoint3_saludo.png
git commit -m "feat: programa saludo.com - salida de texto con INT 21h"

git add src/entrada.asm bin/entrada.com capturas/checkpoint4_entrada.png capturas/checkpoint5_debug.png
git commit -m "feat: programa entrada.com - lectura de teclado y eco en hex"

# Crear el repositorio en GitHub primero, luego:
git remote add origin https://github.com/TU_USUARIO/apellido-post1-u5.git
git push -u origin main
