void delay(unsigned int ms) {
    resetCoreTimer();
    unsigned int K = 20000;
    while(readCoreTimer() < K*ms);
}

int main() {
    putChar('A');
    putChar('\n');
    // int cnt1, cnt5, cnt10, aux;
    // cnt1 = cnt5 = cnt10 = 0;
    
    // while(1) {
    //     aux = 10;
    //     while(aux) {
    //         delay(1);
    //         if(aux % 1 == 0) cnt1++;
    //         if(aux % 5 == 0) cnt5++;
    //         if(aux % 10 == 0) cnt10++;
    //         aux--;
    //     }

    //     putChar('\r');
    //     printInt(cnt1, 10 | 5 << 16);
    //     printInt(cnt5, 10 | 5 << 16);
    //     printInt(cnt10, 10 | 5 << 16);
    // }

    return 0;
}
