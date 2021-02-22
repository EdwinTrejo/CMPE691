`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2021 07:20:51 PM
// Design Name: 
// Module Name: crack_Vigenere
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

`define MAX_SIZE 80*4*8
`define MAX_LINE_SIZE 80*8
`define MAX_WORD_SIZE 8*8
`define MAX_WORD_AMOUNT 5

`define MAX_CHAR_AMOUNT 320
`define MAX_BLOCK_AMOUNT 40

`define replacement_offset1 65
`define replacement_offset2 97
`define replacement_offset3 90
`define replacement_offset4 122

module crack_Vigenere(
  input wire start,

  input wire [`MAX_CHAR_AMOUNT-1:0] line1,
  input wire [`MAX_CHAR_AMOUNT-1:0] line2,
  input wire [`MAX_CHAR_AMOUNT-1:0] line3,
  input wire [`MAX_CHAR_AMOUNT-1:0] line4,

  input wire [15:0] line1_words,
  input wire [15:0] line2_words,

  output reg [`MAX_LINE_SIZE-1:0] key,
  output reg done
);

  reg [7:0] line1_block [`MAX_BLOCK_AMOUNT-1:0];
  reg [7:0] line2_block [`MAX_BLOCK_AMOUNT-1:0];
  reg [7:0] line3_block [`MAX_BLOCK_AMOUNT-1:0];
  reg [7:0] line4_block [`MAX_BLOCK_AMOUNT-1:0];

  reg [7:0] key1 [`MAX_BLOCK_AMOUNT-1:0];
  reg [7:0] key2 [`MAX_BLOCK_AMOUNT-1:0];
  reg [7:0] return_key [79:0];

  reg [15:0] i;
  reg [7:0] number1;
  reg [7:0] number2;
  reg [7:0] number3;

  reg [7:0] key1len;
  reg [7:0] key2len;
  reg [7:0] key1lenb;
  reg [7:0] key2lenb;

  reg [7:0] advance_key1_reg1;
  reg [7:0] advance_key1_reg2;
  reg [7:0] advance_key1_reg3;
  reg [7:0] advance_key2_reg1;
  reg [7:0] advance_key2_reg2;
  reg [7:0] advance_key2_reg3;

  reg [7:0] keylet1;
  reg [7:0] keylet2;
  reg [7:0] keylet3;

  reg [7:0] key_finder_counter = 0;
  reg [7:0] key_finder_counter_ahead1 = 0;
  reg [7:0] key_finder_counter_ahead2 = 0;
  reg [7:0] key_finder_counter_ahead3 = 0;

  always @(start) begin
    done = 0;
    number3 = 0;
    key1len = 0;
    key2len = 0;

    line1_block[0] = line1[7:0]; line1_block[1] = line1[15:8]; line1_block[2] = line1[23:16]; line1_block[3] = line1[31:24]; line1_block[4] = line1[39:32]; line1_block[5] = line1[47:40]; line1_block[6] = line1[55:48]; line1_block[7] = line1[63:56]; line1_block[8] = line1[71:64]; line1_block[9] = line1[79:72]; line1_block[10] = line1[87:80]; line1_block[11] = line1[95:88]; line1_block[12] = line1[103:96]; line1_block[13] = line1[111:104]; line1_block[14] = line1[119:112]; line1_block[15] = line1[127:120]; line1_block[16] = line1[135:128]; line1_block[17] = line1[143:136]; line1_block[18] = line1[151:144]; line1_block[19] = line1[159:152]; line1_block[20] = line1[167:160]; line1_block[21] = line1[175:168]; line1_block[22] = line1[183:176]; line1_block[23] = line1[191:184]; line1_block[24] = line1[199:192]; line1_block[25] = line1[207:200]; line1_block[26] = line1[215:208]; line1_block[27] = line1[223:216]; line1_block[28] = line1[231:224]; line1_block[29] = line1[239:232]; line1_block[30] = line1[247:240]; line1_block[31] = line1[255:248]; line1_block[32] = line1[263:256]; line1_block[33] = line1[271:264]; line1_block[34] = line1[279:272]; line1_block[35] = line1[287:280]; line1_block[36] = line1[295:288]; line1_block[37] = line1[303:296]; line1_block[38] = line1[311:304]; line1_block[39] = line1[319:312];
    line2_block[0] = line2[7:0]; line2_block[1] = line2[15:8]; line2_block[2] = line2[23:16]; line2_block[3] = line2[31:24]; line2_block[4] = line2[39:32]; line2_block[5] = line2[47:40]; line2_block[6] = line2[55:48]; line2_block[7] = line2[63:56]; line2_block[8] = line2[71:64]; line2_block[9] = line2[79:72]; line2_block[10] = line2[87:80]; line2_block[11] = line2[95:88]; line2_block[12] = line2[103:96]; line2_block[13] = line2[111:104]; line2_block[14] = line2[119:112]; line2_block[15] = line2[127:120]; line2_block[16] = line2[135:128]; line2_block[17] = line2[143:136]; line2_block[18] = line2[151:144]; line2_block[19] = line2[159:152]; line2_block[20] = line2[167:160]; line2_block[21] = line2[175:168]; line2_block[22] = line2[183:176]; line2_block[23] = line2[191:184]; line2_block[24] = line2[199:192]; line2_block[25] = line2[207:200]; line2_block[26] = line2[215:208]; line2_block[27] = line2[223:216]; line2_block[28] = line2[231:224]; line2_block[29] = line2[239:232]; line2_block[30] = line2[247:240]; line2_block[31] = line2[255:248]; line2_block[32] = line2[263:256]; line2_block[33] = line2[271:264]; line2_block[34] = line2[279:272]; line2_block[35] = line2[287:280]; line2_block[36] = line2[295:288]; line2_block[37] = line2[303:296]; line2_block[38] = line2[311:304]; line2_block[39] = line2[319:312];
    line3_block[0] = line3[7:0]; line3_block[1] = line3[15:8]; line3_block[2] = line3[23:16]; line3_block[3] = line3[31:24]; line3_block[4] = line3[39:32]; line3_block[5] = line3[47:40]; line3_block[6] = line3[55:48]; line3_block[7] = line3[63:56]; line3_block[8] = line3[71:64]; line3_block[9] = line3[79:72]; line3_block[10] = line3[87:80]; line3_block[11] = line3[95:88]; line3_block[12] = line3[103:96]; line3_block[13] = line3[111:104]; line3_block[14] = line3[119:112]; line3_block[15] = line3[127:120]; line3_block[16] = line3[135:128]; line3_block[17] = line3[143:136]; line3_block[18] = line3[151:144]; line3_block[19] = line3[159:152]; line3_block[20] = line3[167:160]; line3_block[21] = line3[175:168]; line3_block[22] = line3[183:176]; line3_block[23] = line3[191:184]; line3_block[24] = line3[199:192]; line3_block[25] = line3[207:200]; line3_block[26] = line3[215:208]; line3_block[27] = line3[223:216]; line3_block[28] = line3[231:224]; line3_block[29] = line3[239:232]; line3_block[30] = line3[247:240]; line3_block[31] = line3[255:248]; line3_block[32] = line3[263:256]; line3_block[33] = line3[271:264]; line3_block[34] = line3[279:272]; line3_block[35] = line3[287:280]; line3_block[36] = line3[295:288]; line3_block[37] = line3[303:296]; line3_block[38] = line3[311:304]; line3_block[39] = line3[319:312];
    line4_block[0] = line4[7:0]; line4_block[1] = line4[15:8]; line4_block[2] = line4[23:16]; line4_block[3] = line4[31:24]; line4_block[4] = line4[39:32]; line4_block[5] = line4[47:40]; line4_block[6] = line4[55:48]; line4_block[7] = line4[63:56]; line4_block[8] = line4[71:64]; line4_block[9] = line4[79:72]; line4_block[10] = line4[87:80]; line4_block[11] = line4[95:88]; line4_block[12] = line4[103:96]; line4_block[13] = line4[111:104]; line4_block[14] = line4[119:112]; line4_block[15] = line4[127:120]; line4_block[16] = line4[135:128]; line4_block[17] = line4[143:136]; line4_block[18] = line4[151:144]; line4_block[19] = line4[159:152]; line4_block[20] = line4[167:160]; line4_block[21] = line4[175:168]; line4_block[22] = line4[183:176]; line4_block[23] = line4[191:184]; line4_block[24] = line4[199:192]; line4_block[25] = line4[207:200]; line4_block[26] = line4[215:208]; line4_block[27] = line4[223:216]; line4_block[28] = line4[231:224]; line4_block[29] = line4[239:232]; line4_block[30] = line4[247:240]; line4_block[31] = line4[255:248]; line4_block[32] = line4[263:256]; line4_block[33] = line4[271:264]; line4_block[34] = line4[279:272]; line4_block[35] = line4[287:280]; line4_block[36] = line4[295:288]; line4_block[37] = line4[303:296]; line4_block[38] = line4[311:304]; line4_block[39] = line4[319:312];

    for (i=0;i<80;i++) begin
      return_key[i] = 8'h00;
    end

    i = 0;
    //check lines 1 and lines 2 individually
    //`MAX_WORD_SIZE*`MAX_WORD_AMOUNT
    for (i=0; i<`MAX_BLOCK_AMOUNT; i++) begin
      #1
      if  (
        ((line1_block[i] >= `replacement_offset1 && line1_block[i] <= `replacement_offset3) | (line1_block[i] >= `replacement_offset2 && line1_block[i] <= `replacement_offset4)) &
        ((line2_block[i] >= `replacement_offset1 && line2_block[i] <= `replacement_offset3) | (line2_block[i] >= `replacement_offset2 && line2_block[i] <= `replacement_offset4))
      ) begin

        //plaintext
        if ((line1_block[i] >= `replacement_offset1 && line1_block[i] <= `replacement_offset3)) begin
          number1 = line1_block[i] + 32;
        end
        else begin
          number1 = line1_block[i];
        end
        //cyphertext
        if ((line2_block[i] >= `replacement_offset1 && line2_block[i] <= `replacement_offset3)) begin
          number2 = line2_block[i] + 32;
        end
        else begin
          number2 = line2_block[i];
        end
        //number0 = (blockram_message[i] - blockram_key[i] + 26) % 26;
        //number1 plaintext
        //mumber2 cyphertext
        key1[number3] = ((number2 - number1 + 26) % 26) + `replacement_offset1;
        #1;
        number3++;
        key1len++;
      end
    end

    number3 = 0;

    for (i=0; i<`MAX_BLOCK_AMOUNT; i++) begin
      #1
      if  (
        ((line3_block[i] >= `replacement_offset1 && line3_block[i] <= `replacement_offset3) | (line3_block[i] >= `replacement_offset2 && line3_block[i] <= `replacement_offset4)) &
        ((line4_block[i] >= `replacement_offset1 && line4_block[i] <= `replacement_offset3) | (line4_block[i] >= `replacement_offset2 && line4_block[i] <= `replacement_offset4))
      ) begin
        //plaintext
        if ((line3_block[i] >= `replacement_offset1 && line3_block[i] <= `replacement_offset3)) begin
          number1 = line3_block[i] + 32;
        end
        else begin
          number1 = line3_block[i];
        end
        //cyphertext
        if ((line4_block[i] >= `replacement_offset1 && line4_block[i] <= `replacement_offset3)) begin
          number2 = line4_block[i] + 32;
        end
        else begin
          number2 = line4_block[i];
        end
        //number1 plaintext
        //mumber2 cyphertext
        key2[number3] = ((number2 - number1 + 26) % 26) + `replacement_offset1;
        #1;
        number3++;
        key2len++;
      end
    end

    //find repeated words in both and find the keys
    key_finder_counter = 0;
    key1lenb = key1len;
    key2lenb = key2len;
    key1len = key1len - 1;
    key2len = key2len - 1;

    for (i=0; i<`MAX_BLOCK_AMOUNT; i++) begin
      #1;
      if ((key1len >= 0) & (key2len >= 0)) begin
        if (key1[key1len] == key2[key2len]) begin
          key_finder_counter_ahead1 = key_finder_counter + 1;
          key_finder_counter_ahead2 = key_finder_counter + 2;
          key_finder_counter_ahead3 = key_finder_counter + 3;
          case (key_finder_counter)
            0: begin
              keylet1 = key1[key1len];
              return_key[key_finder_counter] = key1[key1len];
            end
            1: begin
              keylet2 = key1[key1len];
              return_key[key_finder_counter] = key1[key1len];
            end
            2: begin
              keylet3 = key1[key1len];
              return_key[key_finder_counter] = key1[key1len];
            end
          endcase

          if (key_finder_counter > 2) begin
            advance_key1_reg1 = key1len - 1;
            advance_key1_reg2 = key1len - 2;
            advance_key1_reg3 = key1len - 3;

            advance_key2_reg1 = key2len - 1;
            advance_key2_reg2 = key2len - 2;
            advance_key2_reg3 = key2len - 3;

            //find certainty that the word is being repeated to up to 2 letters in advance
            //key1 or key2 could be longer
            if ((advance_key1_reg1 >= 0) & (advance_key2_reg1 >= 0)) begin
              if ((key1[advance_key1_reg1] == keylet1) | (key2[advance_key2_reg1] == keylet1)) begin
                if ((advance_key1_reg2 >= 0) & (advance_key2_reg2 >= 0)) begin
                  if ((key1[advance_key1_reg2] == keylet2) | (key2[advance_key2_reg2] == keylet2)) begin
                    if ((advance_key1_reg3 >= 0) & (advance_key2_reg3 >= 0)) begin
                      if ((key1[advance_key1_reg3] == keylet3) | (key2[advance_key2_reg3] == keylet3)) begin
                        //this is pretty close
                        return_key[key_finder_counter] = key1[key1len];
                        //                        return_key[key_finder_counter_ahead1] = key1[advance_key1_reg1];
                        //                        return_key[key_finder_counter_ahead2] = key1[advance_key1_reg2];
                        //                        return_key[key_finder_counter_ahead3] = key1[advance_key1_reg3];
                        i = `MAX_BLOCK_AMOUNT;
                      end
                    end
                    else if ((advance_key1_reg3 < 0) | (advance_key2_reg3 < 0)) begin
                      //                      return_key[key_finder_counter] = key1[key1len];
                      //                      return_key[key_finder_counter_ahead1] = key1[advance_key1_reg1];
                      //                      return_key[key_finder_counter_ahead2] = key1[advance_key1_reg2];
                      i = `MAX_BLOCK_AMOUNT;
                    end
                  end
                end
                else begin
                  if ((advance_key1_reg2 < 0) & (key2[advance_key2_reg2] == keylet2)) begin
                    return_key[key_finder_counter] = key2[key2len];
                    return_key[key_finder_counter_ahead1] = key2[advance_key2_reg1];
                    return_key[key_finder_counter_ahead2] = key2[advance_key2_reg2];
                    i = `MAX_BLOCK_AMOUNT;
                  end
                  else if ((advance_key2_reg2 < 0) & (key1[advance_key1_reg2] == keylet2)) begin
                    return_key[key_finder_counter] = key1[key1len];
                    return_key[key_finder_counter_ahead1] = key1[advance_key1_reg1];
                    return_key[key_finder_counter_ahead2] = key1[advance_key1_reg2];
                    i = `MAX_BLOCK_AMOUNT;
                  end
                end
              end
              //end the future checking
              //future says nothing ahead matches
              else begin
                return_key[key_finder_counter] = key1[key1len];
              end
            end
          end
          key_finder_counter = key_finder_counter + 1;
        end

        else begin
          //one of them dont match
          if (key2[key2len] == keylet1 & key1[key1len] != keylet1) begin
            //the order has been reset
            //restart key1len from the beggining
            key1len = key1lenb;
            key2len = key2len + 1;
            key_finder_counter = 0;
          end
          if (key2[key2len] != keylet1 & key1[key1len] == keylet1) begin
            //restart key2len from the beggining
            key2len = key2lenb;
            key1len = key1len + 1;
            key_finder_counter = 0;
          end
        end
      end
      key1len = key1len - 1;
      key2len = key2len - 1;
    end       

    //assign key
    key[`pos_80] = return_key[0];
    key[`pos_79] = return_key[1];
    key[`pos_78] = return_key[2];
    key[`pos_77] = return_key[3];
    key[`pos_76] = return_key[4];
    key[`pos_75] = return_key[5];
    key[`pos_74] = return_key[6];
    key[`pos_73] = return_key[7];
    key[`pos_72] = return_key[8];
    key[`pos_71] = return_key[9];
    key[`pos_70] = return_key[10];
    key[`pos_69] = return_key[11];
    key[`pos_68] = return_key[12];
    key[`pos_67] = return_key[13];
    key[`pos_66] = return_key[14];
    key[`pos_65] = return_key[15];
    key[`pos_64] = return_key[16];
    key[`pos_63] = return_key[17];
    key[`pos_62] = return_key[18];
    key[`pos_61] = return_key[19];
    key[`pos_60] = return_key[20];
    key[`pos_59] = return_key[21];
    key[`pos_58] = return_key[22];
    key[`pos_57] = return_key[23];
    key[`pos_56] = return_key[24];
    key[`pos_55] = return_key[25];
    key[`pos_54] = return_key[26];
    key[`pos_53] = return_key[27];
    key[`pos_52] = return_key[28];
    key[`pos_51] = return_key[29];
    key[`pos_50] = return_key[30];
    key[`pos_49] = return_key[31];
    key[`pos_48] = return_key[32];
    key[`pos_47] = return_key[33];
    key[`pos_46] = return_key[34];
    key[`pos_45] = return_key[35];
    key[`pos_44] = return_key[36];
    key[`pos_43] = return_key[37];
    key[`pos_42] = return_key[38];
    key[`pos_41] = return_key[39];
    key[`pos_40] = return_key[40];
    key[`pos_39] = return_key[41];
    key[`pos_38] = return_key[42];
    key[`pos_37] = return_key[43];
    key[`pos_36] = return_key[44];
    key[`pos_35] = return_key[45];
    key[`pos_34] = return_key[46];
    key[`pos_33] = return_key[47];
    key[`pos_32] = return_key[48];
    key[`pos_31] = return_key[49];
    key[`pos_30] = return_key[50];
    key[`pos_29] = return_key[51];
    key[`pos_28] = return_key[52];
    key[`pos_27] = return_key[53];
    key[`pos_26] = return_key[54];
    key[`pos_25] = return_key[55];
    key[`pos_24] = return_key[56];
    key[`pos_23] = return_key[57];
    key[`pos_22] = return_key[58];
    key[`pos_21] = return_key[59];
    key[`pos_20] = return_key[60];
    key[`pos_19] = return_key[61];
    key[`pos_18] = return_key[62];
    key[`pos_17] = return_key[63];
    key[`pos_16] = return_key[64];
    key[`pos_15] = return_key[65];
    key[`pos_14] = return_key[66];
    key[`pos_13] = return_key[67];
    key[`pos_12] = return_key[68];
    key[`pos_11] = return_key[69];
    key[`pos_10] = return_key[70];
    key[`pos_9] = return_key[71];
    key[`pos_8] = return_key[72];
    key[`pos_7] = return_key[73];
    key[`pos_6] = return_key[74];
    key[`pos_5] = return_key[75];
    key[`pos_4] = return_key[76];
    key[`pos_3] = return_key[77];
    key[`pos_2] = return_key[78];
    key[`pos_1] = return_key[79];

    done = 1;
  end

endmodule