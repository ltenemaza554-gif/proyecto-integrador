#include "print.h"

#define VGA_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80
#define WHITE_ON_BLACK 0x0f

char* vga_buffer = (char*) VGA_ADDRESS;
int current_row = 0;
int current_col = 0;

void clear_screen() {
    for (int i = 0; i < MAX_COLS * MAX_ROWS; i++) {
        vga_buffer[i*2] = ' ';
        vga_buffer[i*2+1] = WHITE_ON_BLACK;
    }
    current_row = 0;
    current_col = 0;
}

void print_char(char c) {
    if (c == '\n') {
        current_row++;
        current_col = 0;
        return;
    }
    int offset = (current_row * MAX_COLS + current_col) * 2;
    vga_buffer[offset] = c;
    vga_buffer[offset+1] = WHITE_ON_BLACK;
    current_col++;
    if (current_col >= MAX_COLS) {
        current_col = 0;
        current_row++;
    }
}

void print_str(char* str) {
    int i = 0;
    while (str[i] != '\0') {
        print_char(str[i]);
        i++;
    }
}
