#ifndef NTT_H
#define NTT_H

#include "params.h"
#include <stdint.h>

void ntt_asm(uint32_t p[N]);
void inv_ntt_asm(uint32_t p[N]);

void ntt(uint32_t p[N]);
void invntt_tomont(uint32_t p[N]);

void ntt_no_protect(uint32_t p[N]);
void invntt_tomont_no_protect(uint32_t p[N]);

// Shuffling Time with Random Time...

#if(BENCH_NTT_RAND_OR_TOTAL == 0)

#define CALC_NTT_RAND_TIME 1
#define CALC_TOTAL_NTT_TIME 0
#define CALC_NTT_RAND_TIME_RAND 0

// Random Time Only...

#elif(BENCH_NTT_RAND_OR_TOTAL == 1)

#define CALC_NTT_RAND_TIME 0
#define CALC_TOTAL_NTT_TIME 0
#define CALC_NTT_RAND_TIME_RAND 1

// Total NTT Time...

#elif(BENCH_NTT_RAND_OR_TOTAL == 2)
#define CALC_NTT_RAND_TIME 0
#define CALC_TOTAL_NTT_TIME 1
#define CALC_NTT_RAND_TIME_RAND 0

#else

// Total Time for All...

#define CALC_NTT_RAND_TIME 0
#define CALC_TOTAL_NTT_TIME 0
#define CALC_NTT_RAND_TIME_RAND 0

#endif

#endif
