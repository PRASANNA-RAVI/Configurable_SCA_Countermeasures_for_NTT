#include "api.h"
#include "hal.h"
#include "sendfn.h"
#include "ntt.h"

#include <stdint.h>
#include <string.h>
#include <libopencm3/stm32/gpio.h>
#include <libopencm3/stm32/flash.h>

// https://stackoverflow.com/a/1489985/1711232
#define PASTER(x, y) x####y
#define EVALUATOR(x, y) PASTER(x, y)
#define NAMESPACE(fun) EVALUATOR(MUPQ_NAMESPACE, fun)

#define NTESTS 5

unsigned long long randomize_ntt_time = 0;
unsigned long long t0_ntt, t1_ntt;
unsigned long long randomize_intt_time = 0;
unsigned long long t0_intt, t1_intt;
unsigned long long randomize_ntt_total_time = 0;
unsigned long long t0_total_ntt, t1_total_ntt;
unsigned long long randomize_intt_total_time = 0;
unsigned long long t0_total_intt, t1_total_intt;

// use different names so we can have empty namespaces
#define MUPQ_CRYPTO_BYTES           NAMESPACE(CRYPTO_BYTES)
#define MUPQ_CRYPTO_PUBLICKEYBYTES  NAMESPACE(CRYPTO_PUBLICKEYBYTES)
#define MUPQ_CRYPTO_SECRETKEYBYTES  NAMESPACE(CRYPTO_SECRETKEYBYTES)
#define MUPQ_CRYPTO_CIPHERTEXTBYTES NAMESPACE(CRYPTO_CIPHERTEXTBYTES)
#define MUPQ_CRYPTO_ALGNAME NAMESPACE(CRYPTO_ALGNAME)

#define MUPQ_crypto_kem_keypair NAMESPACE(crypto_kem_keypair)
#define MUPQ_crypto_kem_enc NAMESPACE(crypto_kem_enc)
#define MUPQ_crypto_kem_dec NAMESPACE(crypto_kem_dec)

#define printcycles(S, U) send_unsignedll((S), (U))

// static void printcycles(const char *s, unsigned long long c)
// {
//   char outs[32];
//   hal_send_str(s);
//   // snprintf(outs,sizeof(outs),"%llu\n",c);
//   snprintf(outs,sizeof(outs),"%llu",c);
//   hal_send_str(outs);
// }

int main(void)
{
  unsigned char key_a[MUPQ_CRYPTO_BYTES], key_b[MUPQ_CRYPTO_BYTES];
  unsigned char sk[MUPQ_CRYPTO_SECRETKEYBYTES];
  unsigned char pk[MUPQ_CRYPTO_PUBLICKEYBYTES];
  unsigned char ct[MUPQ_CRYPTO_CIPHERTEXTBYTES];
  unsigned long long t0, t1;
  long long t_keygen_time, t_enc_time, t_dec_time;
  long long average_keygen_time = 0;
  long long average_enc_time = 0;
  long long average_dec_time = 0;
  int i;

  unsigned char recv_byte;

  hal_setup(CLOCK_BENCHMARK);

  // hal_send_str("==========================");

  while(1)
  {
    recv_USART_bytes(&recv_byte,1);
    if(recv_byte == 'S')
    {
      // hal_send_str("Here");
      for(i = 0; i < NTESTS; ++i)
      {
        // Key-pair generation
        t0 = hal_get_time();
        MUPQ_crypto_kem_keypair(pk, sk);
        t1 = hal_get_time();
        // printcycles("keypair cycles:", t1-t0);

        t_keygen_time = t1-t0;

        if(i == 0)
          average_keygen_time = t_keygen_time;
        else
          average_keygen_time = average_keygen_time + (t_keygen_time - average_keygen_time)/i;

        // Encapsulation
        t0 = hal_get_time();
        MUPQ_crypto_kem_enc(ct, key_a, pk);
        t1 = hal_get_time();
        // printcycles("encaps cycles:", t1-t0);

        t_enc_time = t1-t0;

        if(i == 0)
          average_enc_time = t_enc_time;
        else
          average_enc_time = average_enc_time + (t_enc_time - average_enc_time)/i;

        // Decapsulation
        t0 = hal_get_time();
        MUPQ_crypto_kem_dec(key_b, ct, sk);
        t1 = hal_get_time();
        // printcycles("decaps cycles:", t1-t0);

        t_dec_time = t1-t0;

        if(i == 0)
          average_dec_time = t_dec_time;
        else
          average_dec_time = average_dec_time + (t_dec_time - average_dec_time)/i;

        if (memcmp(key_a, key_b, MUPQ_CRYPTO_BYTES))
        {
          hal_send_str("ERROR KEYS\n");
          return -1;
        }
        else
        {
          // hal_send_str("OK KEYS\n");
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

      #elif (BENCH_NTT_RAND_OR_TOTAL == 2)
        hal_send_str("C");
        hal_send_str("S");
        printcycles("", randomize_ntt_total_time);
        hal_send_str("E");
        hal_send_str("S");
        printcycles("", randomize_intt_total_time);
        hal_send_str("E");
      #else
        hal_send_str("C");
        hal_send_str("S");
        printcycles("", average_keygen_time);
        hal_send_str("E");
        hal_send_str("S");
        printcycles("", average_enc_time);
        hal_send_str("E");
        hal_send_str("S");
        printcycles("", average_dec_time);
        hal_send_str("E");
     #endif
    }
  }

  while(1);
  return 0;
}
