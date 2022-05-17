/*
 * Program: 
 * Author: Denis Yamunaque
 */
#include <detpic32.h>

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
    unsigned char segment;
    // enable display low (RD5) and disable display high (RD6)
    CNTL_DISP_L = 1;
    CNTL_DISP_H = 0;
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

    unsigned char mask8  = 0x01;
    unsigned char mask9  = 0x02;
    unsigned char mask10 = 0x04;
    unsigned char mask11 = 0x08;
    unsigned char mask12 = 0x10;
    unsigned char mask13 = 0x20;
    unsigned char mask14 = 0x40;

    while(1) {
        segment = 1;
    
        int i;
        for(i=0; i < 7; i++) {
            // send "segment" value to display
            LB8  = (int) (segment & mask8)  == 0 ? 0 : 1;
            LB9  = (int) (segment & mask9)  == 0 ? 0 : 1;
            LB10 = (int) (segment & mask10) == 0 ? 0 : 1;
            LB11 = (int) (segment & mask11) == 0 ? 0 : 1;
            LB12 = (int) (segment & mask12) == 0 ? 0 : 1;
            LB13 = (int) (segment & mask13) == 0 ? 0 : 1;
            LB14 = (int) (segment & mask14) == 0 ? 0 : 1;

            // wait 0.5 second
            delay(100);
            segment = segment << 1;
        }
        // toggle display selection
        CNTL_DISP_H = !CNTL_DISP_H;
        CNTL_DISP_L = !CNTL_DISP_L;
    }
    return 0;
}
