make clean
make IMPLEMENTATION_PATH=crypto_kem/kyber768/m4 bin/crypto_kem_kyber768_m4_speed.bin
cd bin
openocd -f interface/stlink-v2-1.cfg -f target/stm32f4x.cfg -c "program crypto_kem_kyber768_m4_speed.bin 0x08000000 verify reset exit"
