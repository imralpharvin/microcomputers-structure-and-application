*-----------------------------------------------------------
* Title      : Lab7a
* Written by : Ralph Arvin De Castro
* Date       : dd/mm/yyyy
* Description: Computes the sum of the square of two numbers 
*              using the formula c = a^2 + b^2  
*-----------------------------------------------------------

aOffset     EQU     14              ;displacement from frame pointer
bOffset     EQU     12              ;displacement from frame pointer
cOffset     EQU     8               ;displacement from frame pointer
xOffset     EQU     -4              ;displacement from frame pointer
yOffset     EQU     -8              ;displacement from frame pointer
zOffset     EQU     -12              ;displacement from frame pointer



        ORG     $8000

main    MOVE.W  #4,-(A7)            ;push a = 4         
        MOVE.W  #5,-(A7)            ;push b = 5 
        PEA     c                   ;push address of c 
        BSR     sumSquared          ;call subroutine
        LEA     8(A7),A7            ;remove parameters from stack
        
        SIMHALT
   
      
sumSquared   
        LINK    A6,#-12              ;allocate storage for three longwords
        MOVEM.L A0/D0/D1,-(A7)         ;save working registers
        MOVE.W  aOffset(A6),D0      ;get a
        MULS    D0,D0               ;compute a * a
        MOVE.L  D0,xOffset(A6)      ;x = a * a   
        MOVE.W  bOffset(A6),D0      ;get b
        MULS    D0,D0               ;compute b * b
        MOVE.L  D0,yOffset(A6)      ;y = b * b 
        MOVE.W  aOffset(A6),D0      ;get a
        MOVE.W  bOffset(A6),D1      ;get b
        MULS    D1,D0               ;compute a * b
        MULS    #2,D0               ;compute 2 * a * b
        MOVE.L  D0,zOffset(A6)      ;y = b * b 
        MOVEA.L cOffset(A6),A0      ;get address of c
        MOVE.L  xOffset(A6),D0      ;get x
        ADD.L   yOffset(A6),D0      ;add x + y
        ADD.L   zOffset(A6),D0      ;add x + y + z
        MOVE.L  D0,(A0)             ;save in c
        MOVEM.L (A7)+,A0/D0/D1         ;restore working registers
        UNLK    A6                  ;deallocate stack frame
        RTS                         ;return to caller

        ORG     $9000
c       DS.L    1                    ;variable c
       
        END     main
   




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
