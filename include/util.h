#ifndef HAL_H
#define HAL_H

#include <ax8052f143.h>
#include <libmftypes.h>
#include <libmfwtimer.h>
#include <libmfuart.h>
#include <libmfuart1.h>



//Choose LOWFREQ_QUARZ or LOWFREQ_RC as source for RTC clock
#define LOWFREQ_QUARZ
//#define LOWFREQ_RC

#define HIGH (1)
#define LOW (0)

#define BIT(x)  (1<<(x))
#define SET(p,x)    do{(p) |= (x);}while(0)
#define CLEAR(p,x)  do{(p) &= ~(x);}while(0)

#define PIN_SET_INPUT(p,x)  CLEAR(p, (BIT(x)))
#define PIN_SET_OUTPUT(p,x) SET(p, (BIT(x)))
#define PIN_SET_LOW(p,x)    CLEAR(p, (BIT(x)))
#define PIN_SET_HIGH(p,x)   SET(p, (BIT(x)))

#ifdef LOWFREQ_QUARZ
#define SECONDS(x) ((uint32_t)(x) * 8192)
#elif defined LOWFREQ_RC
#define SECONDS(x) ((uint32_t)(x) * 640)
#endif // LOWFREQ_QUARZ
#define MILLISECONDS(x) (SECONDS(x) / 1000)

#define ABSOLUTE    0
#define RELATIVE    1

#define NAIVE_MEMCPY(x,y,n) for(int i=0;i<(n);i++){x[i]=y[i];}

#define BV(x) (1 << (x))
#define st(x) \
  do {        \
    x         \
  } while (__LINE__ == -1)

#define HAL_ENABLE_INTERRUPTS() st(EA = 1;)
#define HAL_DISABLE_INTERRUPTS() st(EA = 0;)
#define HAL_INTERRUPTS_ARE_ENABLED() (EA)

typedef unsigned char halIntState_t;
#define HAL_ENTER_CRITICAL_SECTION(x) st(x = EA; HAL_DISABLE_INTERRUPTS();)
#define HAL_EXIT_CRITICAL_SECTION(x) st(EA = x;)
#define HAL_CRITICAL_STATEMENT(x) st(halIntState_t _s; HAL_ENTER_CRITICAL_SECTION(_s); x; HAL_EXIT_CRITICAL_SECTION(_s);)

#define CLOCKSOURCE_XOSC_STABLE() (SLEEP & 0x40)


#endif // HAL_H