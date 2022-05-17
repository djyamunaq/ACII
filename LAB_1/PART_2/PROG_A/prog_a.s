# int main(void) {        
#     char c;    

#     do {          
#         c = getchar();          
#         putchar(c);        
#         } while( c != '\n' );

#     return 0;      
# }

.equ GET_CHAR, 2
.equ PUT_CHAR, 3

.data

.text

.globl main

# MAP
# $ao: c   
main:                                           # int main(void) {        
                                                #     char c;    
do:                                             #     do {             
        li          $v0, GET_CHAR               #         c = getchar();          
        syscall

        move        $a0, $v0                    #         putchar(c); 
        li          $v0, PUT_CHAR
        syscall

        j            do                         #         } while( c != '\n' );

        jr $ra                                  #     return 0;      
                                                # }