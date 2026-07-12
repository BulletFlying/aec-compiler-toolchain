/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Sun Jul  5 15:01:35 2026
/////////////////////////////////////////////////////////////


module pfpu_f2i_DW01_sub_0 ( A, B, CI, DIFF, CO );
  input [31:0] A;
  input [31:0] B;
  output [31:0] DIFF;
  input CI;
  output CO;
  wire   \B[0] , n1, n2, n3, n4, n5, n6, n13, n14, n15, n16, n17, n18, n19,
         n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33,
         n34, n35, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91;
  assign DIFF[0] = \B[0] ;
  assign \B[0]  = B[0];

  NOR2_X1 U1 ( .A1(B[1]), .A2(\B[0] ), .ZN(n13) );
  AND2_X1 U2 ( .A1(n86), .A2(n6), .ZN(n1) );
  AND2_X1 U3 ( .A1(n77), .A2(n1), .ZN(n2) );
  AND2_X1 U4 ( .A1(n85), .A2(n2), .ZN(n3) );
  AND2_X1 U5 ( .A1(n78), .A2(n35), .ZN(n4) );
  AND2_X1 U6 ( .A1(n83), .A2(n4), .ZN(n5) );
  AND2_X1 U7 ( .A1(n79), .A2(n25), .ZN(n6) );
  XOR2_X1 U8 ( .A(n79), .B(n25), .Z(DIFF[16]) );
  XOR2_X1 U9 ( .A(n86), .B(n6), .Z(DIFF[17]) );
  XOR2_X1 U10 ( .A(n77), .B(n1), .Z(DIFF[18]) );
  XOR2_X1 U11 ( .A(n85), .B(n2), .Z(DIFF[19]) );
  XOR2_X1 U12 ( .A(n78), .B(n35), .Z(DIFF[22]) );
  XOR2_X1 U13 ( .A(n83), .B(n4), .Z(DIFF[23]) );
  AND2_X1 U14 ( .A1(n64), .A2(n33), .ZN(n14) );
  AND2_X1 U15 ( .A1(n65), .A2(n14), .ZN(n15) );
  AND2_X1 U16 ( .A1(n66), .A2(n15), .ZN(n16) );
  AND2_X1 U17 ( .A1(n67), .A2(n16), .ZN(n17) );
  AND2_X1 U18 ( .A1(n75), .A2(n34), .ZN(n18) );
  AND2_X1 U19 ( .A1(n76), .A2(n18), .ZN(n19) );
  AND2_X1 U20 ( .A1(n69), .A2(n19), .ZN(n20) );
  AND2_X1 U21 ( .A1(n70), .A2(n20), .ZN(n21) );
  AND2_X1 U22 ( .A1(n71), .A2(n21), .ZN(n22) );
  AND2_X1 U23 ( .A1(n72), .A2(n22), .ZN(n23) );
  AND2_X1 U24 ( .A1(n73), .A2(n23), .ZN(n24) );
  AND2_X1 U25 ( .A1(n74), .A2(n24), .ZN(n25) );
  AND2_X1 U26 ( .A1(n80), .A2(n3), .ZN(n26) );
  AND2_X1 U27 ( .A1(n81), .A2(n32), .ZN(n27) );
  AND2_X1 U28 ( .A1(n90), .A2(n27), .ZN(n28) );
  AND2_X1 U29 ( .A1(n84), .A2(n28), .ZN(n29) );
  AND2_X1 U30 ( .A1(n89), .A2(n29), .ZN(n30) );
  AND2_X1 U31 ( .A1(n82), .A2(n30), .ZN(n31) );
  AND2_X1 U32 ( .A1(n88), .A2(n5), .ZN(n32) );
  AND2_X1 U33 ( .A1(n63), .A2(n13), .ZN(n33) );
  AND2_X1 U34 ( .A1(n68), .A2(n17), .ZN(n34) );
  AND2_X1 U35 ( .A1(n87), .A2(n26), .ZN(n35) );
  XOR2_X1 U36 ( .A(n84), .B(n28), .Z(DIFF[27]) );
  XOR2_X1 U37 ( .A(n89), .B(n29), .Z(DIFF[28]) );
  XOR2_X1 U38 ( .A(n82), .B(n30), .Z(DIFF[29]) );
  XOR2_X1 U39 ( .A(n91), .B(n31), .Z(DIFF[30]) );
  XOR2_X1 U40 ( .A(n73), .B(n23), .Z(DIFF[14]) );
  INV_X1 U41 ( .A(B[16]), .ZN(n79) );
  INV_X1 U42 ( .A(B[17]), .ZN(n86) );
  INV_X1 U43 ( .A(B[18]), .ZN(n77) );
  INV_X1 U44 ( .A(B[19]), .ZN(n85) );
  XOR2_X1 U45 ( .A(n74), .B(n24), .Z(DIFF[15]) );
  XOR2_X1 U46 ( .A(n80), .B(n3), .Z(DIFF[20]) );
  XOR2_X1 U47 ( .A(n87), .B(n26), .Z(DIFF[21]) );
  XOR2_X1 U48 ( .A(n88), .B(n5), .Z(DIFF[24]) );
  XOR2_X1 U49 ( .A(n81), .B(n32), .Z(DIFF[25]) );
  XOR2_X1 U50 ( .A(n90), .B(n27), .Z(DIFF[26]) );
  XOR2_X1 U51 ( .A(n76), .B(n18), .Z(DIFF[9]) );
  INV_X1 U52 ( .A(B[22]), .ZN(n78) );
  INV_X1 U53 ( .A(B[23]), .ZN(n83) );
  XOR2_X1 U54 ( .A(n63), .B(n13), .Z(DIFF[2]) );
  XOR2_X1 U55 ( .A(n64), .B(n33), .Z(DIFF[3]) );
  XOR2_X1 U56 ( .A(n65), .B(n14), .Z(DIFF[4]) );
  XOR2_X1 U57 ( .A(n66), .B(n15), .Z(DIFF[5]) );
  XOR2_X1 U58 ( .A(n67), .B(n16), .Z(DIFF[6]) );
  XOR2_X1 U59 ( .A(n68), .B(n17), .Z(DIFF[7]) );
  XOR2_X1 U60 ( .A(n75), .B(n34), .Z(DIFF[8]) );
  XOR2_X1 U61 ( .A(n69), .B(n19), .Z(DIFF[10]) );
  XOR2_X1 U62 ( .A(n70), .B(n20), .Z(DIFF[11]) );
  XOR2_X1 U63 ( .A(n71), .B(n21), .Z(DIFF[12]) );
  XOR2_X1 U64 ( .A(n72), .B(n22), .Z(DIFF[13]) );
  XOR2_X1 U65 ( .A(n62), .B(n61), .Z(DIFF[1]) );
  INV_X1 U66 ( .A(\B[0] ), .ZN(n61) );
  INV_X1 U67 ( .A(B[4]), .ZN(n65) );
  INV_X1 U68 ( .A(B[1]), .ZN(n62) );
  INV_X1 U69 ( .A(B[2]), .ZN(n63) );
  INV_X1 U70 ( .A(B[3]), .ZN(n64) );
  INV_X1 U71 ( .A(B[5]), .ZN(n66) );
  NAND2_X1 U72 ( .A1(n91), .A2(n31), .ZN(DIFF[31]) );
  INV_X1 U73 ( .A(B[8]), .ZN(n75) );
  INV_X1 U74 ( .A(B[12]), .ZN(n71) );
  INV_X1 U75 ( .A(B[13]), .ZN(n72) );
  INV_X1 U76 ( .A(B[15]), .ZN(n74) );
  INV_X1 U77 ( .A(B[9]), .ZN(n76) );
  INV_X1 U78 ( .A(B[6]), .ZN(n67) );
  INV_X1 U79 ( .A(B[7]), .ZN(n68) );
  INV_X1 U80 ( .A(B[10]), .ZN(n69) );
  INV_X1 U81 ( .A(B[11]), .ZN(n70) );
  INV_X1 U82 ( .A(B[14]), .ZN(n73) );
  INV_X1 U83 ( .A(B[20]), .ZN(n80) );
  INV_X1 U84 ( .A(B[21]), .ZN(n87) );
  INV_X1 U85 ( .A(B[25]), .ZN(n81) );
  INV_X1 U86 ( .A(B[26]), .ZN(n90) );
  INV_X1 U87 ( .A(B[27]), .ZN(n84) );
  INV_X1 U88 ( .A(B[28]), .ZN(n89) );
  INV_X1 U89 ( .A(B[29]), .ZN(n82) );
  INV_X1 U90 ( .A(B[30]), .ZN(n91) );
  INV_X1 U91 ( .A(B[24]), .ZN(n88) );
endmodule


module pfpu_f2i_DW_rash_0 ( A, DATA_TC, SH, SH_TC, B );
  input [23:0] A;
  input [7:0] SH;
  output [23:0] B;
  input DATA_TC, SH_TC;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134, n135, n136, n137;

  OAI222_X1 U3 ( .A1(n101), .A2(n84), .B1(n100), .B2(n59), .C1(n99), .C2(n63), 
        .ZN(n114) );
  AOI221_X1 U4 ( .B1(n38), .B2(A[5]), .C1(n39), .C2(A[4]), .A(n11), .ZN(n88)
         );
  AOI221_X1 U5 ( .B1(n38), .B2(A[6]), .C1(n39), .C2(A[5]), .A(n8), .ZN(n84) );
  AOI221_X1 U6 ( .B1(n38), .B2(A[7]), .C1(n39), .C2(A[6]), .A(n107), .ZN(n75)
         );
  AOI221_X1 U7 ( .B1(n38), .B2(A[8]), .C1(n39), .C2(A[7]), .A(n102), .ZN(n68)
         );
  AOI221_X1 U8 ( .B1(n38), .B2(A[9]), .C1(n39), .C2(A[8]), .A(n135), .ZN(n65)
         );
  AOI221_X1 U9 ( .B1(n38), .B2(A[13]), .C1(n39), .C2(A[12]), .A(n134), .ZN(n67) );
  AOI221_X1 U10 ( .B1(n38), .B2(A[14]), .C1(n39), .C2(A[13]), .A(n121), .ZN(
        n63) );
  AOI221_X1 U11 ( .B1(n38), .B2(A[15]), .C1(n39), .C2(A[14]), .A(n125), .ZN(
        n83) );
  AOI221_X1 U12 ( .B1(n38), .B2(A[16]), .C1(n39), .C2(A[15]), .A(n122), .ZN(
        n71) );
  AOI221_X1 U13 ( .B1(n38), .B2(A[22]), .C1(n41), .C2(A[21]), .A(n18), .ZN(n86) );
  OAI221_X1 U14 ( .B1(n84), .B2(n60), .C1(n59), .C2(n64), .A(n20), .ZN(B[5])
         );
  OAI221_X1 U15 ( .B1(n75), .B2(n60), .C1(n76), .C2(n64), .A(n77), .ZN(B[6])
         );
  OAI221_X1 U16 ( .B1(n68), .B2(n60), .C1(n69), .C2(n64), .A(n21), .ZN(B[7])
         );
  OR2_X1 U17 ( .A1(n40), .A2(SH[0]), .ZN(n1) );
  NAND2_X1 U18 ( .A1(SH[0]), .A2(n40), .ZN(n2) );
  AND2_X1 U19 ( .A1(n14), .A2(n15), .ZN(n3) );
  AND2_X1 U20 ( .A1(n6), .A2(n7), .ZN(n4) );
  AND2_X1 U21 ( .A1(n16), .A2(n17), .ZN(n5) );
  OAI222_X1 U22 ( .A1(n101), .A2(n88), .B1(n100), .B2(n65), .C1(n99), .C2(n67), 
        .ZN(n133) );
  NAND2_X1 U23 ( .A1(A[5]), .A2(n18), .ZN(n6) );
  NAND2_X1 U24 ( .A1(A[6]), .A2(n97), .ZN(n7) );
  NAND2_X1 U25 ( .A1(A[7]), .A2(n18), .ZN(n9) );
  NAND2_X1 U26 ( .A1(A[8]), .A2(n97), .ZN(n10) );
  NAND2_X1 U27 ( .A1(n9), .A2(n10), .ZN(n8) );
  NAND2_X1 U28 ( .A1(A[6]), .A2(n18), .ZN(n12) );
  NAND2_X1 U29 ( .A1(A[7]), .A2(n97), .ZN(n13) );
  NAND2_X1 U30 ( .A1(n12), .A2(n13), .ZN(n11) );
  NAND2_X1 U31 ( .A1(A[21]), .A2(SH[0]), .ZN(n14) );
  NAND2_X1 U32 ( .A1(A[22]), .A2(SH[1]), .ZN(n15) );
  NAND2_X1 U33 ( .A1(A[4]), .A2(n18), .ZN(n16) );
  NAND2_X1 U34 ( .A1(A[5]), .A2(n97), .ZN(n17) );
  INV_X1 U35 ( .A(n1), .ZN(n18) );
  INV_X1 U36 ( .A(n80), .ZN(n23) );
  OR2_X1 U37 ( .A1(n101), .A2(n117), .ZN(n64) );
  INV_X1 U38 ( .A(n82), .ZN(n22) );
  INV_X1 U39 ( .A(n117), .ZN(n24) );
  INV_X1 U40 ( .A(n73), .ZN(n39) );
  INV_X1 U41 ( .A(n97), .ZN(n37) );
  INV_X1 U42 ( .A(SH[1]), .ZN(n40) );
  INV_X1 U43 ( .A(n116), .ZN(n28) );
  NAND2_X1 U44 ( .A1(n95), .A2(n25), .ZN(n60) );
  INV_X1 U45 ( .A(SH[2]), .ZN(n32) );
  INV_X1 U46 ( .A(n78), .ZN(n29) );
  INV_X1 U47 ( .A(n2), .ZN(n38) );
  NOR2_X1 U48 ( .A1(n41), .A2(n40), .ZN(n97) );
  NAND2_X1 U49 ( .A1(n41), .A2(n40), .ZN(n73) );
  INV_X1 U50 ( .A(n106), .ZN(n31) );
  INV_X1 U51 ( .A(n81), .ZN(n35) );
  INV_X1 U52 ( .A(n133), .ZN(n26) );
  INV_X1 U53 ( .A(n114), .ZN(n27) );
  INV_X1 U54 ( .A(n89), .ZN(n19) );
  INV_X1 U55 ( .A(n70), .ZN(n21) );
  INV_X1 U56 ( .A(n98), .ZN(n30) );
  INV_X1 U57 ( .A(n85), .ZN(n20) );
  INV_X1 U58 ( .A(n83), .ZN(n34) );
  INV_X1 U59 ( .A(SH[7]), .ZN(n25) );
  INV_X1 U60 ( .A(SH[0]), .ZN(n41) );
  INV_X1 U61 ( .A(A[8]), .ZN(n54) );
  INV_X1 U62 ( .A(n124), .ZN(n36) );
  INV_X1 U63 ( .A(A[4]), .ZN(n55) );
  INV_X1 U64 ( .A(A[9]), .ZN(n53) );
  INV_X1 U65 ( .A(A[10]), .ZN(n52) );
  INV_X1 U66 ( .A(A[11]), .ZN(n51) );
  INV_X1 U67 ( .A(A[12]), .ZN(n50) );
  INV_X1 U68 ( .A(A[13]), .ZN(n49) );
  INV_X1 U69 ( .A(A[14]), .ZN(n48) );
  INV_X1 U70 ( .A(A[15]), .ZN(n47) );
  INV_X1 U71 ( .A(A[20]), .ZN(n42) );
  INV_X1 U72 ( .A(A[19]), .ZN(n43) );
  INV_X1 U73 ( .A(A[18]), .ZN(n44) );
  INV_X1 U74 ( .A(A[17]), .ZN(n45) );
  INV_X1 U75 ( .A(A[16]), .ZN(n46) );
  INV_X1 U76 ( .A(A[1]), .ZN(n58) );
  INV_X1 U77 ( .A(n136), .ZN(n33) );
  INV_X1 U78 ( .A(A[3]), .ZN(n56) );
  INV_X1 U79 ( .A(A[2]), .ZN(n57) );
  OAI222_X1 U80 ( .A1(n59), .A2(n60), .B1(n61), .B2(n62), .C1(n63), .C2(n64), 
        .ZN(B[9]) );
  OAI222_X1 U81 ( .A1(n65), .A2(n60), .B1(n66), .B2(n62), .C1(n67), .C2(n64), 
        .ZN(B[8]) );
  OAI222_X1 U82 ( .A1(n22), .A2(n71), .B1(n72), .B2(n73), .C1(n23), .C2(n74), 
        .ZN(n70) );
  AOI222_X1 U83 ( .A1(n78), .A2(n79), .B1(n80), .B2(n81), .C1(n82), .C2(n34), 
        .ZN(n77) );
  OAI222_X1 U84 ( .A1(n22), .A2(n63), .B1(n72), .B2(n86), .C1(n23), .C2(n87), 
        .ZN(n85) );
  OAI221_X1 U85 ( .B1(n88), .B2(n60), .C1(n65), .C2(n64), .A(n19), .ZN(B[4])
         );
  OAI222_X1 U86 ( .A1(n22), .A2(n67), .B1(n72), .B2(n33), .C1(n23), .C2(n90), 
        .ZN(n89) );
  NOR2_X1 U87 ( .A1(n62), .A2(n32), .ZN(n80) );
  NAND2_X1 U88 ( .A1(n79), .A2(n32), .ZN(n72) );
  AND2_X1 U89 ( .A1(n91), .A2(n25), .ZN(n79) );
  NOR2_X1 U90 ( .A1(SH[7]), .A2(n92), .ZN(B[3]) );
  AOI222_X1 U91 ( .A1(n93), .A2(n94), .B1(n91), .B2(n30), .C1(n95), .C2(n96), 
        .ZN(n92) );
  OAI221_X1 U92 ( .B1(n2), .B2(n55), .C1(n73), .C2(n56), .A(n4), .ZN(n96) );
  OAI222_X1 U93 ( .A1(n71), .A2(n99), .B1(n69), .B2(n100), .C1(n68), .C2(n101), 
        .ZN(n94) );
  OAI22_X1 U94 ( .A1(n53), .A2(n1), .B1(n52), .B2(n37), .ZN(n102) );
  NOR2_X1 U95 ( .A1(SH[7]), .A2(n103), .ZN(B[2]) );
  AOI222_X1 U96 ( .A1(n93), .A2(n104), .B1(n91), .B2(n31), .C1(n95), .C2(n105), 
        .ZN(n103) );
  OAI221_X1 U97 ( .B1(n2), .B2(n56), .C1(n73), .C2(n57), .A(n5), .ZN(n105) );
  NOR2_X1 U98 ( .A1(n28), .A2(n93), .ZN(n91) );
  OAI222_X1 U99 ( .A1(n83), .A2(n99), .B1(n76), .B2(n100), .C1(n75), .C2(n101), 
        .ZN(n104) );
  OAI22_X1 U100 ( .A1(n54), .A2(n1), .B1(n53), .B2(n37), .ZN(n107) );
  NOR2_X1 U101 ( .A1(n73), .A2(n60), .ZN(B[23]) );
  NOR2_X1 U102 ( .A1(n29), .A2(n108), .ZN(B[22]) );
  NOR2_X1 U103 ( .A1(n86), .A2(n60), .ZN(B[21]) );
  NOR2_X1 U104 ( .A1(n33), .A2(n60), .ZN(B[20]) );
  AOI21_X1 U105 ( .B1(n109), .B2(n110), .A(SH[7]), .ZN(B[1]) );
  NAND2_X1 U106 ( .A1(n95), .A2(n111), .ZN(n110) );
  OAI221_X1 U107 ( .B1(n2), .B2(n57), .C1(n73), .C2(n58), .A(n112), .ZN(n111)
         );
  AOI22_X1 U108 ( .A1(A[3]), .A2(n18), .B1(A[4]), .B2(n97), .ZN(n112) );
  MUX2_X1 U109 ( .A(n113), .B(n27), .S(n93), .Z(n109) );
  AOI221_X1 U110 ( .B1(n38), .B2(A[10]), .C1(n39), .C2(A[9]), .A(n115), .ZN(
        n59) );
  OAI22_X1 U111 ( .A1(n51), .A2(n1), .B1(n50), .B2(n37), .ZN(n115) );
  NOR2_X1 U112 ( .A1(n98), .A2(n108), .ZN(B[19]) );
  NOR2_X1 U113 ( .A1(n106), .A2(n108), .ZN(B[18]) );
  NAND2_X1 U114 ( .A1(n116), .A2(n24), .ZN(n108) );
  NOR2_X1 U115 ( .A1(n117), .A2(n113), .ZN(B[17]) );
  OR2_X1 U116 ( .A1(n28), .A2(n61), .ZN(n113) );
  MUX2_X1 U117 ( .A(n87), .B(n86), .S(SH[2]), .Z(n61) );
  NOR2_X1 U118 ( .A1(n117), .A2(n118), .ZN(B[16]) );
  OAI222_X1 U119 ( .A1(n71), .A2(n60), .B1(n73), .B2(n22), .C1(n74), .C2(n64), 
        .ZN(B[15]) );
  OAI222_X1 U120 ( .A1(n62), .A2(n29), .B1(n83), .B2(n60), .C1(n35), .C2(n64), 
        .ZN(B[14]) );
  NOR2_X1 U121 ( .A1(n119), .A2(SH[2]), .ZN(n78) );
  OAI222_X1 U122 ( .A1(n63), .A2(n60), .B1(n86), .B2(n22), .C1(n87), .C2(n64), 
        .ZN(B[13]) );
  AOI221_X1 U123 ( .B1(n38), .B2(A[18]), .C1(n39), .C2(A[17]), .A(n120), .ZN(
        n87) );
  OAI22_X1 U124 ( .A1(n43), .A2(n1), .B1(n42), .B2(n37), .ZN(n120) );
  OAI22_X1 U125 ( .A1(n47), .A2(n1), .B1(n46), .B2(n37), .ZN(n121) );
  OAI222_X1 U126 ( .A1(n67), .A2(n60), .B1(n33), .B2(n22), .C1(n90), .C2(n64), 
        .ZN(B[12]) );
  NOR2_X1 U127 ( .A1(n62), .A2(SH[2]), .ZN(n82) );
  OAI222_X1 U128 ( .A1(n98), .A2(n62), .B1(n69), .B2(n60), .C1(n71), .C2(n64), 
        .ZN(B[11]) );
  OAI22_X1 U129 ( .A1(n45), .A2(n1), .B1(n44), .B2(n37), .ZN(n122) );
  AOI221_X1 U130 ( .B1(n38), .B2(A[12]), .C1(n39), .C2(A[11]), .A(n123), .ZN(
        n69) );
  OAI22_X1 U131 ( .A1(n49), .A2(n1), .B1(n48), .B2(n37), .ZN(n123) );
  MUX2_X1 U132 ( .A(n74), .B(n73), .S(SH[2]), .Z(n98) );
  AOI221_X1 U133 ( .B1(n38), .B2(A[20]), .C1(A[19]), .C2(n39), .A(n36), .ZN(
        n74) );
  AOI22_X1 U134 ( .A1(n18), .A2(A[21]), .B1(n97), .B2(A[22]), .ZN(n124) );
  OAI222_X1 U135 ( .A1(n106), .A2(n62), .B1(n76), .B2(n60), .C1(n83), .C2(n64), 
        .ZN(B[10]) );
  OAI22_X1 U136 ( .A1(n46), .A2(n1), .B1(n45), .B2(n37), .ZN(n125) );
  AOI221_X1 U137 ( .B1(n38), .B2(A[11]), .C1(n39), .C2(A[10]), .A(n126), .ZN(
        n76) );
  OAI22_X1 U138 ( .A1(n50), .A2(n1), .B1(n49), .B2(n37), .ZN(n126) );
  NAND2_X1 U139 ( .A1(n24), .A2(n28), .ZN(n62) );
  NAND2_X1 U140 ( .A1(n93), .A2(n25), .ZN(n117) );
  MUX2_X1 U141 ( .A(n35), .B(n119), .S(SH[2]), .Z(n106) );
  AOI21_X1 U142 ( .B1(n40), .B2(A[22]), .A(n38), .ZN(n119) );
  OAI221_X1 U143 ( .B1(n2), .B2(n43), .C1(n44), .C2(n73), .A(n127), .ZN(n81)
         );
  AOI22_X1 U144 ( .A1(A[20]), .A2(n18), .B1(n97), .B2(A[21]), .ZN(n127) );
  AOI21_X1 U145 ( .B1(n128), .B2(n129), .A(SH[7]), .ZN(B[0]) );
  NAND2_X1 U146 ( .A1(n95), .A2(n130), .ZN(n129) );
  OAI221_X1 U147 ( .B1(n1), .B2(n57), .C1(n37), .C2(n56), .A(n131), .ZN(n130)
         );
  AOI22_X1 U148 ( .A1(A[1]), .A2(n38), .B1(A[0]), .B2(n39), .ZN(n131) );
  AND3_X1 U149 ( .A1(n93), .A2(n32), .A3(n116), .ZN(n95) );
  MUX2_X1 U150 ( .A(n118), .B(n26), .S(n93), .Z(n128) );
  NOR2_X1 U151 ( .A1(SH[4]), .A2(n132), .ZN(n93) );
  OAI22_X1 U152 ( .A1(n48), .A2(n1), .B1(n47), .B2(n37), .ZN(n134) );
  NAND2_X1 U153 ( .A1(SH[2]), .A2(n28), .ZN(n99) );
  OAI22_X1 U154 ( .A1(n52), .A2(n1), .B1(n51), .B2(n37), .ZN(n135) );
  NAND2_X1 U155 ( .A1(n28), .A2(n32), .ZN(n100) );
  NAND2_X1 U156 ( .A1(n116), .A2(SH[2]), .ZN(n101) );
  OR2_X1 U157 ( .A1(n28), .A2(n66), .ZN(n118) );
  MUX2_X1 U158 ( .A(n90), .B(n33), .S(SH[2]), .Z(n66) );
  OAI211_X1 U159 ( .C1(n42), .C2(n73), .A(n37), .B(n3), .ZN(n136) );
  AOI221_X1 U160 ( .B1(n18), .B2(A[18]), .C1(A[19]), .C2(n97), .A(n137), .ZN(
        n90) );
  OAI22_X1 U161 ( .A1(n45), .A2(n2), .B1(n46), .B2(n73), .ZN(n137) );
  NOR2_X1 U162 ( .A1(SH[3]), .A2(n132), .ZN(n116) );
  OR2_X1 U163 ( .A1(SH[5]), .A2(SH[6]), .ZN(n132) );
endmodule


module pfpu_f2i_DW01_ash_0 ( A, DATA_TC, SH, SH_TC, B );
  input [30:0] A;
  input [7:0] SH;
  output [30:0] B;
  input DATA_TC, SH_TC;
  wire   \temp_int_SH[4] , \MR_int[1][22] , \ML_int[1][22] , \ML_int[1][21] ,
         \ML_int[1][20] , \ML_int[1][19] , \ML_int[1][18] , \ML_int[1][17] ,
         \ML_int[1][16] , \ML_int[1][15] , \ML_int[1][14] , \ML_int[1][13] ,
         \ML_int[1][12] , \ML_int[1][11] , \ML_int[1][10] , \ML_int[1][9] ,
         \ML_int[1][8] , \ML_int[1][7] , \ML_int[1][6] , \ML_int[1][5] ,
         \ML_int[1][4] , \ML_int[1][3] , \ML_int[1][2] , \ML_int[1][1] ,
         \ML_int[1][0] , \ML_int[2][24] , \ML_int[2][23] , \ML_int[2][22] ,
         \ML_int[2][21] , \ML_int[2][20] , \ML_int[2][19] , \ML_int[2][18] ,
         \ML_int[2][17] , \ML_int[2][16] , \ML_int[2][15] , \ML_int[2][14] ,
         \ML_int[2][13] , \ML_int[2][12] , \ML_int[2][11] , \ML_int[2][10] ,
         \ML_int[2][9] , \ML_int[2][8] , \ML_int[2][7] , \ML_int[2][6] ,
         \ML_int[2][5] , \ML_int[2][4] , \ML_int[2][3] , \ML_int[2][2] ,
         \ML_int[2][1] , \ML_int[2][0] , \ML_int[3][26] , \ML_int[3][25] ,
         \ML_int[3][24] , \ML_int[3][23] , \ML_int[3][22] , \ML_int[3][21] ,
         \ML_int[3][20] , \ML_int[3][19] , \ML_int[3][18] , \ML_int[3][17] ,
         \ML_int[3][16] , \ML_int[3][15] , \ML_int[3][14] , \ML_int[3][13] ,
         \ML_int[3][12] , \ML_int[3][11] , \ML_int[3][10] , \ML_int[3][9] ,
         \ML_int[3][8] , \ML_int[3][7] , \ML_int[3][6] , \ML_int[3][5] ,
         \ML_int[3][4] , \ML_int[3][3] , \ML_int[3][2] , \ML_int[3][1] ,
         \ML_int[3][0] , \ML_int[4][30] , \ML_int[4][29] , \ML_int[4][28] ,
         \ML_int[4][27] , \ML_int[4][26] , \ML_int[4][25] , \ML_int[4][24] ,
         \ML_int[4][23] , \ML_int[4][22] , \ML_int[4][21] , \ML_int[4][20] ,
         \ML_int[4][19] , \ML_int[4][18] , \ML_int[4][17] , \ML_int[4][16] ,
         \ML_int[4][15] , \ML_int[4][14] , \ML_int[4][13] , \ML_int[4][12] ,
         \ML_int[4][11] , \ML_int[4][10] , \ML_int[4][9] , \ML_int[4][8] ,
         \ML_int[5][30] , \ML_int[5][29] , \ML_int[5][28] , \ML_int[5][27] ,
         \ML_int[5][26] , \ML_int[5][25] , \ML_int[5][24] , \ML_int[5][23] ,
         \ML_int[5][22] , \ML_int[5][21] , \ML_int[5][20] , \ML_int[5][19] ,
         \ML_int[5][18] , \ML_int[5][17] , \ML_int[5][16] , \ML_int[6][30] ,
         \ML_int[6][29] , \ML_int[6][28] , \ML_int[6][27] , \ML_int[6][26] ,
         \ML_int[6][25] , \ML_int[6][24] , \ML_int[6][23] , \ML_int[6][22] ,
         \ML_int[6][21] , \ML_int[6][20] , \ML_int[6][19] , \ML_int[6][18] ,
         \ML_int[6][17] , \ML_int[6][16] , \ML_int[6][15] , \ML_int[6][14] ,
         \ML_int[6][13] , \ML_int[6][12] , \ML_int[6][11] , \ML_int[6][10] ,
         \ML_int[6][9] , \ML_int[6][8] , \ML_int[6][7] , \ML_int[6][6] ,
         \ML_int[6][5] , \ML_int[6][4] , \ML_int[6][3] , \ML_int[6][2] ,
         \ML_int[6][1] , \ML_int[6][0] , n1, n2, n3, n4, n5, n6, n7, n8, n9,
         n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23,
         n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37,
         n38, n39, n40, n41, n42, n43;
  assign B[30] = \ML_int[6][30] ;
  assign B[29] = \ML_int[6][29] ;
  assign B[28] = \ML_int[6][28] ;
  assign B[27] = \ML_int[6][27] ;
  assign B[26] = \ML_int[6][26] ;
  assign B[25] = \ML_int[6][25] ;
  assign B[24] = \ML_int[6][24] ;
  assign B[23] = \ML_int[6][23] ;
  assign B[22] = \ML_int[6][22] ;
  assign B[21] = \ML_int[6][21] ;
  assign B[20] = \ML_int[6][20] ;
  assign B[19] = \ML_int[6][19] ;
  assign B[18] = \ML_int[6][18] ;
  assign B[17] = \ML_int[6][17] ;
  assign B[16] = \ML_int[6][16] ;
  assign B[15] = \ML_int[6][15] ;
  assign B[14] = \ML_int[6][14] ;
  assign B[13] = \ML_int[6][13] ;
  assign B[12] = \ML_int[6][12] ;
  assign B[11] = \ML_int[6][11] ;
  assign B[10] = \ML_int[6][10] ;
  assign B[9] = \ML_int[6][9] ;
  assign B[8] = \ML_int[6][8] ;
  assign B[7] = \ML_int[6][7] ;
  assign B[6] = \ML_int[6][6] ;
  assign B[5] = \ML_int[6][5] ;
  assign B[4] = \ML_int[6][4] ;
  assign B[3] = \ML_int[6][3] ;
  assign B[2] = \ML_int[6][2] ;
  assign B[1] = \ML_int[6][1] ;
  assign B[0] = \ML_int[6][0] ;

  MUX2_X1 M1_4_30 ( .A(\ML_int[4][30] ), .B(\ML_int[4][14] ), .S(
        \temp_int_SH[4] ), .Z(\ML_int[5][30] ) );
  MUX2_X1 M1_4_29 ( .A(\ML_int[4][29] ), .B(\ML_int[4][13] ), .S(
        \temp_int_SH[4] ), .Z(\ML_int[5][29] ) );
  MUX2_X1 M1_4_28 ( .A(\ML_int[4][28] ), .B(\ML_int[4][12] ), .S(
        \temp_int_SH[4] ), .Z(\ML_int[5][28] ) );
  MUX2_X1 M1_4_27 ( .A(\ML_int[4][27] ), .B(\ML_int[4][11] ), .S(
        \temp_int_SH[4] ), .Z(\ML_int[5][27] ) );
  MUX2_X1 M1_4_26 ( .A(\ML_int[4][26] ), .B(\ML_int[4][10] ), .S(
        \temp_int_SH[4] ), .Z(\ML_int[5][26] ) );
  MUX2_X1 M1_4_25 ( .A(\ML_int[4][25] ), .B(\ML_int[4][9] ), .S(
        \temp_int_SH[4] ), .Z(\ML_int[5][25] ) );
  MUX2_X1 M1_4_24 ( .A(\ML_int[4][24] ), .B(\ML_int[4][8] ), .S(
        \temp_int_SH[4] ), .Z(\ML_int[5][24] ) );
  MUX2_X1 M1_4_23 ( .A(\ML_int[4][23] ), .B(n25), .S(\temp_int_SH[4] ), .Z(
        \ML_int[5][23] ) );
  MUX2_X1 M1_4_22 ( .A(\ML_int[4][22] ), .B(n21), .S(\temp_int_SH[4] ), .Z(
        \ML_int[5][22] ) );
  MUX2_X1 M1_4_21 ( .A(\ML_int[4][21] ), .B(n23), .S(\temp_int_SH[4] ), .Z(
        \ML_int[5][21] ) );
  MUX2_X1 M1_4_20 ( .A(\ML_int[4][20] ), .B(n19), .S(\temp_int_SH[4] ), .Z(
        \ML_int[5][20] ) );
  MUX2_X1 M1_4_19 ( .A(\ML_int[4][19] ), .B(n24), .S(\temp_int_SH[4] ), .Z(
        \ML_int[5][19] ) );
  MUX2_X1 M1_4_18 ( .A(\ML_int[4][18] ), .B(n20), .S(\temp_int_SH[4] ), .Z(
        \ML_int[5][18] ) );
  MUX2_X1 M1_4_17 ( .A(\ML_int[4][17] ), .B(n22), .S(\temp_int_SH[4] ), .Z(
        \ML_int[5][17] ) );
  MUX2_X1 M1_4_16 ( .A(\ML_int[4][16] ), .B(n18), .S(\temp_int_SH[4] ), .Z(
        \ML_int[5][16] ) );
  MUX2_X1 M1_3_30 ( .A(n6), .B(\ML_int[3][22] ), .S(n16), .Z(\ML_int[4][30] )
         );
  MUX2_X1 M1_3_29 ( .A(n5), .B(\ML_int[3][21] ), .S(n16), .Z(\ML_int[4][29] )
         );
  MUX2_X1 M1_3_28 ( .A(n4), .B(\ML_int[3][20] ), .S(n16), .Z(\ML_int[4][28] )
         );
  MUX2_X1 M1_3_27 ( .A(n3), .B(\ML_int[3][19] ), .S(n16), .Z(\ML_int[4][27] )
         );
  MUX2_X1 M1_3_26 ( .A(\ML_int[3][26] ), .B(\ML_int[3][18] ), .S(n16), .Z(
        \ML_int[4][26] ) );
  MUX2_X1 M1_3_25 ( .A(\ML_int[3][25] ), .B(\ML_int[3][17] ), .S(n16), .Z(
        \ML_int[4][25] ) );
  MUX2_X1 M1_3_24 ( .A(\ML_int[3][24] ), .B(\ML_int[3][16] ), .S(n16), .Z(
        \ML_int[4][24] ) );
  MUX2_X1 M1_3_23 ( .A(\ML_int[3][23] ), .B(\ML_int[3][15] ), .S(n16), .Z(
        \ML_int[4][23] ) );
  MUX2_X1 M1_3_22 ( .A(\ML_int[3][22] ), .B(\ML_int[3][14] ), .S(n16), .Z(
        \ML_int[4][22] ) );
  MUX2_X1 M1_3_21 ( .A(\ML_int[3][21] ), .B(\ML_int[3][13] ), .S(n16), .Z(
        \ML_int[4][21] ) );
  MUX2_X1 M1_3_20 ( .A(\ML_int[3][20] ), .B(\ML_int[3][12] ), .S(n16), .Z(
        \ML_int[4][20] ) );
  MUX2_X1 M1_3_19 ( .A(\ML_int[3][19] ), .B(\ML_int[3][11] ), .S(n16), .Z(
        \ML_int[4][19] ) );
  MUX2_X1 M1_3_18 ( .A(\ML_int[3][18] ), .B(\ML_int[3][10] ), .S(n16), .Z(
        \ML_int[4][18] ) );
  MUX2_X1 M1_3_17 ( .A(\ML_int[3][17] ), .B(\ML_int[3][9] ), .S(n16), .Z(
        \ML_int[4][17] ) );
  MUX2_X1 M1_3_16 ( .A(\ML_int[3][16] ), .B(\ML_int[3][8] ), .S(n16), .Z(
        \ML_int[4][16] ) );
  MUX2_X1 M1_3_15 ( .A(\ML_int[3][15] ), .B(\ML_int[3][7] ), .S(n16), .Z(
        \ML_int[4][15] ) );
  MUX2_X1 M1_3_14 ( .A(\ML_int[3][14] ), .B(\ML_int[3][6] ), .S(n16), .Z(
        \ML_int[4][14] ) );
  MUX2_X1 M1_3_13 ( .A(\ML_int[3][13] ), .B(\ML_int[3][5] ), .S(n16), .Z(
        \ML_int[4][13] ) );
  MUX2_X1 M1_3_12 ( .A(\ML_int[3][12] ), .B(\ML_int[3][4] ), .S(n16), .Z(
        \ML_int[4][12] ) );
  MUX2_X1 M1_3_11 ( .A(\ML_int[3][11] ), .B(\ML_int[3][3] ), .S(n16), .Z(
        \ML_int[4][11] ) );
  MUX2_X1 M1_3_10 ( .A(\ML_int[3][10] ), .B(\ML_int[3][2] ), .S(n16), .Z(
        \ML_int[4][10] ) );
  MUX2_X1 M1_3_9 ( .A(\ML_int[3][9] ), .B(\ML_int[3][1] ), .S(n16), .Z(
        \ML_int[4][9] ) );
  MUX2_X1 M1_3_8 ( .A(\ML_int[3][8] ), .B(\ML_int[3][0] ), .S(n16), .Z(
        \ML_int[4][8] ) );
  MUX2_X1 M1_2_26 ( .A(n8), .B(\ML_int[2][22] ), .S(n15), .Z(\ML_int[3][26] )
         );
  MUX2_X1 M1_2_25 ( .A(n7), .B(\ML_int[2][21] ), .S(n15), .Z(\ML_int[3][25] )
         );
  MUX2_X1 M1_2_24 ( .A(\ML_int[2][24] ), .B(\ML_int[2][20] ), .S(n15), .Z(
        \ML_int[3][24] ) );
  MUX2_X1 M1_2_23 ( .A(\ML_int[2][23] ), .B(\ML_int[2][19] ), .S(n15), .Z(
        \ML_int[3][23] ) );
  MUX2_X1 M1_2_22 ( .A(\ML_int[2][22] ), .B(\ML_int[2][18] ), .S(n15), .Z(
        \ML_int[3][22] ) );
  MUX2_X1 M1_2_21 ( .A(\ML_int[2][21] ), .B(\ML_int[2][17] ), .S(n15), .Z(
        \ML_int[3][21] ) );
  MUX2_X1 M1_2_20 ( .A(\ML_int[2][20] ), .B(\ML_int[2][16] ), .S(n15), .Z(
        \ML_int[3][20] ) );
  MUX2_X1 M1_2_19 ( .A(\ML_int[2][19] ), .B(\ML_int[2][15] ), .S(n15), .Z(
        \ML_int[3][19] ) );
  MUX2_X1 M1_2_18 ( .A(\ML_int[2][18] ), .B(\ML_int[2][14] ), .S(n15), .Z(
        \ML_int[3][18] ) );
  MUX2_X1 M1_2_17 ( .A(\ML_int[2][17] ), .B(\ML_int[2][13] ), .S(n15), .Z(
        \ML_int[3][17] ) );
  MUX2_X1 M1_2_16 ( .A(\ML_int[2][16] ), .B(\ML_int[2][12] ), .S(n15), .Z(
        \ML_int[3][16] ) );
  MUX2_X1 M1_2_15 ( .A(\ML_int[2][15] ), .B(\ML_int[2][11] ), .S(n14), .Z(
        \ML_int[3][15] ) );
  MUX2_X1 M1_2_14 ( .A(\ML_int[2][14] ), .B(\ML_int[2][10] ), .S(n14), .Z(
        \ML_int[3][14] ) );
  MUX2_X1 M1_2_13 ( .A(\ML_int[2][13] ), .B(\ML_int[2][9] ), .S(n14), .Z(
        \ML_int[3][13] ) );
  MUX2_X1 M1_2_12 ( .A(\ML_int[2][12] ), .B(\ML_int[2][8] ), .S(n14), .Z(
        \ML_int[3][12] ) );
  MUX2_X1 M1_2_11 ( .A(\ML_int[2][11] ), .B(\ML_int[2][7] ), .S(n14), .Z(
        \ML_int[3][11] ) );
  MUX2_X1 M1_2_10 ( .A(\ML_int[2][10] ), .B(\ML_int[2][6] ), .S(n14), .Z(
        \ML_int[3][10] ) );
  MUX2_X1 M1_2_9 ( .A(\ML_int[2][9] ), .B(\ML_int[2][5] ), .S(n14), .Z(
        \ML_int[3][9] ) );
  MUX2_X1 M1_2_8 ( .A(\ML_int[2][8] ), .B(\ML_int[2][4] ), .S(n14), .Z(
        \ML_int[3][8] ) );
  MUX2_X1 M1_2_7 ( .A(\ML_int[2][7] ), .B(\ML_int[2][3] ), .S(n14), .Z(
        \ML_int[3][7] ) );
  MUX2_X1 M1_2_6 ( .A(\ML_int[2][6] ), .B(\ML_int[2][2] ), .S(n14), .Z(
        \ML_int[3][6] ) );
  MUX2_X1 M1_2_5 ( .A(\ML_int[2][5] ), .B(\ML_int[2][1] ), .S(n14), .Z(
        \ML_int[3][5] ) );
  MUX2_X1 M1_2_4 ( .A(\ML_int[2][4] ), .B(\ML_int[2][0] ), .S(n14), .Z(
        \ML_int[3][4] ) );
  MUX2_X1 M1_1_24 ( .A(n11), .B(\ML_int[1][22] ), .S(n13), .Z(\ML_int[2][24] )
         );
  MUX2_X1 M1_1_23 ( .A(\MR_int[1][22] ), .B(\ML_int[1][21] ), .S(n13), .Z(
        \ML_int[2][23] ) );
  MUX2_X1 M1_1_22 ( .A(\ML_int[1][22] ), .B(\ML_int[1][20] ), .S(n13), .Z(
        \ML_int[2][22] ) );
  MUX2_X1 M1_1_21 ( .A(\ML_int[1][21] ), .B(\ML_int[1][19] ), .S(n13), .Z(
        \ML_int[2][21] ) );
  MUX2_X1 M1_1_20 ( .A(\ML_int[1][20] ), .B(\ML_int[1][18] ), .S(n13), .Z(
        \ML_int[2][20] ) );
  MUX2_X1 M1_1_19 ( .A(\ML_int[1][19] ), .B(\ML_int[1][17] ), .S(n13), .Z(
        \ML_int[2][19] ) );
  MUX2_X1 M1_1_18 ( .A(\ML_int[1][18] ), .B(\ML_int[1][16] ), .S(n13), .Z(
        \ML_int[2][18] ) );
  MUX2_X1 M1_1_17 ( .A(\ML_int[1][17] ), .B(\ML_int[1][15] ), .S(n13), .Z(
        \ML_int[2][17] ) );
  MUX2_X1 M1_1_16 ( .A(\ML_int[1][16] ), .B(\ML_int[1][14] ), .S(n13), .Z(
        \ML_int[2][16] ) );
  MUX2_X1 M1_1_15 ( .A(\ML_int[1][15] ), .B(\ML_int[1][13] ), .S(n13), .Z(
        \ML_int[2][15] ) );
  MUX2_X1 M1_1_14 ( .A(\ML_int[1][14] ), .B(\ML_int[1][12] ), .S(n13), .Z(
        \ML_int[2][14] ) );
  MUX2_X1 M1_1_13 ( .A(\ML_int[1][13] ), .B(\ML_int[1][11] ), .S(n12), .Z(
        \ML_int[2][13] ) );
  MUX2_X1 M1_1_12 ( .A(\ML_int[1][12] ), .B(\ML_int[1][10] ), .S(n12), .Z(
        \ML_int[2][12] ) );
  MUX2_X1 M1_1_11 ( .A(\ML_int[1][11] ), .B(\ML_int[1][9] ), .S(n12), .Z(
        \ML_int[2][11] ) );
  MUX2_X1 M1_1_10 ( .A(\ML_int[1][10] ), .B(\ML_int[1][8] ), .S(n12), .Z(
        \ML_int[2][10] ) );
  MUX2_X1 M1_1_9 ( .A(\ML_int[1][9] ), .B(\ML_int[1][7] ), .S(n12), .Z(
        \ML_int[2][9] ) );
  MUX2_X1 M1_1_8 ( .A(\ML_int[1][8] ), .B(\ML_int[1][6] ), .S(n12), .Z(
        \ML_int[2][8] ) );
  MUX2_X1 M1_1_7 ( .A(\ML_int[1][7] ), .B(\ML_int[1][5] ), .S(n12), .Z(
        \ML_int[2][7] ) );
  MUX2_X1 M1_1_6 ( .A(\ML_int[1][6] ), .B(\ML_int[1][4] ), .S(n12), .Z(
        \ML_int[2][6] ) );
  MUX2_X1 M1_1_5 ( .A(\ML_int[1][5] ), .B(\ML_int[1][3] ), .S(n12), .Z(
        \ML_int[2][5] ) );
  MUX2_X1 M1_1_4 ( .A(\ML_int[1][4] ), .B(\ML_int[1][2] ), .S(n12), .Z(
        \ML_int[2][4] ) );
  MUX2_X1 M1_1_3 ( .A(\ML_int[1][3] ), .B(\ML_int[1][1] ), .S(n12), .Z(
        \ML_int[2][3] ) );
  MUX2_X1 M1_1_2 ( .A(\ML_int[1][2] ), .B(\ML_int[1][0] ), .S(n12), .Z(
        \ML_int[2][2] ) );
  MUX2_X1 M1_0_22 ( .A(A[22]), .B(A[21]), .S(n11), .Z(\ML_int[1][22] ) );
  MUX2_X1 M1_0_21 ( .A(A[21]), .B(A[20]), .S(n11), .Z(\ML_int[1][21] ) );
  MUX2_X1 M1_0_20 ( .A(A[20]), .B(A[19]), .S(n11), .Z(\ML_int[1][20] ) );
  MUX2_X1 M1_0_19 ( .A(A[19]), .B(A[18]), .S(n11), .Z(\ML_int[1][19] ) );
  MUX2_X1 M1_0_18 ( .A(A[18]), .B(A[17]), .S(n11), .Z(\ML_int[1][18] ) );
  MUX2_X1 M1_0_17 ( .A(A[17]), .B(A[16]), .S(n11), .Z(\ML_int[1][17] ) );
  MUX2_X1 M1_0_16 ( .A(A[16]), .B(A[15]), .S(n11), .Z(\ML_int[1][16] ) );
  MUX2_X1 M1_0_15 ( .A(A[15]), .B(A[14]), .S(n11), .Z(\ML_int[1][15] ) );
  MUX2_X1 M1_0_14 ( .A(A[14]), .B(A[13]), .S(n11), .Z(\ML_int[1][14] ) );
  MUX2_X1 M1_0_13 ( .A(A[13]), .B(A[12]), .S(n11), .Z(\ML_int[1][13] ) );
  MUX2_X1 M1_0_12 ( .A(A[12]), .B(A[11]), .S(n11), .Z(\ML_int[1][12] ) );
  MUX2_X1 M1_0_11 ( .A(A[11]), .B(A[10]), .S(n11), .Z(\ML_int[1][11] ) );
  MUX2_X1 M1_0_10 ( .A(A[10]), .B(A[9]), .S(n11), .Z(\ML_int[1][10] ) );
  MUX2_X1 M1_0_9 ( .A(A[9]), .B(A[8]), .S(n11), .Z(\ML_int[1][9] ) );
  MUX2_X1 M1_0_8 ( .A(A[8]), .B(A[7]), .S(n11), .Z(\ML_int[1][8] ) );
  MUX2_X1 M1_0_7 ( .A(A[7]), .B(A[6]), .S(n11), .Z(\ML_int[1][7] ) );
  MUX2_X1 M1_0_6 ( .A(A[6]), .B(A[5]), .S(n11), .Z(\ML_int[1][6] ) );
  MUX2_X1 M1_0_5 ( .A(A[5]), .B(A[4]), .S(n11), .Z(\ML_int[1][5] ) );
  MUX2_X1 M1_0_4 ( .A(A[4]), .B(A[3]), .S(n11), .Z(\ML_int[1][4] ) );
  MUX2_X1 M1_0_3 ( .A(A[3]), .B(A[2]), .S(n11), .Z(\ML_int[1][3] ) );
  MUX2_X1 M1_0_2 ( .A(A[2]), .B(A[1]), .S(n11), .Z(\ML_int[1][2] ) );
  MUX2_X1 M1_0_1 ( .A(A[1]), .B(A[0]), .S(n11), .Z(\ML_int[1][1] ) );
  AND2_X1 U3 ( .A1(n37), .A2(n40), .ZN(n1) );
  AND2_X1 U4 ( .A1(n37), .A2(n41), .ZN(n2) );
  AND2_X1 U5 ( .A1(n15), .A2(\ML_int[2][23] ), .ZN(n3) );
  AND2_X1 U6 ( .A1(n15), .A2(\ML_int[2][24] ), .ZN(n4) );
  AND2_X1 U7 ( .A1(n15), .A2(n7), .ZN(n5) );
  AND2_X1 U8 ( .A1(n15), .A2(n8), .ZN(n6) );
  INV_X1 U9 ( .A(n28), .ZN(n17) );
  INV_X1 U10 ( .A(n1), .ZN(n15) );
  INV_X1 U11 ( .A(n1), .ZN(n14) );
  INV_X1 U12 ( .A(SH[7]), .ZN(n27) );
  INV_X1 U13 ( .A(n9), .ZN(n11) );
  INV_X1 U14 ( .A(n2), .ZN(n12) );
  INV_X1 U15 ( .A(n43), .ZN(n26) );
  INV_X1 U16 ( .A(n2), .ZN(n13) );
  INV_X1 U17 ( .A(n36), .ZN(n18) );
  INV_X1 U18 ( .A(n35), .ZN(n22) );
  INV_X1 U19 ( .A(n33), .ZN(n24) );
  INV_X1 U20 ( .A(n34), .ZN(n20) );
  AND2_X1 U21 ( .A1(n13), .A2(\MR_int[1][22] ), .ZN(n7) );
  INV_X1 U22 ( .A(n30), .ZN(n21) );
  AND2_X1 U23 ( .A1(n13), .A2(n11), .ZN(n8) );
  INV_X1 U24 ( .A(n32), .ZN(n19) );
  INV_X1 U25 ( .A(n31), .ZN(n23) );
  INV_X1 U26 ( .A(n29), .ZN(n25) );
  NAND2_X1 U27 ( .A1(n37), .A2(n38), .ZN(\temp_int_SH[4] ) );
  AND2_X1 U28 ( .A1(n37), .A2(n42), .ZN(n9) );
  AND2_X1 U29 ( .A1(n37), .A2(n39), .ZN(n10) );
  INV_X1 U30 ( .A(n10), .ZN(n16) );
  AND2_X1 U31 ( .A1(\ML_int[4][9] ), .A2(n28), .ZN(\ML_int[6][9] ) );
  AND2_X1 U32 ( .A1(\ML_int[4][8] ), .A2(n28), .ZN(\ML_int[6][8] ) );
  NOR2_X1 U33 ( .A1(n17), .A2(n29), .ZN(\ML_int[6][7] ) );
  NOR2_X1 U34 ( .A1(n17), .A2(n30), .ZN(\ML_int[6][6] ) );
  NOR2_X1 U35 ( .A1(n17), .A2(n31), .ZN(\ML_int[6][5] ) );
  NOR2_X1 U36 ( .A1(n17), .A2(n32), .ZN(\ML_int[6][4] ) );
  NOR2_X1 U37 ( .A1(n17), .A2(n33), .ZN(\ML_int[6][3] ) );
  AND2_X1 U38 ( .A1(\ML_int[5][30] ), .A2(n27), .ZN(\ML_int[6][30] ) );
  NOR2_X1 U39 ( .A1(n17), .A2(n34), .ZN(\ML_int[6][2] ) );
  AND2_X1 U40 ( .A1(\ML_int[5][29] ), .A2(n27), .ZN(\ML_int[6][29] ) );
  AND2_X1 U41 ( .A1(\ML_int[5][28] ), .A2(n27), .ZN(\ML_int[6][28] ) );
  AND2_X1 U42 ( .A1(\ML_int[5][27] ), .A2(n27), .ZN(\ML_int[6][27] ) );
  AND2_X1 U43 ( .A1(\ML_int[5][26] ), .A2(n27), .ZN(\ML_int[6][26] ) );
  AND2_X1 U44 ( .A1(\ML_int[5][25] ), .A2(n27), .ZN(\ML_int[6][25] ) );
  AND2_X1 U45 ( .A1(\ML_int[5][24] ), .A2(n27), .ZN(\ML_int[6][24] ) );
  AND2_X1 U46 ( .A1(\ML_int[5][23] ), .A2(n27), .ZN(\ML_int[6][23] ) );
  AND2_X1 U47 ( .A1(\ML_int[5][22] ), .A2(n27), .ZN(\ML_int[6][22] ) );
  AND2_X1 U48 ( .A1(\ML_int[5][21] ), .A2(n27), .ZN(\ML_int[6][21] ) );
  AND2_X1 U49 ( .A1(\ML_int[5][20] ), .A2(n27), .ZN(\ML_int[6][20] ) );
  NOR2_X1 U50 ( .A1(n17), .A2(n35), .ZN(\ML_int[6][1] ) );
  AND2_X1 U51 ( .A1(\ML_int[5][19] ), .A2(n27), .ZN(\ML_int[6][19] ) );
  AND2_X1 U52 ( .A1(\ML_int[5][18] ), .A2(n27), .ZN(\ML_int[6][18] ) );
  AND2_X1 U53 ( .A1(\ML_int[5][17] ), .A2(n27), .ZN(\ML_int[6][17] ) );
  AND2_X1 U54 ( .A1(\ML_int[5][16] ), .A2(n27), .ZN(\ML_int[6][16] ) );
  AND2_X1 U55 ( .A1(\ML_int[4][15] ), .A2(n28), .ZN(\ML_int[6][15] ) );
  AND2_X1 U56 ( .A1(\ML_int[4][14] ), .A2(n28), .ZN(\ML_int[6][14] ) );
  AND2_X1 U57 ( .A1(\ML_int[4][13] ), .A2(n28), .ZN(\ML_int[6][13] ) );
  AND2_X1 U58 ( .A1(\ML_int[4][12] ), .A2(n28), .ZN(\ML_int[6][12] ) );
  AND2_X1 U59 ( .A1(\ML_int[4][11] ), .A2(n28), .ZN(\ML_int[6][11] ) );
  AND2_X1 U60 ( .A1(\ML_int[4][10] ), .A2(n28), .ZN(\ML_int[6][10] ) );
  NOR2_X1 U61 ( .A1(n17), .A2(n36), .ZN(\ML_int[6][0] ) );
  NOR2_X1 U62 ( .A1(\temp_int_SH[4] ), .A2(SH[7]), .ZN(n28) );
  NAND2_X1 U63 ( .A1(SH[4]), .A2(n26), .ZN(n38) );
  NAND2_X1 U64 ( .A1(\ML_int[3][7] ), .A2(n10), .ZN(n29) );
  NAND2_X1 U65 ( .A1(\ML_int[3][6] ), .A2(n10), .ZN(n30) );
  NAND2_X1 U66 ( .A1(\ML_int[3][5] ), .A2(n10), .ZN(n31) );
  NAND2_X1 U67 ( .A1(\ML_int[3][4] ), .A2(n10), .ZN(n32) );
  NAND2_X1 U68 ( .A1(\ML_int[3][3] ), .A2(n10), .ZN(n33) );
  NAND2_X1 U69 ( .A1(\ML_int[3][2] ), .A2(n10), .ZN(n34) );
  NAND2_X1 U70 ( .A1(\ML_int[3][1] ), .A2(n10), .ZN(n35) );
  NAND2_X1 U71 ( .A1(\ML_int[3][0] ), .A2(n10), .ZN(n36) );
  NAND2_X1 U72 ( .A1(SH[3]), .A2(n26), .ZN(n39) );
  AND2_X1 U73 ( .A1(\ML_int[2][3] ), .A2(n1), .ZN(\ML_int[3][3] ) );
  AND2_X1 U74 ( .A1(\ML_int[2][2] ), .A2(n1), .ZN(\ML_int[3][2] ) );
  AND2_X1 U75 ( .A1(\ML_int[2][1] ), .A2(n1), .ZN(\ML_int[3][1] ) );
  AND2_X1 U76 ( .A1(\ML_int[2][0] ), .A2(n1), .ZN(\ML_int[3][0] ) );
  NAND2_X1 U77 ( .A1(SH[2]), .A2(n26), .ZN(n40) );
  AND2_X1 U78 ( .A1(\ML_int[1][1] ), .A2(n2), .ZN(\ML_int[2][1] ) );
  AND2_X1 U79 ( .A1(\ML_int[1][0] ), .A2(n2), .ZN(\ML_int[2][0] ) );
  NAND2_X1 U80 ( .A1(SH[1]), .A2(n26), .ZN(n41) );
  OR2_X1 U81 ( .A1(n9), .A2(A[22]), .ZN(\MR_int[1][22] ) );
  AND2_X1 U82 ( .A1(A[0]), .A2(n9), .ZN(\ML_int[1][0] ) );
  NAND2_X1 U83 ( .A1(SH[0]), .A2(n26), .ZN(n42) );
  AOI21_X1 U84 ( .B1(SH[5]), .B2(SH[6]), .A(n27), .ZN(n43) );
  OAI21_X1 U85 ( .B1(SH[5]), .B2(SH[6]), .A(n27), .ZN(n37) );
endmodule


module pfpu_f2i ( sys_clk, alu_rst, a, valid_i, r, valid_o );
  input [31:0] a;
  output [31:0] r;
  input sys_clk, alu_rst, valid_i;
  output valid_o;
  wire   N5, N7, N9, N10, N11, N12, N13, N14, N15, N16, N17, N18, N19, N20,
         N21, N22, N23, N24, N25, N26, N27, N28, N29, N30, N31, N32, N33, N34,
         N35, N36, N37, N38, N39, N40, N41, N42, N43, N44, N45, N47, N48, N49,
         N50, N51, N52, N53, N54, N55, N56, N57, N58, N59, N60, N61, N62, N63,
         N64, N65, N66, N67, N68, N69, N70, N71, N72, N73, N74, N75, N76, N77,
         N79, N81, N82, N83, N84, N85, N86, N87, N88, N89, N90, N91, N92, N93,
         N94, N95, N96, N97, N98, N99, N100, N101, N102, N103, N104, N105,
         N106, N107, N108, N109, N110, N111, N112, N144, n48, n49, n50, n51,
         n52, n53, n54, n56, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110, n111,
         n112, n113, n114, n115, n116, n117, n118, n119, n120, n121, n122,
         n123, n124, n125, n126, n127, n128, n129, n130, n131, n132, n133,
         n134, n135, n136, n137, n138, n139, n140, n141, n142, n143, n144,
         n145, n146, n147, n148, n149, n150, n151, n152, n153, n154, n155,
         n156, n157, n158;
  wire   [8:0] \sub_11/carry ;
  wire   [8:0] \sub_9/carry ;
  assign N7 = a[23];

  DFF_X1 valid_o_reg ( .D(N79), .CK(sys_clk), .Q(valid_o) );
  DFF_X1 \r_reg[31]  ( .D(N144), .CK(sys_clk), .Q(r[31]) );
  SDFF_X1 \r_reg[30]  ( .D(n121), .SI(N111), .SE(n127), .CK(sys_clk), .Q(r[30]) );
  SDFF_X1 \r_reg[29]  ( .D(n120), .SI(N110), .SE(n127), .CK(sys_clk), .Q(r[29]) );
  SDFF_X1 \r_reg[28]  ( .D(n119), .SI(N109), .SE(n127), .CK(sys_clk), .Q(r[28]) );
  SDFF_X1 \r_reg[27]  ( .D(n118), .SI(N108), .SE(n127), .CK(sys_clk), .Q(r[27]) );
  SDFF_X1 \r_reg[26]  ( .D(n117), .SI(N107), .SE(n127), .CK(sys_clk), .Q(r[26]) );
  SDFF_X1 \r_reg[25]  ( .D(n116), .SI(N106), .SE(n127), .CK(sys_clk), .Q(r[25]) );
  SDFF_X1 \r_reg[24]  ( .D(n122), .SI(N105), .SE(n127), .CK(sys_clk), .Q(r[24]) );
  SDFF_X1 \r_reg[23]  ( .D(n154), .SI(N104), .SE(n127), .CK(sys_clk), .Q(r[23]) );
  SDFF_X1 \r_reg[22]  ( .D(n151), .SI(N103), .SE(n127), .CK(sys_clk), .Q(r[22]) );
  SDFF_X1 \r_reg[21]  ( .D(n157), .SI(N102), .SE(n127), .CK(sys_clk), .Q(r[21]) );
  SDFF_X1 \r_reg[20]  ( .D(n153), .SI(N101), .SE(n127), .CK(sys_clk), .Q(r[20]) );
  SDFF_X1 \r_reg[19]  ( .D(n155), .SI(N100), .SE(n127), .CK(sys_clk), .Q(r[19]) );
  SDFF_X1 \r_reg[18]  ( .D(n150), .SI(N99), .SE(n127), .CK(sys_clk), .Q(r[18])
         );
  SDFF_X1 \r_reg[17]  ( .D(n156), .SI(N98), .SE(n127), .CK(sys_clk), .Q(r[17])
         );
  SDFF_X1 \r_reg[16]  ( .D(n152), .SI(N97), .SE(n127), .CK(sys_clk), .Q(r[16])
         );
  SDFF_X1 \r_reg[15]  ( .D(n147), .SI(N96), .SE(n127), .CK(sys_clk), .Q(r[15])
         );
  SDFF_X1 \r_reg[14]  ( .D(n146), .SI(N95), .SE(n127), .CK(sys_clk), .Q(r[14])
         );
  SDFF_X1 \r_reg[13]  ( .D(n145), .SI(N94), .SE(n127), .CK(sys_clk), .Q(r[13])
         );
  SDFF_X1 \r_reg[12]  ( .D(n144), .SI(N93), .SE(n127), .CK(sys_clk), .Q(r[12])
         );
  SDFF_X1 \r_reg[11]  ( .D(n143), .SI(N92), .SE(n126), .CK(sys_clk), .Q(r[11])
         );
  SDFF_X1 \r_reg[10]  ( .D(n142), .SI(N91), .SE(n126), .CK(sys_clk), .Q(r[10])
         );
  SDFF_X1 \r_reg[9]  ( .D(n149), .SI(N90), .SE(n126), .CK(sys_clk), .Q(r[9])
         );
  SDFF_X1 \r_reg[8]  ( .D(n148), .SI(N89), .SE(n126), .CK(sys_clk), .Q(r[8])
         );
  SDFF_X1 \r_reg[7]  ( .D(n141), .SI(N88), .SE(n126), .CK(sys_clk), .Q(r[7])
         );
  SDFF_X1 \r_reg[6]  ( .D(n140), .SI(N87), .SE(n126), .CK(sys_clk), .Q(r[6])
         );
  SDFF_X1 \r_reg[5]  ( .D(n139), .SI(N86), .SE(n126), .CK(sys_clk), .Q(r[5])
         );
  SDFF_X1 \r_reg[4]  ( .D(n138), .SI(N85), .SE(n126), .CK(sys_clk), .Q(r[4])
         );
  SDFF_X1 \r_reg[3]  ( .D(n137), .SI(N84), .SE(n126), .CK(sys_clk), .Q(r[3])
         );
  SDFF_X1 \r_reg[2]  ( .D(n136), .SI(N83), .SE(n126), .CK(sys_clk), .Q(r[2])
         );
  SDFF_X1 \r_reg[1]  ( .D(n135), .SI(N82), .SE(n126), .CK(sys_clk), .Q(r[1])
         );
  SDFF_X1 \r_reg[0]  ( .D(n134), .SI(N81), .SE(n126), .CK(sys_clk), .Q(r[0])
         );
  pfpu_f2i_DW01_sub_0 sub_19 ( .A({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0}), .B({1'b0, n121, n120, n119, n118, n117, n116, n122, n154, n151, 
        n157, n153, n155, n150, n156, n152, n147, n146, n145, n144, n143, n142, 
        n149, n148, n141, n140, n139, n138, n137, n136, n135, n134}), .CI(1'b0), .DIFF({N112, N111, N110, N109, N108, N107, N106, N105, N104, N103, N102, 
        N101, N100, N99, N98, N97, N96, N95, N94, N93, N92, N91, N90, N89, N88, 
        N87, N86, N85, N84, N83, N82, N81}) );
  pfpu_f2i_DW_rash_0 srl_11 ( .A({1'b1, n110, n111, n99, n97, n96, n86, n83, 
        n102, n101, n100, n98, n104, n103, n105, n115, n109, n108, n107, n112, 
        n85, n81, n84, n80}), .DATA_TC(1'b0), .SH({N53, N52, N51, N50, N49, 
        N48, N47, n114}), .SH_TC(1'b0), .B({N77, N76, N75, N74, N73, N72, N71, 
        N70, N69, N68, N67, N66, N65, N64, N63, N62, N61, N60, N59, N58, N57, 
        N56, N55, N54}) );
  pfpu_f2i_DW01_ash_0 sll_9 ( .A({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b1, n110, n111, n99, n97, n96, n86, n83, n102, n101, n100, n98, n104, 
        n103, n105, n115, n109, n108, n107, n112, n85, n81, n84, n80}), 
        .DATA_TC(1'b0), .SH({N14, N13, N12, N11, N10, N9, n128, n114}), 
        .SH_TC(1'b0), .B({N45, N44, N43, N42, N41, N40, N39, N38, N37, N36, 
        N35, N34, N33, N32, N31, N30, N29, N28, N27, N26, N25, N24, N23, N22, 
        N21, N20, N19, N18, N17, N16, N15}) );
  CLKBUF_X1 U76 ( .A(valid_i), .Z(n79) );
  CLKBUF_X1 U77 ( .A(a[0]), .Z(n80) );
  CLKBUF_X1 U78 ( .A(a[2]), .Z(n81) );
  CLKBUF_X1 U79 ( .A(a[30]), .Z(n82) );
  CLKBUF_X1 U80 ( .A(a[16]), .Z(n83) );
  CLKBUF_X1 U81 ( .A(a[1]), .Z(n84) );
  CLKBUF_X1 U82 ( .A(a[3]), .Z(n85) );
  CLKBUF_X1 U83 ( .A(a[17]), .Z(n86) );
  INV_X1 U84 ( .A(n88), .ZN(n87) );
  CLKBUF_X1 U85 ( .A(a[25]), .Z(n88) );
  INV_X1 U86 ( .A(n90), .ZN(n89) );
  CLKBUF_X1 U87 ( .A(a[27]), .Z(n90) );
  INV_X1 U88 ( .A(n92), .ZN(n91) );
  CLKBUF_X1 U89 ( .A(a[29]), .Z(n92) );
  CLKBUF_X1 U90 ( .A(a[26]), .Z(n93) );
  INV_X1 U91 ( .A(n95), .ZN(n94) );
  CLKBUF_X1 U92 ( .A(a[28]), .Z(n95) );
  CLKBUF_X1 U93 ( .A(a[18]), .Z(n96) );
  CLKBUF_X1 U94 ( .A(a[19]), .Z(n97) );
  CLKBUF_X1 U95 ( .A(a[12]), .Z(n98) );
  CLKBUF_X1 U96 ( .A(a[20]), .Z(n99) );
  CLKBUF_X1 U97 ( .A(a[13]), .Z(n100) );
  CLKBUF_X1 U98 ( .A(a[14]), .Z(n101) );
  CLKBUF_X1 U99 ( .A(a[15]), .Z(n102) );
  CLKBUF_X1 U100 ( .A(a[10]), .Z(n103) );
  CLKBUF_X1 U101 ( .A(a[11]), .Z(n104) );
  CLKBUF_X1 U102 ( .A(a[9]), .Z(n105) );
  CLKBUF_X1 U103 ( .A(a[24]), .Z(n106) );
  CLKBUF_X1 U104 ( .A(a[5]), .Z(n107) );
  CLKBUF_X1 U105 ( .A(a[6]), .Z(n108) );
  CLKBUF_X1 U106 ( .A(a[7]), .Z(n109) );
  CLKBUF_X1 U107 ( .A(a[22]), .Z(n110) );
  CLKBUF_X1 U108 ( .A(a[21]), .Z(n111) );
  CLKBUF_X1 U109 ( .A(a[4]), .Z(n112) );
  INV_X1 U110 ( .A(n114), .ZN(n113) );
  CLKBUF_X1 U111 ( .A(N7), .Z(n114) );
  CLKBUF_X1 U112 ( .A(a[8]), .Z(n115) );
  AND2_X1 U113 ( .A1(n127), .A2(N112), .ZN(N144) );
  INV_X1 U114 ( .A(n125), .ZN(n124) );
  INV_X1 U115 ( .A(n71), .ZN(n152) );
  AOI22_X1 U116 ( .A1(N31), .A2(N5), .B1(N70), .B2(n125), .ZN(n71) );
  INV_X1 U117 ( .A(n70), .ZN(n156) );
  AOI22_X1 U118 ( .A1(N32), .A2(N5), .B1(N71), .B2(n125), .ZN(n70) );
  INV_X1 U119 ( .A(n69), .ZN(n150) );
  AOI22_X1 U120 ( .A1(N33), .A2(N5), .B1(N72), .B2(n125), .ZN(n69) );
  INV_X1 U121 ( .A(n68), .ZN(n155) );
  AOI22_X1 U122 ( .A1(N34), .A2(N5), .B1(N73), .B2(n125), .ZN(n68) );
  INV_X1 U123 ( .A(n63), .ZN(n154) );
  AOI22_X1 U124 ( .A1(N38), .A2(N5), .B1(N77), .B2(n125), .ZN(n63) );
  INV_X1 U125 ( .A(n64), .ZN(n151) );
  AOI22_X1 U126 ( .A1(N37), .A2(N5), .B1(N76), .B2(n125), .ZN(n64) );
  INV_X1 U127 ( .A(n78), .ZN(n134) );
  AOI22_X1 U128 ( .A1(N15), .A2(n124), .B1(N54), .B2(n125), .ZN(n78) );
  INV_X1 U129 ( .A(n53), .ZN(n138) );
  AOI22_X1 U130 ( .A1(N19), .A2(n124), .B1(N58), .B2(n125), .ZN(n53) );
  INV_X1 U131 ( .A(n52), .ZN(n139) );
  AOI22_X1 U132 ( .A1(N20), .A2(n124), .B1(N59), .B2(n125), .ZN(n52) );
  INV_X1 U133 ( .A(n67), .ZN(n135) );
  AOI22_X1 U134 ( .A1(N16), .A2(n124), .B1(N55), .B2(n125), .ZN(n67) );
  INV_X1 U135 ( .A(n56), .ZN(n136) );
  AOI22_X1 U136 ( .A1(N17), .A2(n124), .B1(N56), .B2(n125), .ZN(n56) );
  INV_X1 U137 ( .A(n54), .ZN(n137) );
  AOI22_X1 U138 ( .A1(N18), .A2(n124), .B1(N57), .B2(n125), .ZN(n54) );
  INV_X1 U139 ( .A(n51), .ZN(n140) );
  AOI22_X1 U140 ( .A1(N21), .A2(n124), .B1(N60), .B2(n125), .ZN(n51) );
  INV_X1 U141 ( .A(n75), .ZN(n144) );
  AOI22_X1 U142 ( .A1(N27), .A2(n124), .B1(N66), .B2(n125), .ZN(n75) );
  INV_X1 U143 ( .A(n72), .ZN(n147) );
  AOI22_X1 U144 ( .A1(N30), .A2(N5), .B1(N69), .B2(n125), .ZN(n72) );
  INV_X1 U145 ( .A(n49), .ZN(n148) );
  AOI22_X1 U146 ( .A1(N23), .A2(n124), .B1(N62), .B2(n125), .ZN(n49) );
  INV_X1 U147 ( .A(n77), .ZN(n142) );
  AOI22_X1 U148 ( .A1(N25), .A2(n124), .B1(N64), .B2(n125), .ZN(n77) );
  INV_X1 U149 ( .A(n48), .ZN(n149) );
  AOI22_X1 U150 ( .A1(n124), .A2(N24), .B1(N63), .B2(n125), .ZN(n48) );
  INV_X1 U151 ( .A(n74), .ZN(n145) );
  AOI22_X1 U152 ( .A1(N28), .A2(n124), .B1(N67), .B2(n125), .ZN(n74) );
  INV_X1 U153 ( .A(n76), .ZN(n143) );
  AOI22_X1 U154 ( .A1(N26), .A2(n124), .B1(N65), .B2(n125), .ZN(n76) );
  INV_X1 U155 ( .A(n73), .ZN(n146) );
  AOI22_X1 U156 ( .A1(N29), .A2(N5), .B1(N68), .B2(n125), .ZN(n73) );
  INV_X1 U157 ( .A(n50), .ZN(n141) );
  AOI22_X1 U158 ( .A1(N22), .A2(n124), .B1(N61), .B2(n125), .ZN(n50) );
  INV_X1 U159 ( .A(n65), .ZN(n157) );
  AOI22_X1 U160 ( .A1(N36), .A2(N5), .B1(N75), .B2(n125), .ZN(n65) );
  INV_X1 U161 ( .A(n66), .ZN(n153) );
  AOI22_X1 U162 ( .A1(N35), .A2(N5), .B1(N74), .B2(n125), .ZN(n66) );
  AND2_X1 U163 ( .A1(N40), .A2(N5), .ZN(n116) );
  AND2_X1 U164 ( .A1(N41), .A2(n124), .ZN(n117) );
  AND2_X1 U165 ( .A1(N42), .A2(n124), .ZN(n118) );
  AND2_X1 U166 ( .A1(N43), .A2(n124), .ZN(n119) );
  AND2_X1 U167 ( .A1(N44), .A2(n124), .ZN(n120) );
  AND2_X1 U168 ( .A1(N45), .A2(n124), .ZN(n121) );
  AND2_X1 U169 ( .A1(N39), .A2(n124), .ZN(n122) );
  BUF_X1 U170 ( .A(n127), .Z(n126) );
  INV_X1 U171 ( .A(n106), .ZN(n128) );
  INV_X1 U172 ( .A(n93), .ZN(n129) );
  INV_X1 U173 ( .A(n130), .ZN(n132) );
  INV_X1 U174 ( .A(N5), .ZN(n125) );
  INV_X1 U175 ( .A(n82), .ZN(n133) );
  XNOR2_X1 U176 ( .A(n82), .B(n123), .ZN(N53) );
  NAND2_X1 U177 ( .A1(\sub_11/carry [6]), .A2(n91), .ZN(n123) );
  NOR2_X1 U178 ( .A1(n158), .A2(alu_rst), .ZN(N79) );
  INV_X1 U179 ( .A(n79), .ZN(n158) );
  BUF_X1 U180 ( .A(a[31]), .Z(n127) );
  XOR2_X1 U181 ( .A(n91), .B(\sub_11/carry [6]), .Z(N52) );
  AND2_X1 U182 ( .A1(\sub_11/carry [5]), .A2(n94), .ZN(\sub_11/carry [6]) );
  XOR2_X1 U183 ( .A(n94), .B(\sub_11/carry [5]), .Z(N51) );
  OR2_X1 U184 ( .A1(n89), .A2(\sub_11/carry [4]), .ZN(\sub_11/carry [5]) );
  XNOR2_X1 U185 ( .A(\sub_11/carry [4]), .B(n89), .ZN(N50) );
  AND2_X1 U186 ( .A1(\sub_11/carry [3]), .A2(n129), .ZN(\sub_11/carry [4]) );
  XOR2_X1 U187 ( .A(n129), .B(\sub_11/carry [3]), .Z(N49) );
  OR2_X1 U188 ( .A1(n87), .A2(\sub_11/carry [2]), .ZN(\sub_11/carry [3]) );
  XNOR2_X1 U189 ( .A(\sub_11/carry [2]), .B(n87), .ZN(N48) );
  OR2_X1 U190 ( .A1(n128), .A2(n113), .ZN(\sub_11/carry [2]) );
  XNOR2_X1 U191 ( .A(n113), .B(n128), .ZN(N47) );
  XOR2_X1 U192 ( .A(n82), .B(\sub_9/carry [7]), .Z(N14) );
  OR2_X1 U193 ( .A1(n92), .A2(\sub_9/carry [6]), .ZN(\sub_9/carry [7]) );
  XNOR2_X1 U194 ( .A(\sub_9/carry [6]), .B(n92), .ZN(N13) );
  OR2_X1 U195 ( .A1(n95), .A2(\sub_9/carry [5]), .ZN(\sub_9/carry [6]) );
  XNOR2_X1 U196 ( .A(\sub_9/carry [5]), .B(n95), .ZN(N12) );
  AND2_X1 U197 ( .A1(\sub_9/carry [4]), .A2(n90), .ZN(\sub_9/carry [5]) );
  XOR2_X1 U198 ( .A(n90), .B(\sub_9/carry [4]), .Z(N11) );
  OR2_X1 U199 ( .A1(n93), .A2(\sub_9/carry [3]), .ZN(\sub_9/carry [4]) );
  XNOR2_X1 U200 ( .A(\sub_9/carry [3]), .B(n93), .ZN(N10) );
  AND2_X1 U201 ( .A1(n106), .A2(n88), .ZN(\sub_9/carry [3]) );
  XOR2_X1 U202 ( .A(n88), .B(n106), .Z(N9) );
  AOI21_X1 U203 ( .B1(n88), .B2(n106), .A(n93), .ZN(n130) );
  AOI211_X1 U204 ( .C1(n90), .C2(n132), .A(n92), .B(n95), .ZN(n131) );
  NOR2_X1 U205 ( .A1(n131), .A2(n133), .ZN(N5) );
endmodule

