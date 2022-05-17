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
    // enable display low (RD5)
    unsigned int immOp = 1;
    immOp <<= 5;    
    LATD = LATD | immOp; // bit5 = 1
    // disable display high (RD6)
    immOp = 1;
    immOp <<= 6;   
    immOp = ~immOp; // Bitwise not => 0xFFDF = 1111 1111 1011 1111 
    LATD &= immOp;  // bit6 = 0
    // Define TRIS variables
    __TRISBbits_t TRISBbits;
    __TRISDbits_t TRISDbits;
    // Define PORT variables
    __PORTBbits_t PORTBbits;
    // Define TRISB0..3 as inputs
    TRISBbits.TRISB0 = 1;
    TRISBbits.TRISB1 = 1;
    TRISBbits.TRISB2 = 1;
    TRISBbits.TRISB3 = 1;
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
    // Hex codes for display numbers 0..7
    int display7Scodes[] = {0x003F, 0x0006, 0x005B, 0x004F, 0x0066, 0x006D, 0x007B, 0x0007}; 
    int value;

    while(1) {
        // Write input to display7seg
        value = 0;
        value = PB0 == 1 ? value | 1 : value;
        value = PB1 == 1 ? value | (1 << 1) : value;
        value = PB2 == 1 ? value | (1 << 2) : value;
        value = PB3 == 1 ? value | (1 << 3) : value;

        LATBbits.LATB14 = 1;
        /*
         * FREQ     TIME
         * 10Hz     100ms
         * 50Hz     20ms
         * 100Hz    10ms
         */
        delay(100);
    }
    return 0;
}
