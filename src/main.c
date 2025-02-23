
#include <ax8052.h>
#include <ax8052f143.h>
#include <libmftypes.h>
#include <libmf.h>
#include <libmfuart0.h>
#include "util.h"
#include "board.h"


static void pwrmgmt_irq(void) //__interrupt(INT_POWERMGMT)
{
    uint8_t pc = PCON;

    if (!(pc & 0x80))
        return;

    GPIOENABLE = 0;
    IE = EIE = E2IE = 0;

    for (;;)
        PCON |= 0x01;
}

void main()
{
    board_init();
    uart_timer0_baud(CLKSRC_XOSC, 115200, 26000000);
    uart0_init(0, 8, 1);
    
    while (1)
    {
        PIN_SET_LOW(LEDG_PORT, LEDG_PIN);
        delay(25000);
        PIN_SET_HIGH(LEDG_PORT, LEDG_PIN);
        delay(25000);
    }
}