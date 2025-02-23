//
// Created by Oscar on 02/04/25.
//

#ifndef ISR_H
#define ISR_H

#include <ax8052f143.h>

void time_isr(void) __interrupt(WDT_VECTOR);

#endif // ISR_H

#endif //ISR_H
