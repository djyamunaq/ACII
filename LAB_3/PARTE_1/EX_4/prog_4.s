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
main:       
            # RE0 OUTPUT
            li      $t1, SFR_BASE_HI            # 
            lw      $t2, TRISE($t1)             # READ (MemAddr = 0xBF880000 + 0x6100)
            andi    $t2, $t2, 0xFFFE            # MODIFY (bit0=0)
            sw      $t2, TRISE($t1)             # WRITE (TRISE0 = 1 => OUTPUT)
            # RE1 OUTPUT
            li      $t1, SFR_BASE_HI            # 
            lw      $t2, TRISE($t1)             # READ (MemAddr = 0xBF880000 + 0x6100)
            andi    $t2, $t2, 0xFFFD            # MODIFY (bit2=0)
            sw      $t2, TRISE($t1)             # WRITE (TRISE2 = 1 => OUTPUT)
            # RE2 OUTPUT
            li      $t1, SFR_BASE_HI            # 
            lw      $t2, TRISE($t1)             # READ (MemAddr = 0xBF880000 + 0x6100)
            andi    $t2, $t2, 0xFFFB            # MODIFY (bit2=0)
            sw      $t2, TRISE($t1)             # WRITE (TRISE2 = 1 => OUTPUT)
            # RE3 OUTPUT
            li      $t1, SFR_BASE_HI            # 
            lw      $t2, TRISE($t1)             # READ (MemAddr = 0xBF880000 + 0x6100)
            andi    $t2, $t2, 0xFFF7            # MODIFY (bit3=0)
            sw      $t2, TRISE($t1)             # WRITE (TRISE3 = 1 => OUTPUT)
            # RB0 INPUT
            lw      $t2, TRISB($t1)             # READ (MemAddr = 0xBF880000 + 0x6100)
            ori     $t2, $t2, 0x0001            # MODIFY (bit0=1)
            sw      $t2, TRISB($t1)             # WRITE (TRISB0 = 1 => INPUT)
            # RB1 INPUT
            lw      $t2, TRISB($t1)             # READ (MemAddr = 0xBF880000 + 0x6100)
            ori     $t2, $t2, 0x0002            # MODIFY (bit1=1)
            sw      $t2, TRISB($t1)             # WRITE (TRISB1 = 1 => INPUT)
            # RB2 INPUT
            lw      $t2, TRISB($t1)             # READ (MemAddr = 0xBF880000 + 0x6100)
            ori     $t2, $t2, 0x0004            # MODIFY (bit2=1)
            sw      $t2, TRISB($t1)             # WRITE (TRISB2 = 1 => INPUT)
            # RB3 INPUT
            lw      $t2, TRISB($t1)             # READ (MemAddr = 0xBF880000 + 0x6100)
            ori     $t2, $t2, 0x0008            # MODIFY (bit3=1)
            sw      $t2, TRISB($t1)             # WRITE (TRISB3 = 1 => INPUT)

while:                                          # while(1)
            # RE0 = RB0
            lw      $t2, PORTB($t1)             # READ (MemAddr = 0xBF880000 + 0x6050)
            andi    $t2, $t2, 0x0001            # GET (bit0)
            lw      $t3, LATE($t1)              # READ (MemAddr = 0xBF880000 + 0x6120)
            andi    $t3, $t3, 0xFFFE            # MODIFY (bit0=0)
            or      $t3, $t3, $t2               # MODIFY (LATE0=PORTB0)
            sw      $t3, LATE($t1)              # WRITE (LATE0)
            # RE1 = RB1
            lw      $t2, PORTB($t1)             # READ (MemAddr = 0xBF880000 + 0x6050)
            andi    $t2, $t2, 0x0002            # GET (bit1)
            lw      $t3, LATE($t1)              # READ (MemAddr = 0xBF880000 + 0x6120)
            andi    $t3, $t3, 0xFFFD            # MODIFY (bit1=0)
            or      $t3, $t3, $t2               # MODIFY (LATE1=PORTB1)
            sw      $t3, LATE($t1)              # WRITE (LATE1)
            # RE2 = RB2
            lw      $t2, PORTB($t1)             # READ (MemAddr = 0xBF880000 + 0x6050)
            andi    $t2, $t2, 0x0004            # GET (bit2)
            lw      $t3, LATE($t1)              # READ (MemAddr = 0xBF880000 + 0x6120)
            andi    $t3, $t3, 0xFFFB            # MODIFY (bit2=0)
            or      $t3, $t3, $t2               # MODIFY (LATE2=PORTB2)
            sw      $t3, LATE($t1)              # WRITE (LATE2)
            # RE3= RB3
            lw      $t2, PORTB($t1)             # READ (MemAddr = 0xBF880000 + 0x6050)
            andi    $t2, $t2, 0x0008            # GET (bit3)
            lw      $t3, LATE($t1)              # READ (MemAddr = 0xBF880000 + 0x6120)
            andi    $t3, $t3, 0xFFF7            # MODIFY (bit3=0)
            or      $t3, $t3, $t2               # MODIFY (LATE3=PORTB3)
            sw      $t3, LATE($t1)              # WRITE (LATE3)

            j while

