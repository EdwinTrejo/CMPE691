`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2021 07:15:37 PM
// Design Name: 
// Module Name: crack_Vigenere_tb
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

`define MAX_SIZE 80*4*8
`define MAX_LINE_SIZE 80*8
`define MAX_WORD_SIZE 8*8
`define MAX_WORD_AMOUNT 5
`define MAX_CHAR_AMOUNT 320

module crack_Vigenere_tb();


    //read file in
    integer input_data_file, input_scan_file, out_file;
    
    //80 chars 4 lines 8 bits;
//    reg [`MAX_SIZE-1:0] fileinput;
    
    reg [`MAX_WORD_SIZE-1:0] line1 [`MAX_WORD_AMOUNT-1:0];
    reg [`MAX_WORD_SIZE-1:0] line2 [`MAX_WORD_AMOUNT-1:0];
    reg [`MAX_WORD_SIZE-1:0] line3 [`MAX_WORD_AMOUNT-1:0];
    reg [`MAX_WORD_SIZE-1:0] line4 [`MAX_WORD_AMOUNT-1:0];
    
//    wire [`MAX_CHAR_AMOUNT-1:0] flat_line1;
//    wire [`MAX_CHAR_AMOUNT-1:0] flat_line2;
//    wire [`MAX_CHAR_AMOUNT-1:0] flat_line3;
//    wire [`MAX_CHAR_AMOUNT-1:0] flat_line4;
    
//    assign flat_line1 = {line1[0], line1[1], line1[2], line1[3], line1[4]};
//    assign flat_line2 = {line2[0], line2[1], line2[2], line2[3], line2[4]};
//    assign flat_line3 = {line3[0], line3[1], line3[2], line3[3], line3[4]};
//    assign flat_line4 = {line4[0], line4[1], line4[2], line4[3], line4[4]};
    
    reg [15:0] line1_size;
    reg [15:0] line2_size;
    integer i;
    
    wire [`MAX_LINE_SIZE-1:0] key;
    reg start;
    wire done;
    
    crack_Vigenere crack_Vigenere_uut(
        .start(start),
        
        .line1({line1[0], line1[1], line1[2], line1[3], line1[4]}),
        .line2({line2[0], line2[1], line2[2], line2[3], line2[4]}),
        .line3({line3[0], line3[1], line3[2], line3[3], line3[4]}),
        .line4({line4[0], line4[1], line4[2], line4[3], line4[4]}),
        
        .line1_words(line1_size),
        .line2_words(line2_size),
        
        .key(key),
        .done(done)
        );
    
    initial begin    
        input_data_file = $fopen("plain_cypher.txt", "r");
        if (!input_data_file) begin
            $display("Error Opening File for Read");
            $finish;
        end
        i=0;
        
        //i limited the number of inputs for these tests because I cannot use any filo IO
        //utilities for verilog or system verilog
        
        repeat(4)
        while(!$feof(input_data_file) & i < 4)begin
            case (i)
                0: begin
                    line1_size = $fscanf(input_data_file, "%s %s %s %s %s %s\n", line1[0], line1[1], line1[2], line1[3], line1[4]);
                end
                1: begin
                    line1_size = $fscanf(input_data_file, "%s %s %s %s %s %s\n", line2[0], line2[1], line2[2], line2[3], line2[4]);
                end
                2: begin
                    line2_size = $fscanf(input_data_file, "%s %s\n", line3[0], line3[1]);
                end
                3: begin
                    line2_size = $fscanf(input_data_file, "%s %s\n", line4[0], line4[1]);
                end
            endcase
            i++;
        end
        
        #1
        start = 1;
    end
    
    always @(posedge done) begin
        #1;
        $finish;
    end

endmodule
