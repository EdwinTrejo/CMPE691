`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Edwin Trejo
// Module Name: AESEncrypt_tb
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

`define enc_idle 1
`define enc_start_ack 2
`define enc_data_received 3
`define enc_inform_complete 4
`define enc_return_data 5

module AESEncrypt_b_tb();

    reg [127:0] key_stream;
    reg [127:0] state_stream;
    reg [7:0] in_instruction;
    reg clk;
    wire [7:0] out_instruction;
    
    reg [127:0] full_out_state;
    wire [127:0] output_state_stream;
    
    //AESEncrypt(state_stream, key_stream, in_instruction, output_state_stream, out_instruction, clk);
    AESEncrypt_b AESEncrypt_uut(.state_stream(state_stream), .key_stream(key_stream), .in_instruction(in_instruction), .output_state_stream(output_state_stream), .out_instruction(out_instruction), .clk(clk));
    
    initial begin
        clk = 0;
        #1;
        //key
        //69 20 e2 99 a5 20 2a 6d 65 6e 63 68 69 74 6f 2a
        //6920e299a5202a6d656e636869746f2a
        //state
        //54 88 93 89 c0 55 37 1d cb e7 9f 3b 23 39 dd a6
        //54889389c055371dcbe79f3b2339dda6
        //output
        //f1 ee ff d5 dd 7e 1d c1 ea 31 c7 59 95 8d 59 6c
        //f1eeffd5dd7e1dc1ea31c759958d596c
        in_instruction = 1;
        @(out_instruction == `enc_start_ack)
        in_instruction = 2;
        key_stream = 128'h6920e299a5202a6d656e636869746f2a;
        state_stream = 128'h54889389c055371dcbe79f3b2339dda6;
        @(out_instruction == `enc_data_received)
        in_instruction = 3;
        @(out_instruction == `enc_inform_complete)
        @(out_instruction == `enc_return_data)
        full_out_state = output_state_stream;
        #10
        $finish;
    end
    
    always #0.5 clk = ~clk;

endmodule
