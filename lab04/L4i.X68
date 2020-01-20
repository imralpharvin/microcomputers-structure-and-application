*-----------------------------------------------------------
* Title      : Lab4h
* Written by : Ralph Arvin De Castro
* Date       : 10/10/2019
* Description: If-else construct
*-----------------------------------------------------------
    ORG    $8000
START         MOVE.B   A,D1
       MOVE.B   B,D2
       CMP.B    D2,D1    ; first instruction of program
       BLS      ELSE
       MOVE.B   C,A
       MOVE.B   C,B
ELSE   MOVE.B   A,D0
       MOVE.B   B,A
       MOVE.B   D0,B
EXIT   trap     #14
* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here
    ORG     $9000
A   DC.B    0
B   DC.B    9
C   DC.B    2
    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
