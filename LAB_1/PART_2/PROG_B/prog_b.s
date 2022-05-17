# int main(void)      {        
#     char c;    

#     do {          
#         c = inkey();

#         if(c != 0)          
#             putchar(c);
#         else
#             putchar('.');        
#     } while( c != '\n' );

#     return 0;      
# }

.equ INKEY, 1
.equ PUT_CHAR, 3

.data

.text

.globl main

# MAP
# $t0: c
main:                                   # int main(void)      {        
                                        #     char c;    

do:                                     #     do {          
        li          $v0, INKEY          #         c = inkey();
        syscall
        move        $t0, $v0

if:     beq         $t0, '0', else      #         if(c != 0)          
        move        $a0, $t0            #             putchar(c);            
        li          $v0, PUT_CHAR
        syscall 
        j           while
else:                                   #         else
        li          $a0, '.'            #             putchar('.');
        li          $v0, PUT_CHAR  
        syscall      
while:  bne         $t0, '\n', do       #     } while( c != '\n' );

                                        #     return 0;      
                                        # }

        jr          $ra