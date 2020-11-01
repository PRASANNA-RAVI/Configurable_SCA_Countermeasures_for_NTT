#!/usr/bin/python

import copy
import gc
import time
import serial
import random
import struct
import numpy as np
import scipy.io as spio
import datetime
import os
import copy
import sys

waiting_for_start = 1
computation_start = 2
finish_computation = 3
got_number = 4

if __name__ == "__main__":

    # ser = serial.Serial(port='/dev/tty.usbserial-FTBNZ0TN',baudrate=115200,timeout=None)
    #
    # for uu in range(0,10):
    #     ser.reset_input_buffer();

    total_flag = 0
    binary_no = 0

    scheme = sys.argv[1]

    kyber_protection_list = [
                        ["Kyber512: No Protection", "Kyber512: Coarse Shuffling", "Kyber512: Coarse Group Shuffling", "Kyber512: Coarse within group Shuffling", "Kyber512: Fine Shuffling", "Kyber512: Fine Masking", "Kyber512: Coarse Masking", "Kyber512: Generic Multiplicative Masking - 2 Masks", "Kyber512: Generic Multiplicative Masking - 4 Masks"],
                        ["Kyber768: No Protection", "Kyber768: Coarse Shuffling", "Kyber768: Coarse Group Shuffling", "Kyber768: Coarse within group Shuffling", "Kyber768: Fine Shuffling", "Kyber768: Fine Masking", "Kyber768: Coarse Masking", "Kyber768: Generic Multiplicative Masking - 2 Masks", "Kyber768: Generic Multiplicative Masking - 4 Masks"],
                        ["Kyber1024: No Protection", "Kyber1024: Coarse Shuffling", "Kyber1024: Coarse Group Shuffling", "Kyber1024: Coarse within group Shuffling", "Kyber1024: Fine Shuffling", "Kyber1024: Fine Masking", "Kyber1024: Coarse Masking", "Kyber1024: Generic Multiplicative Masking - 2 Masks", "Kyber1024: Generic Multiplicative Masking - 4 Masks"]
                            ]

    dilithium_protection_list = [
                        ["Dilithium2: No Protection", "Dilithium2: Coarse Shuffling", "Dilithium2: Coarse Group Shuffling", "Dilithium2: Coarse within group Shuffling", "Dilithium2: Fine Shuffling", "Dilithium2: Fine Masking", "Dilithium2: Coarse Masking", "Dilithium2: Generic Multiplicative Masking - 2 Masks", "Dilithium2: Generic Multiplicative Masking - 4 Masks"],
                        ["Dilithium3: No Protection", "Dilithium3: Coarse Shuffling", "Dilithium3: Coarse Group Shuffling", "Dilithium3: Coarse within group Shuffling", "Dilithium3: Fine Shuffling", "Dilithium3: Fine Masking", "Dilithium3: Coarse Masking", "Dilithium3: Generic Multiplicative Masking - 2 Masks", "Dilithium3: Generic Multiplicative Masking - 4 Masks"],
                        ["Dilithium4: No Protection", "Dilithium4: Coarse Shuffling", "Dilithium4: Coarse Group Shuffling", "Dilithium4: Coarse within group Shuffling", "Dilithium4: Fine Shuffling", "Dilithium4: Fine Masking", "Dilithium4: Coarse Masking", "Dilithium4: Generic Multiplicative Masking - 2 Masks", "Dilithium4: Generic Multiplicative Masking - 4 Masks"]
                                ]

    if(scheme == "kyber"):
        binary_string_list = [
                          ["crypto_kem_kyber512_no_protection.bin", "crypto_kem_kyber512_coarse_shuffling.bin", "crypto_kem_kyber512_coarse_group_shuffling.bin", "crypto_kem_kyber512_coarse_within_group_shuffling.bin", "crypto_kem_kyber512_fine_shuffling.bin", "crypto_kem_kyber512_fine_masking.bin", "crypto_kem_kyber512_coarse_masking.bin", "crypto_kem_kyber512_generic_multiplicative_masking_2_masks.bin", "crypto_kem_kyber512_generic_multiplicative_masking_4_masks.bin"],
                          ["crypto_kem_kyber768_no_protection.bin", "crypto_kem_kyber768_coarse_shuffling.bin", "crypto_kem_kyber768_coarse_group_shuffling.bin", "crypto_kem_kyber768_coarse_within_group_shuffling.bin", "crypto_kem_kyber768_fine_shuffling.bin", "crypto_kem_kyber768_fine_masking.bin", "crypto_kem_kyber768_coarse_masking.bin", "crypto_kem_kyber768_generic_multiplicative_masking_2_masks.bin", "crypto_kem_kyber768_generic_multiplicative_masking_4_masks.bin"],
                          ["crypto_kem_kyber1024_no_protection.bin", "crypto_kem_kyber1024_coarse_shuffling.bin", "crypto_kem_kyber1024_coarse_group_shuffling.bin", "crypto_kem_kyber1024_coarse_within_group_shuffling.bin", "crypto_kem_kyber1024_fine_shuffling.bin", "crypto_kem_kyber1024_fine_masking.bin", "crypto_kem_kyber1024_coarse_masking.bin", "crypto_kem_kyber1024_generic_multiplicative_masking_2_masks.bin", "crypto_kem_kyber1024_generic_multiplicative_masking_4_masks.bin"]
                             ]
    elif(scheme == "dilithium"):
        binary_string_list = [
                          ["crypto_sign_dilithium3_no_protection.bin", "crypto_sign_dilithium3_coarse_shuffling.bin", "crypto_sign_dilithium3_coarse_group_shuffling.bin", "crypto_sign_dilithium3_coarse_within_group_shuffling.bin", "crypto_sign_dilithium3_fine_shuffling.bin", "crypto_sign_dilithium3_fine_masking.bin", "crypto_sign_dilithium3_coarse_masking.bin", "crypto_sign_dilithium3_generic_multiplicative_masking_2_masks.bin", "crypto_sign_dilithium3_generic_multiplicative_masking_4_masks.bin"],
                          ["crypto_sign_dilithium2_no_protection.bin", "crypto_sign_dilithium2_coarse_shuffling.bin", "crypto_sign_dilithium2_coarse_group_shuffling.bin", "crypto_sign_dilithium2_coarse_within_group_shuffling.bin", "crypto_sign_dilithium2_fine_shuffling.bin", "crypto_sign_dilithium2_fine_masking.bin", "crypto_sign_dilithium2_coarse_masking.bin", "crypto_sign_dilithium2_generic_multiplicative_masking_2_masks.bin", "crypto_sign_dilithium2_generic_multiplicative_masking_4_masks.bin"],
                          ["crypto_sign_dilithium4_no_protection.bin", "crypto_sign_dilithium4_coarse_shuffling.bin", "crypto_sign_dilithium4_coarse_group_shuffling.bin", "crypto_sign_dilithium4_coarse_within_group_shuffling.bin", "crypto_sign_dilithium4_fine_shuffling.bin", "crypto_sign_dilithium4_fine_masking.bin", "crypto_sign_dilithium4_coarse_masking.bin", "crypto_sign_dilithium4_generic_multiplicative_masking_2_masks.bin", "crypto_sign_dilithium4_generic_multiplicative_masking_4_masks.bin"]
                             ]

    while(total_flag == 0):
        total_binary_no = 27

        if(sys.argv[2] == "bench_total_randomize_time" or sys.argv[2] == "bench_only_random_generation_time" or sys.argv[2] == "bench_total_ntt_time"):
            total_no_got = 1
        elif(sys.argv[2] == "bench_total_procedure_time"):
            total_no_got = 2

        if(sys.argv[2] == "bench_total_randomize_time"):
            print "Benchmarking time taken for: "
            print "Shuffling Countermeasures (Randomness Generation + Shuffling Algo.) in NTT & INTT"
        elif(sys.argv[2] == "bench_only_random_generation_time"):
            print "Benchmarking time taken for Randomness Generation Only in NTT & INTT: "
        elif(sys.argv[2] == "bench_total_ntt_time"):
            print "Benchmarking time taken for total NTT & INTT: "
        elif(sys.argv[2] == "bench_total_procedure_time"):
            print "Benchmarking time taken for Total Procedure: "
            if(sys.argv[1] == "Kyber"):
                print "Kyber (KeyGen & Encaps & Decaps)"
            elif(sys.argv[1] == "Dilithium"):
                print "Dilithium (KeyGen & Sign)"

        bin_row_no = binary_no/9
        bin_col_no = binary_no%9
        binary_str = "openocd -f interface/stlink-v2-1.cfg -f target/stm32f4x.cfg -c \"program bin_compiled_files/" + binary_string_list[bin_row_no][bin_col_no] + " 0x08000000 verify reset exit \" &> /dev/null"

        if(sys.argv[1] == "Kyber"):
            print kyber_protection_list[bin_row_no][bin_col_no]
        elif(sys.argv[1] == "Dilithium"):
            print dilithium_protection_list[bin_row_no][bin_col_no]

        os.system(binary_str)
        binary_no = binary_no + 1
        ser.write(chr(0x53)) # Starting Computation...
        time.sleep(0.01)

        state = waiting_for_start
        while(state == waiting_for_start):
            rcv_char = 0
            while(rcv_char != 0x43): # Waiting for C...
                rcv_char = ord(ser.read())

            state = computation_start

        no_got = 0

        while(no_got <= total_no_got):
            rcv_char = 0

            while(rcv_char != 0x53): # Waiting for S...
                rcv_char = ord(ser.read())

            no_digits = 0
            digit_array = [0]*10
            rcv_char = 0

            while(rcv_char != 0x45): # Waiting for E...
                rcv_char = ord(ser.read())
                if(rcv_char != 0x45):
                    digit_array[no_digits] = rcv_char - 0x30
                    no_digits = no_digits+1
                else:
                    break

            state = got_number
            received_number = 0
            for hg in range(0,no_digits):
                received_number = received_number + 10**(hg) * digit_array[no_digits - hg - 1]

            if(sys.argv[2] == "bench_total_randomize_time" or sys.argv[2] == "bench_only_random_generation_time" or sys.argv[2] == "bench_total_ntt_time"):
                if(no_got == 0):
                    print "NTT:"
                if(no_got == 0):
                    print "INTT:"
            elif(sys.argv[2] == "bench_total_procedure_time"):
                if(sys.argv[1] == "Kyber"):
                    if(no_got == 0):
                        print "KeyGen:"
                    elif(no_got == 1):
                        print "Encaps:"
                    elif(no_got == 2):
                        print "Decaps:"
                elif(sys.argv[1] == "Dilithium"):
                    if(no_got == 0):
                        print "KeyGen:"
                    elif(no_got == 1):
                        print "Sign:"
                    elif(no_got == 2):
                        print "Verify:"

            print received_number
            no_got = no_got+1

        if(binary_no == total_binary_no):
            total_flag = 1
