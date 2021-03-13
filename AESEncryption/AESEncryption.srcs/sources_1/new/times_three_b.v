`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Edwin Trejo
// Module Name: times_three
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


module times_three_b(word_in, word_out);

    input [7:0] word_in;
    output wire [7:0] word_out;
    wire [7:0] temp_word;
    
    times_two_b time_two_b_uut1(word_in, temp_word);
    
    assign word_out = temp_word ^ word_in;
    
endmodule
