#define TMR2PRESCALE 16

#include <xc.h>
// BEGIN CONFIG
#pragma config OSC = INTIO67   // Oscillator Selection bits (HS oscillator)
#pragma config WDT = OFF  // Watchdog Timer Enable bit (WDT enabled)
#pragma config PWRT = OFF // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = ON  // Brown-out Reset Enable bit (BOR enabled)
#pragma config LVP = OFF   // Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
#pragma config CPD = OFF   // Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)

//END CONFIG

PWM1_Init(long setDuty)
{
  PR2 = setDuty;
}

/*
 * 15.625 -> 0.5ms
 * 46.875 -> 1.5ms
 * 75.000 -> 2.4ms
 */
PWM1_Duty(unsigned int duty)
{
    //set duty to CCPR1L , CCP1X(CCP1CON:5) and CCP1Y(CCP1CON:4)
    CCP1CONbits.CCP1X = (duty >> 1) & 1;
    CCP1CONbits.CCP1Y = duty & 1;
    CCPR1L = duty >> 2;
}

PWM1_Start()
{

  //set CCP1CON
  CCP1CON = 0b00001100;// bit5-4 are the last two bits for 10-bit PWM duty cycle
    
  //set timer2 on
  T2CONbits.TMR2ON = 1;
  
  //set rc2 output
  TRISCbits.RC2 = 0;
  
  if (TMR2PRESCALE == 1)
  {
	;
  }
  else if(TMR2PRESCALE == 4)
  {  
      ;
  }
  else if (TMR2PRESCALE == 16)
  {
      T2CON = 0b00000111; //bit 2 = timer on ,bit 1-0 = set prescaler=16
  }
 
}

void main()
{
    
  PWM1_Init(155);
  PWM1_Start();
  
  unsigned int i=16;// TODO
  
  // set button input
  TRISDbits.RD0 = 1;
  
  //set Fosc to 500kHz
  OSCCON ^= 0b01110000;
  
  do    
  {
    if(RD0 == 1 && i<= 75)
      i=i+1;
    PWM1_Duty(i);
    int delay_i = 10;
    while(delay_i--){
        int delay_j = 100;
        while(delay_j--);
    }

   // __delay_ms(50);
  }while(1);
}