*-----------------------------------------------------------
* Title      : Lab4
* Written by : Ralph Arvin De Castro
* Date       : 10/10/2019
* Description: While-statement and For-statement
*-----------------------------------------------------------
    ORG    $8000

* Put program code here
START   MOVEA.L  #MY_SID,A0
LOOP    CMPI.B  #7,D3
        BGE     EXIT
        CLR.L     D2
        MOVE.W  (A0)+,D2
        DIVU    #2, D2
        SWAP    D2
        CMPI.W  #0,D2
        BEQ     IsEVEN
        ADDQ    #1,D1
        BRA     CONT
IsEVEN  ADDQ    #1,D0
CONT    ADDQ    #1,D3
        BRA     LOOP
EXIT    TRAP    #14
    
    SIMHALT             ; halt simulator

* Put variables and constants here
    ORG     $9000
MY_SID   DC.W    0,9,2,3,2,2,3
even     DS.W   1
odd      DS.W   1
digit    DS.W   1
counter  DS.W   1

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
