*-----------------------------------------------------------
* Title      : Lab4h
* Written by : Ralph Arvin De Castro
* Date       : 10/10/2019
* Description: If-else construct
*-----------------------------------------------------------
    ORG    $8000
START  MOVE.W   A,D0
       CMP.W    #0,D0    ; condition 1
       BLO      ELSE    ;if a less than 0
       CMP.W    #100,D0 ;   condition 2
       BHI      COND3
       BRA      CODE1
COND3  CMP.W    #800,D0
       BLO      ELSE
       BRA      COND4
COND4  CMP.W    #900,D0
       BHI      ELSE
       BRA      CODE1
CODE1  MOVE.W   #1, B
       BRA      EXIT
ELSE   MOVE.W   #0, B
EXIT   trap     #14
* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here
    ORG     $9000
A   DC.W    092
B   DS.W    1

    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
