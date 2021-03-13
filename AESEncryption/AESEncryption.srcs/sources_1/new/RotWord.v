`timescale 1 ns / 1 ns
// -------------------------------------------------------------
// 
// Engineer: Edwin Trejo
// Module: RotWord
// Source Path: test3/RotWord
// Hierarchy Level: 1
// 
// -------------------------------------------------------------

module RotWord (word, ret_word);


  input   [31:0] word;  // uint32
  output wire [31:0] ret_word;  // uint32

  assign ret_word = {word[23:16], word[15:8], word[7:0], word[31:24]};

endmodule  // RotWord