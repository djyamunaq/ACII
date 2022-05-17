.equ SFR_BASE_HI, 0xBF880000    # 16 MSbits of SFR area
.equ TRISE, 0x6100              # TRISE address is 0xBF886100
.equ PORTE, 0x6110              # PORTE address is 0xBF886110
.equ LATE, 0x6120               # LATE address is 0xBF886120
.equ LATB, 0x6060               # LATE address is 0xBF886060
.equ TRISD, 0x60C0              # TRISE address is 0xBF886040
.equ PORTD, 0x60D0              # PORTE address is 0xBF886050
.equ LATD, 0x60E0               # LATE address is 0xBF886060
.equ K, 20000
.equ READ_CORE_TIMER, 11
.equ RESET_CORE_TIMER, 12
.equ PRINT_INT10, 7
.equ K, 20000

.data
.text
.globl main

# MAP
# $s0: v
# $s1: TRISE/TRISD
# $s2: LATE/LATD
# $s3: SFR_BASE_HI
main:                                               # void main(void)
            li          $s3, SFR_BASE_HI
                                                    # {
            li          $s0, 0                      #   int v = 0;
            # TRISE0 OUTPUT
            lw          $s1, TRISE($s3)             #   TRISE0 = 0; // Configura o porto RE0 como saída
            andi        $s1, $s1, 0xFFFE
            sw          $s1, TRISE($s3)
            # TRISD0 OUTPUT
            lw          $s1, TRISD($s3)             #   TRISD0 = 0; // Configura o porto RD0 como saída
            andi        $s1, $s1, 0xFFFE
            sw          $s1, TRISD($s3)

while:                                              #   while(1)
                                                    #   {
            # LATE0 = v
            lw          $s2, LATE($s3)              #       LATE0 = v; // Escreve v no bit 0 do porto E
            andi        $s0, $s0, 0x0001
            andi        $s2, $s2, 0xFFFE
            or          $s2, $s2, $s0 
            sw          $s2, LATE($s3)
            # LATD0 = v
            lw          $s2, LATD($s3)              #       LATD0 = v; // Escreve v no bit 0 do porto E
            andi        $s0, $s0, 0x0001
            andi        $s2, $s2, 0xFFFE
            or          $s2, $s2, $s0 
            sw          $s2, LATD($s3)
            # CALL delay()
            addi        $sp, $sp, -4                #       delay(500); // Atraso de 500ms
            sw          $ra, 0($sp)
            li          $a0, 500
            jal         delay
            lw          $ra, 0($sp)
            addi        $sp, $sp, 4

            xori        $s0, $s0, 0x0001            #       v ^= 1; // complementa o bit 0 de v (v = v xor 1)
                                                    #   }
                                                    # }
            # DEBUG
            li          $v0, PRINT_INT10
            move        $a0, $s0
            syscall

            j           while


# MAP
# $a0: ms
# $t1: K*ms
delay:                                              # void delay(unsigned int ms) {    
            li          $t1, K                       
            mul         $t1, $t1, $a0
            li          $v0, RESET_CORE_TIMER       #     resetCoreTimer();    
            syscall

delay_While1: 
            li          $v0, READ_CORE_TIMER
            syscall
            bge         $v0, $t1, end_delay_While1  #     while(readCoreTimer() < K * ms);
            j           delay_While1
                                                    # } 
end_delay_While1:
            jr          $ra

