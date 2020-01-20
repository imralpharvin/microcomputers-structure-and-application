*-----------------------------------------------------------
* Title      : Lab7b
* Written by : Your name goes here
* Date       : dd/mm/yyyy
* Description: Computes n! recursively 
*-----------------------------------------------------------

qOffset     EQU      8              ;displacement from frame pointer
rOffset  EQU     -2              ;displacement from frame pointer


*
* Prologue: Prompt user to enter n, then compute n! 
*

        ORG     $8000
main    LEA     MSG,A1              ;initalize pointer to string
        MOVE    #14,D0              ;print string is task 14
        TRAP    #15                 ;system call
        MOVE    #4,D0               ;read integer from keyboard is task 4
        TRAP    #15                 ;get value of n 
        
        MOVE.W  D1,-(A7)            ;push n onto stack         
        BSR     display            ;call subroutine
        LEA     2(A7),A7            ;remove parameter from stack

        SIMHALT

*
* Display (n)
*  - parameter n is at 8(A6)
*  - local variable fact is at -2(A6)
*  - value of factorial(n) returned in D1

display   
        LINK    A6,#-4              ;allocate storage r and q
        MOVEM.L  D0/D1/D2,-(A7)            ;save working register
*
*       if (n == 1)
*
        CMPI    #0,qOffset(A6)      ;is n=0?
        BNE     L1                  ;no
*
*       else
*
        BRA     L2                  ;return
*
*       display
*        
L1      CLR.L   D2
        MOVE.W  qOffset(A6),D2      ;get n
        DIVS    #10, D2             ;divide by 10
        MOVE.W  D2, qOffset(A6)     ;move quotient
        SWAP    D2
        MOVE.W  D2, rOffset(A6)     ;move remainder
        MOVE.W  qOffset(A6),-(A7)   ;push quotient
        MOVE.W  rOffset(A6),D1
        BSR     display             ;recursion
        MOVE    #3,D0               ;display integer is task 3
        TRAP    #15                 ;system call
        MOVE.L  #10,D1
        MOVE.B  #6,D0
        TRAP    #15
        MOVE.L  #13,D1
        MOVE.B  #6,D0
        TRAP    #15
        LEA     2(A7),A7            ;remove n-1
*}        
L2      MOVEM.L  (A7)+,D0/D1/D2            ;restore working register               
        UNLK    A6                  ;deallocate stack frame
        RTS                         ;return value of factorial(n) in D1

        ORG $9000
MSG     DC.B 'Enter n: ',0

        END     main

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
