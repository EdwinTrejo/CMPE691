`timescale 1 ns / 1 ns
// -------------------------------------------------------------
// 
// Engineer: Edwin Trejo
// Module: SubWord
// Source Path: test3/SubWord
// Hierarchy Level: 1
// 
// -------------------------------------------------------------

module SubWord(word, ret_word);
    input   [31:0] word;  // uint32
    output  [31:0] ret_word;  // uint32
    
    getSBoxValue SubByte_uut_1(word[31:24], ret_word[31:24]);
    getSBoxValue SubByte_uut_2(word[23:16], ret_word[23:16]);
    getSBoxValue SubByte_uut_3(word[15:8], ret_word[15:8]);
    getSBoxValue SubByte_uut_4(word[7:0], ret_word[7:0]);
    
endmodule
