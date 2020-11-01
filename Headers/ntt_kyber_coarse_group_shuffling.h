#ifndef NTT_H
#define NTT_H

#include <stdint.h>
#include "params.h"
#include "benchmark.h"

#define RANDOM_BUFFER_SIZE_NEW 256
#define RANDOM_BUFFER_SIZE 4

#define NO_PROTECTION 0
#define COARSE_SHUFFLING 1
#define GROUP_COARSE_SHUFFLING 2
#define GROUP_SHUFFLING 4
#define FINE_SHUFFLING 8
#define COARSE_MULTIPLICATIVE_MASKING 16
#define FINE_MULTIPLICATIVE_MASKING 32
#define GENERIC_MULTIPLICATIVE_MASKING 64
#define NO_MASKS_IN_STAGE 1

#define NTT_PROTECTION_MODE GROUP_SHUFFLING

extern const int16_t zetas_poly[64];
extern const int16_t zetas[128];
extern const int16_t zetas_inv[128];

void ntt(int16_t poly[256]);
void ntt_no_protect(int16_t poly[256]);
void invntt_no_protect(int16_t poly[256]);
void invntt(int16_t poly[256]);
void basemul(int16_t r[2],
             const int16_t a[2],
             const int16_t b[2],
             int16_t zeta);

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
