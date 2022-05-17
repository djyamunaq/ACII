#include <detpic32.h>

/*
 * TRIS MACROS
 */

// TRISA
#define TA   TRISA
#define TA0  TRISA0
#define TA1  TRISA1
#define TA2  TRISA2
#define TA3  TRISA3
#define TA4  TRISA4
#define TA5  TRISA5
#define TA6  TRISA6
#define TA7  TRISA7
#define TA8  TRISA8
#define TA9  TRISA9
#define TA10 TRISA10
#define TA11 TRISA11
#define TA12 TRISA12
#define TA13 TRISA13
#define TA14 TRISA14
#define TA15 TRISA15
// TRISB
#define TB   TRISB
#define TB0  TRISB0
#define TB1  TRISB1
#define TB2  TRISB2
#define TB3  TRISB3
#define TB4  TRISB4
#define TB5  TRISB5
#define TB6  TRISB6
#define TB7  TRISB7
#define TB8  TRISB8
#define TB9  TRISB9
#define TB10 TRISB10
#define TB11 TRISB11
#define TB12 TRISB12
#define TB13 TRISB13
#define TB14 TRISB14
#define TB15 TRISB15
// TRISC
#define TC   TRISC
#define TC12 TRISC12
#define TC13 TRISC13
#define TC14 TRISC14
#define TC15 TRISC15
// TRISD
#define TD   TRISD
#define TD0  TRISD0
#define TD1  TRISD1
#define TD2  TRISD2
#define TD3  TRISD3
#define TD4  TRISD4
#define TD5  TRISD5
#define TD6  TRISD6
#define TD7  TRISD7
#define TD8  TRISD8
#define TD9  TRISD9
#define TD10 TRISD10
#define TD11 TRISD11
// TRISE
#define TE   TRISE
#define TE0  TRISE0
#define TE1  TRISE1
#define TE2  TRISE2
#define TE3  TRISE3
#define TE4  TRISE4
#define TE5  TRISE5
#define TE6  TRISE6
#define TE7  TRISE7
// TRISF
#define TF   TRISF
#define TF0  TRISF0
#define TF1  TRISF1
#define TF2  TRISF2
#define TF3  TRISF3
#define TF4  TRISF4
#define TF5  TRISF5
// TRISG
#define TG   TRISG
#define TG2  TRISG2
#define TG3  TRISG3
#define TG6  TRISG6
#define TG7  TRISG7
#define TG8  TRISG8
#define TG9  TRISG9

/*
 * PORT MACROS
 */

// PORTA
#define PA   PORTA
#define PA0  RA0
#define PA1  RA1
#define PA2  RA2
#define PA3  RA3
#define PA4  RA4
#define PA5  RA5
#define PA6  RA6
#define PA7  RA7
#define PA8  RA8
#define PA9  RA9
#define PA10 RA10
#define PA11 RA11
#define PA12 RA12
#define PA13 RA13
#define PA14 RA14
#define PA15 RA15
// PORTB
#define PB   PORTB
#define PB0  RB0
#define PB1  RB1
#define PB2  RB2
#define PB3  RB3
#define PB4  RB4
#define PB5  RB5
#define PB6  RB6
#define PB7  RB7
#define PB8  RB8
#define PB9  RB9
#define PB10 RB10
#define PB11 RB11
#define PB12 RB12
#define PB13 RB13
#define PB14 RB14
#define PB15 RB15
// PORTC
#define PC   PORTC
#define PC12 RC12
#define PC13 RC13
#define PC14 RC14
#define PC15 RC15
// PORTD
#define PD   PORTD
#define PD0  RD0
#define PD1  RD1
#define PD2  RD2
#define PD3  RD3
#define PD4  RD4
#define PD5  RD5
#define PD6  RD6
#define PD7  RD7
#define PD8  RD8
#define PD9  RD9
#define PD10 RD10
#define PD11 RD11
// PORTE
#define PE   PORTE
#define PE0  RE0
#define PE1  RE1
#define PE2  RE2
#define PE3  RE3
#define PE4  RE4
#define PE5  RE5
#define PE6  RE6
#define PE7  RE7
// PORTF
#define PF   PORTF
#define PF0  RF0
#define PF1  RF1
#define PF2  RF2
#define PF3  RF3
#define PF4  RF4
#define PF5  RF5
// PORTG
#define PG   PORTG
#define PG2  RG2
#define PG3  RG3
#define PG6  RG6
#define PG7  RG7
#define PG8  RG8
#define PG9  RG9

/*
 * LAT MACROS
 */

//LAT A
#define LA   LATA
#define LA0  LATA0
#define LA1  LATA1
#define LA2  LATA2
#define LA3  LATA3
#define LA4  LATA4
#define LA5  LATA5
#define LA6  LATA6
#define LA7  LATA7
#define LA8  LATA8
#define LA9  LATA9
#define LA10 LATA10
#define LA11 LATA11
#define LA12 LATA12
#define LA13 LATA13
#define LA14 LATA14
#define LA15 LATA15
// LATB
#define LB   LATB
#define LB0  LATB0
#define LB1  LATB1
#define LB2  LATB2
#define LB3  LATB3
#define LB4  LATB4
#define LB5  LATB5
#define LB6  LATB6
#define LB7  LATB7
#define LB8  LATB8
#define LB9  LATB9
#define LB10 LATB10
#define LB11 LATB11
#define LB12 LATB12
#define LB13 LATB13
#define LB14 LATB14
#define LB15 LATB15
// LATC
#define LC   LATC
#define LC12 LATC12
#define LC13 LATC13
#define LC14 LATC14
#define LC15 LATC15
// LATD
#define LD   LATD
#define LD0  LATD0
#define LD1  LATD1
#define LD2  LATD2
#define LD3  LATD3
#define LD4  LATD4
#define LD5  LATD5
#define LD6  LATD6
#define LD7  LATD7
#define LD8  LATD8
#define LD9  LATD9
#define LD10 LATD10
#define LD11 LATD11
// LATE
#define LE   LATE
#define LE0  LATE0
#define LE1  LATE1
#define LE2  LATE2
#define LE3  LATE3
#define LE4  LATE4
#define LE5  LATE5
#define LE6  LATE6
#define LE7  LATE7
// LATF
#define LF   LATF
#define LF0  LATF0
#define LF1  LATF1
#define LF2  LATF2
#define LF3  LATF3
#define LF4  LATF4
#define LF5  LATF5
// LATG
#define LG   LATG
#define LG2  LATG2
#define LG3  LATG3
#define LG6  LATG6
#define LG7  LATG7
#define LG8  LATG8
#define LG9  LATG9

/*
 * Display controllers macros
 */
#define CNTL_DISP_L LATDbits.LATD5
#define CNTL_DISP_H LATDbits.LATD6