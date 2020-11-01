# mkdir bin_compiled_files

if [ $1 == "help" ]
then
echo "Format (e.g) : sh script_kyber.sh kyber512 bench_total_randomize_time run"
echo "Argument 1 Options: kyber512, kyber768, kyber1024"
echo ""
echo "Argument 2 Options:"
echo "1. To benchmark total shuffling time: bench_total_randomize_time"
echo "2. To benchmark only random generation: bench_only_random_generation_time"
echo "3. To benchmark total NTT/INTT time: bench_total_ntt_time"
echo "4. To benchmark total procedure time: bench_total_procedure_time"
echo ""
echo "Argument 3 Options:"
echo "To flash and run rmplementations: run"
echo "To not flash and run rmplementations: compile"
echo ""
fi

if [ $# == 3 ]
then

d="bin_compiled_files"
[ -d "${d}" ] && echo "" || mkdir bin_compiled_files

if [ $2 == "bench_total_randomize_time" ]
then
cp Headers/benchmark_total_randomize_time.h Headers/benchmark.h
elif [ $2 == "bench_only_random_generation_time" ]
then
cp Headers/benchmark_only_random_generation_time.h Headers/benchmark.h
elif [ $2 == "bench_total_ntt_time" ]
then
cp Headers/benchmark_total_ntt_time.h Headers/benchmark.h
elif [ $2 == "bench_total_procedure_time" ]
then
cp Headers/benchmark_total_procedure_time.h Headers/benchmark.h
fi

if [ $1 == "kyber768" ]
then

cp Headers/benchmark.h crypto_kem/kyber768/m4/

make clean
cp Headers/ntt_kyber_no_protection.h crypto_kem/kyber768/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber768/m4 bin/crypto_kem_kyber768_m4_speed.bin
cp bin/crypto_kem_kyber768_m4_speed.bin bin_compiled_files/crypto_kem_kyber768_no_protection.bin
cp bin/crypto_kem_kyber768_m4_speed.elf bin_compiled_files/crypto_kem_kyber768_no_protection.elf

make clean
cp Headers/ntt_kyber_coarse_shuffling.h crypto_kem/kyber768/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber768/m4 bin/crypto_kem_kyber768_m4_speed.bin
cp bin/crypto_kem_kyber768_m4_speed.bin bin_compiled_files/crypto_kem_kyber768_coarse_shuffling.bin
cp bin/crypto_kem_kyber768_m4_speed.elf bin_compiled_files/crypto_kem_kyber768_coarse_shuffling.elf

make clean
cp Headers/ntt_kyber_fine_shuffling.h crypto_kem/kyber768/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber768/m4 bin/crypto_kem_kyber768_m4_speed.bin
cp bin/crypto_kem_kyber768_m4_speed.bin bin_compiled_files/crypto_kem_kyber768_fine_shuffling.bin
cp bin/crypto_kem_kyber768_m4_speed.elf bin_compiled_files/crypto_kem_kyber768_fine_shuffling.elf

make clean
cp Headers/ntt_kyber_fine_masking.h crypto_kem/kyber768/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber768/m4 bin/crypto_kem_kyber768_m4_speed.bin
cp bin/crypto_kem_kyber768_m4_speed.bin bin_compiled_files/crypto_kem_kyber768_fine_masking.bin
cp bin/crypto_kem_kyber768_m4_speed.elf bin_compiled_files/crypto_kem_kyber768_fine_masking.elf

make clean
cp Headers/ntt_kyber_coarse_masking.h crypto_kem/kyber768/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber768/m4 bin/crypto_kem_kyber768_m4_speed.bin
cp bin/crypto_kem_kyber768_m4_speed.bin bin_compiled_files/crypto_kem_kyber768_coarse_masking.bin
cp bin/crypto_kem_kyber768_m4_speed.elf bin_compiled_files/crypto_kem_kyber768_coarse_masking.elf

make clean
cp Headers/ntt_kyber_coarse_group_shuffling.h crypto_kem/kyber768/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber768/m4 bin/crypto_kem_kyber768_m4_speed.bin
cp bin/crypto_kem_kyber768_m4_speed.bin bin_compiled_files/crypto_kem_kyber768_coarse_group_shuffling.bin
cp bin/crypto_kem_kyber768_m4_speed.elf bin_compiled_files/crypto_kem_kyber768_coarse_group_shuffling.elf

make clean
cp Headers/ntt_kyber_coarse_group_within_shuffling.h crypto_kem/kyber768/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber768/m4 bin/crypto_kem_kyber768_m4_speed.bin
cp bin/crypto_kem_kyber768_m4_speed.bin bin_compiled_files/crypto_kem_kyber768_coarse_within_group_shuffling.bin
cp bin/crypto_kem_kyber768_m4_speed.elf bin_compiled_files/crypto_kem_kyber768_coarse_within_group_shuffling.elf

make clean
cp Headers/ntt_kyber_generic_multiplicative_masking_2_masks.h crypto_kem/kyber768/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber768/m4 bin/crypto_kem_kyber768_m4_speed.bin
cp bin/crypto_kem_kyber768_m4_speed.bin bin_compiled_files/crypto_kem_kyber768_generic_multiplicative_masking_2_masks.bin
cp bin/crypto_kem_kyber768_m4_speed.elf bin_compiled_files/crypto_kem_kyber768_generic_multiplicative_masking_2_masks.elf

make clean
cp Headers/ntt_kyber_generic_multiplicative_masking_4_masks.h crypto_kem/kyber768/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber768/m4 bin/crypto_kem_kyber768_m4_speed.bin
cp bin/crypto_kem_kyber768_m4_speed.bin bin_compiled_files/crypto_kem_kyber768_generic_multiplicative_masking_4_masks.bin
cp bin/crypto_kem_kyber768_m4_speed.elf bin_compiled_files/crypto_kem_kyber768_generic_multiplicative_masking_4_masks.elf

elif [ $1 == "kyber512" ]
then

cp Headers/benchmark.h crypto_kem/kyber512/m4/

make clean
cp Headers/ntt_kyber_no_protection.h crypto_kem/kyber512/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber512/m4 bin/crypto_kem_kyber512_m4_speed.bin
cp bin/crypto_kem_kyber512_m4_speed.bin bin_compiled_files/crypto_kem_kyber512_no_protection.bin
cp bin/crypto_kem_kyber512_m4_speed.elf bin_compiled_files/crypto_kem_kyber512_no_protection.elf

make clean
cp Headers/ntt_kyber_coarse_shuffling.h crypto_kem/kyber512/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber512/m4 bin/crypto_kem_kyber512_m4_speed.bin
cp bin/crypto_kem_kyber512_m4_speed.bin bin_compiled_files/crypto_kem_kyber512_coarse_shuffling.bin
cp bin/crypto_kem_kyber512_m4_speed.elf bin_compiled_files/crypto_kem_kyber512_coarse_shuffling.elf

make clean
cp Headers/ntt_kyber_fine_shuffling.h crypto_kem/kyber512/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber512/m4 bin/crypto_kem_kyber512_m4_speed.bin
cp bin/crypto_kem_kyber512_m4_speed.bin bin_compiled_files/crypto_kem_kyber512_fine_shuffling.bin
cp bin/crypto_kem_kyber512_m4_speed.elf bin_compiled_files/crypto_kem_kyber512_fine_shuffling.elf

make clean
cp Headers/ntt_kyber_fine_masking.h crypto_kem/kyber512/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber512/m4 bin/crypto_kem_kyber512_m4_speed.bin
cp bin/crypto_kem_kyber512_m4_speed.bin bin_compiled_files/crypto_kem_kyber512_fine_masking.bin
cp bin/crypto_kem_kyber512_m4_speed.elf bin_compiled_files/crypto_kem_kyber512_fine_masking.elf

make clean
cp Headers/ntt_kyber_coarse_masking.h crypto_kem/kyber512/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber512/m4 bin/crypto_kem_kyber512_m4_speed.bin
cp bin/crypto_kem_kyber512_m4_speed.bin bin_compiled_files/crypto_kem_kyber512_coarse_masking.bin
cp bin/crypto_kem_kyber512_m4_speed.elf bin_compiled_files/crypto_kem_kyber512_coarse_masking.elf

make clean
cp Headers/ntt_kyber_coarse_group_shuffling.h crypto_kem/kyber512/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber512/m4 bin/crypto_kem_kyber512_m4_speed.bin
cp bin/crypto_kem_kyber512_m4_speed.bin bin_compiled_files/crypto_kem_kyber512_coarse_group_shuffling.bin
cp bin/crypto_kem_kyber512_m4_speed.elf bin_compiled_files/crypto_kem_kyber512_coarse_group_shuffling.elf

make clean
cp Headers/ntt_kyber_coarse_group_within_shuffling.h crypto_kem/kyber512/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber512/m4 bin/crypto_kem_kyber512_m4_speed.bin
cp bin/crypto_kem_kyber512_m4_speed.bin bin_compiled_files/crypto_kem_kyber512_coarse_within_group_shuffling.bin
cp bin/crypto_kem_kyber512_m4_speed.elf bin_compiled_files/crypto_kem_kyber512_coarse_within_group_shuffling.elf

make clean
cp Headers/ntt_kyber_generic_multiplicative_masking_2_masks.h crypto_kem/kyber512/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber512/m4 bin/crypto_kem_kyber512_m4_speed.bin
cp bin/crypto_kem_kyber512_m4_speed.bin bin_compiled_files/crypto_kem_kyber512_generic_multiplicative_masking_2_masks.bin
cp bin/crypto_kem_kyber512_m4_speed.elf bin_compiled_files/crypto_kem_kyber512_generic_multiplicative_masking_2_masks.elf

make clean
cp Headers/ntt_kyber_generic_multiplicative_masking_4_masks.h crypto_kem/kyber512/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber512/m4 bin/crypto_kem_kyber512_m4_speed.bin
cp bin/crypto_kem_kyber512_m4_speed.bin bin_compiled_files/crypto_kem_kyber512_generic_multiplicative_masking_4_masks.bin
cp bin/crypto_kem_kyber512_m4_speed.elf bin_compiled_files/crypto_kem_kyber512_generic_multiplicative_masking_4_masks.elf

elif [ $1 == "kyber1024" ]
then

cp Headers/benchmark.h crypto_kem/kyber1024/m4/

make clean
cp Headers/ntt_kyber_no_protection.h crypto_kem/kyber1024/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber1024/m4 bin/crypto_kem_kyber1024_m4_speed.bin
cp bin/crypto_kem_kyber1024_m4_speed.bin bin_compiled_files/crypto_kem_kyber1024_no_protection.bin
cp bin/crypto_kem_kyber1024_m4_speed.elf bin_compiled_files/crypto_kem_kyber1024_no_protection.elf

make clean
cp Headers/ntt_kyber_coarse_shuffling.h crypto_kem/kyber1024/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber1024/m4 bin/crypto_kem_kyber1024_m4_speed.bin
cp bin/crypto_kem_kyber1024_m4_speed.bin bin_compiled_files/crypto_kem_kyber1024_coarse_shuffling.bin
cp bin/crypto_kem_kyber1024_m4_speed.elf bin_compiled_files/crypto_kem_kyber1024_coarse_shuffling.elf

make clean
cp Headers/ntt_kyber_fine_shuffling.h crypto_kem/kyber1024/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber1024/m4 bin/crypto_kem_kyber1024_m4_speed.bin
cp bin/crypto_kem_kyber1024_m4_speed.bin bin_compiled_files/crypto_kem_kyber1024_fine_shuffling.bin
cp bin/crypto_kem_kyber1024_m4_speed.elf bin_compiled_files/crypto_kem_kyber1024_fine_shuffling.elf

make clean
cp Headers/ntt_kyber_fine_masking.h crypto_kem/kyber1024/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber1024/m4 bin/crypto_kem_kyber1024_m4_speed.bin
cp bin/crypto_kem_kyber1024_m4_speed.bin bin_compiled_files/crypto_kem_kyber1024_fine_masking.bin
cp bin/crypto_kem_kyber1024_m4_speed.elf bin_compiled_files/crypto_kem_kyber1024_fine_masking.elf

make clean
cp Headers/ntt_kyber_coarse_masking.h crypto_kem/kyber1024/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber1024/m4 bin/crypto_kem_kyber1024_m4_speed.bin
cp bin/crypto_kem_kyber1024_m4_speed.bin bin_compiled_files/crypto_kem_kyber1024_coarse_masking.bin
cp bin/crypto_kem_kyber1024_m4_speed.elf bin_compiled_files/crypto_kem_kyber1024_coarse_masking.elf

make clean
cp Headers/ntt_kyber_coarse_group_shuffling.h crypto_kem/kyber1024/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber1024/m4 bin/crypto_kem_kyber1024_m4_speed.bin
cp bin/crypto_kem_kyber1024_m4_speed.bin bin_compiled_files/crypto_kem_kyber1024_coarse_group_shuffling.bin
cp bin/crypto_kem_kyber1024_m4_speed.elf bin_compiled_files/crypto_kem_kyber1024_coarse_group_shuffling.elf

make clean
cp Headers/ntt_kyber_coarse_group_within_shuffling.h crypto_kem/kyber1024/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber1024/m4 bin/crypto_kem_kyber1024_m4_speed.bin
cp bin/crypto_kem_kyber1024_m4_speed.bin bin_compiled_files/crypto_kem_kyber1024_coarse_within_group_shuffling.bin
cp bin/crypto_kem_kyber1024_m4_speed.elf bin_compiled_files/crypto_kem_kyber1024_coarse_within_group_shuffling.elf


make clean
cp Headers/ntt_kyber_generic_multiplicative_masking_2_masks.h crypto_kem/kyber1024/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber1024/m4 bin/crypto_kem_kyber1024_m4_speed.bin
cp bin/crypto_kem_kyber1024_m4_speed.bin bin_compiled_files/crypto_kem_kyber1024_generic_multiplicative_masking_2_masks.bin
cp bin/crypto_kem_kyber1024_m4_speed.elf bin_compiled_files/crypto_kem_kyber1024_generic_multiplicative_masking_2_masks.elf

make clean
cp Headers/ntt_kyber_generic_multiplicative_masking_4_masks.h crypto_kem/kyber1024/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_kem/kyber1024/m4 bin/crypto_kem_kyber1024_m4_speed.bin
cp bin/crypto_kem_kyber1024_m4_speed.bin bin_compiled_files/crypto_kem_kyber1024_generic_multiplicative_masking_4_masks.bin
cp bin/crypto_kem_kyber1024_m4_speed.elf bin_compiled_files/crypto_kem_kyber1024_generic_multiplicative_masking_4_masks.elf

fi

if [ $3 == "run" ]
then
  if [ $2 == "bench_total_randomize_time" ]
  then
    python get_numbers.py Kyber bench_total_randomize_time
  elif [ $2 == "bench_only_random_generation_time" ]
  then
    python get_numbers.py bench_only_random_generation_time
  elif [ $2 == "bench_total_ntt_time" ]
  then
    python get_numbers.py bench_total_ntt_time
  elif [ $2 == "bench_total_procedure_time" ]
  then
    python get_numbers.py bench_total_procedure_time
  fi

fi

fi
