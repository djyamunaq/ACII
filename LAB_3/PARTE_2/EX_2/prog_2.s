# Program: 1Hz binary counter

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
.equ K, 20000
.equ READ_CORE_TIMER, 11
.equ RESET_CORE_TIMER, 12

.data
.text
.globl main

# MAP
# $s0: SFR_BASE_HI 
# $s1: counter
main:       
            li      $s0, SFR_BASE_HI            
            # RE0 OUTPUT
            lw      $t2, TRISE($s0)             # READ (MemAddr = 0xBF880000 + 0x6100)
            andi    $t2, $t2, 0xFFFE            # MODIFY (bit0=0)
            sw      $t2, TRISE($s0)             # WRITE (TRISE0 = 1 => OUTPUT)
            # RE1 OUTPUT
            lw      $t2, TRISE($s0)             # READ (MemAddr = 0xBF880000 + 0x6100)
            andi    $t2, $t2, 0xFFFD            # MODIFY (bit2=0)
            sw      $t2, TRISE($s0)             # WRITE (TRISE2 = 1 => OUTPUT)
            # RE2 OUTPUT
            lw      $t2, TRISE($s0)             # READ (MemAddr = 0xBF880000 + 0x6100)
            andi    $t2, $t2, 0xFFFB            # MODIFY (bit2=0)
            sw      $t2, TRISE($s0)             # WRITE (TRISE2 = 1 => OUTPUT)
            # RE3 OUTPUT
            lw      $t2, TRISE($s0)             # READ (MemAddr = 0xBF880000 + 0x6100)
            andi    $t2, $t2, 0xFFF7            # MODIFY (bit3=0)
            sw      $t2, TRISE($s0)             # WRITE (TRISE3 = 1 => OUTPUT)

            li      $s1, 15                     # counter = 0

while:                                          # while(1)
            # RE0 = bit0 counter
            move    $t2, $s1
            andi    $t2, $t2, 0x0001
            lw      $t3, LATE($s0)              # READ (MemAddr = 0xBF880000 + 0x6120)
            andi    $t3, $t3, 0xFFFE            # MODIFY (bit0=0)
            or      $t3, $t3, $t2               # MODIFY (LATE0=PORTB0)
            sw      $t3, LATE($s0)              # WRITE (LATE0)
            # RE1 = bit1 counter
            move    $t2, $s1
            andi    $t2, $t2, 0x0002
            lw      $t3, LATE($s0)              # READ (MemAddr = 0xBF880000 + 0x6120)
            andi    $t3, $t3, 0xFFFD            # MODIFY (bit1=0)
            or      $t3, $t3, $t2               # MODIFY (LATE1=PORTB1)
            sw      $t3, LATE($s0)              # WRITE (LATE1)
            # RE2 = bit2 counter
            move    $t2, $s1
            andi    $t2, $t2, 0x0004
            lw      $t3, LATE($s0)              # READ (MemAddr = 0xBF880000 + 0x6120)
            andi    $t3, $t3, 0xFFFB            # MODIFY (bit2=0)
            or      $t3, $t3, $t2               # MODIFY (LATE2=PORTB2)
            sw      $t3, LATE($s0)              # WRITE (LATE2)
            # RE3 = bit3 counter
            move    $t2, $s1
            andi    $t2, $t2, 0x0008
            lw      $t3, LATE($s0)              # READ (MemAddr = 0xBF880000 + 0x6120)
            andi    $t3, $t3, 0xFFF7            # MODIFY (bit3=0)
            or      $t3, $t3, $t2               # MODIFY (LATE3=PORTB3)
            sw      $t3, LATE($s0)              # WRITE (LATE3)

            addiu       $sp, $sp, -4            # delay(1000);
            sw          $ra, 0($sp)
            addiu       $sp, $sp, -4            # save $s0
            sw          $s0, 0($sp)
            addiu       $sp, $sp, -4            # save $s1
            sw          $s1, 0($sp)

            li          $a0, 250
            jal         delay

            lw          $s1, 0($sp)             # Restore $s1
            addiu       $sp, $sp, 4
            lw          $s0, 0($sp)             # Restore $s0
            addiu       $sp, $sp, 4
            lw          $ra, 0($sp)             # Restore $ra
            addiu       $sp, $sp, 4

            addi        $s1, $s1, -1             # counter--

            j while

# MAP
# $a0: ms
# $t0: K*ms
delay:                                              # void delay(unsigned int ms) {    
            li          $t0, K                       
            mul         $t0, $t0, $a0
            li          $v0, RESET_CORE_TIMER       #     resetCoreTimer();    
            syscall

delay_While1: 
            li          $v0, READ_CORE_TIMER
            syscall
            bge         $v0, $t0, end_delay_While1  #     while(readCoreTimer() < K * ms);
            j           delay_While1
                                                    # } 
end_delay_While1:
            jr          $ra
