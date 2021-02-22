`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2021 01:18:42 PM
// Design Name: 
// Module Name: vignere_tb
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

module vignere_tb();

    //READ the character replacement file in
    parameter REPLACEMENT_LINE_AMOUNT = 27;
    parameter ASCII_ELEMENT_SIZE = 8;
    parameter REPLACEMENT_FILE_LINE_SIZE = REPLACEMENT_LINE_AMOUNT * ASCII_ELEMENT_SIZE;//215
    reg [REPLACEMENT_FILE_LINE_SIZE-1:0] file_text [REPLACEMENT_LINE_AMOUNT-1:0];
    integer line_counter = REPLACEMENT_LINE_AMOUNT-1;
    integer data_file, scan_file;
    
    //read the plaintext and the user
    parameter MAX_PLAINTEXT_CHAR_LENGTH = 80;
    integer input_data_file, input_scan_file, out_file;
    integer input_data_file_counter = 0;
    reg flag;
    
    reg [7:0] plaintext_block [79:0];
    reg [7:0] plaintext_block2 [79:0];
    
    reg [MAX_PLAINTEXT_CHAR_LENGTH*8-1:0] plaintext;   
    wire [MAX_PLAINTEXT_CHAR_LENGTH*8-1:0] plaintext2;
    
    assign plaintext2 = { plaintext_block2[0], plaintext_block2[1], plaintext_block2[2], plaintext_block2[3], plaintext_block2[4], plaintext_block2[5], plaintext_block2[6], plaintext_block2[7], plaintext_block2[8], plaintext_block2[9],
                            plaintext_block2[10], plaintext_block2[11], plaintext_block2[12], plaintext_block2[13], plaintext_block2[14], plaintext_block2[15], plaintext_block2[16], plaintext_block2[17], plaintext_block2[18], plaintext_block2[19],
                            plaintext_block2[20], plaintext_block2[21], plaintext_block2[22], plaintext_block2[23], plaintext_block2[24], plaintext_block2[25], plaintext_block2[26], plaintext_block2[27], plaintext_block2[28], plaintext_block2[29],
                            plaintext_block2[30], plaintext_block2[31], plaintext_block2[32], plaintext_block2[33], plaintext_block2[34], plaintext_block2[35], plaintext_block2[36], plaintext_block2[37], plaintext_block2[38], plaintext_block2[39],
                            plaintext_block2[40], plaintext_block2[41], plaintext_block2[42], plaintext_block2[43], plaintext_block2[44], plaintext_block2[45], plaintext_block2[46], plaintext_block2[47], plaintext_block2[48], plaintext_block2[49],
                            plaintext_block2[50], plaintext_block2[51], plaintext_block2[52], plaintext_block2[53], plaintext_block2[54], plaintext_block2[55], plaintext_block2[56], plaintext_block2[57], plaintext_block2[58], plaintext_block2[59],
                            plaintext_block2[60], plaintext_block2[61], plaintext_block2[62], plaintext_block2[63], plaintext_block2[64], plaintext_block2[65], plaintext_block2[66], plaintext_block2[67], plaintext_block2[68], plaintext_block2[69],
                            plaintext_block2[70], plaintext_block2[71], plaintext_block2[72], plaintext_block2[73], plaintext_block2[74], plaintext_block2[75], plaintext_block2[76], plaintext_block2[77], plaintext_block2[78], plaintext_block2[79]
                        };

    reg [0:MAX_PLAINTEXT_CHAR_LENGTH*8-1] message_out;
    //reg [0:MAX_PLAINTEXT_CHAR_LENGTH*8-1] reverse_message_out;
    reg [7:0] reverse_message_out [MAX_PLAINTEXT_CHAR_LENGTH-1:0];
    
    reg [7:0] userkey_reg [MAX_PLAINTEXT_CHAR_LENGTH-1:0];
    wire [MAX_PLAINTEXT_CHAR_LENGTH*8-1:0] userkey_reg2;
    reg [7:0] plaintext_counter, plaintext_counter2;
    string userkey;
    
    assign userkey_reg2 = { userkey_reg[0], userkey_reg[1], userkey_reg[2], userkey_reg[3], userkey_reg[4], userkey_reg[5], userkey_reg[6], userkey_reg[7], userkey_reg[8], userkey_reg[9],
                            userkey_reg[10], userkey_reg[11], userkey_reg[12], userkey_reg[13], userkey_reg[14], userkey_reg[15], userkey_reg[16], userkey_reg[17], userkey_reg[18], userkey_reg[19],
                            userkey_reg[20], userkey_reg[21], userkey_reg[22], userkey_reg[23], userkey_reg[24], userkey_reg[25], userkey_reg[26], userkey_reg[27], userkey_reg[28], userkey_reg[29],
                            userkey_reg[30], userkey_reg[31], userkey_reg[32], userkey_reg[33], userkey_reg[34], userkey_reg[35], userkey_reg[36], userkey_reg[37], userkey_reg[38], userkey_reg[39],
                            userkey_reg[40], userkey_reg[41], userkey_reg[42], userkey_reg[43], userkey_reg[44], userkey_reg[45], userkey_reg[46], userkey_reg[47], userkey_reg[48], userkey_reg[49],
                            userkey_reg[50], userkey_reg[51], userkey_reg[52], userkey_reg[53], userkey_reg[54], userkey_reg[55], userkey_reg[56], userkey_reg[57], userkey_reg[58], userkey_reg[59],
                            userkey_reg[60], userkey_reg[61], userkey_reg[62], userkey_reg[63], userkey_reg[64], userkey_reg[65], userkey_reg[66], userkey_reg[67], userkey_reg[68], userkey_reg[69],
                            userkey_reg[70], userkey_reg[71], userkey_reg[72], userkey_reg[73], userkey_reg[74], userkey_reg[75], userkey_reg[76], userkey_reg[77], userkey_reg[78], userkey_reg[79]
                        };
    
    reg [7:0] plaintext_size;
    reg [7:0] userkey_size;
     
    reg character_replacement_read = 1'b0;
    reg user_instructions_read = 1'b0;
    
    reg start = 1'b0;
    wire done;
    
    vignere vignere_uut(
        .start(start),
        .flag(flag),
        .key(userkey_reg2),
        .message_in(plaintext2),
        .message_size(plaintext_size),
        .key_size(userkey_size),        
        .a_replace(file_text[25]),
        .b_replace(file_text[24]),
        .c_replace(file_text[23]),
        .d_replace(file_text[22]),
        .e_replace(file_text[21]),
        .f_replace(file_text[20]),
        .g_replace(file_text[19]),
        .h_replace(file_text[18]),
        .i_replace(file_text[17]),
        .j_replace(file_text[16]),
        .k_replace(file_text[15]),
        .l_replace(file_text[14]),
        .m_replace(file_text[13]),
        .n_replace(file_text[12]),
        .o_replace(file_text[11]),
        .p_replace(file_text[10]),
        .q_replace(file_text[9]),
        .r_replace(file_text[8]),
        .s_replace(file_text[7]),
        .t_replace(file_text[6]),
        .u_replace(file_text[5]),
        .v_replace(file_text[4]),
        .w_replace(file_text[3]),
        .x_replace(file_text[2]),
        .y_replace(file_text[1]),
        .z_replace(file_text[0]),            
        .message_out(message_out),
        .done(done)
        );
    
    initial begin
        
        input_data_file = $fopen("in.txt", "r");
        if (!input_data_file) begin
            $display("Error Opening File for Read");
            $finish;
        end
        
        out_file = $fopen("./out.txt", "w");
        if (!out_file) begin
            $display("Error Opening File for Write");
            $finish;
        end
        
        data_file = $fopen("replacement.mem", "r");
        if (!data_file) begin
            $display("Error Opening File for Read");
            $finish;
        end
        
        repeat(REPLACEMENT_LINE_AMOUNT)
			while(!$feof(data_file))begin
				scan_file = $fscanf(data_file, "%c %c %c %c %c %c %c %c %c %c %c %c %c %c %c %c %c %c %c %c %c %c %c %c %c %c %c\n",				
				file_text[line_counter][215:208],   file_text[line_counter][207:200],   file_text[line_counter][199:192],   file_text[line_counter][191:184],
				file_text[line_counter][183:176],   file_text[line_counter][175:168],   file_text[line_counter][167:160],   file_text[line_counter][159:152],
				file_text[line_counter][151:144],   file_text[line_counter][143:136],   file_text[line_counter][135:128],   file_text[line_counter][127:120],
				file_text[line_counter][119:112],   file_text[line_counter][111:104],   file_text[line_counter][103:96],    file_text[line_counter][95:88],
				file_text[line_counter][87:80],     file_text[line_counter][79:72],     file_text[line_counter][71:64],     file_text[line_counter][63:56],
				file_text[line_counter][55:48],     file_text[line_counter][47:40],     file_text[line_counter][39:32],     file_text[line_counter][31:24],
				file_text[line_counter][23:16],     file_text[line_counter][15:8],      file_text[line_counter][7:0]);
				line_counter = line_counter - 1;
			end
			        
        character_replacement_read = 1'b1;
        
        //repeat(2)
            while(!$feof(input_data_file) && input_data_file_counter < 2)begin
                if (input_data_file_counter == 0) begin
                    input_scan_file = $fscanf(input_data_file, "%b %s", flag, userkey);
                    userkey_size = userkey.len();
                    
                    for (int i = 0; i < userkey_size; i++) begin
                        userkey_reg[i] = userkey[i];
                    end
                end
                else begin
                    plaintext_size = $fread(plaintext, input_data_file);
                end
                #1
                input_data_file_counter = input_data_file_counter + 1;
            end
        
        #1
        plaintext_block[0] = plaintext[`pos_1];
        plaintext_block[1] = plaintext[`pos_2];
        plaintext_block[2] = plaintext[`pos_3];
        plaintext_block[3] = plaintext[`pos_4];
        plaintext_block[4] = plaintext[`pos_5];
        plaintext_block[5] = plaintext[`pos_6];
        plaintext_block[6] = plaintext[`pos_7];
        plaintext_block[7] = plaintext[`pos_8];
        plaintext_block[8] = plaintext[`pos_9];
        plaintext_block[9] = plaintext[`pos_10];
        plaintext_block[10] = plaintext[`pos_11];
        plaintext_block[11] = plaintext[`pos_12];
        plaintext_block[12] = plaintext[`pos_13];
        plaintext_block[13] = plaintext[`pos_14];
        plaintext_block[14] = plaintext[`pos_15];
        plaintext_block[15] = plaintext[`pos_16];
        plaintext_block[16] = plaintext[`pos_17];
        plaintext_block[17] = plaintext[`pos_18];
        plaintext_block[18] = plaintext[`pos_19];
        plaintext_block[19] = plaintext[`pos_20];
        plaintext_block[20] = plaintext[`pos_21];
        plaintext_block[21] = plaintext[`pos_22];
        plaintext_block[22] = plaintext[`pos_23];
        plaintext_block[23] = plaintext[`pos_24];
        plaintext_block[24] = plaintext[`pos_25];
        plaintext_block[25] = plaintext[`pos_26];
        plaintext_block[26] = plaintext[`pos_27];
        plaintext_block[27] = plaintext[`pos_28];
        plaintext_block[28] = plaintext[`pos_29];
        plaintext_block[29] = plaintext[`pos_30];
        plaintext_block[30] = plaintext[`pos_31];
        plaintext_block[31] = plaintext[`pos_32];
        plaintext_block[32] = plaintext[`pos_33];
        plaintext_block[33] = plaintext[`pos_34];
        plaintext_block[34] = plaintext[`pos_35];
        plaintext_block[35] = plaintext[`pos_36];
        plaintext_block[36] = plaintext[`pos_37];
        plaintext_block[37] = plaintext[`pos_38];
        plaintext_block[38] = plaintext[`pos_39];
        plaintext_block[39] = plaintext[`pos_40];
        plaintext_block[40] = plaintext[`pos_41];
        plaintext_block[41] = plaintext[`pos_42];
        plaintext_block[42] = plaintext[`pos_43];
        plaintext_block[43] = plaintext[`pos_44];
        plaintext_block[44] = plaintext[`pos_45];
        plaintext_block[45] = plaintext[`pos_46];
        plaintext_block[46] = plaintext[`pos_47];
        plaintext_block[47] = plaintext[`pos_48];
        plaintext_block[48] = plaintext[`pos_49];
        plaintext_block[49] = plaintext[`pos_50];
        plaintext_block[50] = plaintext[`pos_51];
        plaintext_block[51] = plaintext[`pos_52];
        plaintext_block[52] = plaintext[`pos_53];
        plaintext_block[53] = plaintext[`pos_54];
        plaintext_block[54] = plaintext[`pos_55];
        plaintext_block[55] = plaintext[`pos_56];
        plaintext_block[56] = plaintext[`pos_57];
        plaintext_block[57] = plaintext[`pos_58];
        plaintext_block[58] = plaintext[`pos_59];
        plaintext_block[59] = plaintext[`pos_60];
        plaintext_block[60] = plaintext[`pos_61];
        plaintext_block[61] = plaintext[`pos_62];
        plaintext_block[62] = plaintext[`pos_63];
        plaintext_block[63] = plaintext[`pos_64];
        plaintext_block[64] = plaintext[`pos_65];
        plaintext_block[65] = plaintext[`pos_66];
        plaintext_block[66] = plaintext[`pos_67];
        plaintext_block[67] = plaintext[`pos_68];
        plaintext_block[68] = plaintext[`pos_69];
        plaintext_block[69] = plaintext[`pos_70];
        plaintext_block[70] = plaintext[`pos_71];
        plaintext_block[71] = plaintext[`pos_72];
        plaintext_block[72] = plaintext[`pos_73];
        plaintext_block[73] = plaintext[`pos_74];
        plaintext_block[74] = plaintext[`pos_75];
        plaintext_block[75] = plaintext[`pos_76];
        plaintext_block[76] = plaintext[`pos_77];
        plaintext_block[77] = plaintext[`pos_78];
        plaintext_block[78] = plaintext[`pos_79];
        plaintext_block[79] = plaintext[`pos_80];

        plaintext_counter2 = 0;
        for (plaintext_counter = plaintext_size-1; plaintext_counter > 0; plaintext_counter--) begin
            plaintext_block2[plaintext_counter2] = plaintext_block[plaintext_counter-1];
            plaintext_counter2++;
        end
        
        start = 1'b1;
        #4
        user_instructions_read = 1'b1;
    end
    
    reg [10:0] write_counter;
    reg [7:0] write_reg;
    
    always @(*) begin
        if (done) begin
            //write to file
            //`define pos_1 7:0
//            `define pos_2 15:8
//            `define pos_3 23:16
//            `define pos_4 31:24
//            `define pos_5 39:32
            //`define pos_80 639:632
            
            reverse_message_out[0] = message_out[`poslow_1:`poshigh_1];
            reverse_message_out[1] = message_out[`poslow_2:`poshigh_2];
            reverse_message_out[2] = message_out[`poslow_3:`poshigh_3];
            reverse_message_out[3] = message_out[`poslow_4:`poshigh_4];
            reverse_message_out[4] = message_out[`poslow_5:`poshigh_5];
            reverse_message_out[5] = message_out[`poslow_6:`poshigh_6];
            reverse_message_out[6] = message_out[`poslow_7:`poshigh_7];
            reverse_message_out[7] = message_out[`poslow_8:`poshigh_8];
            reverse_message_out[8] = message_out[`poslow_9:`poshigh_9];
            reverse_message_out[9] = message_out[`poslow_10:`poshigh_10];
            reverse_message_out[10] = message_out[`poslow_11:`poshigh_11];
            reverse_message_out[11] = message_out[`poslow_12:`poshigh_12];
            reverse_message_out[12] = message_out[`poslow_13:`poshigh_13];
            reverse_message_out[13] = message_out[`poslow_14:`poshigh_14];
            reverse_message_out[14] = message_out[`poslow_15:`poshigh_15];
            reverse_message_out[15] = message_out[`poslow_16:`poshigh_16];
            reverse_message_out[16] = message_out[`poslow_17:`poshigh_17];
            reverse_message_out[17] = message_out[`poslow_18:`poshigh_18];
            reverse_message_out[18] = message_out[`poslow_19:`poshigh_19];
            reverse_message_out[19] = message_out[`poslow_20:`poshigh_20];
            reverse_message_out[20] = message_out[`poslow_21:`poshigh_21];
            reverse_message_out[21] = message_out[`poslow_22:`poshigh_22];
            reverse_message_out[22] = message_out[`poslow_23:`poshigh_23];
            reverse_message_out[23] = message_out[`poslow_24:`poshigh_24];
            reverse_message_out[24] = message_out[`poslow_25:`poshigh_25];
            reverse_message_out[25] = message_out[`poslow_26:`poshigh_26];
            reverse_message_out[26] = message_out[`poslow_27:`poshigh_27];
            reverse_message_out[27] = message_out[`poslow_28:`poshigh_28];
            reverse_message_out[28] = message_out[`poslow_29:`poshigh_29];
            reverse_message_out[29] = message_out[`poslow_30:`poshigh_30];
            reverse_message_out[30] = message_out[`poslow_31:`poshigh_31];
            reverse_message_out[31] = message_out[`poslow_32:`poshigh_32];
            reverse_message_out[32] = message_out[`poslow_33:`poshigh_33];
            reverse_message_out[33] = message_out[`poslow_34:`poshigh_34];
            reverse_message_out[34] = message_out[`poslow_35:`poshigh_35];
            reverse_message_out[35] = message_out[`poslow_36:`poshigh_36];
            reverse_message_out[36] = message_out[`poslow_37:`poshigh_37];
            reverse_message_out[37] = message_out[`poslow_38:`poshigh_38];
            reverse_message_out[38] = message_out[`poslow_39:`poshigh_39];
            reverse_message_out[39] = message_out[`poslow_40:`poshigh_40];
            reverse_message_out[40] = message_out[`poslow_41:`poshigh_41];
            reverse_message_out[41] = message_out[`poslow_42:`poshigh_42];
            reverse_message_out[42] = message_out[`poslow_43:`poshigh_43];
            reverse_message_out[43] = message_out[`poslow_44:`poshigh_44];
            reverse_message_out[44] = message_out[`poslow_45:`poshigh_45];
            reverse_message_out[45] = message_out[`poslow_46:`poshigh_46];
            reverse_message_out[46] = message_out[`poslow_47:`poshigh_47];
            reverse_message_out[47] = message_out[`poslow_48:`poshigh_48];
            reverse_message_out[48] = message_out[`poslow_49:`poshigh_49];
            reverse_message_out[49] = message_out[`poslow_50:`poshigh_50];
            reverse_message_out[50] = message_out[`poslow_51:`poshigh_51];
            reverse_message_out[51] = message_out[`poslow_52:`poshigh_52];
            reverse_message_out[52] = message_out[`poslow_53:`poshigh_53];
            reverse_message_out[53] = message_out[`poslow_54:`poshigh_54];
            reverse_message_out[54] = message_out[`poslow_55:`poshigh_55];
            reverse_message_out[55] = message_out[`poslow_56:`poshigh_56];
            reverse_message_out[56] = message_out[`poslow_57:`poshigh_57];
            reverse_message_out[57] = message_out[`poslow_58:`poshigh_58];
            reverse_message_out[58] = message_out[`poslow_59:`poshigh_59];
            reverse_message_out[59] = message_out[`poslow_60:`poshigh_60];
            reverse_message_out[60] = message_out[`poslow_61:`poshigh_61];
            reverse_message_out[61] = message_out[`poslow_62:`poshigh_62];
            reverse_message_out[62] = message_out[`poslow_63:`poshigh_63];
            reverse_message_out[63] = message_out[`poslow_64:`poshigh_64];
            reverse_message_out[64] = message_out[`poslow_65:`poshigh_65];
            reverse_message_out[65] = message_out[`poslow_66:`poshigh_66];
            reverse_message_out[66] = message_out[`poslow_67:`poshigh_67];
            reverse_message_out[67] = message_out[`poslow_68:`poshigh_68];
            reverse_message_out[68] = message_out[`poslow_69:`poshigh_69];
            reverse_message_out[69] = message_out[`poslow_70:`poshigh_70];
            reverse_message_out[70] = message_out[`poslow_71:`poshigh_71];
            reverse_message_out[71] = message_out[`poslow_72:`poshigh_72];
            reverse_message_out[72] = message_out[`poslow_73:`poshigh_73];
            reverse_message_out[73] = message_out[`poslow_74:`poshigh_74];
            reverse_message_out[74] = message_out[`poslow_75:`poshigh_75];
            reverse_message_out[75] = message_out[`poslow_76:`poshigh_76];
            reverse_message_out[76] = message_out[`poslow_77:`poshigh_77];
            reverse_message_out[77] = message_out[`poslow_78:`poshigh_78];
            reverse_message_out[78] = message_out[`poslow_79:`poshigh_79];
            reverse_message_out[79] = message_out[`poslow_80:`poshigh_80];
            
            
//            for (write_counter = 80; write_counter > 0; write_counter--) begin
//                write_reg = reverse_message_out[write_counter-1];
//                $fputc(out_file, "%c", write_reg);
//            end
            
            $finish;
        end
    end

endmodule