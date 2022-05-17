#include "header.h"

void send2displays(unsigned char value) {
    static const char display7Scodes[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7B, 0x07, 0x7F, 0x67, 0x77, 0x7D, 0x38, 0x5F, 0x79, 0x71}; 
    // select display high
    CNTL_DISP_L = 0;
    CNTL_DISP_H = 1;
    // send digit_high (dh) to display: dh = value >> 4
    unsigned char valueH = value & 0xF0;
    PORTB = (int) display7Scodes[valueH]

    // select display low
    CNTL_DISP_L = 1;
    CNTL_DISP_H = 0;
    // send digit_low (dl) to display: dl = value & 0x0F
    unsigned char valueL = value & 0x0F;
    PORTB = (int) display7Scodes[valueL];
}