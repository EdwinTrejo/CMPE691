`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Edwin Trejo
// Module Name: times_two
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//  8	7	6	5	4	3	2	1	0
//  1	0	0	0	1	1	0	1	1 - 1B
//  0	1	0	1	0	1	0	0	1 - A9

//10001 = 11
//1011 = B

//01010 = A
//1001 = 9

`ifndef TIMES_TWO_B
`define TIMES_TWO_VAL_B 8'hA9
`endif

module times_two_b(word_in, word_out);

    input [7:0] word_in;
    output wire [7:0] word_out;
    
    assign word_out = (word_in[7] == 1'b1) ?  ((word_in << 1) ^ `TIMES_TWO_VAL_B) : (word_in << 1);
    
endmodule
