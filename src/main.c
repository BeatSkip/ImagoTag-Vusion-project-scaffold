/*************************************
 * 
 *        89c52 sdcc blink demo
 * 
 * CPU: 89C52
 * FREQ: 12MHz
 * PIN: P00
 * 
 * ***********************************
*/
#include <ax8052.h>
#include <libmf.h>
#include <libmftypes.h>
#include <libmfuart.h>


void dbglink_irq(void) __interrupt(21) __naked
{
    // Add your code here
}

void delay_100ms(); //@12MHz

void main()
{
    while (1)
    {
        
    }
}

