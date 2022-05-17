#include <detpic32.h>

int main() {
    TRISEbits.TRISE0 = 0;
    LATEbits.LATE0 = 1;

    while(1){}

    return 0;
}
