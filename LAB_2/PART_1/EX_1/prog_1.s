# int main(void) {    
#     int counter = 0;    
#     while(1)    {       
#         resetCoreTimer();       
#         while(readCoreTimer() < 200000);       
#             printInt(counter++, 10 | 4 << 16);    // Ver nota1      
#             putChar('\r');                        // cursor regressa ao inicio da linha    
#     }    
#     return 0; 
# }

.equ READ_CORE_TIMER, 11
.equ RESET_CORE_TIMER, 12
.equ PUT_CHAR, 3
.equ PRINT_INT, 6

.data

.text

.globl main

# MAP
# $t0: counter
main:                                           # int main(void) {    
            li      $t0, 0                      #     int counter = 0;    

while1:                                         #     while(1)    {       

            li      $v0, RESET_CORE_TIMER       #         resetCoreTimer();       

while2: 
            li      $v0, READ_CORE_TIMER        #         while(readCoreTimer() < 200000);       
            bge     $v0, 200000, endWhile2

            li      $v0, PRINT_INT              #             printInt(counter++, 10 | 4 << 16);    // Ver nota1      
            move    $a0, $t0
            li      $a1, 4
            sll     $a1, $a1, 16
            ori     $a1, $a1, 10
            syscall
            addiu   $t0, $t0, 1

            li      $a0, '\r'                   #             putChar('\r');            // cursor regressa ao inicio da linha    
            li      $v0, PUT_CHAR 
            syscall

            j while2

endWhile2: 

            j while1
 
                                                #     }    
                                                #     return 0; 
                                                # }
