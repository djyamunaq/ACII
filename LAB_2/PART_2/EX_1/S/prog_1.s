# void delay(unsigned int ms) {
#     WriteCoreTimer(0);
#     unsigned int K = 20000;
#     while(ReadCoreTimer() < K*ms);
# }

# int main() {
#     int cnt1, cnt5, cnt10, aux;
#     cnt1 = cnt5 = cnt10;
#     while(1) {
#       aux = 10;
#         while(aux) {
#             delay(1);
#             if(aux % 1 == 0) cnt1;
#             if(aux % 5 == 0) cnt5;
#             if(aux % 10 == 0) cnt10;
#             aux--;
#             putchar('\r');
#             printf("%5d %5d %5d\n", cnt1++, cnt5++, cnt10++);
#         }
#     }

#     return 0;
# }

.equ PUT_CHAR, 3
.equ READ_CORE_TIMER, 11
.equ RESET_CORE_TIMER, 12
.equ PRINT_INT, 6
.equ K, 20000


.data

.text

.globl main

# MAP
# $s0: cnt1
# $s1: cnt5
# $s2: cnt10
# $s3: aux
main:                                               # int main() {
                                                    #     int cnt1, cnt5, cnt10, aux;
li $s0, 0                                           #     cnt1 = cnt5 = cnt10 = 0;
li $s1, 0
li $s2, 0

while1:                                             #     while(1) {

            li          $s3, 1                      #       aux = 10;

while2:     beq         $s3, 11, endWhile2          #         while(aux) {

            addiu       $sp, $sp, -4                #             delay(1);
            sw          $ra, 0($sp)

            li          $a0, 1000
            jal         delay

            lw          $ra, 0($sp)
            addiu       $sp, $sp, 4

            li          $v0, PUT_CHAR               #         putchar('\r');
            li          $a0, '\r' 
            syscall

            li          $v0, PRINT_INT               #         printf("%5d %5d %5d\n", cnt1, cnt5, cnt10);
            li          $a1, 5
            sll         $a1, $a1, 16
            ori         $a1, $a1, 10
            move        $a0, $s0
            syscall 

            li          $v0, PUT_CHAR               
            li          $a0, ' ' 
            syscall

            li          $v0, PRINT_INT 
            li          $a1, 5
            sll         $a1, $a1, 16
            ori         $a1, $a1, 10
            move        $a0, $s1
            syscall 

            li          $v0, PUT_CHAR               
            li          $a0, ' ' 
            syscall

            li          $v0, PRINT_INT
            li          $a1, 5
            sll         $a1, $a1, 16
            ori         $a1, $a1, 10
            move        $a0, $s2
            syscall 
            li          $t0, 5                      #             if(aux % 5 == 0) cnt5++;
            rem         $t0, $s3, $t0
            bne         $t0, 0, if10
            addiu       $s1, $s1, 1

if10:                                               #             if(aux % 10 == 0) cnt10++;
            li          $t0, 10
            rem         $t0, $s3, $t0
            bne         $t0, 0, endif
            addiu       $s2, $s2, 1

endif:
            addiu       $s0, $s0, 1                 #             cnt1++;

            addi        $s3, $s3, 1                #             aux--;

            j while2
                                                    #         }

endWhile2:
            j while1
                                                    #     }

            li          $v0, 0                      #     return 0;
            jr          $ra
                                                    # }

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

