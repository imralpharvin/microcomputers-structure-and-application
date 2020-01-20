*-----------------------------------------------------------
* Title      : Lab4k
* Written by : Ralph Arvin De Castro
* Date       : 10/10/2019
* Description: While-statement and For-statement
*-----------------------------------------------------------
    ORG    $8000

* Put program code here
START 
TOP     CMPI.W  #50,I
        BGE     EXIT
        ADDQ.W  #1,A
        ADDQ.W  #1,I
        BRA     TOP ;loop
EXIT    TRAP    #14
    
    SIMHALT             ; halt simulator

* Put variables and constants here
    ORG     $9000
A   DC.W    0
I   DC.W    0

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
