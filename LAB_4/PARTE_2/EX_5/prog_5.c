/*
 * Program: 
 * Author: Denis Yamunaque
 */
#include "header.h"

#define CNTL_DISP_L LATDbits.LATD5
#define CNTL_DISP_H LATDbits.LATD6
#define LB8 LATBbits.LATB8
#define LB9 LATBbits.LATB9
#define LB10 LATBbits.LATB10
#define LB10 LATBbits.LATB10
#define LB11 LATBbits.LATB11
#define LB12 LATBbits.LATB12
#define LB13 LATBbits.LATB13
#define LB14 LATBbits.LATB14

void delay(unsigned int ms) {
    resetCoreTimer();
    unsigned int K = 20000;
    while(readCoreTimer() < K*ms);
}

int main(void) {
    // Define TRISB8..14 as outputs
    TRISBbits.TRISB8 = 0;
    TRISBbits.TRISB9 = 0;
    TRISBbits.TRISB10 = 0;
    TRISBbits.TRISB11 = 0;
    TRISBbits.TRISB12 = 0;
    TRISBbits.TRISB13 = 0;
    TRISBbits.TRISB14 = 0;
    // Define TRISB5..6 as outputs
    TRISDbits.TRISD5 = 0;
    TRISDbits.TRISD6 = 0;
    // enable display low (RD5)
    unsigned int immOp = 1;
    immOp <<= 5;    
    LATD = LATD | immOp; // bit5 = 1
    // disable display high (RD6)
    immOp = 1;
    immOp <<= 6;   
    immOp = ~immOp; // Bitwise not => 0xFFDF = 1111 1111 1011 1111 
    LATD &= immOp;  // bit6 = 0

    int display7Scodes[] = {0x3F00, 0x0600, 0x5B00, 0x4F00, 0x6600, 0x6D00, 0x7B00, 0x0700}; 

    // Mask to toggle bits 6 and 5 from LATB
    int mask5 = 1 << 5;
    int mask6 = 1 << 6;
    while(1) {
        int i;
        for(i=0; i < 7; i++) {
            LATB = display7Scodes[i];
            /*
             * FREQ     TIME
             * 10Hz     100ms
             * 50Hz     20ms
             * 100Hz    10ms
             */
            delay(500);
        }
        // toggle display selection
        CNTL_DISP_H = !CNTL_DISP_H;
        CNTL_DISP_L = !CNTL_DISP_L;
    }
    return 0;
}
