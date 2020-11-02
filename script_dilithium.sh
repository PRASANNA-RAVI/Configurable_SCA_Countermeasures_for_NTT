# mkdir bin_compiled_files

if [ $1 == "help" ]
then
echo "Format (e.g) : sh script_dilithium.sh <Argument1> <Argument2> <Argument3>"
echo "Argument 1 Options: Dilithium2, Dilithium3, Dilithium4"
echo ""
echo "Argument 2 Options:"
echo "1. To benchmark total shuffling time: bench_total_randomize_time"
echo "2. To benchmark only random generation: bench_only_random_generation_time"
echo "3. To benchmark total NTT/INTT time: bench_total_ntt_time"
echo "4. To benchmark total procedure time: bench_total_procedure_time"
echo ""
echo "Argument 3 Options:"
echo "To only compile: compile"
echo "To flash and run rmplementations: run"
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

if [ $3 == "compile" ]
then

if [ $1 == "Dilithium2" ]
then

cp Headers/benchmark.h crypto_sign/dilithium2/m4/

make clean
cp Headers/ntt_dilithium_no_protection.h crypto_sign/dilithium2/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium2/m4 bin/crypto_sign_dilithium2_m4_speed.bin
cp bin/crypto_sign_dilithium2_m4_speed.bin bin_compiled_files/crypto_sign_dilithium2_no_protection.bin
cp bin/crypto_sign_dilithium2_m4_speed.elf bin_compiled_files/crypto_sign_dilithium2_no_protection.elf

make clean
cp Headers/ntt_dilithium_coarse_shuffling.h crypto_sign/dilithium2/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium2/m4 bin/crypto_sign_dilithium2_m4_speed.bin
cp bin/crypto_sign_dilithium2_m4_speed.bin bin_compiled_files/crypto_sign_dilithium2_coarse_shuffling.bin
cp bin/crypto_sign_dilithium2_m4_speed.elf bin_compiled_files/crypto_sign_dilithium2_coarse_shuffling.elf

make clean
cp Headers/ntt_dilithium_fine_shuffling.h crypto_sign/dilithium2/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium2/m4 bin/crypto_sign_dilithium2_m4_speed.bin
cp bin/crypto_sign_dilithium2_m4_speed.bin bin_compiled_files/crypto_sign_dilithium2_fine_shuffling.bin
cp bin/crypto_sign_dilithium2_m4_speed.elf bin_compiled_files/crypto_sign_dilithium2_fine_shuffling.elf

make clean
cp Headers/ntt_dilithium_fine_masking.h crypto_sign/dilithium2/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium2/m4 bin/crypto_sign_dilithium2_m4_speed.bin
cp bin/crypto_sign_dilithium2_m4_speed.bin bin_compiled_files/crypto_sign_dilithium2_fine_masking.bin
cp bin/crypto_sign_dilithium2_m4_speed.elf bin_compiled_files/crypto_sign_dilithium2_fine_masking.elf

make clean
cp Headers/ntt_dilithium_coarse_masking.h crypto_sign/dilithium2/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium2/m4 bin/crypto_sign_dilithium2_m4_speed.bin
cp bin/crypto_sign_dilithium2_m4_speed.bin bin_compiled_files/crypto_sign_dilithium2_coarse_masking.bin
cp bin/crypto_sign_dilithium2_m4_speed.elf bin_compiled_files/crypto_sign_dilithium2_coarse_masking.elf

make clean
cp Headers/ntt_dilithium_coarse_group_shuffling.h crypto_sign/dilithium2/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium2/m4 bin/crypto_sign_dilithium2_m4_speed.bin
cp bin/crypto_sign_dilithium2_m4_speed.bin bin_compiled_files/crypto_sign_dilithium2_coarse_group_shuffling.bin
cp bin/crypto_sign_dilithium2_m4_speed.elf bin_compiled_files/crypto_sign_dilithium2_coarse_group_shuffling.elf

make clean
cp Headers/ntt_dilithium_coarse_group_within_shuffling.h crypto_sign/dilithium2/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium2/m4 bin/crypto_sign_dilithium2_m4_speed.bin
cp bin/crypto_sign_dilithium2_m4_speed.bin bin_compiled_files/crypto_sign_dilithium2_coarse_within_group_shuffling.bin
cp bin/crypto_sign_dilithium2_m4_speed.elf bin_compiled_files/crypto_sign_dilithium2_coarse_within_group_shuffling.elf

make clean
cp Headers/ntt_dilithium_generic_multiplicative_masking_2_masks.h crypto_sign/dilithium2/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium2/m4 bin/crypto_sign_dilithium2_m4_speed.bin
cp bin/crypto_sign_dilithium2_m4_speed.bin bin_compiled_files/crypto_sign_dilithium2_generic_multiplicative_masking_2_masks.bin
cp bin/crypto_sign_dilithium2_m4_speed.elf bin_compiled_files/crypto_sign_dilithium2_generic_multiplicative_masking_2_masks.elf

make clean
cp Headers/ntt_dilithium_generic_multiplicative_masking_4_masks.h crypto_sign/dilithium2/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium2/m4 bin/crypto_sign_dilithium2_m4_speed.bin
cp bin/crypto_sign_dilithium2_m4_speed.bin bin_compiled_files/crypto_sign_dilithium2_generic_multiplicative_masking_4_masks.bin
cp bin/crypto_sign_dilithium2_m4_speed.elf bin_compiled_files/crypto_sign_dilithium2_generic_multiplicative_masking_4_masks.elf

elif [ $1 == "Dilithium3" ]
then

cp Headers/benchmark.h crypto_sign/dilithium3/m4/

make clean
cp Headers/ntt_dilithium_no_protection.h crypto_sign/dilithium3/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium3/m4 bin/crypto_sign_dilithium3_m4_speed.bin
cp bin/crypto_sign_dilithium3_m4_speed.bin bin_compiled_files/crypto_sign_dilithium3_no_protection.bin
cp bin/crypto_sign_dilithium3_m4_speed.elf bin_compiled_files/crypto_sign_dilithium3_no_protection.elf

make clean
cp Headers/ntt_dilithium_coarse_shuffling.h crypto_sign/dilithium3/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium3/m4 bin/crypto_sign_dilithium3_m4_speed.bin
cp bin/crypto_sign_dilithium3_m4_speed.bin bin_compiled_files/crypto_sign_dilithium3_coarse_shuffling.bin
cp bin/crypto_sign_dilithium3_m4_speed.elf bin_compiled_files/crypto_sign_dilithium3_coarse_shuffling.elf

make clean
cp Headers/ntt_dilithium_fine_shuffling.h crypto_sign/dilithium3/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium3/m4 bin/crypto_sign_dilithium3_m4_speed.bin
cp bin/crypto_sign_dilithium3_m4_speed.bin bin_compiled_files/crypto_sign_dilithium3_fine_shuffling.bin
cp bin/crypto_sign_dilithium3_m4_speed.elf bin_compiled_files/crypto_sign_dilithium3_fine_shuffling.elf

make clean
cp Headers/ntt_dilithium_fine_masking.h crypto_sign/dilithium3/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium3/m4 bin/crypto_sign_dilithium3_m4_speed.bin
cp bin/crypto_sign_dilithium3_m4_speed.bin bin_compiled_files/crypto_sign_dilithium3_fine_masking.bin
cp bin/crypto_sign_dilithium3_m4_speed.elf bin_compiled_files/crypto_sign_dilithium3_fine_masking.elf

make clean
cp Headers/ntt_dilithium_coarse_masking.h crypto_sign/dilithium3/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium3/m4 bin/crypto_sign_dilithium3_m4_speed.bin
cp bin/crypto_sign_dilithium3_m4_speed.bin bin_compiled_files/crypto_sign_dilithium3_coarse_masking.bin
cp bin/crypto_sign_dilithium3_m4_speed.elf bin_compiled_files/crypto_sign_dilithium3_coarse_masking.elf

make clean
cp Headers/ntt_dilithium_coarse_group_shuffling.h crypto_sign/dilithium3/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium3/m4 bin/crypto_sign_dilithium3_m4_speed.bin
cp bin/crypto_sign_dilithium3_m4_speed.bin bin_compiled_files/crypto_sign_dilithium3_coarse_group_shuffling.bin
cp bin/crypto_sign_dilithium3_m4_speed.elf bin_compiled_files/crypto_sign_dilithium3_coarse_group_shuffling.elf

make clean
cp Headers/ntt_dilithium_coarse_group_within_shuffling.h crypto_sign/dilithium3/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium3/m4 bin/crypto_sign_dilithium3_m4_speed.bin
cp bin/crypto_sign_dilithium3_m4_speed.bin bin_compiled_files/crypto_sign_dilithium3_coarse_within_group_shuffling.bin
cp bin/crypto_sign_dilithium3_m4_speed.elf bin_compiled_files/crypto_sign_dilithium3_coarse_within_group_shuffling.elf

make clean
cp Headers/ntt_dilithium_generic_multiplicative_masking_2_masks.h crypto_sign/dilithium3/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium3/m4 bin/crypto_sign_dilithium3_m4_speed.bin
cp bin/crypto_sign_dilithium3_m4_speed.bin bin_compiled_files/crypto_sign_dilithium3_generic_multiplicative_masking_2_masks.bin
cp bin/crypto_sign_dilithium3_m4_speed.elf bin_compiled_files/crypto_sign_dilithium3_generic_multiplicative_masking_2_masks.elf

make clean
cp Headers/ntt_dilithium_generic_multiplicative_masking_4_masks.h crypto_sign/dilithium3/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium3/m4 bin/crypto_sign_dilithium3_m4_speed.bin
cp bin/crypto_sign_dilithium3_m4_speed.bin bin_compiled_files/crypto_sign_dilithium3_generic_multiplicative_masking_4_masks.bin
cp bin/crypto_sign_dilithium3_m4_speed.elf bin_compiled_files/crypto_sign_dilithium3_generic_multiplicative_masking_4_masks.elf

elif [ $1 == "Dilithium4" ]
then

cp Headers/benchmark.h crypto_sign/dilithium4/m4/

make clean
cp Headers/ntt_dilithium_no_protection.h crypto_sign/dilithium4/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium4/m4 bin/crypto_sign_dilithium4_m4_speed.bin
cp bin/crypto_sign_dilithium4_m4_speed.bin bin_compiled_files/crypto_sign_dilithium4_no_protection.bin
cp bin/crypto_sign_dilithium4_m4_speed.elf bin_compiled_files/crypto_sign_dilithium4_no_protection.elf

make clean
cp Headers/ntt_dilithium_coarse_shuffling.h crypto_sign/dilithium4/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium4/m4 bin/crypto_sign_dilithium4_m4_speed.bin
cp bin/crypto_sign_dilithium4_m4_speed.bin bin_compiled_files/crypto_sign_dilithium4_coarse_shuffling.bin
cp bin/crypto_sign_dilithium4_m4_speed.elf bin_compiled_files/crypto_sign_dilithium4_coarse_shuffling.elf

make clean
cp Headers/ntt_dilithium_fine_shuffling.h crypto_sign/dilithium4/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium4/m4 bin/crypto_sign_dilithium4_m4_speed.bin
cp bin/crypto_sign_dilithium4_m4_speed.bin bin_compiled_files/crypto_sign_dilithium4_fine_shuffling.bin
cp bin/crypto_sign_dilithium4_m4_speed.elf bin_compiled_files/crypto_sign_dilithium4_fine_shuffling.elf

make clean
cp Headers/ntt_dilithium_fine_masking.h crypto_sign/dilithium4/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium4/m4 bin/crypto_sign_dilithium4_m4_speed.bin
cp bin/crypto_sign_dilithium4_m4_speed.bin bin_compiled_files/crypto_sign_dilithium4_fine_masking.bin
cp bin/crypto_sign_dilithium4_m4_speed.elf bin_compiled_files/crypto_sign_dilithium4_fine_masking.elf

make clean
cp Headers/ntt_dilithium_coarse_masking.h crypto_sign/dilithium4/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium4/m4 bin/crypto_sign_dilithium4_m4_speed.bin
cp bin/crypto_sign_dilithium4_m4_speed.bin bin_compiled_files/crypto_sign_dilithium4_coarse_masking.bin
cp bin/crypto_sign_dilithium4_m4_speed.elf bin_compiled_files/crypto_sign_dilithium4_coarse_masking.elf

make clean
cp Headers/ntt_dilithium_coarse_group_shuffling.h crypto_sign/dilithium4/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium4/m4 bin/crypto_sign_dilithium4_m4_speed.bin
cp bin/crypto_sign_dilithium4_m4_speed.bin bin_compiled_files/crypto_sign_dilithium4_coarse_group_shuffling.bin
cp bin/crypto_sign_dilithium4_m4_speed.elf bin_compiled_files/crypto_sign_dilithium4_coarse_group_shuffling.elf

make clean
cp Headers/ntt_dilithium_coarse_group_within_shuffling.h crypto_sign/dilithium4/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium4/m4 bin/crypto_sign_dilithium4_m4_speed.bin
cp bin/crypto_sign_dilithium4_m4_speed.bin bin_compiled_files/crypto_sign_dilithium4_coarse_within_group_shuffling.bin
cp bin/crypto_sign_dilithium4_m4_speed.elf bin_compiled_files/crypto_sign_dilithium4_coarse_within_group_shuffling.elf

make clean
cp Headers/ntt_dilithium_generic_multiplicative_masking_2_masks.h crypto_sign/dilithium4/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium4/m4 bin/crypto_sign_dilithium4_m4_speed.bin
cp bin/crypto_sign_dilithium4_m4_speed.bin bin_compiled_files/crypto_sign_dilithium4_generic_multiplicative_masking_2_masks.bin
cp bin/crypto_sign_dilithium4_m4_speed.elf bin_compiled_files/crypto_sign_dilithium4_generic_multiplicative_masking_2_masks.elf

make clean
cp Headers/ntt_dilithium_generic_multiplicative_masking_4_masks.h crypto_sign/dilithium4/m4/ntt.h
make IMPLEMENTATION_PATH=crypto_sign/dilithium4/m4 bin/crypto_sign_dilithium4_m4_speed.bin
cp bin/crypto_sign_dilithium4_m4_speed.bin bin_compiled_files/crypto_sign_dilithium4_generic_multiplicative_masking_4_masks.bin
cp bin/crypto_sign_dilithium4_m4_speed.elf bin_compiled_files/crypto_sign_dilithium4_generic_multiplicative_masking_4_masks.elf

fi

rm -rf bin

fi

if [ $3 == "run" ]
then
  python get_numbers.py $1 $2
fi

fi
