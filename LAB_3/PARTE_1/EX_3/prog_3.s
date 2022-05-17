.equ SFR_BASE_HI, 0xBF880000    # 16 MSbits of SFR area
.equ TRISE, 0x6100              # TRISE address is 0xBF886100
.equ PORTE, 0x6110              # PORTE address is 0xBF886110
.equ LATE, 0x6120               # LATE address is 0xBF886120
.equ TRISB, 0x6040              # TRISE address is 0xBF886040
.equ PORTB, 0x6050              # PORTE address is 0xBF886050
.equ LATB, 0x6060               # LATE address is 0xBF886060
.equ TRISD, 0x60C0              # TRISE address is 0xBF886040
.equ PORTD, 0x60D0              # PORTE address is 0xBF886050
.equ LATD, 0x60E0               # LATE address is 0xBF886060

.data
.text
.globl main

# MAP
# $t1: SFR_BASE_HI 
main:       li      $t1, SFR_BASE_HI            # 
            lw      $t2, TRISE($t1)             # READ (MemAddr = 0xBF880000 + 0x6100)
            andi    $t2, $t2, 0xFFFE            # MODIFY (bit0=0)
            sw      $t2, TRISE($t1)             # WRITE (TRISE0 = 1 => OUTPUT)

            lw      $t2, TRISD($t1)             # READ (MemAddr = 0xBF880000 + 0x60C0)
            ori     $t2, $t2, 0x0100            # MODIFY (bit8=1)
            sw      $t2, TRISD($t1)             # WRITE (TRISD8 = 1 => INPUT)

while:                                          # while(1)
            lw      $t2, PORTD($t1)             # READ (MemAddr = 0xBF880000 + 0x60D0)
            andi    $t2, $t2, 0x0100            # GET (bit8)
            srl     $t2, $t2, 8                 # MODIFY (Shift right logical by 8 bits)
            lw      $t3, LATE($t1)              # READ (MemAddr = 0xBF880000 + 0x6120)
            andi    $t3, $t3, 0xFFFE            # MODIFY (bit8=0)
            or      $t3, $t3, $t2               # MODIFY (LATE0=PORTD8)
            sw      $t3, LATE($t1)              # WRITE (LATE0)

            j       while

