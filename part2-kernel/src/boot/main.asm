global start

section .text
bits 32
start:
    mov dword [0xb8000], 0x2f4b2f4f   ; escribe "OK" con fondo verde
    hlt                                ; detiene el CPU aquí (fin del Episodio 1)
