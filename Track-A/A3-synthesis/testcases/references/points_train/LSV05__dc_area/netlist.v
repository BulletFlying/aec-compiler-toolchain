/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Sun Jul  5 15:01:30 2026
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
  wire   \S_AXI_BID[0] , first_mi_word, n3, n7, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n24, n25, n26, n27, n31, n32, n33, n34, n35, n36, n37,
         n38, n39, n40, n41, n42, n43, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n64, n65, n66, n67,
         n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81,
         n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n93, n95, n96;
  wire   [1:0] S_AXI_BRESP_ACC;
  wire   [7:0] repeat_cnt;
  wire   [7:0] repeat_cnt_pre;
  wire   [7:0] next_repeat_cnt;
  assign S_AXI_BID[0] = \S_AXI_BID[0] ;
  assign \S_AXI_BID[0]  = cmd_id[0];

  DFF_X1 \repeat_cnt_reg[0]  ( .D(n62), .CK(ACLK), .Q(n65), .QN(n18) );
  DFF_X1 \S_AXI_BRESP_ACC_reg[1]  ( .D(n52), .CK(ACLK), .Q(S_AXI_BRESP_ACC[1]), 
        .QN(n3) );
  DFF_X1 \S_AXI_BRESP_ACC_reg[0]  ( .D(n53), .CK(ACLK), .Q(S_AXI_BRESP_ACC[0]), 
        .QN(n7) );
  DFF_X1 \repeat_cnt_reg[7]  ( .D(n61), .CK(ACLK), .Q(n67), .QN(n11) );
  DFF_X1 \repeat_cnt_reg[1]  ( .D(n55), .CK(ACLK), .Q(n68), .QN(n17) );
  DFF_X1 \repeat_cnt_reg[2]  ( .D(n56), .CK(ACLK), .Q(n64), .QN(n16) );
  DFF_X1 \repeat_cnt_reg[3]  ( .D(n57), .CK(ACLK), .Q(repeat_cnt[3]), .QN(n15)
         );
  DFF_X1 \repeat_cnt_reg[4]  ( .D(n58), .CK(ACLK), .Q(repeat_cnt[4]), .QN(n14)
         );
  DFF_X1 \repeat_cnt_reg[5]  ( .D(n59), .CK(ACLK), .QN(n13) );
  DFF_X1 \repeat_cnt_reg[6]  ( .D(n60), .CK(ACLK), .QN(n12) );
  DFF_X1 first_mi_word_reg ( .D(n54), .CK(ACLK), .Q(first_mi_word), .QN(n10)
         );
  MUX2_X1 U63 ( .A(n64), .B(cmd_repeat[2]), .S(first_mi_word), .Z(
        repeat_cnt_pre[2]) );
  MUX2_X1 U64 ( .A(n65), .B(cmd_repeat[0]), .S(first_mi_word), .Z(
        repeat_cnt_pre[0]) );
  AND3_X1 U65 ( .A1(n45), .A2(cmd_valid), .A3(n66), .ZN(cmd_ready) );
  INV_X1 U66 ( .A(n34), .ZN(n66) );
  XNOR2_X1 U67 ( .A(repeat_cnt_pre[0]), .B(repeat_cnt_pre[1]), .ZN(
        next_repeat_cnt[1]) );
  MUX2_X1 U68 ( .A(n67), .B(cmd_repeat[7]), .S(first_mi_word), .Z(
        repeat_cnt_pre[7]) );
  MUX2_X1 U69 ( .A(n68), .B(cmd_repeat[1]), .S(first_mi_word), .Z(
        repeat_cnt_pre[1]) );
  OAI22_X1 U70 ( .A1(n91), .A2(repeat_cnt_pre[0]), .B1(n18), .B2(n35), .ZN(n62) );
  CLKBUF_X1 U71 ( .A(M_AXI_BVALID), .Z(n69) );
  CLKBUF_X1 U72 ( .A(M_AXI_BRESP[1]), .Z(n70) );
  CLKBUF_X1 U73 ( .A(cmd_split), .Z(n71) );
  CLKBUF_X1 U74 ( .A(ARESET), .Z(n72) );
  INV_X1 U75 ( .A(n74), .ZN(n73) );
  CLKBUF_X1 U76 ( .A(M_AXI_BRESP[0]), .Z(n74) );
  INV_X1 U77 ( .A(n79), .ZN(n89) );
  INV_X1 U78 ( .A(n75), .ZN(n81) );
  INV_X1 U79 ( .A(n78), .ZN(n87) );
  INV_X1 U80 ( .A(n77), .ZN(n85) );
  INV_X1 U81 ( .A(n76), .ZN(n83) );
  INV_X1 U82 ( .A(n45), .ZN(n95) );
  INV_X1 U83 ( .A(n32), .ZN(S_AXI_BRESP[1]) );
  INV_X1 U84 ( .A(n33), .ZN(S_AXI_BRESP[0]) );
  NAND2_X1 U85 ( .A1(n90), .A2(n91), .ZN(n35) );
  INV_X1 U86 ( .A(n37), .ZN(n91) );
  NAND2_X1 U87 ( .A1(n90), .A2(n34), .ZN(n31) );
  AOI21_X1 U88 ( .B1(S_AXI_BRESP_ACC[1]), .B2(n49), .A(n70), .ZN(n32) );
  OAI21_X1 U89 ( .B1(n46), .B2(n47), .A(n71), .ZN(n45) );
  NAND4_X1 U90 ( .A1(n10), .A2(n18), .A3(n17), .A4(n16), .ZN(n47) );
  NAND4_X1 U91 ( .A1(n12), .A2(n11), .A3(n13), .A4(n48), .ZN(n46) );
  NOR2_X1 U92 ( .A1(repeat_cnt[4]), .A2(repeat_cnt[3]), .ZN(n48) );
  INV_X1 U93 ( .A(n70), .ZN(n96) );
  NAND2_X1 U94 ( .A1(n69), .A2(M_AXI_BREADY), .ZN(n34) );
  NOR3_X1 U95 ( .A1(n50), .A2(first_mi_word), .A3(n51), .ZN(n49) );
  AOI21_X1 U96 ( .B1(n96), .B2(S_AXI_BRESP_ACC[1]), .A(n73), .ZN(n50) );
  OAI21_X1 U97 ( .B1(n96), .B2(S_AXI_BRESP_ACC[1]), .A(n71), .ZN(n51) );
  OR2_X1 U98 ( .A1(n95), .A2(S_AXI_BREADY), .ZN(M_AXI_BREADY) );
  AOI22_X1 U99 ( .A1(n93), .A2(n74), .B1(n49), .B2(S_AXI_BRESP_ACC[0]), .ZN(
        n33) );
  INV_X1 U100 ( .A(n49), .ZN(n93) );
  NOR2_X1 U101 ( .A1(n34), .A2(n72), .ZN(n37) );
  OAI22_X1 U102 ( .A1(n3), .A2(n31), .B1(n32), .B2(n91), .ZN(n52) );
  OAI221_X1 U103 ( .B1(n95), .B2(n91), .C1(n10), .C2(n35), .A(n90), .ZN(n54)
         );
  OAI22_X1 U104 ( .A1(n31), .A2(n7), .B1(n33), .B2(n91), .ZN(n53) );
  OAI21_X1 U105 ( .B1(first_mi_word), .B2(n15), .A(n27), .ZN(repeat_cnt_pre[3]) );
  NAND2_X1 U106 ( .A1(cmd_repeat[3]), .A2(first_mi_word), .ZN(n27) );
  AND2_X1 U107 ( .A1(n45), .A2(n69), .ZN(S_AXI_BVALID) );
  OAI21_X1 U108 ( .B1(n12), .B2(n35), .A(n42), .ZN(n60) );
  NAND2_X1 U109 ( .A1(next_repeat_cnt[6]), .A2(n37), .ZN(n42) );
  OAI21_X1 U110 ( .B1(n13), .B2(n35), .A(n41), .ZN(n59) );
  NAND2_X1 U111 ( .A1(next_repeat_cnt[5]), .A2(n37), .ZN(n41) );
  INV_X1 U112 ( .A(repeat_cnt_pre[5]), .ZN(n88) );
  OAI21_X1 U113 ( .B1(n14), .B2(n35), .A(n40), .ZN(n58) );
  NAND2_X1 U114 ( .A1(next_repeat_cnt[4]), .A2(n37), .ZN(n40) );
  INV_X1 U115 ( .A(repeat_cnt_pre[4]), .ZN(n86) );
  OAI21_X1 U116 ( .B1(n15), .B2(n35), .A(n39), .ZN(n57) );
  NAND2_X1 U117 ( .A1(next_repeat_cnt[3]), .A2(n37), .ZN(n39) );
  INV_X1 U118 ( .A(repeat_cnt_pre[3]), .ZN(n84) );
  OAI21_X1 U119 ( .B1(n16), .B2(n35), .A(n38), .ZN(n56) );
  NAND2_X1 U120 ( .A1(next_repeat_cnt[2]), .A2(n37), .ZN(n38) );
  INV_X1 U121 ( .A(repeat_cnt_pre[2]), .ZN(n82) );
  OAI21_X1 U122 ( .B1(n17), .B2(n35), .A(n36), .ZN(n55) );
  NAND2_X1 U123 ( .A1(next_repeat_cnt[1]), .A2(n37), .ZN(n36) );
  OAI21_X1 U124 ( .B1(n11), .B2(n35), .A(n43), .ZN(n61) );
  NAND2_X1 U125 ( .A1(next_repeat_cnt[7]), .A2(n37), .ZN(n43) );
  OAI21_X1 U126 ( .B1(first_mi_word), .B2(n13), .A(n25), .ZN(repeat_cnt_pre[5]) );
  NAND2_X1 U127 ( .A1(cmd_repeat[5]), .A2(first_mi_word), .ZN(n25) );
  OAI21_X1 U128 ( .B1(first_mi_word), .B2(n14), .A(n26), .ZN(repeat_cnt_pre[4]) );
  NAND2_X1 U129 ( .A1(cmd_repeat[4]), .A2(first_mi_word), .ZN(n26) );
  OAI21_X1 U130 ( .B1(first_mi_word), .B2(n12), .A(n24), .ZN(repeat_cnt_pre[6]) );
  NAND2_X1 U131 ( .A1(cmd_repeat[6]), .A2(first_mi_word), .ZN(n24) );
  INV_X1 U132 ( .A(n72), .ZN(n90) );
  NOR2_X1 U133 ( .A1(repeat_cnt_pre[1]), .A2(repeat_cnt_pre[0]), .ZN(n75) );
  NOR2_X1 U134 ( .A1(n81), .A2(repeat_cnt_pre[2]), .ZN(n76) );
  OAI21_X1 U135 ( .B1(n75), .B2(n82), .A(n83), .ZN(next_repeat_cnt[2]) );
  NOR2_X1 U136 ( .A1(n83), .A2(repeat_cnt_pre[3]), .ZN(n77) );
  OAI21_X1 U137 ( .B1(n76), .B2(n84), .A(n85), .ZN(next_repeat_cnt[3]) );
  NOR2_X1 U138 ( .A1(n85), .A2(repeat_cnt_pre[4]), .ZN(n78) );
  OAI21_X1 U139 ( .B1(n77), .B2(n86), .A(n87), .ZN(next_repeat_cnt[4]) );
  NOR2_X1 U140 ( .A1(n87), .A2(repeat_cnt_pre[5]), .ZN(n79) );
  OAI21_X1 U141 ( .B1(n78), .B2(n88), .A(n89), .ZN(next_repeat_cnt[5]) );
  XOR2_X1 U142 ( .A(repeat_cnt_pre[6]), .B(n79), .Z(next_repeat_cnt[6]) );
  NOR2_X1 U143 ( .A1(repeat_cnt_pre[6]), .A2(n89), .ZN(n80) );
  XOR2_X1 U144 ( .A(repeat_cnt_pre[7]), .B(n80), .Z(next_repeat_cnt[7]) );
endmodule

