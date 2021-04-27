onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /aes_128_tb/uut/clock
add wave -noupdate /aes_128_tb/uut/fault_detected
add wave -noupdate /aes_128_tb/uut/xorkey_pcheck
add wave -noupdate /aes_128_tb/uut/subbytes_pcheck
add wave -noupdate /aes_128_tb/uut/shiftrows_pcheck
add wave -noupdate /aes_128_tb/uut/mixcolumns_pcheck
add wave -noupdate -divider KeyExpansion
add wave -noupdate /aes_128_tb/uut/round_parity
add wave -noupdate -divider SubBytes
add wave -noupdate /aes_128_tb/uut/subbytes_pcheck
add wave -noupdate /aes_128_tb/uut/DByteParity_subbytes/DByte_In
add wave -noupdate -divider XorKey
add wave -noupdate /aes_128_tb/uut/xorkey_pcheck
add wave -noupdate /aes_128_tb/uut/roundKeyParity
add wave -noupdate /aes_128_tb/uut/KeyXorParity_Keyxor/ParityU
add wave -noupdate /aes_128_tb/uut/KeyXorParity_Keyxor/ParityK
add wave -noupdate /aes_128_tb/uut/KeyXorParity_Keyxor/ParityV2
add wave -noupdate -divider MixColumns
add wave -noupdate /aes_128_tb/uut/mixcolumns_pcheck
add wave -noupdate -radix hexadecimal -childformat {{/aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(0) -radix hexadecimal -childformat {{/aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(0)(0) -radix hexadecimal} {/aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(0)(1) -radix hexadecimal} {/aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(0)(2) -radix hexadecimal} {/aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(0)(3) -radix hexadecimal}}} {/aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(1) -radix hexadecimal -childformat {{/aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(1)(0) -radix hexadecimal} {/aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(1)(1) -radix hexadecimal} {/aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(1)(2) -radix hexadecimal} {/aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(1)(3) -radix hexadecimal}}}} -subitemconfig {/aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(0) {-height 15 -radix hexadecimal -childformat {{/aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(0)(0) -radix hexadecimal} {/aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(0)(1) -radix hexadecimal} {/aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(0)(2) -radix hexadecimal} {/aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(0)(3) -radix hexadecimal}}} /aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(0)(0) {-height 15 -radix hexadecimal} /aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(0)(1) {-height 15 -radix hexadecimal} /aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(0)(2) {-height 15 -radix hexadecimal} /aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(0)(3) {-height 15 -radix hexadecimal} /aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(1) {-height 15 -radix hexadecimal -childformat {{/aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(1)(0) -radix hexadecimal} {/aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(1)(1) -radix hexadecimal} {/aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(1)(2) -radix hexadecimal} {/aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(1)(3) -radix hexadecimal}}} /aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(1)(0) {-height 15 -radix hexadecimal} /aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(1)(1) {-height 15 -radix hexadecimal} /aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(1)(2) {-height 15 -radix hexadecimal} /aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState(1)(3) {-height 15 -radix hexadecimal}} /aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/DoubleState
add wave -noupdate /aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/matrix_1
add wave -noupdate /aes_128_tb/uut/DoubleMatrixParityColumns_mixcolumns/matrix_2
add wave -noupdate -divider ShiftRows
add wave -noupdate /aes_128_tb/uut/shiftrows_pcheck
add wave -noupdate -radix hexadecimal -childformat {{/aes_128_tb/uut/DoubleMatrixParityRows_shiftrow/DoubleState(0) -radix hexadecimal} {/aes_128_tb/uut/DoubleMatrixParityRows_shiftrow/DoubleState(1) -radix hexadecimal}} -subitemconfig {/aes_128_tb/uut/DoubleMatrixParityRows_shiftrow/DoubleState(0) {-height 15 -radix hexadecimal} /aes_128_tb/uut/DoubleMatrixParityRows_shiftrow/DoubleState(1) {-height 15 -radix hexadecimal}} /aes_128_tb/uut/DoubleMatrixParityRows_shiftrow/DoubleState
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 4} {370652 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 451
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1575 ns}
