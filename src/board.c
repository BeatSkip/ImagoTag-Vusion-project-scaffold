#include "board.h"
#include "util.h"

void board_init(void)
{
    // Set LED pins as output
    PIN_SET_OUTPUT(LEDW_DIR, LEDW_PIN);
    PIN_SET_OUTPUT(LEDR_DIR, LEDR_PIN);
    PIN_SET_OUTPUT(LEDG_DIR, LEDG_PIN);
    PIN_SET_OUTPUT(LEDB_DIR, LEDB_PIN);  

    PIN_SET_LOW(LEDW_PORT, LEDW_PIN);
    PIN_SET_LOW(LEDR_PORT, LEDR_PIN);
    PIN_SET_LOW(LEDG_PORT, LEDG_PIN);
    PIN_SET_LOW(LEDB_PORT, LEDB_PIN);  
}