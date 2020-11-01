#include "api.h"
#include "hal.h"
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "ntt.h"
#include "randombytes.h"

#define MLEN 59
#define POLY_MASK_1 0X9ABDCD93
#define POLY_MASK_2 0X91CB0C2C

#define NTESTS 100

// #define ALL_ONLINE 1

unsigned long long randomize_ntt_time = 0;
unsigned long long t0_ntt, t1_ntt;
unsigned long long randomize_intt_time = 0;
unsigned long long t0_intt, t1_intt;
unsigned long long randomize_ntt_total_time = 0;
unsigned long long t0_total_ntt, t1_total_ntt;
unsigned long long randomize_intt_total_time = 0;
unsigned long long t0_total_intt, t1_total_intt;
unsigned long long simply_temp = 0;

static int shift_lfsr(unsigned int *lfsr, unsigned int polynomial_mask)
{
    int feedback;

    feedback = *lfsr & 1;
    *lfsr >>= 1;
    if(feedback == 1)
        *lfsr ^= polynomial_mask;
    return *lfsr;
}

static int get_random(void)
{
    static unsigned int lfsr_1 = 0xAABBCCDD;
    static unsigned int lfsr_2 = 0x778800DD;
    shift_lfsr(&lfsr_1, POLY_MASK_1);
    shift_lfsr(&lfsr_2, POLY_MASK_2);
    return ((shift_lfsr(&lfsr_1, POLY_MASK_1) ^ shift_lfsr(&lfsr_2, POLY_MASK_2)) & 0XFF);
}

static unsigned long long average(unsigned long long *t, size_t tlen)
{
  unsigned long long acc=0;
  size_t i;
  for(i=0;i<tlen;i++)
    acc += t[i];
  return acc/(tlen);
}

static void calc_print_results(const char *s, unsigned long long *t, size_t tlen)
{
  unsigned long long tmp;
  char outs[32];
  hal_send_str(s);
  hal_send_str("\n");
  tmp = average(t, tlen);
  snprintf(outs,sizeof(outs),"%llu\n",tmp);
  hal_send_str(outs);
  hal_send_str("\n");
}

// https://stackoverflow.com/a/1489985/1711232
#define PASTER(x, y) x####y
#define EVALUATOR(x, y) PASTER(x, y)
#define NAMESPACE(fun) EVALUATOR(MUPQ_NAMESPACE, fun)

// use different names so we can have empty namespaces
#define MUPQ_CRYPTO_PUBLICKEYBYTES NAMESPACE(CRYPTO_PUBLICKEYBYTES)
#define MUPQ_CRYPTO_SECRETKEYBYTES NAMESPACE(CRYPTO_SECRETKEYBYTES)
#define MUPQ_CRYPTO_BYTES          NAMESPACE(CRYPTO_BYTES)
#define MUPQ_CRYPTO_ALGNAME        NAMESPACE(CRYPTO_ALGNAME)

#define MUPQ_crypto_sign_keypair NAMESPACE(crypto_sign_keypair)
#define MUPQ_crypto_sign NAMESPACE(crypto_sign)
#define MUPQ_crypto_sign_open NAMESPACE(crypto_sign_open)
#define MUPQ_crypto_sign_signature NAMESPACE(crypto_sign_signature)
#define MUPQ_crypto_sign_verify NAMESPACE(crypto_sign_verify)

static void printcycles(const char *s, unsigned long long c)
{
  char outs[32];
  hal_send_str(s);
  // snprintf(outs,sizeof(outs),"%llu\n",c);
  snprintf(outs,sizeof(outs),"%llu",c);
  hal_send_str(outs);
}

int main(void)
{
    // unsigned char sk[CRYPTO_SECRETKEYBYTES];
    // unsigned char pk[CRYPTO_PUBLICKEYBYTES];
    // unsigned char sm[MLEN+CRYPTO_BYTES];
    // unsigned char m[MLEN];
    // unsigned char m2[MLEN + CRYPTO_BYTES];
    // unsigned long long smlen, mlen;
    // unsigned int t0, t1;
    // unsigned long long t_keygen[NTESTS], t_sign[NTESTS], t_verify[NTESTS];
    int i, j, ret;
    long long average_time = 0;

    long long t_keygen_time, t_sign_time, t_verify_time;
    long long average_keygen_time = 0;
    long long average_sign_time = 0;
    long long average_verify_time = 0;


  unsigned char recv_byte;
  unsigned char sk[MUPQ_CRYPTO_SECRETKEYBYTES];
  unsigned char pk[MUPQ_CRYPTO_PUBLICKEYBYTES];
  unsigned char sm[MLEN+MUPQ_CRYPTO_BYTES];
  size_t smlen;
  unsigned long long t0, t1;
  hal_setup(CLOCK_BENCHMARK);

  while(1)
  {
      recv_USART_bytes(&recv_byte,1);
      if(recv_byte == 'S')
      {
          for(i = 0; i < NTESTS; ++i)
          {
              hal_send_str("DONE");
              t0 = hal_get_time();
              MUPQ_crypto_sign_keypair(pk, sk);
              t1 = hal_get_time();

              t_keygen_time = t1-t0;

              if(i == 0)
                average_keygen_time = t_keygen_time;
              else
                average_keygen_time = average_keygen_time + (t_keygen_time - average_keygen_time)/i;

              // // Signing
              // for(j=0;j<MLEN;j++)
              //   sm[j] = get_random();
              randombytes(sm,MLEN);

              t0 = hal_get_time();
              t_sign_time = MUPQ_crypto_sign(sm, &smlen, sm, MLEN, sk);
              t1 = hal_get_time();
              t_sign_time = t1-t0;

              if(i == 0)
                average_sign_time = t_sign_time;
              else
                average_sign_time = average_sign_time + (t_sign_time-average_sign_time)/i;

              t0 = hal_get_time();
              ret = MUPQ_crypto_sign_open(sm, &smlen, sm, smlen, pk);
              t1 = hal_get_time();

              t_verify_time = t1-t0;

              if(i == 0)
                average_verify_time = t_verify_time;
              else
                average_verify_time = average_verify_time + (t_verify_time-average_verify_time)/i;

              // t1 = systick_get_value();
              // t_verify[i] = (t0+overflowcnt*2400000llu)-t1;
              // printcycles("verify cycles: ", (t0+overflowcnt*2400000llu)-t1);

              if(ret)
              {
                hal_send_str("Verification failed\n");
                hal_send_str("#");
                return -1;
              }
          }

          #if (BENCH_NTT_RAND_OR_TOTAL == 0 || BENCH_NTT_RAND_OR_TOTAL == 1)
            hal_send_str("C");
            hal_send_str("S");
            printcycles("", randomize_ntt_time);
            hal_send_str("E");
            hal_send_str("S");
            printcycles("", randomize_intt_time);
            hal_send_str("E");
            hal_send_str("S");
            printcycles("", simply_temp);
            hal_send_str("E");

         #elif (BENCH_NTT_RAND_OR_TOTAL == 2)
           hal_send_str("C");
           hal_send_str("S");
           printcycles("", randomize_ntt_total_time);
           hal_send_str("E");
           hal_send_str("S");
           printcycles("", randomize_intt_total_time);
           hal_send_str("E");
           hal_send_str("S");
           printcycles("", simply_temp);
           hal_send_str("E");
         #else
           hal_send_str("C");
           hal_send_str("S");
           printcycles("", average_keygen_time);
           hal_send_str("E");
           hal_send_str("S");
           printcycles("", average_sign_time);
           hal_send_str("E");
           hal_send_str("S");
           printcycles("", average_verify_time);
           hal_send_str("E");
         #endif

      }
  }
  return 0;
}
