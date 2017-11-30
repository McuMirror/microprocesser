LIST p=18f4520		
#include<p18f4520.inc>		
; CONFIG1H
  CONFIG  OSC = INTIO67              ; Oscillator Selection bits (Internal oscillator block, port function on RA6 and RA7)
; CONFIG2H
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))

	org 	0x00	
	
Initial:	
    	clrf	LATC
	clrf	LATD	
	clrf     LATA
	clrf	LATB
; ***********************************
start:
    ;1011 0101 NAND 0111 1100
    movlw 0xb5
    andlw 0x7c
    xorlw b'11111111'
    movwf LATD
    ;1001 0110 NOR 0110 1001
    movlw b'10010110'
    iorlw b'01101001'
    xorlw b'11111111'
    movwf LATC
    movlw 0x01
sumloop:    ;Lab2
    movlw 0x00
    addlw 0x01
    addwf LATA,1,0
    bnov 0x1C
    goto rotate
    nop
    nop
    nop
    goto Initial
 rotate:
   movlw 0x8f
   movwf LATB
   rrcf LATB,0,0
   movf LATB,0 
end




