`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2021 07:47:37 PM
// Design Name: 
// Module Name: vignere
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

parameter LINE_SIZE = 80*8;
parameter REPLACEMENT_LINE_AMOUNT = 27*8;

`define pos_1 7:0
`define pos_2 15:8
`define pos_3 23:16
`define pos_4 31:24
`define pos_5 39:32
`define pos_6 47:40
`define pos_7 55:48
`define pos_8 63:56
`define pos_9 71:64
`define pos_10 79:72
`define pos_11 87:80
`define pos_12 95:88
`define pos_13 103:96
`define pos_14 111:104
`define pos_15 119:112
`define pos_16 127:120
`define pos_17 135:128
`define pos_18 143:136
`define pos_19 151:144
`define pos_20 159:152
`define pos_21 167:160
`define pos_22 175:168
`define pos_23 183:176
`define pos_24 191:184
`define pos_25 199:192
`define pos_26 207:200
`define pos_27 215:208
`define pos_28 223:216
`define pos_29 231:224
`define pos_30 239:232
`define pos_31 247:240
`define pos_32 255:248
`define pos_33 263:256
`define pos_34 271:264
`define pos_35 279:272
`define pos_36 287:280
`define pos_37 295:288
`define pos_38 303:296
`define pos_39 311:304
`define pos_40 319:312
`define pos_41 327:320
`define pos_42 335:328
`define pos_43 343:336
`define pos_44 351:344
`define pos_45 359:352
`define pos_46 367:360
`define pos_47 375:368
`define pos_48 383:376
`define pos_49 391:384
`define pos_50 399:392
`define pos_51 407:400
`define pos_52 415:408
`define pos_53 423:416
`define pos_54 431:424
`define pos_55 439:432
`define pos_56 447:440
`define pos_57 455:448
`define pos_58 463:456
`define pos_59 471:464
`define pos_60 479:472
`define pos_61 487:480
`define pos_62 495:488
`define pos_63 503:496
`define pos_64 511:504
`define pos_65 519:512
`define pos_66 527:520
`define pos_67 535:528
`define pos_68 543:536
`define pos_69 551:544
`define pos_70 559:552
`define pos_71 567:560
`define pos_72 575:568
`define pos_73 583:576
`define pos_74 591:584
`define pos_75 599:592
`define pos_76 607:600
`define pos_77 615:608
`define pos_78 623:616
`define pos_79 631:624
`define pos_80 639:632

`define poshigh_1 7
`define poslow_1 0
`define poshigh_2 15
`define poslow_2 8
`define poshigh_3 23
`define poslow_3 16
`define poshigh_4 31
`define poslow_4 24
`define poshigh_5 39
`define poslow_5 32
`define poshigh_6 47
`define poslow_6 40
`define poshigh_7 55
`define poslow_7 48
`define poshigh_8 63
`define poslow_8 56
`define poshigh_9 71
`define poslow_9 64
`define poshigh_10 79
`define poslow_10 72
`define poshigh_11 87
`define poslow_11 80
`define poshigh_12 95
`define poslow_12 88
`define poshigh_13 103
`define poslow_13 96
`define poshigh_14 111
`define poslow_14 104
`define poshigh_15 119
`define poslow_15 112
`define poshigh_16 127
`define poslow_16 120
`define poshigh_17 135
`define poslow_17 128
`define poshigh_18 143
`define poslow_18 136
`define poshigh_19 151
`define poslow_19 144
`define poshigh_20 159
`define poslow_20 152
`define poshigh_21 167
`define poslow_21 160
`define poshigh_22 175
`define poslow_22 168
`define poshigh_23 183
`define poslow_23 176
`define poshigh_24 191
`define poslow_24 184
`define poshigh_25 199
`define poslow_25 192
`define poshigh_26 207
`define poslow_26 200
`define poshigh_27 215
`define poslow_27 208
`define poshigh_28 223
`define poslow_28 216
`define poshigh_29 231
`define poslow_29 224
`define poshigh_30 239
`define poslow_30 232
`define poshigh_31 247
`define poslow_31 240
`define poshigh_32 255
`define poslow_32 248
`define poshigh_33 263
`define poslow_33 256
`define poshigh_34 271
`define poslow_34 264
`define poshigh_35 279
`define poslow_35 272
`define poshigh_36 287
`define poslow_36 280
`define poshigh_37 295
`define poslow_37 288
`define poshigh_38 303
`define poslow_38 296
`define poshigh_39 311
`define poslow_39 304
`define poshigh_40 319
`define poslow_40 312
`define poshigh_41 327
`define poslow_41 320
`define poshigh_42 335
`define poslow_42 328
`define poshigh_43 343
`define poslow_43 336
`define poshigh_44 351
`define poslow_44 344
`define poshigh_45 359
`define poslow_45 352
`define poshigh_46 367
`define poslow_46 360
`define poshigh_47 375
`define poslow_47 368
`define poshigh_48 383
`define poslow_48 376
`define poshigh_49 391
`define poslow_49 384
`define poshigh_50 399
`define poslow_50 392
`define poshigh_51 407
`define poslow_51 400
`define poshigh_52 415
`define poslow_52 408
`define poshigh_53 423
`define poslow_53 416
`define poshigh_54 431
`define poslow_54 424
`define poshigh_55 439
`define poslow_55 432
`define poshigh_56 447
`define poslow_56 440
`define poshigh_57 455
`define poslow_57 448
`define poshigh_58 463
`define poslow_58 456
`define poshigh_59 471
`define poslow_59 464
`define poshigh_60 479
`define poslow_60 472
`define poshigh_61 487
`define poslow_61 480
`define poshigh_62 495
`define poslow_62 488
`define poshigh_63 503
`define poslow_63 496
`define poshigh_64 511
`define poslow_64 504
`define poshigh_65 519
`define poslow_65 512
`define poshigh_66 527
`define poslow_66 520
`define poshigh_67 535
`define poslow_67 528
`define poshigh_68 543
`define poslow_68 536
`define poshigh_69 551
`define poslow_69 544
`define poshigh_70 559
`define poslow_70 552
`define poshigh_71 567
`define poslow_71 560
`define poshigh_72 575
`define poslow_72 568
`define poshigh_73 583
`define poslow_73 576
`define poshigh_74 591
`define poslow_74 584
`define poshigh_75 599
`define poslow_75 592
`define poshigh_76 607
`define poslow_76 600
`define poshigh_77 615
`define poslow_77 608
`define poshigh_78 623
`define poslow_78 616
`define poshigh_79 631
`define poslow_79 624
`define poshigh_80 639
`define poslow_80 632

`define replacement_offset1 65
`define replacement_offset2 97
`define replacement_offset3 90
`define replacement_offset4 122

module vignere(
    input start,
    input flag,
    
    input wire [LINE_SIZE-1:0] key,
    input wire [LINE_SIZE-1:0] message_in,
    
    input wire [7:0] message_size,
    input wire [7:0] key_size,
    
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] a_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] b_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] c_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] d_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] e_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] f_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] g_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] h_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] i_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] j_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] k_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] l_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] m_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] n_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] o_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] p_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] q_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] r_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] s_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] t_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] u_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] v_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] w_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] x_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] y_replace,
    input wire [REPLACEMENT_LINE_AMOUNT-1:0] z_replace,
        
    output reg [LINE_SIZE-1:0] message_out,
    output reg done
    );
    
    //reg [LINE_SIZE-1:0] resized_key;
    
    reg [7:0] blockram_original_key [79:0];
    reg [7:0] blockram_key [79:0];
    reg [7:0] blockram_message [79:0];
    reg [7:0] blockram_message_out [79:0];
    
    reg [7:0] i;
    reg [7:0] number0;
    reg [7:0] number1;
    reg [7:0] number2;
    reg [7:0] number3;
    
    reg lowercase;
       
    always @(posedge start) begin
        
        done = 0;
        blockram_message[79] = message_in[`pos_1];
        blockram_message[78] = message_in[`pos_2];
        blockram_message[77] = message_in[`pos_3];
        blockram_message[76] = message_in[`pos_4];
        blockram_message[75] = message_in[`pos_5];
        blockram_message[74] = message_in[`pos_6];
        blockram_message[73] = message_in[`pos_7];
        blockram_message[72] = message_in[`pos_8];
        blockram_message[71] = message_in[`pos_9];
        blockram_message[70] = message_in[`pos_10];
        blockram_message[69] = message_in[`pos_11];
        blockram_message[68] = message_in[`pos_12];
        blockram_message[67] = message_in[`pos_13];
        blockram_message[66] = message_in[`pos_14];
        blockram_message[65] = message_in[`pos_15];
        blockram_message[64] = message_in[`pos_16];
        blockram_message[63] = message_in[`pos_17];
        blockram_message[62] = message_in[`pos_18];
        blockram_message[61] = message_in[`pos_19];
        blockram_message[60] = message_in[`pos_20];
        blockram_message[59] = message_in[`pos_21];
        blockram_message[58] = message_in[`pos_22];
        blockram_message[57] = message_in[`pos_23];
        blockram_message[56] = message_in[`pos_24];
        blockram_message[55] = message_in[`pos_25];
        blockram_message[54] = message_in[`pos_26];
        blockram_message[53] = message_in[`pos_27];
        blockram_message[52] = message_in[`pos_28];
        blockram_message[51] = message_in[`pos_29];
        blockram_message[50] = message_in[`pos_30];
        blockram_message[49] = message_in[`pos_31];
        blockram_message[48] = message_in[`pos_32];
        blockram_message[47] = message_in[`pos_33];
        blockram_message[46] = message_in[`pos_34];
        blockram_message[45] = message_in[`pos_35];
        blockram_message[44] = message_in[`pos_36];
        blockram_message[43] = message_in[`pos_37];
        blockram_message[42] = message_in[`pos_38];
        blockram_message[41] = message_in[`pos_39];
        blockram_message[40] = message_in[`pos_40];
        blockram_message[39] = message_in[`pos_41];
        blockram_message[38] = message_in[`pos_42];
        blockram_message[37] = message_in[`pos_43];
        blockram_message[36] = message_in[`pos_44];
        blockram_message[35] = message_in[`pos_45];
        blockram_message[34] = message_in[`pos_46];
        blockram_message[33] = message_in[`pos_47];
        blockram_message[32] = message_in[`pos_48];
        blockram_message[31] = message_in[`pos_49];
        blockram_message[30] = message_in[`pos_50];
        blockram_message[29] = message_in[`pos_51];
        blockram_message[28] = message_in[`pos_52];
        blockram_message[27] = message_in[`pos_53];
        blockram_message[26] = message_in[`pos_54];
        blockram_message[25] = message_in[`pos_55];
        blockram_message[24] = message_in[`pos_56];
        blockram_message[23] = message_in[`pos_57];
        blockram_message[22] = message_in[`pos_58];
        blockram_message[21] = message_in[`pos_59];
        blockram_message[20] = message_in[`pos_60];
        blockram_message[19] = message_in[`pos_61];
        blockram_message[18] = message_in[`pos_62];
        blockram_message[17] = message_in[`pos_63];
        blockram_message[16] = message_in[`pos_64];
        blockram_message[15] = message_in[`pos_65];
        blockram_message[14] = message_in[`pos_66];
        blockram_message[13] = message_in[`pos_67];
        blockram_message[12] = message_in[`pos_68];
        blockram_message[11] = message_in[`pos_69];
        blockram_message[10] = message_in[`pos_70];
        blockram_message[9] = message_in[`pos_71];
        blockram_message[8] = message_in[`pos_72];
        blockram_message[7] = message_in[`pos_73];
        blockram_message[6] = message_in[`pos_74];
        blockram_message[5] = message_in[`pos_75];
        blockram_message[4] = message_in[`pos_76];
        blockram_message[3] = message_in[`pos_77];
        blockram_message[2] = message_in[`pos_78];
        blockram_message[1] = message_in[`pos_79];
        blockram_message[0] = message_in[`pos_80];
        #1
        blockram_original_key[79] = key[`pos_1];
        blockram_original_key[78] = key[`pos_2];
        blockram_original_key[77] = key[`pos_3];
        blockram_original_key[76] = key[`pos_4];
        blockram_original_key[75] = key[`pos_5];
        blockram_original_key[74] = key[`pos_6];
        blockram_original_key[73] = key[`pos_7];
        blockram_original_key[72] = key[`pos_8];
        blockram_original_key[71] = key[`pos_9];
        blockram_original_key[70] = key[`pos_10];
        blockram_original_key[69] = key[`pos_11];
        blockram_original_key[68] = key[`pos_12];
        blockram_original_key[67] = key[`pos_13];
        blockram_original_key[66] = key[`pos_14];
        blockram_original_key[65] = key[`pos_15];
        blockram_original_key[64] = key[`pos_16];
        blockram_original_key[63] = key[`pos_17];
        blockram_original_key[62] = key[`pos_18];
        blockram_original_key[61] = key[`pos_19];
        blockram_original_key[60] = key[`pos_20];
        blockram_original_key[59] = key[`pos_21];
        blockram_original_key[58] = key[`pos_22];
        blockram_original_key[57] = key[`pos_23];
        blockram_original_key[56] = key[`pos_24];
        blockram_original_key[55] = key[`pos_25];
        blockram_original_key[54] = key[`pos_26];
        blockram_original_key[53] = key[`pos_27];
        blockram_original_key[52] = key[`pos_28];
        blockram_original_key[51] = key[`pos_29];
        blockram_original_key[50] = key[`pos_30];
        blockram_original_key[49] = key[`pos_31];
        blockram_original_key[48] = key[`pos_32];
        blockram_original_key[47] = key[`pos_33];
        blockram_original_key[46] = key[`pos_34];
        blockram_original_key[45] = key[`pos_35];
        blockram_original_key[44] = key[`pos_36];
        blockram_original_key[43] = key[`pos_37];
        blockram_original_key[42] = key[`pos_38];
        blockram_original_key[41] = key[`pos_39];
        blockram_original_key[40] = key[`pos_40];
        blockram_original_key[39] = key[`pos_41];
        blockram_original_key[38] = key[`pos_42];
        blockram_original_key[37] = key[`pos_43];
        blockram_original_key[36] = key[`pos_44];
        blockram_original_key[35] = key[`pos_45];
        blockram_original_key[34] = key[`pos_46];
        blockram_original_key[33] = key[`pos_47];
        blockram_original_key[32] = key[`pos_48];
        blockram_original_key[31] = key[`pos_49];
        blockram_original_key[30] = key[`pos_50];
        blockram_original_key[29] = key[`pos_51];
        blockram_original_key[28] = key[`pos_52];
        blockram_original_key[27] = key[`pos_53];
        blockram_original_key[26] = key[`pos_54];
        blockram_original_key[25] = key[`pos_55];
        blockram_original_key[24] = key[`pos_56];
        blockram_original_key[23] = key[`pos_57];
        blockram_original_key[22] = key[`pos_58];
        blockram_original_key[21] = key[`pos_59];
        blockram_original_key[20] = key[`pos_60];
        blockram_original_key[19] = key[`pos_61];
        blockram_original_key[18] = key[`pos_62];
        blockram_original_key[17] = key[`pos_63];
        blockram_original_key[16] = key[`pos_64];
        blockram_original_key[15] = key[`pos_65];
        blockram_original_key[14] = key[`pos_66];
        blockram_original_key[13] = key[`pos_67];
        blockram_original_key[12] = key[`pos_68];
        blockram_original_key[11] = key[`pos_69];
        blockram_original_key[10] = key[`pos_70];
        blockram_original_key[9] = key[`pos_71];
        blockram_original_key[8] = key[`pos_72];
        blockram_original_key[7] = key[`pos_73];
        blockram_original_key[6] = key[`pos_74];
        blockram_original_key[5] = key[`pos_75];
        blockram_original_key[4] = key[`pos_76];
        blockram_original_key[3] = key[`pos_77];
        blockram_original_key[2] = key[`pos_78];
        blockram_original_key[1] = key[`pos_79];
        blockram_original_key[0] = key[`pos_80];
        #1
        number3 = 1;
        //fix the key size
        if (key_size < message_size) begin
            for (number0 = 1; number0 <= message_size; number0++) begin
                #1
                if ((blockram_message[number0-1] >= 65 & blockram_message[number0-1] <= 90) | (blockram_message[number0-1] >= 97 & blockram_message[number0-1] <= 122)) begin
                    if ((number3 % key_size) == 0) begin
                        number2 = (key_size - 1);
                    end
                    else begin
                        number2 = (number3 % key_size) - 1;
                    end
                    
                    number1 = number0-1;
                    blockram_key[number1] = blockram_original_key[number2];
                    number3++;
                end
                else begin
                    number1 = number0-1;
                    blockram_key[number1] = blockram_message[number1];
                end
            end
        end
        else begin
            for (number0 = 0; number0 < key_size; number0++) begin
                #1
                if ((blockram_message[number0] >= 65 & blockram_message[number0] <= 90) | (blockram_message[number0] >= 97 & blockram_message[number0] <= 122)) begin
                    blockram_key[number0] = blockram_original_key[number3];
                    number3++;
                end
                else begin
                    blockram_key[number0] = blockram_message[number0];
                end
            end
        end
        
        number0 = 0;
        number1 = 0;
        number2 = 0;
        
        case (flag)
            //decrypt
            1'b0: begin
                for (i = 0; i < message_size; i++) begin
                    #1
//`define replacement_offset1 65
//`define replacement_offset2 97
//`define replacement_offset3 90
//`define replacement_offset4 122
                    if  (
                            (blockram_message[i] >= `replacement_offset1 && blockram_message[i] <= `replacement_offset3) | 
                            (blockram_message[i] >= `replacement_offset2 && blockram_message[i] <= `replacement_offset4)
                        ) begin
                        
                        //normal letter
                        
                        number0 = (blockram_message[i] - blockram_key[i] + 26) % 26;
                        blockram_message_out[i] = number0 + `replacement_offset1;
                    end
                    else begin
                        blockram_message_out[i] = blockram_message[i];
                    end
                end
            end
            //encrypt
            1'b1: begin
                //LINE_SIZE
                for (i = 0; i < message_size; i++) begin
                    #1
                    
                    if (blockram_key[i] >= 65 && blockram_key[i] <= 90) begin
                        number0 = blockram_key[i] - `replacement_offset1;
                    end
                    else begin
                        number0 = blockram_key[i] - `replacement_offset2;
                    end
                    
                    case (blockram_message[i])
                        8'd65, 8'd97 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = a_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = a_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = a_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = a_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = a_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = a_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = a_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = a_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = a_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = a_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = a_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = a_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = a_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = a_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = a_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = a_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = a_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = a_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = a_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = a_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = a_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = a_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = a_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = a_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = a_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = a_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd66, 8'd98 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = b_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = b_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = b_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = b_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = b_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = b_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = b_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = b_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = b_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = b_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = b_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = b_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = b_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = b_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = b_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = b_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = b_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = b_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = b_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = b_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = b_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = b_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = b_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = b_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = b_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = b_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd67, 8'd99 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = c_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = c_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = c_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = c_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = c_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = c_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = c_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = c_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = c_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = c_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = c_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = c_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = c_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = c_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = c_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = c_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = c_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = c_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = c_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = c_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = c_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = c_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = c_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = c_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = c_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = c_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd68, 8'd100 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = d_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = d_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = d_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = d_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = d_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = d_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = d_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = d_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = d_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = d_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = d_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = d_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = d_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = d_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = d_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = d_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = d_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = d_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = d_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = d_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = d_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = d_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = d_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = d_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = d_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = d_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd69, 8'd101 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = e_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = e_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = e_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = e_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = e_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = e_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = e_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = e_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = e_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = e_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = e_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = e_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = e_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = e_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = e_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = e_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = e_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = e_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = e_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = e_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = e_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = e_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = e_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = e_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = e_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = e_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd70, 8'd102 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = f_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = f_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = f_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = f_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = f_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = f_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = f_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = f_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = f_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = f_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = f_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = f_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = f_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = f_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = f_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = f_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = f_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = f_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = f_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = f_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = f_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = f_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = f_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = f_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = f_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = f_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd71, 8'd103 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = g_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = g_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = g_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = g_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = g_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = g_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = g_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = g_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = g_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = g_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = g_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = g_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = g_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = g_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = g_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = g_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = g_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = g_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = g_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = g_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = g_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = g_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = g_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = g_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = g_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = g_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd72, 8'd104 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = h_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = h_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = h_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = h_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = h_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = h_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = h_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = h_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = h_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = h_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = h_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = h_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = h_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = h_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = h_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = h_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = h_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = h_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = h_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = h_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = h_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = h_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = h_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = h_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = h_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = h_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd73, 8'd105 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = i_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = i_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = i_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = i_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = i_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = i_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = i_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = i_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = i_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = i_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = i_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = i_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = i_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = i_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = i_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = i_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = i_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = i_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = i_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = i_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = i_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = i_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = i_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = i_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = i_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = i_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd74, 8'd106 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = j_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = j_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = j_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = j_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = j_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = j_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = j_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = j_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = j_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = j_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = j_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = j_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = j_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = j_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = j_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = j_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = j_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = j_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = j_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = j_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = j_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = j_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = j_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = j_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = j_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = j_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd75, 8'd107 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = k_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = k_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = k_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = k_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = k_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = k_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = k_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = k_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = k_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = k_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = k_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = k_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = k_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = k_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = k_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = k_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = k_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = k_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = k_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = k_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = k_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = k_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = k_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = k_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = k_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = k_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd76, 8'd108 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = l_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = l_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = l_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = l_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = l_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = l_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = l_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = l_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = l_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = l_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = l_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = l_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = l_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = l_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = l_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = l_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = l_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = l_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = l_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = l_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = l_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = l_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = l_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = l_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = l_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = l_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd77, 8'd109 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = m_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = m_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = m_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = m_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = m_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = m_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = m_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = m_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = m_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = m_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = m_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = m_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = m_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = m_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = m_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = m_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = m_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = m_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = m_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = m_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = m_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = m_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = m_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = m_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = m_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = m_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd78, 8'd110 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = n_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = n_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = n_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = n_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = n_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = n_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = n_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = n_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = n_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = n_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = n_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = n_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = n_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = n_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = n_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = n_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = n_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = n_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = n_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = n_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = n_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = n_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = n_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = n_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = n_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = n_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd79, 8'd111 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = o_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = o_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = o_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = o_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = o_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = o_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = o_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = o_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = o_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = o_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = o_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = o_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = o_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = o_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = o_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = o_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = o_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = o_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = o_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = o_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = o_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = o_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = o_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = o_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = o_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = o_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd80, 8'd112 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = p_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = p_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = p_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = p_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = p_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = p_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = p_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = p_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = p_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = p_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = p_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = p_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = p_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = p_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = p_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = p_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = p_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = p_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = p_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = p_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = p_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = p_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = p_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = p_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = p_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = p_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd81, 8'd113 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = q_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = q_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = q_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = q_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = q_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = q_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = q_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = q_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = q_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = q_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = q_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = q_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = q_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = q_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = q_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = q_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = q_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = q_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = q_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = q_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = q_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = q_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = q_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = q_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = q_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = q_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd82, 8'd114 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = r_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = r_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = r_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = r_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = r_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = r_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = r_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = r_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = r_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = r_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = r_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = r_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = r_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = r_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = r_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = r_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = r_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = r_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = r_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = r_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = r_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = r_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = r_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = r_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = r_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = r_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd83, 8'd115 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = s_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = s_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = s_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = s_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = s_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = s_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = s_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = s_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = s_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = s_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = s_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = s_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = s_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = s_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = s_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = s_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = s_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = s_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = s_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = s_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = s_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = s_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = s_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = s_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = s_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = s_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd84, 8'd116 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = t_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = t_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = t_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = t_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = t_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = t_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = t_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = t_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = t_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = t_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = t_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = t_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = t_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = t_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = t_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = t_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = t_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = t_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = t_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = t_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = t_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = t_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = t_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = t_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = t_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = t_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd85, 8'd117 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = u_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = u_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = u_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = u_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = u_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = u_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = u_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = u_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = u_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = u_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = u_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = u_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = u_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = u_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = u_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = u_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = u_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = u_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = u_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = u_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = u_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = u_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = u_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = u_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = u_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = u_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd86, 8'd118 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = v_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = v_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = v_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = v_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = v_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = v_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = v_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = v_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = v_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = v_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = v_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = v_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = v_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = v_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = v_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = v_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = v_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = v_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = v_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = v_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = v_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = v_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = v_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = v_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = v_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = v_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd87, 8'd119 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = w_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = w_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = w_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = w_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = w_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = w_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = w_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = w_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = w_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = w_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = w_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = w_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = w_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = w_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = w_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = w_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = w_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = w_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = w_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = w_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = w_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = w_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = w_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = w_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = w_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = w_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd88, 8'd120 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = x_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = x_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = x_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = x_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = x_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = x_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = x_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = x_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = x_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = x_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = x_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = x_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = x_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = x_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = x_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = x_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = x_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = x_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = x_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = x_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = x_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = x_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = x_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = x_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = x_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = x_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd89, 8'd121 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = y_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = y_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = y_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = y_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = y_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = y_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = y_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = y_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = y_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = y_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = y_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = y_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = y_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = y_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = y_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = y_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = y_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = y_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = y_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = y_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = y_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = y_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = y_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = y_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = y_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = y_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                        8'd90, 8'd122 : begin
                            case (number0)
                                0: begin
                                    blockram_message_out[i] = z_replace[`poshigh_26:`poslow_26];
                                end
                                1: begin
                                    blockram_message_out[i] = z_replace[`poshigh_25:`poslow_25];
                                end
                                2: begin
                                    blockram_message_out[i] = z_replace[`poshigh_24:`poslow_24];
                                end
                                3: begin
                                    blockram_message_out[i] = z_replace[`poshigh_23:`poslow_23];
                                end
                                4: begin
                                    blockram_message_out[i] = z_replace[`poshigh_22:`poslow_22];
                                end
                                5: begin
                                    blockram_message_out[i] = z_replace[`poshigh_21:`poslow_21];
                                end
                                6: begin
                                    blockram_message_out[i] = z_replace[`poshigh_20:`poslow_20];
                                end
                                7: begin
                                    blockram_message_out[i] = z_replace[`poshigh_19:`poslow_19];
                                end
                                8: begin
                                    blockram_message_out[i] = z_replace[`poshigh_18:`poslow_18];
                                end
                                9: begin
                                    blockram_message_out[i] = z_replace[`poshigh_17:`poslow_17];
                                end
                                10: begin
                                    blockram_message_out[i] = z_replace[`poshigh_16:`poslow_16];
                                end
                                11: begin
                                    blockram_message_out[i] = z_replace[`poshigh_15:`poslow_15];
                                end
                                12: begin
                                    blockram_message_out[i] = z_replace[`poshigh_14:`poslow_14];
                                end
                                13: begin
                                    blockram_message_out[i] = z_replace[`poshigh_13:`poslow_13];
                                end
                                14: begin
                                    blockram_message_out[i] = z_replace[`poshigh_12:`poslow_12];
                                end
                                15: begin
                                    blockram_message_out[i] = z_replace[`poshigh_11:`poslow_11];
                                end
                                16: begin
                                    blockram_message_out[i] = z_replace[`poshigh_10:`poslow_10];
                                end
                                17: begin
                                    blockram_message_out[i] = z_replace[`poshigh_9:`poslow_9];
                                end
                                18: begin
                                    blockram_message_out[i] = z_replace[`poshigh_8:`poslow_8];
                                end
                                19: begin
                                    blockram_message_out[i] = z_replace[`poshigh_7:`poslow_7];
                                end
                                20: begin
                                    blockram_message_out[i] = z_replace[`poshigh_6:`poslow_6];
                                end
                                21: begin
                                    blockram_message_out[i] = z_replace[`poshigh_5:`poslow_5];
                                end
                                22: begin
                                    blockram_message_out[i] = z_replace[`poshigh_4:`poslow_4];
                                end
                                23: begin
                                    blockram_message_out[i] = z_replace[`poshigh_3:`poslow_3];
                                end
                                24: begin
                                    blockram_message_out[i] = z_replace[`poshigh_2:`poslow_2];
                                end
                                25: begin
                                    blockram_message_out[i] = z_replace[`poshigh_1:`poslow_1];
                                end
                            endcase
                        end
                    endcase
                end
            end
        endcase
                
        message_out[`pos_1] = blockram_message_out[0];
        message_out[`pos_2] = blockram_message_out[1];
        message_out[`pos_3] = blockram_message_out[2];
        message_out[`pos_4] = blockram_message_out[3];
        message_out[`pos_5] = blockram_message_out[4];
        message_out[`pos_6] = blockram_message_out[5];
        message_out[`pos_7] = blockram_message_out[6];
        message_out[`pos_8] = blockram_message_out[7];
        message_out[`pos_9] = blockram_message_out[8];
        message_out[`pos_10] = blockram_message_out[9];
        message_out[`pos_11] = blockram_message_out[10];
        message_out[`pos_12] = blockram_message_out[11];
        message_out[`pos_13] = blockram_message_out[12];
        message_out[`pos_14] = blockram_message_out[13];
        message_out[`pos_15] = blockram_message_out[14];
        message_out[`pos_16] = blockram_message_out[15];
        message_out[`pos_17] = blockram_message_out[16];
        message_out[`pos_18] = blockram_message_out[17];
        message_out[`pos_19] = blockram_message_out[18];
        message_out[`pos_20] = blockram_message_out[19];
        message_out[`pos_21] = blockram_message_out[20];
        message_out[`pos_22] = blockram_message_out[21];
        message_out[`pos_23] = blockram_message_out[22];
        message_out[`pos_24] = blockram_message_out[23];
        message_out[`pos_25] = blockram_message_out[24];
        message_out[`pos_26] = blockram_message_out[25];
        message_out[`pos_27] = blockram_message_out[26];
        message_out[`pos_28] = blockram_message_out[27];
        message_out[`pos_29] = blockram_message_out[28];
        message_out[`pos_30] = blockram_message_out[29];
        message_out[`pos_31] = blockram_message_out[30];
        message_out[`pos_32] = blockram_message_out[31];
        message_out[`pos_33] = blockram_message_out[32];
        message_out[`pos_34] = blockram_message_out[33];
        message_out[`pos_35] = blockram_message_out[34];
        message_out[`pos_36] = blockram_message_out[35];
        message_out[`pos_37] = blockram_message_out[36];
        message_out[`pos_38] = blockram_message_out[37];
        message_out[`pos_39] = blockram_message_out[38];
        message_out[`pos_40] = blockram_message_out[39];
        message_out[`pos_41] = blockram_message_out[40];
        message_out[`pos_42] = blockram_message_out[41];
        message_out[`pos_43] = blockram_message_out[42];
        message_out[`pos_44] = blockram_message_out[43];
        message_out[`pos_45] = blockram_message_out[44];
        message_out[`pos_46] = blockram_message_out[45];
        message_out[`pos_47] = blockram_message_out[46];
        message_out[`pos_48] = blockram_message_out[47];
        message_out[`pos_49] = blockram_message_out[48];
        message_out[`pos_50] = blockram_message_out[49];
        message_out[`pos_51] = blockram_message_out[50];
        message_out[`pos_52] = blockram_message_out[51];
        message_out[`pos_53] = blockram_message_out[52];
        message_out[`pos_54] = blockram_message_out[53];
        message_out[`pos_55] = blockram_message_out[54];
        message_out[`pos_56] = blockram_message_out[55];
        message_out[`pos_57] = blockram_message_out[56];
        message_out[`pos_58] = blockram_message_out[57];
        message_out[`pos_59] = blockram_message_out[58];
        message_out[`pos_60] = blockram_message_out[59];
        message_out[`pos_61] = blockram_message_out[60];
        message_out[`pos_62] = blockram_message_out[61];
        message_out[`pos_63] = blockram_message_out[62];
        message_out[`pos_64] = blockram_message_out[63];
        message_out[`pos_65] = blockram_message_out[64];
        message_out[`pos_66] = blockram_message_out[65];
        message_out[`pos_67] = blockram_message_out[66];
        message_out[`pos_68] = blockram_message_out[67];
        message_out[`pos_69] = blockram_message_out[68];
        message_out[`pos_70] = blockram_message_out[69];
        message_out[`pos_71] = blockram_message_out[70];
        message_out[`pos_72] = blockram_message_out[71];
        message_out[`pos_73] = blockram_message_out[72];
        message_out[`pos_74] = blockram_message_out[73];
        message_out[`pos_75] = blockram_message_out[74];
        message_out[`pos_76] = blockram_message_out[75];
        message_out[`pos_77] = blockram_message_out[76];
        message_out[`pos_78] = blockram_message_out[77];
        message_out[`pos_79] = blockram_message_out[78];
        message_out[`pos_80] = blockram_message_out[79];
        
        done = 1;
    end
    
endmodule