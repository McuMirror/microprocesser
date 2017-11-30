LIST p=18f4520		
#include<p18f4520.inc>		
; CONFIG1H
  CONFIG  OSC = INTIO67              ; Oscillator Selection bits (Internal oscillator block, port function on RA6 and RA7)
; CONFIG2H
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))




	org 	0x00		
Initial:	
 		
		
	clrf	LATD		

;***************************************
start:
			; Write your assembly code HERE 
INCF LATD ,1,0		; increase LATD
MOVLW 0x22		; move literal to WREG     	
ADDWF WREG,0,0	; add the value of f to WREG
ADDLW 0x2E  		; add the value to WREG
CLRF  	WREG		; clear WREG
    
	end