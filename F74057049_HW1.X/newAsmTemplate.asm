LIST p=18f4520		
#include<p18f4520.inc>		
; CONFIG1H
  CONFIG  OSC = INTIO67              ; Oscillator Selection bits (Internal oscillator block, port function on RA6 and RA7)
; CONFIG2H
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))

	org 	0x00		
Initial:	
 	;input
	INPUT	equ 0x01
	OUTPUT	equ 0x02
	THETA_T equ LATA
	PREV_DIS	equ LATB
	GREATER_DIS	equ LATC
	
	;*************************************
	; FOR TA:
	; change your input here ~
	movlw	0xc
	;*************************************
	movwf	INPUT
	movlw	-2
	movwf	THETA_T
	
;***************************************
start:	
	movwf	PREV_DIS; will exec more than once, don't care about first exec
	
	;THETA_T += 2
	movlw	2
	addwf	THETA_T
	
	;w = THETA_T
	movf	THETA_T, 0, 0

	;call table
	call	Table	
	
	;if w <= INPUT goto start
	cpfslt	INPUT, 0 ;skip if INPUT < w
	goto start

	;mov greater distance to GREATER_DIS
	movwf	GREATER_DIS
	
	;convert THETA_T to 2*theta (THETA_T means 2*raw to jump in table before this)
	bcf	THETA_T, 0
	rrncf	THETA_T
	
	;store greater THETA_T to output first
	movff	THETA_T, OUTPUT
	
	; GREATER_DIS = GREATER_DIS - INPUT
	movf	INPUT, 0, 0
	subwf	GREATER_DIS, 1, 0
	
	; PREV_DIS = INPUT - PREV_DIS
	movf	PREV_DIS, 0, 0
	subwf	INPUT, 0, 0
	movwf	PREV_DIS
	
	; if PREV_DIS > GREATER_DIS  finish, else adjust (0x02 = 0x02 - 1)
	movf	GREATER_DIS, 0, 0
	cpfsgt	PREV_DIS, 0
	decf	OUTPUT
	goto	finish
				
Table:
	addwf	PCL
	retlw	0x0   	; 0
	retlw	0x4   	; 4
	retlw	0x9   	; 9
	retlw	0xd   	; 13
	retlw	0x12  	; 18
	retlw	0x16  	; 22
	retlw	0x1b  	; 27
	retlw	0x1f  	; 31
	retlw	0x24  	; 36
	retlw	0x28  	; 40
	retlw	0x2c  	; 44
	retlw	0x31  	; 49
	retlw	0x35  	; 53
	retlw	0x3a  	; 58
	retlw	0x3e  	; 62
	retlw	0x42  	; 66
	retlw	0x47  	; 71
	retlw	0x4b  	; 75
	retlw	0x4f  	; 79
	retlw	0x53  	; 83
	retlw	0x58  	; 88
	retlw	0x5c  	; 92
	retlw	0x60  	; 96
	retlw	0x64  	; 100
	retlw	0x68  	; 104
	retlw	0x6c  	; 108
	retlw	0x70  	; 112
	retlw	0x74  	; 116
	retlw	0x78  	; 120
	retlw	0x7c  	; 124
	retlw	0x80  	; 128
	retlw	0x84  	; 132
	retlw	0x88  	; 136
	retlw	0x8b  	; 139
	retlw	0x8f  	; 143
	retlw	0x93  	; 147
	retlw	0x96  	; 150
	retlw	0x9a  	; 154
	retlw	0x9e  	; 158
	retlw	0xa1  	; 161
	retlw	0xa5  	; 165
	retlw	0xa8  	; 168
	retlw	0xab  	; 171
	retlw	0xaf  	; 175
	retlw	0xb2  	; 178
	retlw	0xb5  	; 181
	retlw	0xb8  	; 184
	retlw	0xbb  	; 187
	retlw	0xbe  	; 190
	retlw	0xc1  	; 193
	retlw	0xc4  	; 196
	retlw	0xc7  	; 199
	retlw	0xca  	; 202
	retlw	0xcc  	; 204
	retlw	0xcf  	; 207
	retlw	0xd2  	; 210
	retlw	0xd4  	; 212
	retlw	0xd7  	; 215
	retlw	0xd9  	; 217
	retlw	0xdb  	; 219
	retlw	0xde  	; 222
	retlw	0xe0  	; 224
	retlw	0xe2  	; 226
	retlw	0xe4  	; 228
	retlw	0xe6  	; 230
	retlw	0xe8  	; 232
	retlw	0xea  	; 234
	retlw	0xec  	; 236
	retlw	0xed  	; 237
	retlw	0xef  	; 239
	retlw	0xf1  	; 241
	retlw	0xf2  	; 242
	retlw	0xf3  	; 243
	retlw	0xf5  	; 245
	retlw	0xf6  	; 246
	retlw	0xf7  	; 247
	retlw	0xf8  	; 248
	retlw	0xf9  	; 249
	retlw	0xfa  	; 250
	retlw	0xfb  	; 251
	retlw	0xfc  	; 252
	retlw	0xfd  	; 253
	retlw	0xfe  	; 254
	retlw	0xfe  	; 254
	retlw	0xff  	; 255
	retlw	0xff  	; 255
	retlw	0xff  	; 255
	retlw	0xff  	; 255
	retlw	0xff  	; 255
	retlw	0xff  	; 255
	retlw	0xff  	; 255
special_case: ; when input = 0xff
	movlw	0x55
	movwf	OUTPUT
	
finish:
	nop
	end