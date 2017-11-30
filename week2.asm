LIST p=18f4520		
#include<p18f4520.inc>		
; CONFIG1H
  CONFIG  OSC = INTIO67              ; Oscillator Selection bits (Internal oscillator block, port function on RA6 and RA7)
; CONFIG2H
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))

	org 	0x00		
Initial:		
	clrf	LATD	

start:

    MOVLW 0x77
    MOVFF WREG, LATD
    MOVLW 0x22
    ADDWF LATD, 1,0
    
    
    MOVLW 0xff
    MOVWF 0x28c 

 LOOP:   
    LFSR 0,0x28c  ;4b
    DECFSZ INDF0,1 ;2b
    GOTO LOOP ;4b
CONTINUE:
    MOVLW -0X12 ;4b
    ADDWF PCL
    
    end    
    


