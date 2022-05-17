#include <detpic32.h>

void delay(unsigned int ms) {
    unsigned int K = 20000;
    unsigned int limit = K*ms;
    resetCoreTimer();
    while(readCoreTimer() < limit);
}

int main(void) {
    // Configure port RE1 as output
    __TRISEbits_t TRISEbits;
    TRISEbits.TRISE0 = 0;

    __LATEbits_t LATEbits;

    while(1) {
        // Wait 0.5s
        delay(1000);
        // Toggle RE1 port value
        LATEbits.LATE0 = !LATEbits.LATE0;
    }
    return 0;
}