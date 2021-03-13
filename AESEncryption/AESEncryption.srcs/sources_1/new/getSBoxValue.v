`timescale 1 ns / 1 ns
// -------------------------------------------------------------
// 
// Engineer: Edwin Trejo
// Module: getSBoxValue
// Source Path: test3/getSBoxValue
// Hierarchy Level: 1
// 
// -------------------------------------------------------------

//SubByte
//uses values calculated from the multiplicative inverse GF28 table
//https://images.slideplayer.com/17/5276780/slides/slide_69.jpg
/*
    %B is the value of the current item in the multiplicative inverse table
    B = fi(0x1C, 0, 8, 0);
    constant = fi(0x63, 0, 8, 0);
    s = bitxor(B, bitrol(B, 1));
    s = bitxor(s, bitrol(B, 2));
    s = bitxor(s, bitrol(B, 3));
    s = bitxor(s, bitrol(B, 4));
    s = bitxor(s, constant);
    disp(bin(s))
    var = dec2hex(s)
*/

module getSBoxValue
          (number,
           sbox_val);


  input   [7:0] number;  // uint8
  output  [7:0] sbox_val;  // uint8


  reg [7:0] sbox_val_1;  // uint8
  reg [7:0] low_sel;  // uint8
  reg [7:0] high_sel;  // uint8
  reg [7:0] temp;  // ufix8
  reg [7:0] c;  // ufix8
  reg [7:0] sbox [0:15] [0:15];  // uint8 [16x16]
  reg [7:0] add_cast;  // uint8
  reg signed [31:0] and_temp;  // int32
  reg signed [31:0] t_0;  // int32
  reg signed [31:0] t_1;  // int32
  reg signed [31:0] t_2;  // int32

    // 32'sd 32 bit signed decimal
    // 8'd 8 bit unsigned decimal

  always @(number) begin
    sbox[0][32'sd0] = 8'd99;
    sbox[1][32'sd0] = 8'd202;
    sbox[2][32'sd0] = 8'd183;
    sbox[3][32'sd0] = 8'd4;
    sbox[4][32'sd0] = 8'd9;
    sbox[5][32'sd0] = 8'd83;
    sbox[6][32'sd0] = 8'd208;
    sbox[7][32'sd0] = 8'd81;
    sbox[8][32'sd0] = 8'd205;
    sbox[9][32'sd0] = 8'd96;
    sbox[10][32'sd0] = 8'd224;
    sbox[11][32'sd0] = 8'd231;
    sbox[12][32'sd0] = 8'd186;
    sbox[13][32'sd0] = 8'd112;
    sbox[14][32'sd0] = 8'd225;
    sbox[15][32'sd0] = 8'd140;
    sbox[0][32'sd1] = 8'd124;
    sbox[1][32'sd1] = 8'd130;
    sbox[2][32'sd1] = 8'd253;
    sbox[3][32'sd1] = 8'd199;
    sbox[4][32'sd1] = 8'd131;
    sbox[5][32'sd1] = 8'd209;
    sbox[6][32'sd1] = 8'd239;
    sbox[7][32'sd1] = 8'd163;
    sbox[8][32'sd1] = 8'd12;
    sbox[9][32'sd1] = 8'd129;
    sbox[10][32'sd1] = 8'd50;
    sbox[11][32'sd1] = 8'd200;
    sbox[12][32'sd1] = 8'd120;
    sbox[13][32'sd1] = 8'd62;
    sbox[14][32'sd1] = 8'd248;
    sbox[15][32'sd1] = 8'd161;
    sbox[0][32'sd2] = 8'd119;
    sbox[1][32'sd2] = 8'd201;
    sbox[2][32'sd2] = 8'd147;
    sbox[3][32'sd2] = 8'd35;
    sbox[4][32'sd2] = 8'd44;
    sbox[5][32'sd2] = 8'd0;
    sbox[6][32'sd2] = 8'd170;
    sbox[7][32'sd2] = 8'd64;
    sbox[8][32'sd2] = 8'd19;
    sbox[9][32'sd2] = 8'd79;
    sbox[10][32'sd2] = 8'd58;
    sbox[11][32'sd2] = 8'd55;
    sbox[12][32'sd2] = 8'd37;
    sbox[13][32'sd2] = 8'd181;
    sbox[14][32'sd2] = 8'd152;
    sbox[15][32'sd2] = 8'd137;
    sbox[0][32'sd3] = 8'd123;
    sbox[1][32'sd3] = 8'd125;
    sbox[2][32'sd3] = 8'd38;
    sbox[3][32'sd3] = 8'd195;
    sbox[4][32'sd3] = 8'd26;
    sbox[5][32'sd3] = 8'd237;
    sbox[6][32'sd3] = 8'd251;
    sbox[7][32'sd3] = 8'd143;
    sbox[8][32'sd3] = 8'd236;
    sbox[9][32'sd3] = 8'd220;
    sbox[10][32'sd3] = 8'd10;
    sbox[11][32'sd3] = 8'd109;
    sbox[12][32'sd3] = 8'd46;
    sbox[13][32'sd3] = 8'd102;
    sbox[14][32'sd3] = 8'd17;
    sbox[15][32'sd3] = 8'd13;
    sbox[0][32'sd4] = 8'd242;
    sbox[1][32'sd4] = 8'd250;
    sbox[2][32'sd4] = 8'd54;
    sbox[3][32'sd4] = 8'd24;
    sbox[4][32'sd4] = 8'd27;
    sbox[5][32'sd4] = 8'd32;
    sbox[6][32'sd4] = 8'd67;
    sbox[7][32'sd4] = 8'd146;
    sbox[8][32'sd4] = 8'd95;
    sbox[9][32'sd4] = 8'd34;
    sbox[10][32'sd4] = 8'd73;
    sbox[11][32'sd4] = 8'd141;
    sbox[12][32'sd4] = 8'd28;
    sbox[13][32'sd4] = 8'd72;
    sbox[14][32'sd4] = 8'd105;
    sbox[15][32'sd4] = 8'd191;
    sbox[0][32'sd5] = 8'd107;
    sbox[1][32'sd5] = 8'd89;
    sbox[2][32'sd5] = 8'd63;
    sbox[3][32'sd5] = 8'd150;
    sbox[4][32'sd5] = 8'd110;
    sbox[5][32'sd5] = 8'd252;
    sbox[6][32'sd5] = 8'd77;
    sbox[7][32'sd5] = 8'd157;
    sbox[8][32'sd5] = 8'd151;
    sbox[9][32'sd5] = 8'd42;
    sbox[10][32'sd5] = 8'd6;
    sbox[11][32'sd5] = 8'd213;
    sbox[12][32'sd5] = 8'd166;
    sbox[13][32'sd5] = 8'd3;
    sbox[14][32'sd5] = 8'd217;
    sbox[15][32'sd5] = 8'd230;
    sbox[0][32'sd6] = 8'd111;
    sbox[1][32'sd6] = 8'd71;
    sbox[2][32'sd6] = 8'd247;
    sbox[3][32'sd6] = 8'd5;
    sbox[4][32'sd6] = 8'd90;
    sbox[5][32'sd6] = 8'd177;
    sbox[6][32'sd6] = 8'd51;
    sbox[7][32'sd6] = 8'd56;
    sbox[8][32'sd6] = 8'd68;
    sbox[9][32'sd6] = 8'd144;
    sbox[10][32'sd6] = 8'd36;
    sbox[11][32'sd6] = 8'd78;
    sbox[12][32'sd6] = 8'd180;
    sbox[13][32'sd6] = 8'd246;
    sbox[14][32'sd6] = 8'd142;
    sbox[15][32'sd6] = 8'd66;
    sbox[0][32'sd7] = 8'd197;
    sbox[1][32'sd7] = 8'd240;
    sbox[2][32'sd7] = 8'd204;
    sbox[3][32'sd7] = 8'd154;
    sbox[4][32'sd7] = 8'd160;
    sbox[5][32'sd7] = 8'd91;
    sbox[6][32'sd7] = 8'd133;
    sbox[7][32'sd7] = 8'd245;
    sbox[8][32'sd7] = 8'd23;
    sbox[9][32'sd7] = 8'd136;
    sbox[10][32'sd7] = 8'd92;
    sbox[11][32'sd7] = 8'd169;
    sbox[12][32'sd7] = 8'd198;
    sbox[13][32'sd7] = 8'd14;
    sbox[14][32'sd7] = 8'd148;
    sbox[15][32'sd7] = 8'd104;
    sbox[0][32'sd8] = 8'd48;
    sbox[1][32'sd8] = 8'd173;
    sbox[2][32'sd8] = 8'd52;
    sbox[3][32'sd8] = 8'd7;
    sbox[4][32'sd8] = 8'd82;
    sbox[5][32'sd8] = 8'd106;
    sbox[6][32'sd8] = 8'd69;
    sbox[7][32'sd8] = 8'd188;
    sbox[8][32'sd8] = 8'd196;
    sbox[9][32'sd8] = 8'd70;
    sbox[10][32'sd8] = 8'd194;
    sbox[11][32'sd8] = 8'd108;
    sbox[12][32'sd8] = 8'd232;
    sbox[13][32'sd8] = 8'd97;
    sbox[14][32'sd8] = 8'd155;
    sbox[15][32'sd8] = 8'd65;
    sbox[0][32'sd9] = 8'd1;
    sbox[1][32'sd9] = 8'd212;
    sbox[2][32'sd9] = 8'd165;
    sbox[3][32'sd9] = 8'd18;
    sbox[4][32'sd9] = 8'd59;
    sbox[5][32'sd9] = 8'd203;
    sbox[6][32'sd9] = 8'd249;
    sbox[7][32'sd9] = 8'd182;
    sbox[8][32'sd9] = 8'd167;
    sbox[9][32'sd9] = 8'd238;
    sbox[10][32'sd9] = 8'd211;
    sbox[11][32'sd9] = 8'd86;
    sbox[12][32'sd9] = 8'd221;
    sbox[13][32'sd9] = 8'd53;
    sbox[14][32'sd9] = 8'd30;
    sbox[15][32'sd9] = 8'd153;
    sbox[0][32'sd10] = 8'd103;
    sbox[1][32'sd10] = 8'd162;
    sbox[2][32'sd10] = 8'd229;
    sbox[3][32'sd10] = 8'd128;
    sbox[4][32'sd10] = 8'd214;
    sbox[5][32'sd10] = 8'd190;
    sbox[6][32'sd10] = 8'd2;
    sbox[7][32'sd10] = 8'd218;
    sbox[8][32'sd10] = 8'd126;
    sbox[9][32'sd10] = 8'd184;
    sbox[10][32'sd10] = 8'd172;
    sbox[11][32'sd10] = 8'd244;
    sbox[12][32'sd10] = 8'd116;
    sbox[13][32'sd10] = 8'd87;
    sbox[14][32'sd10] = 8'd135;
    sbox[15][32'sd10] = 8'd45;
    sbox[0][32'sd11] = 8'd43;
    sbox[1][32'sd11] = 8'd175;
    sbox[2][32'sd11] = 8'd241;
    sbox[3][32'sd11] = 8'd226;
    sbox[4][32'sd11] = 8'd179;
    sbox[5][32'sd11] = 8'd57;
    sbox[6][32'sd11] = 8'd127;
    sbox[7][32'sd11] = 8'd33;
    sbox[8][32'sd11] = 8'd61;
    sbox[9][32'sd11] = 8'd20;
    sbox[10][32'sd11] = 8'd98;
    sbox[11][32'sd11] = 8'd234;
    sbox[12][32'sd11] = 8'd31;
    sbox[13][32'sd11] = 8'd185;
    sbox[14][32'sd11] = 8'd233;
    sbox[15][32'sd11] = 8'd15;
    sbox[0][32'sd12] = 8'd254;
    sbox[1][32'sd12] = 8'd156;
    sbox[2][32'sd12] = 8'd113;
    sbox[3][32'sd12] = 8'd235;
    sbox[4][32'sd12] = 8'd41;
    sbox[5][32'sd12] = 8'd74;
    sbox[6][32'sd12] = 8'd80;
    sbox[7][32'sd12] = 8'd16;
    sbox[8][32'sd12] = 8'd100;
    sbox[9][32'sd12] = 8'd222;
    sbox[10][32'sd12] = 8'd145;
    sbox[11][32'sd12] = 8'd101;
    sbox[12][32'sd12] = 8'd75;
    sbox[13][32'sd12] = 8'd134;
    sbox[14][32'sd12] = 8'd206;
    sbox[15][32'sd12] = 8'd176;
    sbox[0][32'sd13] = 8'd215;
    sbox[1][32'sd13] = 8'd164;
    sbox[2][32'sd13] = 8'd216;
    sbox[3][32'sd13] = 8'd39;
    sbox[4][32'sd13] = 8'd227;
    sbox[5][32'sd13] = 8'd76;
    sbox[6][32'sd13] = 8'd60;
    sbox[7][32'sd13] = 8'd255;
    sbox[8][32'sd13] = 8'd93;
    sbox[9][32'sd13] = 8'd94;
    sbox[10][32'sd13] = 8'd149;
    sbox[11][32'sd13] = 8'd122;
    sbox[12][32'sd13] = 8'd189;
    sbox[13][32'sd13] = 8'd193;
    sbox[14][32'sd13] = 8'd85;
    sbox[15][32'sd13] = 8'd84;
    sbox[0][32'sd14] = 8'd171;
    sbox[1][32'sd14] = 8'd114;
    sbox[2][32'sd14] = 8'd49;
    sbox[3][32'sd14] = 8'd178;
    sbox[4][32'sd14] = 8'd47;
    sbox[5][32'sd14] = 8'd88;
    sbox[6][32'sd14] = 8'd159;
    sbox[7][32'sd14] = 8'd243;
    sbox[8][32'sd14] = 8'd25;
    sbox[9][32'sd14] = 8'd11;
    sbox[10][32'sd14] = 8'd228;
    sbox[11][32'sd14] = 8'd174;
    sbox[12][32'sd14] = 8'd139;
    sbox[13][32'sd14] = 8'd29;
    sbox[14][32'sd14] = 8'd40;
    sbox[15][32'sd14] = 8'd187;
    sbox[0][32'sd15] = 8'd118;
    sbox[1][32'sd15] = 8'd192;
    sbox[2][32'sd15] = 8'd21;
    sbox[3][32'sd15] = 8'd117;
    sbox[4][32'sd15] = 8'd132;
    sbox[5][32'sd15] = 8'd207;
    sbox[6][32'sd15] = 8'd168;
    sbox[7][32'sd15] = 8'd210;
    sbox[8][32'sd15] = 8'd115;
    sbox[9][32'sd15] = 8'd219;
    sbox[10][32'sd15] = 8'd121;
    sbox[11][32'sd15] = 8'd8;
    sbox[12][32'sd15] = 8'd138;
    sbox[13][32'sd15] = 8'd158;
    sbox[14][32'sd15] = 8'd223;
    sbox[15][32'sd15] = 8'd22;
    //ascii numbering
    t_0 = {24'b0, number};
    t_1 = t_0 & 32'sd15;
    add_cast = t_1[7:0];
    low_sel = add_cast + 8'd1;
    t_2 = {24'b0, number};
    and_temp = t_2 & 32'sd240;
    temp = and_temp[7:0];
    c = temp >> 8'd4;
    high_sel = c + 8'b00000001;
    sbox_val_1 = sbox[$signed({1'b0, high_sel}) - 32'sd1][$signed({1'b0, low_sel}) - 32'sd1];
  end
  
  assign sbox_val = sbox_val_1;

endmodule  // getSBoxValue