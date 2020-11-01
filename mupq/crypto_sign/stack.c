#include "api.h"
#include "randombytes.h"
#include "hal.h"
#include "sendfn.h"

#include <stdio.h>
#include <string.h>

static void printcycles(const char *s, unsigned long long c)
{
  char outs[32];
  hal_send_str(s);
  // snprintf(outs,sizeof(outs),"%llu\n",c);
  snprintf(outs,sizeof(outs),"%llu",c);
  hal_send_str(outs);
}

#define MLEN 32
#define MAX_SIZE 0x1B000
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

#define send_stack_usage(S, U) send_unsigned((S), (U))

unsigned int canary_size = MAX_SIZE;
volatile unsigned char *p;
unsigned int c;
uint8_t canary = 0x42;

unsigned char pk[MUPQ_CRYPTO_PUBLICKEYBYTES];
unsigned char sk[MUPQ_CRYPTO_SECRETKEYBYTES];
unsigned char sm[MLEN + MUPQ_CRYPTO_BYTES];
unsigned char m[MLEN];
unsigned char m_out[MLEN + MUPQ_CRYPTO_BYTES];

size_t mlen;
size_t smlen;
unsigned int rc;
unsigned int stack_key_gen, stack_sign, stack_verify;

#define FILL_STACK()                                                           \
  p = &a;                                                                      \
  while (p > &a - canary_size)                                                    \
    *(p--) = canary;
#define CHECK_STACK()                                                         \
  c = canary_size;                                                                \
  p = &a - canary_size + 1;                                                       \
  while (*p == canary && p < &a) {                                             \
    p++;                                                                       \
    c--;                                                                       \
  }                                                                            \

static int test_sign(void) {
  volatile unsigned char a;
  // Alice generates a public key
  FILL_STACK()
  MUPQ_crypto_sign_keypair(pk, sk);
  CHECK_STACK()
  if(c >= canary_size) return -1;
  stack_key_gen = c;

  // Bob derives a secret key and creates a response
  randombytes(m, MLEN);
  FILL_STACK()
  MUPQ_crypto_sign(sm, &smlen, m, MLEN, sk);
  CHECK_STACK()
  if(c >= canary_size) return -1;
  stack_sign = c;

  // Alice uses Bobs response to get her secret key
  FILL_STACK()
  rc = MUPQ_crypto_sign_open(m_out, &mlen, sm, smlen, pk);
  CHECK_STACK()
  if(c >= canary_size) return -1;
  stack_verify = c;

  if (rc) {
    return -1;
  } else {
    // send_stack_usage("keypair stack usage:", stack_key_gen);
    // send_stack_usage("sign stack usage:", stack_sign);
    // send_stack_usage("verify stack usage:", stack_verify);
    // hal_send_str("Signature valid!\n");
    hal_send_str("C");
    hal_send_str("S");
    printcycles("", stack_key_gen);
    hal_send_str("E");
    hal_send_str("S");
    printcycles("", stack_sign);
    hal_send_str("E");
    hal_send_str("S");
    printcycles("", stack_verify);
    hal_send_str("E");
    return 0;
  }
}

int main(void) {
  hal_setup(CLOCK_FAST);

  unsigned char recv_byte;

  recv_USART_bytes(&recv_byte,1);
  if(recv_byte == 'S')
  {
   // marker for automated benchmarks
    // hal_send_str("==========================");
    canary_size = 0x1000;
    while(test_sign()){
      canary_size += 0x1000;
      if(canary_size >= MAX_SIZE)
      {
        // hal_send_str("failed to measure stack usage.\n");
        break;
      }
    }
}

  // marker for automated benchmarks
  // hal_send_str("#");

  while(1);
  return 0;
}