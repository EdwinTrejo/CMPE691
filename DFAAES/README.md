# Giraud Differential Fault Attack program

## to run the program using visual studio
''' bash
Just change the values in input.txt
'''

* the program can be found under the program folder of the submission
* the 4 lines following the identifier will be the ciphertext in the following format
* row, column
''' bash
0,0 0,1 0,2 0,3
1,0 1,1 1,2 1,3
2,0 2,1 2,2 2,3
3,0 3,1 3,2 3,3
'''

## to run the program, using the exe file
* Modify the input.txt file with the desired faulty attacks
* Must include the fault free cyphertext
** the index to identify this section will be FaultFreeCiphertext
* Must include the 3 faulty attacks cyphertext
** the indexes that identify the faulty attacks are
*** FirstFaultyCiphertext
*** SecondFaultyCiphertext
*** ThirdFaultyCiphertext
* the output can be found in the same folder and it will be called full_program_output.json

## How it works
* CXORD = fault_free ^ faulty (cyphertext)
* the M value is found for all bytes in CXORD
* the M value is as follows: sbox(M) ^ sbox(M ^ F)
* M = 0-255
* F = 1,2,4,8,16,32,64,128 (bit position)
* then these values are used to calculate round key at round 10
* K = fault_free ^ ShiftRows(SubByte(M))
* the K (round 10 key) is then used in the reverse key expansion function to find the key for all rounds