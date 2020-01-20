*-----------------------------------------------------------
* Title      : Lab5
* Written by : Ralph Arvin De Castro
* Date       : October 30,2019
* Description: Minimum, maximum and average of the numbers in the list
*-----------------------------------------------------------
    ORG    $8000
MAIN    LEA     LIST, A2
        BSR     GETDATA     ;call function get_data
    
        MOVE.L  LENGTH, -(A7)
        PEA     LIST
        PEA     STRUCT
        BSR     STATS       ;call function Statistics
        LEA     12(A7),A7
       
        MOVE.L  STRUCT, -(A7)
        MOVE.L  STRUCT+4,-(A7)
        MOVE.W  STRUCT+8,-(A7)
        MOVE.W  STRUCT+10,-(A7)
        BSR     DISPLAY     ;function display
        LEA     12(A7),A7

        SIMHALT            
GETDATA MOVEM.L D0/D1/D2/A1/A2, -(A7) ;working registers
        LEA     MSG1, A1
LOOP    MOVE.B  #14, D0                 
        TRAP     #15            
        MOVE.B  #4,D0              
        TRAP    #15                
        MOVE.L  D1,LENGTH              
        MOVE.L  D1,D2
        CMP.L   #1, D2             
        BLO     LOOP
        CMP.L   #10, D2
        BHI     LOOP    
LOOP2   BEQ     EXIT
        LEA     MSG2,A1
        MOVE.B  #14,D0
        TRAP    #15
        MOVE.B  #4,D0              
        TRAP    #15                
        MOVE.L  D1,(A2)+
        SUB.L   #1, D2
        BRA     LOOP2
EXIT    MOVEM.L (A7)+, D0/D1/D2/A1/A2
        RTS         ;return
        
STATS   MOVEM.L D0/D1/D2/A1/A2, -(A7)
MAX     CLR.L   D0              ;find maximum
        CLR.L   D1
        CLR.L   D2
        MOVE.L  32(A7),D0
        MOVEA.L 28(A7),A1
        MOVEA.L 24(A7),A2
LOOP3   BEQ     EXIT2
        MOVE.L  (A1)+, D1
        CMP.L   D2,D1
        BLO     ELSE2
        MOVE.L  D1,D2
ELSE2   SUB.L   #1, D0
        BRA     LOOP3
EXIT2   MOVE.L  D2,(A2)

MIN     CLR.L   D0              ;find minimum
        CLR.L   D1
        MOVE.L  32(A7),D0
        MOVEA.L 28(A7),A1
        MOVEA.L 24(A7),A2
LOOP4   BEQ     EXIT3
        MOVE.L  (A1)+, D1
        CMP.L   D2,D1
        BHI     ELSE3
        MOVE.L  D1,D2
ELSE3   SUB.L   #1, D0
        BRA LOOP4
EXIT3   MOVE.L  D2,4(A2)

AVERAGE CLR.L   D0              ;find average
        CLR.L   D1
        CLR.L   D2
        MOVE.L  32(A7),D0
        MOVE.L  32(A7),D2
        MOVEA.L 28(A7),A1
        MOVEA.L 24(A7),A2
LOOP5   BEQ     EXIT4
        ADD.L   (A1)+, D1
        SUB.L   #1, D0
        BRA     LOOP5
EXIT4   DIVS    D2,D1
        SWAP    D1
        MOVE.L  D1, 8(A2)
        MOVEM.L (A7)+, D0/D1/D2/A1/A2
        RTS

  
DISPLAY MOVEM.L D1, -(A7) 
        MOVE.L  12(A7),D1 
        LEA     MSG3, A1 ; display minimum
        MOVE.B  #14, D0
        TRAP    #15
        MOVE.B  #3,D0
        TRAP    #15 
        MOVE.L  #10,D1
        MOVE.B  #6,D0
        TRAP    #15
        MOVE.L  #13,D1
        MOVE.B  #6,D0
        TRAP    #15
        MOVE.L  16(A7),D1 
        LEA     MSG4, A1 ; display maximum
        MOVE.B  #14, D0
        TRAP    #15
        MOVE.B  #3,D0
        TRAP    #15 
        MOVE.L  #10,D1
        MOVE.B  #6,D0
        TRAP    #15
        MOVE.L  #13,D1
        MOVE.B  #6,D0
        TRAP    #15
        MOVE.W  10(A7),D1
        LEA     MSG5, A1 ; display average
        MOVE.B  #14, D0
        TRAP    #15
        MOVE.B  #3,D0
        TRAP    #15
        MOVE.L  #32,D1
        MOVE.B  #6,D0
        TRAP    #15
        MOVE.W  8(A7),D1 ; display remainder
        MOVE.B  #3,D0
        TRAP    #15
        MOVE.L  #47,D1
        MOVE.B  #6,D0
        TRAP    #15
        MOVE.L  LENGTH,D1
        MOVE.B  #3,D0
        TRAP    #15
EXIT5   MOVEM.L (A7)+, D1
        RTS  

        

    ORG     $9000
MSG1    DC.B    'Enter number of values in list(1-10): ',0
MSG2    DC.B    'Enter number: ',0
LENGTH  DC.L    0
LIST    DC.L    0,0,0,0,0,0,0,0,0,0
    ORG     $7000
STRUCT  DC.L    0,0,0
MSG3    DC.B    'Minimum = ',0
MSG4    DC.B    'Maximum = ',0
MSG5    DC.B    'Average = ',0
MSG6    DC.B    0


    END    MAIN        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
