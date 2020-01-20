*-----------------------------------------------------------
* Title      : Lab8j
* Written by : Ralph Arvin De Castro
* Date       : 21/11/2019
* Description: This program demonstrates a level-2 ISR
*----------------------------------------------------------

HARDWARE    EQU     $E00000     ;base address of hardware devices
H1          EQU     0           ;offset of digit 1 from base
H2          EQU     2          
N1          EQU     4
M1          EQU     6
M2          EQU     8
N2          EQU     10
S1          EQU     12
S2          EQU     14          


*
* Prologue: Display hardware window from software

            ORG    $8000
START:      MOVE.L  #32,D0           ;task number 32
            CLR.B   D1               ;parameter: display window
            TRAP    #15              ;system call
*
* Place address of the level-2 ISR into the vector table

            MOVE.L  #ISR6,$78
            MOVE.L  #ISR7,$7C

*
* Main () function continuously displays text message on screen

MAIN        NOP
            BRA      MAIN

MSG         DC.B    'Executing in main() function',0


ISR7        MOVE.L  #0, SECOND
            MOVE.L  #0, MINUTE
            MOVE.L  #0, HOUR
            RTE

*
* Interrupt service routine for level-2 auto-vector interrupt

ISR6        ORI.W   #$0700,SR          ;set priority level to 7
            MOVEM.L A1/D0,-(A7)        ;save working registers
            ANDI.W  #$FEFF,SR          ;set priority level to 6
            LEA     MSG2,A1            ;point to message
            MOVE.B  #13,D0             ;display message on console
            TRAP    #15                ;system call
                     
            SUB.L   #1, COUNTER
            CMP.L   #0, COUNTER
            BNE     EXIT
            MOVE.L  #60, COUNTER
                     
            ADD.L   #1, SECOND            ;decrement second by 1
            CMP.L   #60, SECOND
            BNE     EXIT
            MOVE.L  #0, SECOND
            
            ADD.L   #1, MINUTE
            CMP.L   #60, MINUTE
            BNE     EXIT
            MOVE.L  #0, MINUTE
            
            ADD.L   #1, HOUR
            CMP.L   #24, HOUR
            BNE     EXIT
            MOVE.L  #0, HOUR
            
EXIT        NOP
            
            LEA      HARDWARE,A3               ;point to base
            LEA      CONVERT,A2                ;point to conversion table
            MOVE.L   SECOND, D4
            DIVS     #10,D4 
            MOVE.B   (A2,D4),SS1
            MOVE.B   SS1,S1(A3)           ;write digit to 7-segment display
            SWAP     D4
            MOVE.B   (A2,D4),SS2
            MOVE.B   SS2,S2(A3) 
            MOVE.B   NN2,N2(A3)  

            MOVE.L   MINUTE, D4
            DIVS     #10,D4 
            MOVE.B   (A2,D4),MM1
            MOVE.B   MM1,M1(A3)           ;write digit to 7-segment display
            SWAP     D4
            MOVE.B   (A2,D4),MM2
            MOVE.B   MM2,M2(A3) 
            MOVE.B   NN1,N1(A3)   
            
            MOVE.L   HOUR, D4
            DIVS     #10,D4 
            MOVE.B   (A2,D4),HH1
            MOVE.B   HH1,H1(A3)           ;write digit to 7-segment display
            SWAP     D4
            MOVE.B   (A2,D4),HH2
            MOVE.B   HH2,H2(A3) 
  
   

*
* Restore state: working registers, status register, and program counter
            MOVEM.L (A7)+,A1/D0        ;restore working registers
            RTE                        ;use RTE to return from interrupt

MSG2        DC.B    'Executing level-6 interrupt service routine',0

*
* 7-Segment LED patterns for digits 0-9
CONVERT     DC.B    $3F, $06, $5B, $4F, $66, $6D, $7D, $07, $7F, $6F

            ORG $9000
COUNTER     DC.l    60
HOUR        DC.L    23
MINUTE      DC.L    59
SECOND      DC.L    55
HH1         DC.B    0
HH2         DC.B    0
NN1         DC.B    $40
MM1         DC.B    0
MM2         DC.B    0
NN2         DC.B    $40
SS1         DC.B    0
SS2         DC.B    0

            END     START


            END     START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
