#  int main(void)      {        
#     int value;        
#     while(1)        {          
#         printStr("\nIntroduza um inteiro (sinal e módulo): ";          
#         value = readInt10();          
#         printStr("\nValor em base 10 (signed): ");          
#         printInt10(value);          
#         printStr("\nValor em base 2: ";          
#         printInt(value, 2);          
#         printStr("\nValor em base 16: ");          
#         printInt(value, 16);          
#         printStr("\nValor em base 10 (unsigned): ");          
#         printInt(value, 10);          
#         printStr("\nValor em base 10 (unsigned), formatado: ";          
#         printInt(value, 10 | 5 << 16); // ver nota de rodapé 3       
#     }        
#     return 0;      
#  }

.equ printStr, 8
.equ readInt10, 5
.equ printInt10, 7
.equ printInt, 6

.data
msg1:   .asciiz "\nIntroduza um inteiro (sinal e módulo): "
msg2:   .asciiz "\nValor em base 10 (signed): "
msg3:   .asciiz "\nValor em base 2: "
msg4:   .asciiz "\nValor em base 16: " 
msg5:   .asciiz "\nValor em base 10 (unsigned): "
msg6:   .asciiz "\nValor em base 10 (unsigned), formatado: "

.text

.globl main

# PARAM
# $t0: value
main:                                       #  int main(void)      {        
                                            #     int value;        
while:                                      #     while(1)        {          
        la          $a0, msg1
        li          $v0, printStr           #         printStr("\nIntroduza um inteiro (sinal e módulo): ";          
        syscall 
        
        li          $v0, readInt10          #         value = readInt10();          
        syscall 
        move        $t0, $v0
        
        la          $a0, msg2               #         printStr("\nValor em base 10 (signed): ");          
        li          $v0, printStr
        syscall 
        
        move        $a0, $t0                #         printInt10(value);  
        li          $v0, printInt10
        syscall 
        
        la          $a0, msg3               #         printStr("\nValor em base 2: ";          
        li          $v0, printStr
        syscall 
        
        move        $a0, $t0                #         printInt(value, 2);        
        li          $a1, 2
        li          $v0, printInt
        syscall 
        
        la          $a0, msg4               #         printStr("\nValor em base 16: ");  
        li          $v0, printStr
        syscall   
        
        move        $a0, $t0                #         printInt(value, 16);        
        li          $a1, 16
        li          $v0, printInt
        syscall       
        

        la          $a0, msg5               #         printStr("\nValor em base 10 (unsigned): ");     
        li          $v0, printStr
        syscall   
        
        move        $a0, $t0                #         printInt(value, 10);        
        li          $a1, 10
        li          $v0, printInt
        syscall   
                    
        la          $a0, msg6               #         printStr("\nValor em base 10 (unsigned), formatado: "; 
        li          $v0, printStr
        syscall   

        move        $a0, $t0                #         printInt(value, 10 | 5 << 16); // ver nota de rodapé 3       
        li          $t1, 5
        sll         $t1, $t1, 16
        ori		    $t1, $t1, 10		
        move        $a1, $t1
        li          $v0, printInt
        syscall 
                
        j           while
                                            #     }        
                                            #     return 0;      
                                            #  }
