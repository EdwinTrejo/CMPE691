`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Edwin Trejo
// Module Name: FlatEncryption
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

`ifndef AES_ENCRYPT_V

`define state0 0
`define state1 1
`define state2 2
`define state3 3
`define state4 4
`define state5 5
`define state6 6
`define state7 7
`define state8 8
`define state9 9
`define state10 10
`define state11 11
`define state12 12
`define state13 13
`define state14 14
`define state15 15

`define enc_idle 1
`define enc_start_ack 2
`define enc_data_received 3
`define enc_inform_complete 4
`define enc_return_data 5

`define ON 1'b1
`define OFF 1'b0

`endif

`define SIZE_OF_STREAM 128

module AESEncrypt(state_stream, key_stream, in_instruction, output_state_stream, out_instruction, clk);
    //size references
    parameter PARTIAL_MSG_SIZE = 8'h40;//64
    parameter FULL_MSG_SIZE = 8'h80;//128
    parameter EXPANDED_KEYS = 8'h2C;//44
    parameter EXPANDED_KEY_PART_SIZE = 8'h20;//32
    parameter INSTRUCTION_SIZE = 8'h08;//8
    parameter STATE_COUNTER_SIZE = 8'h08;//8

    //key expansin round addition value
    parameter RCON0 = 32'h8d000000, RCON1 = 32'h01000000, RCON2 = 32'h02000000, RCON3 = 32'h04000000, RCON4 = 32'h08000000, RCON5 = 32'h10000000;
    parameter RCON6 = 32'h20000000, RCON7 = 32'h40000000, RCON8 = 32'h80000000, RCON9 = 32'h1B000000, RCON10 = 32'h36000000;

    input [`SIZE_OF_STREAM-1:0]state_stream;
    input [`SIZE_OF_STREAM-1:0]key_stream;
    output reg [`SIZE_OF_STREAM-1:0]output_state_stream;
    //inputs and outputs
    input [INSTRUCTION_SIZE-1:0] in_instruction;
    input clk;
    output reg [INSTRUCTION_SIZE-1:0] out_instruction;
        
    //state machine management
    reg [FULL_MSG_SIZE-1:0] key;
    reg [FULL_MSG_SIZE-1:0] state;
    reg [STATE_COUNTER_SIZE-1:0] current_sm_state = 8'h00, next_sm_state = 8'h00;
    reg start_key_expansion = 1'b0, run_key_expansion = 1'b0, key_expansion_done = 1'b0;
    reg start_encryption = 1'b0, encryption_done = 1'b0;

    //key expansion
    reg [STATE_COUNTER_SIZE-1:0] KeySchedule, KeySchedule_next, KeySchedule_part;
    reg [STATE_COUNTER_SIZE-1:0] KeySchedule_current_1, KeySchedule_current_2, KeySchedule_current_3, KeySchedule_current_4; //also will be used by encryption
    reg [STATE_COUNTER_SIZE-1:0] KeySchedule_prev_1, KeySchedule_prev_2, KeySchedule_prev_3, KeySchedule_prev_4;
    reg [EXPANDED_KEY_PART_SIZE-1:0] KeySchedule_current_rcon;
    //reg KeyExpansionDone;
    reg [EXPANDED_KEY_PART_SIZE-1:0] expanded_key [0:EXPANDED_KEYS-1];

    reg [EXPANDED_KEY_PART_SIZE-1:0] msg_in_subword, msg_in_rotword;
    wire [EXPANDED_KEY_PART_SIZE-1:0] msg_out_subword, msg_out_rotword;
    RotWord RotWord_uut(msg_in_rotword, msg_out_rotword);
    SubWord SubWord_uut(msg_in_subword, msg_out_subword);

    //encryption
    parameter state_blocks = 8'h10;//16
    parameter state_block_size = 8'h08;//8
    reg [state_block_size-1:0] block_state [0:state_blocks-1];
    reg [state_block_size-1:0] block_key [0:state_blocks-1];
    reg [STATE_COUNTER_SIZE-1:0] xtime, xtime_next, xtime_part;
    
    //shiftrows
    reg [7:0] shiftrows_0, shiftrows_1, shiftrows_2, shiftrows_3, shiftrows_4, shiftrows_5, shiftrows_6, shiftrows_7, shiftrows_8, shiftrows_9, shiftrows_10, shiftrows_11, shiftrows_12, shiftrows_13, shiftrows_14, shiftrows_15;
    //encryption mixcolumns
    parameter times_two_B = 8'h1B;
    reg [7:0] MixColumns1, MixColumns2, MixColumns3, MixColumns4, MixColumns5, MixColumns6, MixColumns7, MixColumns8, MixColumns9, MixColumns10, MixColumns11, MixColumns12, MixColumns13, MixColumns14, MixColumns15, MixColumns16;
    reg [state_block_size-1:0] MixColumns2_1, MixColumns2_2, MixColumns2_3, MixColumns2_4, MixColumns2_5, MixColumns2_6, MixColumns2_7, MixColumns2_8, MixColumns2_9, MixColumns2_10, MixColumns2_11, MixColumns2_12, MixColumns2_13, MixColumns2_14, MixColumns2_15, MixColumns2_16;
    reg [state_block_size-1:0] MixColumns3_1, MixColumns3_2, MixColumns3_3, MixColumns3_4, MixColumns3_5, MixColumns3_6, MixColumns3_7, MixColumns3_8, MixColumns3_9, MixColumns3_10, MixColumns3_11, MixColumns3_12, MixColumns3_13, MixColumns3_14, MixColumns3_15, MixColumns3_16;
    wire [state_block_size-1:0] MixColumns2out_1, MixColumns2out_2, MixColumns2out_3, MixColumns2out_4, MixColumns2out_5, MixColumns2out_6, MixColumns2out_7, MixColumns2out_8, MixColumns2out_9, MixColumns2out_10, MixColumns2out_11, MixColumns2out_12, MixColumns2out_13, MixColumns2out_14, MixColumns2out_15, MixColumns2out_16;
    wire [state_block_size-1:0] MixColumns3out_1, MixColumns3out_2, MixColumns3out_3, MixColumns3out_4, MixColumns3out_5, MixColumns3out_6, MixColumns3out_7, MixColumns3out_8, MixColumns3out_9, MixColumns3out_10, MixColumns3out_11, MixColumns3out_12, MixColumns3out_13, MixColumns3out_14, MixColumns3out_15, MixColumns3out_16;
    times_two times_two_uut1(MixColumns2_1, MixColumns2out_1);
    times_two times_two_uut2(MixColumns2_2, MixColumns2out_2);
    times_two times_two_uut3(MixColumns2_3, MixColumns2out_3);
    times_two times_two_uut4(MixColumns2_4, MixColumns2out_4);
    times_two times_two_uut5(MixColumns2_5, MixColumns2out_5);
    times_two times_two_uut6(MixColumns2_6, MixColumns2out_6);
    times_two times_two_uut7(MixColumns2_7, MixColumns2out_7);
    times_two times_two_uut8(MixColumns2_8, MixColumns2out_8);
    times_two times_two_uut9(MixColumns2_9, MixColumns2out_9);
    times_two times_two_uut10(MixColumns2_10, MixColumns2out_10);
    times_two times_two_uut11(MixColumns2_11, MixColumns2out_11);
    times_two times_two_uut12(MixColumns2_12, MixColumns2out_12);
    times_two times_two_uut13(MixColumns2_13, MixColumns2out_13);
    times_two times_two_uut14(MixColumns2_14, MixColumns2out_14);
    times_two times_two_uut15(MixColumns2_15, MixColumns2out_15);
    times_two times_two_uut16(MixColumns2_16, MixColumns2out_16);
    
    times_three times_three_uut1(MixColumns3_1, MixColumns3out_1);
    times_three times_three_uut2(MixColumns3_2, MixColumns3out_2);
    times_three times_three_uut3(MixColumns3_3, MixColumns3out_3);
    times_three times_three_uut4(MixColumns3_4, MixColumns3out_4);
    times_three times_three_uut5(MixColumns3_5, MixColumns3out_5);
    times_three times_three_uut6(MixColumns3_6, MixColumns3out_6);
    times_three times_three_uut7(MixColumns3_7, MixColumns3out_7);
    times_three times_three_uut8(MixColumns3_8, MixColumns3out_8);
    times_three times_three_uut9(MixColumns3_9, MixColumns3out_9);
    times_three times_three_uut10(MixColumns3_10, MixColumns3out_10);
    times_three times_three_uut11(MixColumns3_11, MixColumns3out_11);
    times_three times_three_uut12(MixColumns3_12, MixColumns3out_12);
    times_three times_three_uut13(MixColumns3_13, MixColumns3out_13);
    times_three times_three_uut14(MixColumns3_14, MixColumns3out_14);
    times_three times_three_uut15(MixColumns3_15, MixColumns3out_15);
    times_three times_three_uut16(MixColumns3_16, MixColumns3out_16);
     
    //encryption subbytes
    reg [state_block_size-1:0] msg_in_subbyte1, msg_in_subbyte2, msg_in_subbyte3, msg_in_subbyte4, msg_in_subbyte5, msg_in_subbyte6, msg_in_subbyte7, msg_in_subbyte8, msg_in_subbyte9, msg_in_subbyte10, msg_in_subbyte11, msg_in_subbyte12, msg_in_subbyte13, msg_in_subbyte14, msg_in_subbyte15, msg_in_subbyte16;
    wire [state_block_size-1:0] msg_out_subbyte1, msg_out_subbyte2, msg_out_subbyte3, msg_out_subbyte4, msg_out_subbyte5, msg_out_subbyte6, msg_out_subbyte7, msg_out_subbyte8, msg_out_subbyte9, msg_out_subbyte10, msg_out_subbyte11, msg_out_subbyte12, msg_out_subbyte13, msg_out_subbyte14, msg_out_subbyte15, msg_out_subbyte16;
    getSBoxValue getSBoxValue_uut1(msg_in_subbyte1, msg_out_subbyte1);
    getSBoxValue getSBoxValue_uut2(msg_in_subbyte2, msg_out_subbyte2);
    getSBoxValue getSBoxValue_uut3(msg_in_subbyte3, msg_out_subbyte3);
    getSBoxValue getSBoxValue_uut4(msg_in_subbyte4, msg_out_subbyte4);
    getSBoxValue getSBoxValue_uut5(msg_in_subbyte5, msg_out_subbyte5);
    getSBoxValue getSBoxValue_uut6(msg_in_subbyte6, msg_out_subbyte6);
    getSBoxValue getSBoxValue_uut7(msg_in_subbyte7, msg_out_subbyte7);
    getSBoxValue getSBoxValue_uut8(msg_in_subbyte8, msg_out_subbyte8);
    getSBoxValue getSBoxValue_uut9(msg_in_subbyte9, msg_out_subbyte9);
    getSBoxValue getSBoxValue_uut10(msg_in_subbyte10, msg_out_subbyte10);
    getSBoxValue getSBoxValue_uut11(msg_in_subbyte11, msg_out_subbyte11);
    getSBoxValue getSBoxValue_uut12(msg_in_subbyte12, msg_out_subbyte12);
    getSBoxValue getSBoxValue_uut13(msg_in_subbyte13, msg_out_subbyte13);
    getSBoxValue getSBoxValue_uut14(msg_in_subbyte14, msg_out_subbyte14);
    getSBoxValue getSBoxValue_uut15(msg_in_subbyte15, msg_out_subbyte15);
    getSBoxValue getSBoxValue_uut16(msg_in_subbyte16, msg_out_subbyte16);
    
    reg transmit_done = 1'b0, transmit_result_1 = 1'b0, transmit_result_2 = 1'b0;
    //reg receive_key1 = 1'b0, receive_key2 = 1'b0, receive_state1 = 1'b0, receive_state2 = 1'b0;
    reg key_received = 1'b0, state_received = 1'b0;
    reg key_pt1_received = 1'b0, state_pt1_received = 1'b0;
    //move to IEEE format with always at *
    
    always @(posedge clk) begin
        current_sm_state = next_sm_state;
    end
        
    always @(posedge clk) begin
        if (current_sm_state == `state0 && in_instruction == 1) begin
            out_instruction = `enc_start_ack;
            next_sm_state = `state1;
        end
        else if (current_sm_state == `state0 && in_instruction != 1) begin
            //waiting state
            //dont put this one above because the state will never be reached
            out_instruction = `enc_idle;
            next_sm_state = `state0;
        end
        else if (current_sm_state == `state1 && in_instruction == 2) begin
            //receiveing first part of key
            next_sm_state = `state2;
            out_instruction = `enc_data_received;
        end
        else if (current_sm_state == `state2) begin
            next_sm_state = `state3;
        end
        else if (current_sm_state == `state3 && key_expansion_done != 1'b1 && start_key_expansion != 1'b1 && run_key_expansion != 1'b1)  begin
            //start key expansion
            start_key_expansion = 1'b1;
        end
        else if (current_sm_state == `state3 && key_expansion_done != 1'b1 && start_key_expansion == 1'b1 && run_key_expansion != 1'b1)  begin
            //turn off key expansion start
            start_key_expansion = 1'b0;
            run_key_expansion = 1'b1;
        end
        else if (current_sm_state == `state3 && key_expansion_done == 1'b1 && start_key_expansion != 1'b1 && run_key_expansion == 1'b1) begin
            //key expansion done
            run_key_expansion = 1'b0;
            next_sm_state = `state4;
        end
        else if (current_sm_state == `state4)  begin
            //add initial first key
            next_sm_state = `state5;
        end
        else if (current_sm_state == `state5 && encryption_done != 1'b1 && start_encryption != 1'b1)  begin
            //start encryption
            start_encryption = 1'b1;
        end
        else if (current_sm_state == `state5 && encryption_done != 1'b1 && start_encryption == 1'b1)  begin
            //turn off emcryption start
            start_encryption = 1'b0;
        end
        else if (current_sm_state == `state5 && encryption_done == 1'b1 && start_encryption != 1'b1)  begin
            //encryption done
            next_sm_state = `state6;
        end
        else if (current_sm_state == `state6)  begin
            //Load result into output array
            out_instruction = `enc_inform_complete;
            next_sm_state = `state7;
        end
        else if (current_sm_state == `state7)  begin
            //send result 1
            next_sm_state = `state8;
        end
        else if (current_sm_state == `state8)  begin
            //clear everything and back to idle/waiting
            //needs the second clock for the register write
            out_instruction = `enc_return_data;
            next_sm_state = `state0;
        end
    end
    
    //receiving the key
    always @(posedge clk) begin
        
        if (in_instruction == 2) begin
            key = key_stream;
            state = state_stream;
        end
        
        //send encryption done signal and place into the state register
        if (current_sm_state == `state6) begin
            state[7:0] = block_state[0];
            state[15:8] = block_state[1];
            state[23:16] = block_state[2];
            state[31:24] = block_state[3];
            state[39:32] = block_state[4];
            state[47:40] = block_state[5];
            state[55:48] = block_state[6];
            state[63:56] = block_state[7];
            state[71:64] = block_state[8];
            state[79:72] = block_state[9];
            state[87:80] = block_state[10];
            state[95:88] = block_state[11];
            state[103:96] = block_state[12];
            state[111:104] = block_state[13];
            state[119:112] = block_state[14];
            state[127:120] = block_state[15];
        end
        else if (current_sm_state == `state7) begin
            output_state_stream = state;
        end
    end
        
    //run key expansion here and store in block ram
    always @(posedge clk) begin
        if (current_sm_state == `state3 && start_key_expansion == 1'b1) begin
            //load key into from original key
            expanded_key[3] = key[31:0];
            expanded_key[2] = key[63:32];
            expanded_key[1] = key[95:64];
            expanded_key[0] = key[127:96];
            KeySchedule = 1;
            KeySchedule_part = 1;
            key_expansion_done = 1'b0;
            KeySchedule_next = 1;
        end
        else if (current_sm_state == `state3 && start_key_expansion == 1'b0 && run_key_expansion == 1'b1 && KeySchedule > 0 && KeySchedule < 11) begin
            case (KeySchedule_part)
                    1: begin
                        //load the current key from key schedule
                        case (KeySchedule)
                            1: begin
                                KeySchedule_current_1 = 4; KeySchedule_current_2 = 5; KeySchedule_current_3 = 6; KeySchedule_current_4 = 7;
                                KeySchedule_prev_1 = 0; KeySchedule_prev_2 = 1; KeySchedule_prev_3 = 2; KeySchedule_prev_4 = 3;
                                KeySchedule_current_rcon = RCON1;
                                KeySchedule_next = 2;
                            end
                            2: begin
                                KeySchedule_current_1 = 8; KeySchedule_current_2 = 9; KeySchedule_current_3 = 10; KeySchedule_current_4 = 11;
                                KeySchedule_prev_1 = 4; KeySchedule_prev_2 = 5; KeySchedule_prev_3 = 6; KeySchedule_prev_4 = 7;
                                KeySchedule_current_rcon = RCON2;
                                KeySchedule_next = 3;
                            end
                            3: begin
                                KeySchedule_current_1 = 12; KeySchedule_current_2 = 13; KeySchedule_current_3 = 14; KeySchedule_current_4 = 15;
                                KeySchedule_prev_1 = 8; KeySchedule_prev_2 = 9; KeySchedule_prev_3 = 10; KeySchedule_prev_4 = 11;
                                KeySchedule_current_rcon = RCON3;
                                KeySchedule_next = 4;
                            end
                            4: begin
                                KeySchedule_current_1 = 16; KeySchedule_current_2 = 17; KeySchedule_current_3 = 18; KeySchedule_current_4 = 19;
                                KeySchedule_prev_1 = 12; KeySchedule_prev_2 = 13; KeySchedule_prev_3 = 14; KeySchedule_prev_4 = 15;
                                KeySchedule_current_rcon = RCON4;
                                KeySchedule_next = 5;
                            end
                            5: begin
                                KeySchedule_current_1 = 20; KeySchedule_current_2 = 21; KeySchedule_current_3 = 22; KeySchedule_current_4 = 23;
                                KeySchedule_prev_1 = 16; KeySchedule_prev_2 = 17; KeySchedule_prev_3 = 18; KeySchedule_prev_4 = 19;
                                KeySchedule_current_rcon = RCON5;
                                KeySchedule_next = 6;
                            end
                            6: begin
                                KeySchedule_current_1 = 24; KeySchedule_current_2 = 25; KeySchedule_current_3 = 26; KeySchedule_current_4 = 27;
                                KeySchedule_prev_1 = 20; KeySchedule_prev_2 = 21; KeySchedule_prev_3 = 22; KeySchedule_prev_4 = 23;
                                KeySchedule_current_rcon = RCON6;
                                KeySchedule_next = 7;
                            end
                            7: begin
                                KeySchedule_current_1 = 28; KeySchedule_current_2 = 29; KeySchedule_current_3 = 30; KeySchedule_current_4 = 31;
                                KeySchedule_prev_1 = 24; KeySchedule_prev_2 = 25; KeySchedule_prev_3 = 26; KeySchedule_prev_4 = 27;
                                KeySchedule_current_rcon = RCON7;
                                KeySchedule_next = 8;
                            end
                            8: begin
                                KeySchedule_current_1 = 32; KeySchedule_current_2 = 33; KeySchedule_current_3 = 34; KeySchedule_current_4 = 35;
                                KeySchedule_prev_1 = 28; KeySchedule_prev_2 = 29; KeySchedule_prev_3 = 30; KeySchedule_prev_4 = 31;
                                KeySchedule_current_rcon = RCON8;
                                KeySchedule_next = 9;
                            end
                            9: begin
                                KeySchedule_current_1 = 36; KeySchedule_current_2 = 37; KeySchedule_current_3 = 38; KeySchedule_current_4 = 39;
                                KeySchedule_prev_1 = 32; KeySchedule_prev_2 = 33; KeySchedule_prev_3 = 34; KeySchedule_prev_4 = 35;
                                KeySchedule_current_rcon = RCON9;
                                KeySchedule_next = 10;
                            end
                            10: begin
                                KeySchedule_current_1 = 40; KeySchedule_current_2 = 41; KeySchedule_current_3 = 42; KeySchedule_current_4 = 43;
                                KeySchedule_prev_1 = 36; KeySchedule_prev_2 = 37; KeySchedule_prev_3 = 38; KeySchedule_prev_4 = 39;
                                KeySchedule_current_rcon = RCON10;
                                KeySchedule_next = 11;
                            end
                        endcase
                    KeySchedule_part = 2;
                end
                2: begin
                    //do the next part of the key
                    expanded_key[KeySchedule_current_1] = expanded_key[KeySchedule_prev_4];
                    KeySchedule_part = 3;
                end
                3: begin
                    //rotate word 1
                    msg_in_rotword = expanded_key[KeySchedule_current_1];
                    KeySchedule_part = 4;
                end
                4: begin
                    //rotate word 2
                    expanded_key[KeySchedule_current_1] = msg_out_rotword;
                    KeySchedule_part = 5;
                end
                5: begin
                    //subword 1
                    msg_in_subword = expanded_key[KeySchedule_current_1];
                    KeySchedule_part = 6;
                end
                6: begin
                    //subword 2
                    expanded_key[KeySchedule_current_1] = msg_out_subword;
                    KeySchedule_part = 7;
                end
                7: begin
                    //rcon
                    expanded_key[KeySchedule_current_1] = expanded_key[KeySchedule_current_1] ^ KeySchedule_current_rcon;
                    KeySchedule_part = 8;
                end
                8: begin
                    //addkey
                    expanded_key[KeySchedule_current_1] = expanded_key[KeySchedule_current_1] ^ expanded_key[KeySchedule_prev_1];
                    KeySchedule_part = 9;
                end
                9: begin
                    expanded_key[KeySchedule_current_2] = expanded_key[KeySchedule_current_1] ^ expanded_key[KeySchedule_prev_2];
                    KeySchedule_part = 10;
                end
                10: begin
                    expanded_key[KeySchedule_current_3] = expanded_key[KeySchedule_current_2] ^ expanded_key[KeySchedule_prev_3];
                    KeySchedule_part = 11;
                end
                11: begin
//                    expanded_key[KeySchedule_current_4] = expanded_key[KeySchedule_current_3] ^ expanded_key[KeySchedule_prev_4];
//                    //advance counter for loop
                    expanded_key[KeySchedule_current_4] = expanded_key[KeySchedule_current_3] ^ expanded_key[KeySchedule_prev_4];
                    //advance counter for loop
                    KeySchedule = KeySchedule_next;
                    
                    if (KeySchedule < 11) begin
                        KeySchedule_part = 1;
                    end
                    else begin
                        KeySchedule_part = 12;
                    end
                    
                end
            endcase
        end
        else if (current_sm_state == `state3 && KeySchedule == 11) begin
            key_expansion_done = 1'b1;
            KeySchedule = 0;
            KeySchedule_next = 0;
        end
        else if (current_sm_state == `state4) begin
            KeySchedule = 0;
            KeySchedule_part = 0;
            key_expansion_done = 1'b0;
            KeySchedule_next = 0;
        end
    end

    //run full encryption
    always @(posedge clk) begin
        //add initial key
        if (current_sm_state == `state4) begin
            xtime = 1;
            xtime_part = 1;
            xtime_next = 1;
            encryption_done = 0;
            block_state[0] = state[7:0] ^ key[7:0];
            block_state[1] = state[15:8] ^ key[15:8];
            block_state[2] = state[23:16] ^ key[23:16];
            block_state[3] = state[31:24] ^ key[31:24];
            block_state[4] = state[39:32] ^ key[39:32];
            block_state[5] = state[47:40] ^ key[47:40];
            block_state[6] = state[55:48] ^ key[55:48];
            block_state[7] = state[63:56] ^ key[63:56];
            block_state[8] = state[71:64] ^ key[71:64];
            block_state[9] = state[79:72] ^ key[79:72];
            block_state[10] = state[87:80] ^ key[87:80];
            block_state[11] = state[95:88] ^ key[95:88];
            block_state[12] = state[103:96] ^ key[103:96];
            block_state[13] = state[111:104] ^ key[111:104];
            block_state[14] = state[119:112] ^ key[119:112];
            block_state[15] = state[127:120] ^ key[127:120];
        end
        //it might be best to break this down as well as keyexpansion into multiple always blocks to reduce wait
        //xtime, xtime_next, xtime_part

        //THIS ONE might take a lot of steps
        else if (current_sm_state == `state5 && encryption_done == 0 && xtime > 0 && xtime < 11) begin
            //steps
            //1 subbytes
            //2 shiftrows
            //3 mixcolumns
            //4 addkey
            case (xtime_part)
                1: begin
                    case (xtime)
                        1: begin
                            //4 to 7
                            block_key[0] = expanded_key[7][7:0];
                            block_key[1] = expanded_key[7][15:8];
                            block_key[2] = expanded_key[7][23:16];
                            block_key[3] = expanded_key[7][31:24];
                            block_key[4] = expanded_key[6][7:0];
                            block_key[5] = expanded_key[6][15:8];
                            block_key[6] = expanded_key[6][23:16];
                            block_key[7] = expanded_key[6][31:24];
                            block_key[8] = expanded_key[5][7:0];
                            block_key[9] = expanded_key[5][15:8];
                            block_key[10] = expanded_key[5][23:16];
                            block_key[11] = expanded_key[5][31:24];
                            block_key[12] = expanded_key[4][7:0];
                            block_key[13] = expanded_key[4][15:8];
                            block_key[14] = expanded_key[4][23:16];
                            block_key[15] = expanded_key[4][31:24];
                            xtime_next = 2;
                        end
                        2: begin
                            //8 to 11
                            block_key[0] = expanded_key[11][7:0];
                            block_key[1] = expanded_key[11][15:8];
                            block_key[2] = expanded_key[11][23:16];
                            block_key[3] = expanded_key[11][31:24];
                            block_key[4] = expanded_key[10][7:0];
                            block_key[5] = expanded_key[10][15:8];
                            block_key[6] = expanded_key[10][23:16];
                            block_key[7] = expanded_key[10][31:24];
                            block_key[8] = expanded_key[9][7:0];
                            block_key[9] = expanded_key[9][15:8];
                            block_key[10] = expanded_key[9][23:16];
                            block_key[11] = expanded_key[9][31:24];
                            block_key[12] = expanded_key[8][7:0];
                            block_key[13] = expanded_key[8][15:8];
                            block_key[14] = expanded_key[8][23:16];
                            block_key[15] = expanded_key[8][31:24];
                            xtime_next = 3;
                        end
                        3: begin
                            //12 to 15
                            block_key[0] = expanded_key[15][7:0];
                            block_key[1] = expanded_key[15][15:8];
                            block_key[2] = expanded_key[15][23:16];
                            block_key[3] = expanded_key[15][31:24];
                            block_key[4] = expanded_key[14][7:0];
                            block_key[5] = expanded_key[14][15:8];
                            block_key[6] = expanded_key[14][23:16];
                            block_key[7] = expanded_key[14][31:24];
                            block_key[8] = expanded_key[13][7:0];
                            block_key[9] = expanded_key[13][15:8];
                            block_key[10] = expanded_key[13][23:16];
                            block_key[11] = expanded_key[13][31:24];
                            block_key[12] = expanded_key[12][7:0];
                            block_key[13] = expanded_key[12][15:8];
                            block_key[14] = expanded_key[12][23:16];
                            block_key[15] = expanded_key[12][31:24];
                            xtime_next = 4;
                        end
                        4: begin
                            //16 to 19
                            block_key[0] = expanded_key[19][7:0];
                            block_key[1] = expanded_key[19][15:8];
                            block_key[2] = expanded_key[19][23:16];
                            block_key[3] = expanded_key[19][31:24];
                            block_key[4] = expanded_key[18][7:0];
                            block_key[5] = expanded_key[18][15:8];
                            block_key[6] = expanded_key[18][23:16];
                            block_key[7] = expanded_key[18][31:24];
                            block_key[8] = expanded_key[17][7:0];
                            block_key[9] = expanded_key[17][15:8];
                            block_key[10] = expanded_key[17][23:16];
                            block_key[11] = expanded_key[17][31:24];
                            block_key[12] = expanded_key[16][7:0];
                            block_key[13] = expanded_key[16][15:8];
                            block_key[14] = expanded_key[16][23:16];
                            block_key[15] = expanded_key[16][31:24];
                            xtime_next = 5;
                        end
                        5: begin
                            //20 to 23
                            block_key[0] = expanded_key[23][7:0];
                            block_key[1] = expanded_key[23][15:8];
                            block_key[2] = expanded_key[23][23:16];
                            block_key[3] = expanded_key[23][31:24];
                            block_key[4] = expanded_key[22][7:0];
                            block_key[5] = expanded_key[22][15:8];
                            block_key[6] = expanded_key[22][23:16];
                            block_key[7] = expanded_key[22][31:24];
                            block_key[8] = expanded_key[21][7:0];
                            block_key[9] = expanded_key[21][15:8];
                            block_key[10] = expanded_key[21][23:16];
                            block_key[11] = expanded_key[21][31:24];
                            block_key[12] = expanded_key[20][7:0];
                            block_key[13] = expanded_key[20][15:8];
                            block_key[14] = expanded_key[20][23:16];
                            block_key[15] = expanded_key[20][31:24];
                            xtime_next = 6;
                        end
                        6: begin
                            //24 to 27
                            block_key[0] = expanded_key[27][7:0];
                            block_key[1] = expanded_key[27][15:8];
                            block_key[2] = expanded_key[27][23:16];
                            block_key[3] = expanded_key[27][31:24];
                            block_key[4] = expanded_key[26][7:0];
                            block_key[5] = expanded_key[26][15:8];
                            block_key[6] = expanded_key[26][23:16];
                            block_key[7] = expanded_key[26][31:24];
                            block_key[8] = expanded_key[25][7:0];
                            block_key[9] = expanded_key[25][15:8];
                            block_key[10] = expanded_key[25][23:16];
                            block_key[11] = expanded_key[25][31:24];
                            block_key[12] = expanded_key[24][7:0];
                            block_key[13] = expanded_key[24][15:8];
                            block_key[14] = expanded_key[24][23:16];
                            block_key[15] = expanded_key[24][31:24];
                            xtime_next = 7;
                        end
                        7: begin
                            //28 to 31
                            block_key[0] = expanded_key[31][7:0];
                            block_key[1] = expanded_key[31][15:8];
                            block_key[2] = expanded_key[31][23:16];
                            block_key[3] = expanded_key[31][31:24];
                            block_key[4] = expanded_key[30][7:0];
                            block_key[5] = expanded_key[30][15:8];
                            block_key[6] = expanded_key[30][23:16];
                            block_key[7] = expanded_key[30][31:24];
                            block_key[8] = expanded_key[29][7:0];
                            block_key[9] = expanded_key[29][15:8];
                            block_key[10] = expanded_key[29][23:16];
                            block_key[11] = expanded_key[29][31:24];
                            block_key[12] = expanded_key[28][7:0];
                            block_key[13] = expanded_key[28][15:8];
                            block_key[14] = expanded_key[28][23:16];
                            block_key[15] = expanded_key[28][31:24];
                            xtime_next = 8;
                        end
                        8: begin
                            //32 to 35
                            block_key[0] = expanded_key[35][7:0];
                            block_key[1] = expanded_key[35][15:8];
                            block_key[2] = expanded_key[35][23:16];
                            block_key[3] = expanded_key[35][31:24];
                            block_key[4] = expanded_key[34][7:0];
                            block_key[5] = expanded_key[34][15:8];
                            block_key[6] = expanded_key[34][23:16];
                            block_key[7] = expanded_key[34][31:24];
                            block_key[8] = expanded_key[33][7:0];
                            block_key[9] = expanded_key[33][15:8];
                            block_key[10] = expanded_key[33][23:16];
                            block_key[11] = expanded_key[33][31:24];
                            block_key[12] = expanded_key[32][7:0];
                            block_key[13] = expanded_key[32][15:8];
                            block_key[14] = expanded_key[32][23:16];
                            block_key[15] = expanded_key[32][31:24];
                            xtime_next = 9;
                        end
                        9: begin
                            //36 to 39
                            block_key[0] = expanded_key[39][7:0];
                            block_key[1] = expanded_key[39][15:8];
                            block_key[2] = expanded_key[39][23:16];
                            block_key[3] = expanded_key[39][31:24];
                            block_key[4] = expanded_key[38][7:0];
                            block_key[5] = expanded_key[38][15:8];
                            block_key[6] = expanded_key[38][23:16];
                            block_key[7] = expanded_key[38][31:24];
                            block_key[8] = expanded_key[37][7:0];
                            block_key[9] = expanded_key[37][15:8];
                            block_key[10] = expanded_key[37][23:16];
                            block_key[11] = expanded_key[37][31:24];
                            block_key[12] = expanded_key[36][7:0];
                            block_key[13] = expanded_key[36][15:8];
                            block_key[14] = expanded_key[36][23:16];
                            block_key[15] = expanded_key[36][31:24];
                            xtime_next = 10;
                        end
                        10: begin
                            //40 to 43
                            block_key[0] = expanded_key[43][7:0];
                            block_key[1] = expanded_key[43][15:8];
                            block_key[2] = expanded_key[43][23:16];
                            block_key[3] = expanded_key[43][31:24];
                            block_key[4] = expanded_key[42][7:0];
                            block_key[5] = expanded_key[42][15:8];
                            block_key[6] = expanded_key[42][23:16];
                            block_key[7] = expanded_key[42][31:24];
                            block_key[8] = expanded_key[41][7:0];
                            block_key[9] = expanded_key[41][15:8];
                            block_key[10] = expanded_key[41][23:16];
                            block_key[11] = expanded_key[41][31:24];
                            block_key[12] = expanded_key[40][7:0];
                            block_key[13] = expanded_key[40][15:8];
                            block_key[14] = expanded_key[40][23:16];
                            block_key[15] = expanded_key[40][31:24];
                            xtime_next = 11;
                        end
                    endcase
                    xtime_part = 2;
                end
                2: begin
                    //subbytes
                    msg_in_subbyte1 = block_state[0];
                    msg_in_subbyte2 = block_state[1];
                    msg_in_subbyte3 = block_state[2];
                    msg_in_subbyte4 = block_state[3];
                    msg_in_subbyte5 = block_state[4];
                    msg_in_subbyte6 = block_state[5];
                    msg_in_subbyte7 = block_state[6];
                    msg_in_subbyte8 = block_state[7];
                    msg_in_subbyte9 = block_state[8];
                    msg_in_subbyte10 = block_state[9];
                    msg_in_subbyte11 = block_state[10];
                    msg_in_subbyte12 = block_state[11];
                    msg_in_subbyte13 = block_state[12];
                    msg_in_subbyte14 = block_state[13];
                    msg_in_subbyte15 = block_state[14];
                    msg_in_subbyte16 = block_state[15];
                    xtime_part = 3;
                end
                3: begin
                    //subbytes
                    block_state[0] = msg_out_subbyte1;
                    block_state[1] = msg_out_subbyte2;
                    block_state[2] = msg_out_subbyte3;
                    block_state[3] = msg_out_subbyte4;
                    block_state[4] = msg_out_subbyte5;
                    block_state[5] = msg_out_subbyte6;
                    block_state[6] = msg_out_subbyte7;
                    block_state[7] = msg_out_subbyte8;
                    block_state[8] = msg_out_subbyte9;
                    block_state[9] = msg_out_subbyte10;
                    block_state[10] = msg_out_subbyte11;
                    block_state[11] = msg_out_subbyte12;
                    block_state[12] = msg_out_subbyte13;
                    block_state[13] = msg_out_subbyte14;
                    block_state[14] = msg_out_subbyte15;
                    block_state[15] = msg_out_subbyte16;
                    xtime_part = 4;
                end
                4: begin
                    //shiftrows
                    //  15  14  13  12  11  10  9   8   7   6   5   4   3   2   1   0
                    //  15  10  5   0   11  6   1   12  7   2   13  8   3   12  9   4
                    
                    //Does not work with non concurrent assignment
                    shiftrows_0 = block_state[0];
                    shiftrows_1 = block_state[1];
                    shiftrows_2 = block_state[2];
                    shiftrows_3 = block_state[3];
                    shiftrows_4 = block_state[4];
                    shiftrows_5 = block_state[5];
                    shiftrows_6 = block_state[6];
                    shiftrows_7 = block_state[7];
                    shiftrows_8 = block_state[8];
                    shiftrows_9 = block_state[9];
                    shiftrows_10 = block_state[10];
                    shiftrows_11 = block_state[11];
                    shiftrows_12 = block_state[12];
                    shiftrows_13 = block_state[13];
                    shiftrows_14 = block_state[14];
                    shiftrows_15 = block_state[15];
                    
                    block_state[0] = shiftrows_4;
                    block_state[1] = shiftrows_9;
                    block_state[2] = shiftrows_14;
                    block_state[3] = shiftrows_3;
                    block_state[4] = shiftrows_8;
                    block_state[5] = shiftrows_13;
                    block_state[6] = shiftrows_2;
                    block_state[7] = shiftrows_7;
                    block_state[8] = shiftrows_12;
                    block_state[9] = shiftrows_1;
                    block_state[10] = shiftrows_6;
                    block_state[11] = shiftrows_11;
                    block_state[12] = shiftrows_0;
                    block_state[13] = shiftrows_5;
                    block_state[14] = shiftrows_10;
                    block_state[15] = shiftrows_15;
                    
//                    block_state[0] = block_state[4];
//                    block_state[1] = block_state[9];
//                    block_state[2] = block_state[14];
//                    block_state[3] = block_state[3];
//                    block_state[4] = block_state[8];
//                    block_state[5] = block_state[13];
//                    block_state[6] = block_state[2];
//                    block_state[7] = block_state[7];
//                    block_state[8] = block_state[12];
//                    block_state[9] = block_state[1];
//                    block_state[10] = block_state[6];
//                    block_state[11] = block_state[11];
//                    block_state[12] = block_state[0];
//                    block_state[13] = block_state[5];
//                    block_state[14] = block_state[10];
//                    block_state[15] = block_state[15];
                    xtime_part = 5;
                end
                5: begin
                    //mixcolumns
                    //times_two_B = 8'h1B;
                    //MixColumns1
                    
                    //high to low
                    //times 2 = (block_state[] ^ times_two_B)
                    //times 3 = (block_state[] ^ (block_state[] ^ times_two_B))
                    //  15  14  13  12
                    //  11  10  9   8
                    //  7   6   5   4
                    //  3   2   1   0
                    
                    //  15  11  7   3
                    //  14  10  6   2
                    //  13  9   5   1
                    //  12  8   4   0
                                        
                    //  0   1   2   3
                    //  0   1   2   3
                    //  0   1   2   3
                    //  0   1   2   3
                    
                    //case 3
                    MixColumns2_1 = block_state[0]; MixColumns3_1 = block_state[3];
                    MixColumns2_2 = block_state[1]; MixColumns3_2 = block_state[0];
                    MixColumns2_3 = block_state[2]; MixColumns3_3 = block_state[1];
                    MixColumns2_4 = block_state[3]; MixColumns3_4 = block_state[2];
                    
                    MixColumns2_5 = block_state[4]; MixColumns3_5 = block_state[7];
                    MixColumns2_6 = block_state[5]; MixColumns3_6 = block_state[4];
                    MixColumns2_7 = block_state[6]; MixColumns3_7 = block_state[5];
                    MixColumns2_8 = block_state[7]; MixColumns3_8 = block_state[6];
                    
                    MixColumns2_9 = block_state[8]; MixColumns3_9 = block_state[11];
                    MixColumns2_10 = block_state[9]; MixColumns3_10 = block_state[8];
                    MixColumns2_11 = block_state[10]; MixColumns3_11 = block_state[9];
                    MixColumns2_12 = block_state[11]; MixColumns3_12 = block_state[10];
                    
                    MixColumns2_13 = block_state[12]; MixColumns3_13 = block_state[15];
                    MixColumns2_14 = block_state[13]; MixColumns3_14 = block_state[12];
                    MixColumns2_15 = block_state[14]; MixColumns3_15 = block_state[13];
                    MixColumns2_16 = block_state[15]; MixColumns3_16 = block_state[14];
                    
                    xtime_part = 6;
                end
                6: begin
                    //mixcolumns
                    if (xtime < 10) begin
                        MixColumns1 = block_state[0];
                        MixColumns2 = block_state[1];
                        MixColumns3 = block_state[2];
                        MixColumns4 = block_state[3];
                        MixColumns5 = block_state[4];
                        MixColumns6 = block_state[5];
                        MixColumns7 = block_state[6];
                        MixColumns8 = block_state[7];
                        MixColumns9 = block_state[8];
                        MixColumns10 = block_state[9];
                        MixColumns11 = block_state[10];
                        MixColumns12 = block_state[11];
                        MixColumns13 = block_state[12];
                        MixColumns14 = block_state[13];
                        MixColumns15 = block_state[14];
                        MixColumns16 = block_state[15];
                        
                        //MixColumns2out_1 MixColumns3out_1
                        block_state[0] = MixColumns2out_1 ^ MixColumns3out_1 ^ MixColumns2 ^ MixColumns3;
                        block_state[1] = MixColumns2out_2 ^ MixColumns3out_2 ^ MixColumns3 ^ MixColumns4;
                        block_state[2] = MixColumns2out_3 ^ MixColumns3out_3 ^ MixColumns1 ^ MixColumns4;
                        block_state[3] = MixColumns2out_4 ^ MixColumns3out_4 ^ MixColumns1 ^ MixColumns2;
                        
                        block_state[4] = MixColumns2out_5 ^ MixColumns3out_5 ^ MixColumns6 ^ MixColumns7;
                        block_state[5] = MixColumns2out_6 ^ MixColumns3out_6 ^ MixColumns7 ^ MixColumns8;
                        block_state[6] = MixColumns2out_7 ^ MixColumns3out_7 ^ MixColumns5 ^ MixColumns8;
                        block_state[7] = MixColumns2out_8 ^ MixColumns3out_8 ^ MixColumns5 ^ MixColumns6;
                        
                        block_state[8] = MixColumns2out_9 ^ MixColumns3out_9 ^ MixColumns10 ^ MixColumns11;
                        block_state[9] = MixColumns2out_10 ^ MixColumns3out_10 ^ MixColumns11 ^ MixColumns12;
                        block_state[10] = MixColumns2out_11 ^ MixColumns3out_11 ^ MixColumns9 ^ MixColumns12;
                        block_state[11] = MixColumns2out_12 ^ MixColumns3out_12 ^ MixColumns9 ^ MixColumns10;
                        
                        block_state[12] = MixColumns2out_13 ^ MixColumns3out_13 ^ MixColumns14 ^ MixColumns15;
                        block_state[13] = MixColumns2out_14 ^ MixColumns3out_14 ^ MixColumns15 ^ MixColumns16;
                        block_state[14] = MixColumns2out_15 ^ MixColumns3out_15 ^ MixColumns13 ^ MixColumns16;
                        block_state[15] = MixColumns2out_16 ^ MixColumns3out_16 ^ MixColumns13 ^ MixColumns14;
                    end
                    xtime_part = 7;
                end
                7: begin
                    //addkey
                    block_state[0] = block_state[0] ^ block_key[0];
                    block_state[1] = block_state[1] ^ block_key[1];
                    block_state[2] = block_state[2] ^ block_key[2];
                    block_state[3] = block_state[3] ^ block_key[3];
                    block_state[4] = block_state[4] ^ block_key[4];
                    block_state[5] = block_state[5] ^ block_key[5];
                    block_state[6] = block_state[6] ^ block_key[6];
                    block_state[7] = block_state[7] ^ block_key[7];
                    block_state[8] = block_state[8] ^ block_key[8];
                    block_state[9] = block_state[9] ^ block_key[9];
                    block_state[10] = block_state[10] ^ block_key[10];
                    block_state[11] = block_state[11] ^ block_key[11];
                    block_state[12] = block_state[12] ^ block_key[12];
                    block_state[13] = block_state[13] ^ block_key[13];
                    block_state[14] = block_state[14] ^ block_key[14];
                    block_state[15] = block_state[15] ^ block_key[15];
                    xtime_part = 8;
                end
                8: begin
                    if (xtime < 10) begin
                        xtime_part = 1;
                    end
                    else begin
                        xtime_part = 9;
                        encryption_done = 1'b1;
                    end
                    xtime = xtime_next;
                end
            endcase
        end
        else if (current_sm_state == `state5 && encryption_done == 1'b1) begin
            encryption_done = 1'b0;
            xtime = 0;
            xtime_part = 0;
        end
        else if (current_sm_state == `state1) begin
            encryption_done = 1'b0;
        end
    end
    
endmodule
