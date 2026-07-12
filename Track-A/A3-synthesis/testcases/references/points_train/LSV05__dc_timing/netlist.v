/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Sun Jul  5 14:08:44 2026
/////////////////////////////////////////////////////////////


module axi_dwidth_converter_v2_1_b_downsizer ( ARESET, ACLK, cmd_valid, 
        cmd_split, cmd_repeat, cmd_ready, cmd_id, S_AXI_BID, S_AXI_BRESP, 
        S_AXI_BVALID, S_AXI_BREADY, M_AXI_BRESP, M_AXI_BVALID, M_AXI_BREADY );
  input [7:0] cmd_repeat;
  input [0:0] cmd_id;
  output [0:0] S_AXI_BID;
  output [1:0] S_AXI_BRESP;
  input [1:0] M_AXI_BRESP;
  input ARESET, ACLK, cmd_valid, cmd_split, S_AXI_BREADY, M_AXI_BVALID;
  output cmd_ready, S_AXI_BVALID, M_AXI_BREADY;
  wire   \S_AXI_BID[0] , first_mi_word, n32, n33, n34, n35, n36, n37, n38, n39,
         n40, n41, n42, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54,
         n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68,
         n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82,
         n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96,
         n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108;
  wire   [1:0] S_AXI_BRESP_ACC;
  wire   [7:0] repeat_cnt;
  assign S_AXI_BID[0] = \S_AXI_BID[0] ;
  assign \S_AXI_BID[0]  = cmd_id[0];

  DFF_X1 \repeat_cnt_reg[0]  ( .D(n42), .CK(ACLK), .Q(repeat_cnt[0]), .QN(n105) );
  DFF_X1 \repeat_cnt_reg[7]  ( .D(n41), .CK(ACLK), .Q(repeat_cnt[7]), .QN(n108) );
  DFF_X1 first_mi_word_reg ( .D(n40), .CK(ACLK), .Q(first_mi_word), .QN(n102)
         );
  DFF_X1 \repeat_cnt_reg[6]  ( .D(n39), .CK(ACLK), .Q(repeat_cnt[6]) );
  DFF_X1 \repeat_cnt_reg[5]  ( .D(n38), .CK(ACLK), .Q(repeat_cnt[5]), .QN(n106) );
  DFF_X1 \repeat_cnt_reg[4]  ( .D(n37), .CK(ACLK), .Q(repeat_cnt[4]) );
  DFF_X1 \repeat_cnt_reg[3]  ( .D(n36), .CK(ACLK), .Q(repeat_cnt[3]), .QN(n107) );
  DFF_X1 \repeat_cnt_reg[2]  ( .D(n35), .CK(ACLK), .Q(repeat_cnt[2]) );
  DFF_X1 \repeat_cnt_reg[1]  ( .D(n34), .CK(ACLK), .QN(n104) );
  DFF_X1 \S_AXI_BRESP_ACC_reg[1]  ( .D(n32), .CK(ACLK), .Q(S_AXI_BRESP_ACC[1]), 
        .QN(n103) );
  DFF_X1 \S_AXI_BRESP_ACC_reg[0]  ( .D(n33), .CK(ACLK), .Q(S_AXI_BRESP_ACC[0])
         );
  CLKBUF_X1 U58 ( .A(cmd_repeat[2]), .Z(n44) );
  CLKBUF_X1 U59 ( .A(cmd_repeat[4]), .Z(n45) );
  CLKBUF_X1 U60 ( .A(cmd_repeat[6]), .Z(n46) );
  CLKBUF_X1 U61 ( .A(cmd_repeat[7]), .Z(n47) );
  CLKBUF_X1 U62 ( .A(cmd_repeat[0]), .Z(n48) );
  CLKBUF_X1 U63 ( .A(cmd_valid), .Z(n49) );
  CLKBUF_X1 U64 ( .A(cmd_repeat[3]), .Z(n50) );
  CLKBUF_X1 U65 ( .A(cmd_repeat[5]), .Z(n51) );
  INV_X1 U66 ( .A(n53), .ZN(n52) );
  CLKBUF_X1 U67 ( .A(cmd_split), .Z(n53) );
  CLKBUF_X1 U68 ( .A(M_AXI_BRESP[1]), .Z(n54) );
  CLKBUF_X1 U69 ( .A(ARESET), .Z(n55) );
  INV_X1 U70 ( .A(n57), .ZN(n56) );
  CLKBUF_X1 U71 ( .A(M_AXI_BVALID), .Z(n57) );
  NAND2_X1 U72 ( .A1(n102), .A2(n104), .ZN(n62) );
  NOR4_X1 U73 ( .A1(repeat_cnt[2]), .A2(repeat_cnt[4]), .A3(repeat_cnt[3]), 
        .A4(n62), .ZN(n59) );
  NOR4_X1 U74 ( .A1(repeat_cnt[6]), .A2(repeat_cnt[0]), .A3(repeat_cnt[7]), 
        .A4(repeat_cnt[5]), .ZN(n58) );
  AOI21_X1 U75 ( .B1(n59), .B2(n58), .A(n52), .ZN(n86) );
  OR2_X1 U76 ( .A1(S_AXI_BREADY), .A2(n86), .ZN(M_AXI_BREADY) );
  NAND2_X1 U77 ( .A1(n57), .A2(M_AXI_BREADY), .ZN(n85) );
  INV_X1 U78 ( .A(n85), .ZN(n60) );
  NOR2_X1 U79 ( .A1(n55), .A2(n60), .ZN(n80) );
  NOR2_X1 U80 ( .A1(n85), .A2(n55), .ZN(n81) );
  INV_X1 U81 ( .A(n48), .ZN(n61) );
  OAI22_X1 U82 ( .A1(n102), .A2(n61), .B1(n105), .B2(first_mi_word), .ZN(n97)
         );
  OAI21_X1 U83 ( .B1(cmd_repeat[1]), .B2(n102), .A(n62), .ZN(n63) );
  INV_X1 U84 ( .A(n63), .ZN(n98) );
  NOR2_X1 U85 ( .A1(n97), .A2(n98), .ZN(n96) );
  AOI22_X1 U86 ( .A1(n44), .A2(first_mi_word), .B1(repeat_cnt[2]), .B2(n102), 
        .ZN(n64) );
  NAND2_X1 U87 ( .A1(n96), .A2(n64), .ZN(n94) );
  OAI21_X1 U88 ( .B1(n96), .B2(n64), .A(n94), .ZN(n65) );
  AOI22_X1 U89 ( .A1(repeat_cnt[2]), .A2(n80), .B1(n81), .B2(n65), .ZN(n66) );
  INV_X1 U90 ( .A(n66), .ZN(n35) );
  AOI221_X1 U91 ( .B1(n50), .B2(first_mi_word), .C1(repeat_cnt[3]), .C2(n102), 
        .A(n94), .ZN(n92) );
  AOI22_X1 U92 ( .A1(n45), .A2(first_mi_word), .B1(repeat_cnt[4]), .B2(n102), 
        .ZN(n70) );
  NAND2_X1 U93 ( .A1(n92), .A2(n70), .ZN(n90) );
  AOI221_X1 U94 ( .B1(repeat_cnt[5]), .B2(n102), .C1(n51), .C2(first_mi_word), 
        .A(n90), .ZN(n88) );
  AOI22_X1 U95 ( .A1(n46), .A2(first_mi_word), .B1(repeat_cnt[6]), .B2(n102), 
        .ZN(n67) );
  NAND2_X1 U96 ( .A1(n88), .A2(n67), .ZN(n82) );
  OAI21_X1 U97 ( .B1(n88), .B2(n67), .A(n82), .ZN(n68) );
  AOI22_X1 U98 ( .A1(repeat_cnt[6]), .A2(n80), .B1(n81), .B2(n68), .ZN(n69) );
  INV_X1 U99 ( .A(n69), .ZN(n39) );
  OAI21_X1 U100 ( .B1(n92), .B2(n70), .A(n90), .ZN(n71) );
  AOI22_X1 U101 ( .A1(repeat_cnt[4]), .A2(n80), .B1(n81), .B2(n71), .ZN(n72)
         );
  INV_X1 U102 ( .A(n72), .ZN(n37) );
  INV_X1 U103 ( .A(n54), .ZN(n76) );
  AOI21_X1 U104 ( .B1(S_AXI_BRESP_ACC[1]), .B2(n76), .A(S_AXI_BRESP_ACC[0]), 
        .ZN(n73) );
  NAND2_X1 U105 ( .A1(n53), .A2(n102), .ZN(n77) );
  AOI211_X1 U106 ( .C1(n54), .C2(n103), .A(n73), .B(n77), .ZN(n74) );
  MUX2_X1 U107 ( .A(M_AXI_BRESP[0]), .B(S_AXI_BRESP_ACC[0]), .S(n74), .Z(
        S_AXI_BRESP[0]) );
  AOI22_X1 U108 ( .A1(S_AXI_BRESP[0]), .A2(n81), .B1(n80), .B2(
        S_AXI_BRESP_ACC[0]), .ZN(n75) );
  INV_X1 U109 ( .A(n75), .ZN(n33) );
  OAI21_X1 U110 ( .B1(n77), .B2(n103), .A(n76), .ZN(S_AXI_BRESP[1]) );
  AOI22_X1 U111 ( .A1(S_AXI_BRESP[1]), .A2(n81), .B1(n80), .B2(
        S_AXI_BRESP_ACC[1]), .ZN(n78) );
  INV_X1 U112 ( .A(n78), .ZN(n32) );
  NOR2_X1 U113 ( .A1(n86), .A2(n56), .ZN(S_AXI_BVALID) );
  INV_X1 U114 ( .A(n49), .ZN(n79) );
  NOR3_X1 U115 ( .A1(n85), .A2(n79), .A3(n86), .ZN(cmd_ready) );
  INV_X1 U116 ( .A(n80), .ZN(n99) );
  INV_X1 U117 ( .A(n81), .ZN(n100) );
  OAI22_X1 U118 ( .A1(n105), .A2(n99), .B1(n100), .B2(n97), .ZN(n42) );
  AOI22_X1 U119 ( .A1(n47), .A2(first_mi_word), .B1(repeat_cnt[7]), .B2(n102), 
        .ZN(n83) );
  XNOR2_X1 U120 ( .A(n83), .B(n82), .ZN(n84) );
  OAI22_X1 U121 ( .A1(n108), .A2(n99), .B1(n100), .B2(n84), .ZN(n41) );
  AOI22_X1 U122 ( .A1(n57), .A2(n86), .B1(n102), .B2(n85), .ZN(n87) );
  OR2_X1 U123 ( .A1(n55), .A2(n87), .ZN(n40) );
  MUX2_X1 U124 ( .A(n51), .B(repeat_cnt[5]), .S(n102), .Z(n89) );
  AOI21_X1 U125 ( .B1(n90), .B2(n89), .A(n88), .ZN(n91) );
  OAI22_X1 U126 ( .A1(n91), .A2(n100), .B1(n106), .B2(n99), .ZN(n38) );
  MUX2_X1 U127 ( .A(n50), .B(repeat_cnt[3]), .S(n102), .Z(n93) );
  AOI21_X1 U128 ( .B1(n94), .B2(n93), .A(n92), .ZN(n95) );
  OAI22_X1 U129 ( .A1(n95), .A2(n100), .B1(n107), .B2(n99), .ZN(n36) );
  AOI21_X1 U130 ( .B1(n98), .B2(n97), .A(n96), .ZN(n101) );
  OAI22_X1 U131 ( .A1(n101), .A2(n100), .B1(n104), .B2(n99), .ZN(n34) );
endmodule

