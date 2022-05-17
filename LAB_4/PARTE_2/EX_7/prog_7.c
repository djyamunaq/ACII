/*
 * Program: 
 * Author: Denis Yamunaque
 */
#include <detpic32.h>

#define CNTL_DISP_L LATDbits.LATD5
#define CNTL_DISP_H LATDbits.LATD6
#define PB0 PORTBbits.RB0
#define PB1 PORTBbits.RB1
#define PB2 PORTBbits.RB2
#define PB3 PORTBbits.RB3
#define LB8 LATBbits.LATB8
#define LB9 LATBbits.LATB9
#define LB10 LATBbits.LATB10
#define LB10 LATBbits.LATB10
#define LB11 LATBbits.LATB11
#define LB12 LATBbits.LATB12
#define LB13 LATBbits.LATB13
#define LB14 LATBbits.LATB14

void send2displays(unsigned char value) {
    static const char display7Scodes[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7B, 0x07, 0xFF, 0x4F, 0x77, 0x7D, 0x68, 0x5F, 0x79, 0x71}; 
    int output, hexIndex;

    // select display high
    CNTL_DISP_H = 1;
    CNTL_DISP_L = 0;
    // send digit_high (dh) to display: dh = value >> 4
    hexIndex = (int) (value >> 4);
    output = (int) (display7Scodes[hexIndex]);
    
    // select display low
    CNTL_DISP_H = 1;
    CNTL_DISP_L = 0;
    // send digit_low (dl) to display: dl = value & 0x0F
    hexIndex = (int) (value & 0x0F);
    output = (int) (display7Scodes[hexIndex]);
}

void delay(unsigned int ms) {
    resetCoreTimer();
    unsigned int K = 20000;
    while(readCoreTimer() < K*ms);
}
