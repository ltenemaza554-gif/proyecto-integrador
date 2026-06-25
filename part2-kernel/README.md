# Parte 2 — Kernel de 64 bits

## Cómo compilar y ejecutar

```bash
# 1. Construir el entorno de build (una sola vez)
docker build -t kernel-build-buildenv buildenv/

# 2. Compilar el kernel y generar el ISO
docker run --rm -it -v "$(pwd)":/root/env kernel-build-buildenv make iso

# 3. Probar en QEMU
qemu-system-x86_64 -cdrom build/x86_64/kernel.iso
```

## Estructura
- `src/boot/` — código en Assembly (header Multiboot2, boot de 32 bits, salto a 64 bits)
- `src/kernel/` — código en C (funciones de impresión y kernel_main)
- `targets/x86_64/` — linker script y configuración de GRUB
- `buildenv/` — Dockerfile con el entorno de compilación (GCC cross-compiler, NASM, GRUB, xorriso)

## Episodio 1
Header Multiboot2 + código de 32 bits que escribe "OK" directo en memoria de video (0xb8000).

## Episodio 2
- Verificación de Multiboot, CPUID y soporte de Long Mode
- Configuración de paging (identity-map del primer GB con huge pages de 2MB)
- GDT de 64 bits
- Salto a modo de 64 bits y enlace con código en C
- Función `print_str` en C que imprime el mensaje personalizado del grupo

## Evidencia
Ver `screen2.png` — captura del kernel mostrando el mensaje personalizado tras el arranque en modo de 64 bits.
