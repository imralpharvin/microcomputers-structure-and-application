*-----------------------------------------------------------
* Title      : Lab7e
* Written by : Ralph Arvin De Castro
* Date       : 11/11/2019
* Description: Allow a user to change the operational mode of the processor
*-----------------------------------------------------------
        
        MEMORY ROM 0,1023

        ORG    $8000       
main    TRAP #0
        TRAP #0
        TRAP #0
        TRAP #0                  
        SIMHALT             ; halt simulator
        
* The code below is included as a system initialization
* program

* Update Vector Table
TRAPADDR EQU     $80
           ORG     TRAPADDR
           DC.L    TRAPHANDLER

*Trap#0 exception handler
        ORG     $400
TRAPHANDLER
        EORI    #$2000,(A7)
        RTE                     ;return from exception


        END $8000






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
