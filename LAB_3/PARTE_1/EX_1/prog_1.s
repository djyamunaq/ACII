.equ SFR_BASE_HI, 0xBF880000    # 16 MSbits of SFR area
.equ TRISE, 0x6100              # TRISE address is 0xBF886100
.equ PORTE, 0x6110              # PORTE address is 0xBF886110
.equ LATE, 0x6120               # LATE address is 0xBF886120
.equ TRISB, 0x6040              # TRISE address is 0xBF886040
.equ PORTB, 0x6050              # PORTE address is 0xBF886050
.equ LATB, 0x6060               # LATE address is 0xBF886060

.data
.text
.globl main

# MAP
# $t1: SFR_BASE_HI 
main:       li      $t1, SFR_BASE_HI            # 
            lw      $t2, TRISE($t1)             # READ (MemAddr = 0xBF880000 + 0x6100)
            andi    $t2, $t2, 0xFFFE            # MODIFY (bit0=0)
            sw      $t2, TRISE($t1)             # WRITE (TRISE0 = 1 => OUTPUT)

            lw      $t2, TRISB($t1)             # READ (MemAddr = 0xBF880000 + 0x6100)
            ori     $t2, $t2, 0x0001            # MODIFY (bit0=1)
            sw      $t2, TRISB($t1)             # WRITE (TRISB0 = 1 => INPUT)

while:                                          # while(1)
            lw      $t2, PORTB($t1)             # READ (MemAddr = 0xBF880000 + 0x6050)
            andi    $t2, $t2, 0x0001            # GET (bit0)
            lw      $t3, LATE($t1)              # READ (MemAddr = 0xBF880000 + 0x6120)
            andi    $t3, $t3, 0xFFFE            # MODIFY (bit0=0)
            or      $t3, $t3, $t2               # MODIFY (LATE0=PORTB0)
            sw      $t3, LATE($t1)              # WRITE (LATE0)

            j while

