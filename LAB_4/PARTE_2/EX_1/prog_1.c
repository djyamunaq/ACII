/*
 * Program: Increase counter module 16 4Hz
 * Author: Denis Yamunaque
 */
#include <detpic32.h>

#define CNTL_DISP_L LATDbits.LATD5
#define CNTL_DISP_H LATDbits.LATD6
#define RB8 LATBbits.LATB8
#define RB9 LATBbits.LATB9
#define RB10 LATBbits.LATB10
#define RB11 LATBbits.LATB11
#define RB12 LATBbits.LATB12
#define RB13 LATBbits.LATB13
#define RB14 LATBbits.LATB14

void writeLetterInDisp(char c) {
    switch(c) {
        case 'b':
            RB8  = 0;
            RB9  = 0;
            RB10 = 1;
            RB11 = 1;
            RB12 = 1;
            RB13 = 1;
            RB14 = 1;
            break;
        case 'c':
            RB8  = 1;
            RB9  = 0;
            RB10 = 0;
            RB11 = 1;
            RB12 = 1;
            RB13 = 1;
            RB14 = 0;
            break;
        case 'd':
            RB8  = 0;
            RB9  = 1;
            RB10 = 1;
            RB11 = 1;
            RB12 = 1;
            RB13 = 0;
            RB14 = 1;
            break;
        case 'e':
            RB8  = 1;
            RB9  = 1;
            RB10 = 0;
            RB11 = 1;
            RB12 = 1;
            RB13 = 1;
            RB14 = 1;
            break;
        case 'f':
            RB8  = 1;
            RB9  = 0;
            RB10 = 0;
            RB11 = 0;
            RB12 = 1;
            RB13 = 1;
            RB14 = 1;
            break;
    }
}

int main(void) {
    // Define ports as output
    TRISBbits.TRISB8 = 0;
    TRISBbits.TRISB14 = 0;
    TRISDbits.TRISD5 = 0;
    TRISDbits.TRISD6 = 0;

    CNTL_DISP_L = 0;
    CNTL_DISP_H = 1;

    while(1) {
        char c = getChar();
        RB8  = 1;
        RB9  = 1;
        RB10 = 1;
        RB11 = 1;
        RB12 = 1;
        RB13 = 1;
        RB14 = 1;
        if(c > 'a' && c < 'g') {
            writeLetterInDisp(c);
        }
    }

    return 0;
}
