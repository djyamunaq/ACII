# void delay(unsigned int ms) {    
#     resetCoreTimer();    
#     while(readCoreTimer() < K * ms); 
# } 

.equ READ_CORE_TIMER, 11
.equ RESET_CORE_TIMER, 12
.equ PRINT_STR, 8
.equ K, 20000

.data
.text
.globl main

main:       # Save return address
            addiu	$sp, $sp, -4
            sw		$ra, 0($sp)

            # Call function delay with ms = 1
            
            jal     delay 

            # Restore return address
            lw		$ra, 0($sp)
            addiu	$sp, $sp, 4

            # Return 0
            li      $v0, 0
            jr      $ra

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