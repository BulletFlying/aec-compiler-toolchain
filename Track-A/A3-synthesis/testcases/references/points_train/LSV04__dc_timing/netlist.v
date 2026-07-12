/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Sun Jul  5 14:10:51 2026
/////////////////////////////////////////////////////////////


module b11 ( x_in, stbi, clock, reset, x_out );
  input [5:0] x_in;
  output [5:0] x_out;
  input stbi, clock, reset;
  wire   N501, N503, \C33/DATA3_0 , \C33/DATA3_1 , \C33/DATA3_2 ,
         \C33/DATA3_3 , \C33/DATA3_4 , \C33/DATA3_5 , \C33/DATA3_6 ,
         \C33/DATA3_7 , \C33/DATA3_8 , \C33/DATA3_9 , \C33/DATA3_10 ,
         \C33/DATA3_11 , \C33/DATA3_12 , \C33/DATA3_13 , \C33/DATA3_14 ,
         \C33/DATA3_15 , \C33/DATA3_16 , \C33/DATA3_17 , \C33/DATA3_18 ,
         \C33/DATA3_19 , \C33/DATA3_20 , \C33/DATA3_21 , \C33/DATA3_22 ,
         \C33/DATA3_23 , \C33/DATA3_24 , \C33/DATA3_25 , \C33/DATA3_26 ,
         \C33/DATA3_27 , \C33/DATA3_28 , \C33/DATA3_29 , \C33/DATA3_30 , n210,
         n211, n212, n213, n214, n215, n242, n243, n244, n245, n246, n248,
         n249, n250, n251, n252, n253, n254, n255, n256, n257, n258, n259,
         n260, n261, n262, n263, n264, n265, n266, n267, n268, n269, n270,
         n271, n272, n273, n274, n275, n276, n277, n278, n279, n280, n281,
         n282, n283, n284, n285, n286, n287, n288, n289, \U8/RSOP_50/C2/Z_30 ,
         \U8/RSOP_50/C2/Z_29 , \U8/RSOP_50/C2/Z_28 , \U8/RSOP_50/C2/Z_27 ,
         \U8/RSOP_50/C2/Z_26 , \U8/RSOP_50/C2/Z_25 , \U8/RSOP_50/C2/Z_24 ,
         \U8/RSOP_50/C2/Z_23 , \U8/RSOP_50/C2/Z_22 , \U8/RSOP_50/C2/Z_21 ,
         \U8/RSOP_50/C2/Z_20 , \U8/RSOP_50/C2/Z_19 , \U8/RSOP_50/C2/Z_18 ,
         \U8/RSOP_50/C2/Z_17 , \U8/RSOP_50/C2/Z_16 , \U8/RSOP_50/C2/Z_15 ,
         \U8/RSOP_50/C2/Z_14 , \U8/RSOP_50/C2/Z_13 , \U8/RSOP_50/C2/Z_12 ,
         \U8/RSOP_50/C2/Z_11 , \U8/RSOP_50/C2/Z_10 , \U8/RSOP_50/C2/Z_9 ,
         \U8/RSOP_50/C2/Z_8 , \U8/RSOP_50/C2/Z_7 , \U8/RSOP_50/C2/Z_6 ,
         \DP_OP_61J1_122_4439/n139 , \DP_OP_61J1_122_4439/n138 ,
         \DP_OP_61J1_122_4439/n137 , \DP_OP_61J1_122_4439/n136 ,
         \DP_OP_61J1_122_4439/n135 , \DP_OP_61J1_122_4439/n134 ,
         \DP_OP_61J1_122_4439/n68 , \DP_OP_61J1_122_4439/n67 ,
         \DP_OP_61J1_122_4439/n66 , \DP_OP_61J1_122_4439/n65 ,
         \DP_OP_61J1_122_4439/n64 , \DP_OP_61J1_122_4439/n63 ,
         \DP_OP_61J1_122_4439/n62 , \DP_OP_61J1_122_4439/n61 ,
         \DP_OP_61J1_122_4439/n60 , \DP_OP_61J1_122_4439/n59 ,
         \DP_OP_61J1_122_4439/n58 , \DP_OP_61J1_122_4439/n57 ,
         \DP_OP_61J1_122_4439/n56 , \DP_OP_61J1_122_4439/n55 ,
         \DP_OP_61J1_122_4439/n54 , \DP_OP_61J1_122_4439/n53 ,
         \DP_OP_61J1_122_4439/n52 , \DP_OP_61J1_122_4439/n51 ,
         \DP_OP_61J1_122_4439/n50 , \DP_OP_61J1_122_4439/n49 ,
         \DP_OP_61J1_122_4439/n48 , \DP_OP_61J1_122_4439/n47 ,
         \DP_OP_61J1_122_4439/n46 , \DP_OP_61J1_122_4439/n45 ,
         \DP_OP_61J1_122_4439/n44 , \DP_OP_61J1_122_4439/n43 ,
         \DP_OP_61J1_122_4439/n42 , \DP_OP_61J1_122_4439/n41 ,
         \DP_OP_61J1_122_4439/n40 , \DP_OP_61J1_122_4439/n39 ,
         \DP_OP_61J1_122_4439/n38 , \DP_OP_61J1_122_4439/n32 ,
         \DP_OP_61J1_122_4439/n31 , \DP_OP_61J1_122_4439/n30 ,
         \DP_OP_61J1_122_4439/n29 , \DP_OP_61J1_122_4439/n28 ,
         \DP_OP_61J1_122_4439/n27 , \DP_OP_61J1_122_4439/n26 ,
         \DP_OP_61J1_122_4439/n25 , \DP_OP_61J1_122_4439/n24 ,
         \DP_OP_61J1_122_4439/n23 , \DP_OP_61J1_122_4439/n22 ,
         \DP_OP_61J1_122_4439/n21 , \DP_OP_61J1_122_4439/n20 ,
         \DP_OP_61J1_122_4439/n19 , \DP_OP_61J1_122_4439/n18 ,
         \DP_OP_61J1_122_4439/n17 , \DP_OP_61J1_122_4439/n16 ,
         \DP_OP_61J1_122_4439/n15 , \DP_OP_61J1_122_4439/n14 ,
         \DP_OP_61J1_122_4439/n13 , \DP_OP_61J1_122_4439/n12 ,
         \DP_OP_61J1_122_4439/n11 , \DP_OP_61J1_122_4439/n10 ,
         \DP_OP_61J1_122_4439/n9 , \DP_OP_61J1_122_4439/n8 ,
         \DP_OP_61J1_122_4439/n7 , \DP_OP_61J1_122_4439/n6 ,
         \DP_OP_61J1_122_4439/n5 , \DP_OP_61J1_122_4439/n4 ,
         \DP_OP_61J1_122_4439/n3 , \DP_OP_61J1_122_4439/n2 , n298, n299, n300,
         n301, n302, n303, n304, n305, n306, n307, n308, n309, n310, n311,
         n312, n313, n314, n315, n316, n317, n318, n319, n320, n321, n322,
         n323, n324, n325, n326, n327, n328, n329, n330, n331, n332, n333,
         n334, n335, n336, n337, n338, n339, n340, n341, n342, n343, n344,
         n345, n346, n347, n348, n349, n350, n351, n352, n353, n354, n355,
         n356, n357, n358, n359, n360, n361, n362, n363, n364, n365, n366,
         n367, n368, n369, n370, n371, n372, n373, n374, n375, n376, n377,
         n378, n379, n380, n381, n382, n383, n384, n385, n386, n387, n388,
         n389, n390, n391, n392, n393, n394, n395, n396, n397, n398, n399,
         n400, n401, n402, n403, n404, n405, n406, n407, n408, n409, n410,
         n411, n412, n413, n414, n415, n416, n417, n418, n419, n420, n421,
         n422, n423, n424, n425, n426, n427, n428, n429, n430, n431, n432,
         n433, n434, n435, n436, n437, n438, n439, n440, n441, n442, n443,
         n444, n445, n446, n447, n448, n449, n450, n451, n452, n453, n454,
         n455, n456, n457, n458, n459, n460, n461, n462, n463, n464, n465,
         n466, n467, n468, n469, n470, n471, n472, n473, n474, n475, n476,
         n477, n478, n479, n480, n481, n482, n483, n484, n485, n486, n487,
         n488, n489, n490, n491, n492, n493, n494, n495, n496, n497, n498,
         n499, n500, n501, n502, n503, n504, n505, n506, n507, n508, n509,
         n510, n511, n512, n513, n514, n515, n516, n517, n518, n519, n520,
         n521, n522, n523, n524, n525, n526, n527, n528, n529, n530, n531,
         n532, n533, n534, n535, n536, n537, n538, n539, n540, n541, n542,
         n543, n544, n545, n546, n547, n548, n549, n550, n551;
  wire   [3:0] stato;
  wire   [31:0] r_in;
  wire   [31:0] cont;
  wire   [31:0] cont1;

  DFFR_X1 \r_in_reg[0]  ( .D(n253), .CK(clock), .RN(n550), .Q(r_in[0]), .QN(
        n507) );
  DFFR_X1 \stato_reg[0]  ( .D(n256), .CK(clock), .RN(n550), .Q(stato[0]), .QN(
        n514) );
  DFFR_X1 \stato_reg[2]  ( .D(n255), .CK(clock), .RN(n549), .Q(stato[2]) );
  DFFR_X1 \stato_reg[3]  ( .D(n287), .CK(clock), .RN(n549), .Q(stato[3]), .QN(
        n516) );
  DFFR_X1 \r_in_reg[5]  ( .D(n252), .CK(clock), .RN(n549), .Q(r_in[5]), .QN(
        n529) );
  DFFR_X1 \r_in_reg[4]  ( .D(n251), .CK(clock), .RN(n549), .Q(r_in[4]), .QN(
        n530) );
  DFFR_X1 \r_in_reg[3]  ( .D(n250), .CK(clock), .RN(n550), .Q(r_in[3]), .QN(
        n505) );
  DFFR_X1 \r_in_reg[1]  ( .D(n248), .CK(clock), .RN(n551), .Q(r_in[1]), .QN(
        n508) );
  DFFR_X1 \cont_reg[4]  ( .D(n242), .CK(clock), .RN(n549), .Q(cont[4]) );
  DFFR_X1 \cont_reg[3]  ( .D(n243), .CK(clock), .RN(n551), .Q(cont[3]), .QN(
        n541) );
  DFFR_X1 \cont_reg[2]  ( .D(n244), .CK(clock), .RN(n549), .Q(cont[2]), .QN(
        n504) );
  DFFR_X1 \cont_reg[1]  ( .D(n245), .CK(clock), .RN(n551), .Q(cont[1]), .QN(
        n542) );
  DFFR_X1 \cont_reg[0]  ( .D(n246), .CK(clock), .RN(n549), .Q(cont[0]), .QN(
        n511) );
  DFFR_X1 \cont1_reg[31]  ( .D(n288), .CK(clock), .RN(n550), .Q(N501), .QN(
        n512) );
  DFFR_X1 \cont1_reg[30]  ( .D(n257), .CK(clock), .RN(n550), .Q(cont1[30]), 
        .QN(n513) );
  DFFR_X1 \cont1_reg[29]  ( .D(n258), .CK(clock), .RN(n550), .QN(n515) );
  DFFR_X1 \cont1_reg[28]  ( .D(n259), .CK(clock), .RN(n549), .Q(cont1[28]), 
        .QN(n544) );
  DFFR_X1 \cont1_reg[27]  ( .D(n260), .CK(clock), .RN(n550), .Q(cont1[27]), 
        .QN(n546) );
  DFFR_X1 \cont1_reg[26]  ( .D(n261), .CK(clock), .RN(n551), .Q(cont1[26]), 
        .QN(n545) );
  DFFR_X1 \cont1_reg[25]  ( .D(n262), .CK(clock), .RN(n549), .Q(cont1[25]), 
        .QN(n543) );
  DFFR_X1 \cont1_reg[24]  ( .D(n263), .CK(clock), .RN(n550), .Q(cont1[24]), 
        .QN(n535) );
  DFFR_X1 \cont1_reg[23]  ( .D(n264), .CK(clock), .RN(n551), .Q(cont1[23]), 
        .QN(n531) );
  DFFR_X1 \cont1_reg[22]  ( .D(n265), .CK(clock), .RN(n549), .Q(cont1[22]), 
        .QN(n534) );
  DFFR_X1 \cont1_reg[21]  ( .D(n266), .CK(clock), .RN(n550), .Q(cont1[21]), 
        .QN(n532) );
  DFFR_X1 \cont1_reg[20]  ( .D(n267), .CK(clock), .RN(n551), .Q(cont1[20]), 
        .QN(n537) );
  DFFR_X1 \cont1_reg[19]  ( .D(n268), .CK(clock), .RN(n549), .Q(cont1[19]), 
        .QN(n533) );
  DFFR_X1 \cont1_reg[18]  ( .D(n269), .CK(clock), .RN(n550), .Q(cont1[18]), 
        .QN(n538) );
  DFFR_X1 \cont1_reg[17]  ( .D(n270), .CK(clock), .RN(n551), .Q(cont1[17]), 
        .QN(n540) );
  DFFR_X1 \cont1_reg[16]  ( .D(n271), .CK(clock), .RN(n551), .Q(cont1[16]), 
        .QN(n539) );
  DFFR_X1 \cont1_reg[15]  ( .D(n272), .CK(clock), .RN(n550), .Q(cont1[15]), 
        .QN(n536) );
  DFFR_X1 \cont1_reg[14]  ( .D(n273), .CK(clock), .RN(n551), .QN(n547) );
  DFFR_X1 \cont1_reg[13]  ( .D(n274), .CK(clock), .RN(n549), .Q(cont1[13]), 
        .QN(n521) );
  DFFR_X1 \cont1_reg[12]  ( .D(n275), .CK(clock), .RN(n550), .Q(cont1[12]), 
        .QN(n525) );
  DFFR_X1 \cont1_reg[11]  ( .D(n276), .CK(clock), .RN(n551), .Q(cont1[11]), 
        .QN(n522) );
  DFFR_X1 \cont1_reg[10]  ( .D(n277), .CK(clock), .RN(n549), .Q(cont1[10]), 
        .QN(n528) );
  DFFR_X1 \cont1_reg[9]  ( .D(n278), .CK(clock), .RN(n550), .Q(cont1[9]), .QN(
        n526) );
  DFFR_X1 \cont1_reg[8]  ( .D(n279), .CK(clock), .RN(n551), .Q(cont1[8]), .QN(
        n523) );
  DFFR_X1 \cont1_reg[7]  ( .D(n280), .CK(clock), .RN(n550), .Q(cont1[7]), .QN(
        n527) );
  DFFR_X1 \cont1_reg[6]  ( .D(n281), .CK(clock), .RN(n551), .Q(cont1[6]), .QN(
        n524) );
  DFFR_X1 \cont1_reg[5]  ( .D(n282), .CK(clock), .RN(n550), .Q(cont1[5]), .QN(
        n503) );
  DFFR_X1 \x_out_reg[5]  ( .D(n210), .CK(clock), .RN(n551), .Q(x_out[5]) );
  DFFR_X1 \cont1_reg[4]  ( .D(n283), .CK(clock), .RN(n551), .Q(cont1[4]), .QN(
        n510) );
  DFFR_X1 \x_out_reg[4]  ( .D(n211), .CK(clock), .RN(n549), .Q(x_out[4]) );
  DFFR_X1 \cont1_reg[3]  ( .D(n284), .CK(clock), .RN(n549), .Q(cont1[3]), .QN(
        n517) );
  DFFR_X1 \x_out_reg[3]  ( .D(n212), .CK(clock), .RN(n549), .Q(x_out[3]) );
  DFFR_X1 \cont1_reg[2]  ( .D(n285), .CK(clock), .RN(n551), .Q(cont1[2]), .QN(
        n518) );
  DFFR_X1 \x_out_reg[2]  ( .D(n213), .CK(clock), .RN(n551), .Q(x_out[2]) );
  DFFR_X1 \cont1_reg[1]  ( .D(n286), .CK(clock), .RN(n551), .Q(cont1[1]), .QN(
        n520) );
  DFFR_X1 \x_out_reg[1]  ( .D(n214), .CK(clock), .RN(n550), .Q(x_out[1]) );
  DFFR_X1 \cont1_reg[0]  ( .D(n289), .CK(clock), .RN(n549), .Q(N503), .QN(n519) );
  DFFR_X1 \x_out_reg[0]  ( .D(n215), .CK(clock), .RN(n549), .Q(x_out[0]) );
  FA_X1 \DP_OP_61J1_122_4439/U33  ( .A(\DP_OP_61J1_122_4439/n134 ), .B(n548), 
        .CI(\DP_OP_61J1_122_4439/n68 ), .CO(\DP_OP_61J1_122_4439/n32 ), .S(
        \C33/DATA3_0 ) );
  FA_X1 \DP_OP_61J1_122_4439/U32  ( .A(\DP_OP_61J1_122_4439/n67 ), .B(
        \DP_OP_61J1_122_4439/n135 ), .CI(\DP_OP_61J1_122_4439/n32 ), .CO(
        \DP_OP_61J1_122_4439/n31 ), .S(\C33/DATA3_1 ) );
  FA_X1 \DP_OP_61J1_122_4439/U31  ( .A(\DP_OP_61J1_122_4439/n66 ), .B(
        \DP_OP_61J1_122_4439/n136 ), .CI(\DP_OP_61J1_122_4439/n31 ), .CO(
        \DP_OP_61J1_122_4439/n30 ), .S(\C33/DATA3_2 ) );
  FA_X1 \DP_OP_61J1_122_4439/U30  ( .A(\DP_OP_61J1_122_4439/n65 ), .B(
        \DP_OP_61J1_122_4439/n137 ), .CI(\DP_OP_61J1_122_4439/n30 ), .CO(
        \DP_OP_61J1_122_4439/n29 ), .S(\C33/DATA3_3 ) );
  FA_X1 \DP_OP_61J1_122_4439/U29  ( .A(\DP_OP_61J1_122_4439/n64 ), .B(
        \DP_OP_61J1_122_4439/n138 ), .CI(\DP_OP_61J1_122_4439/n29 ), .CO(
        \DP_OP_61J1_122_4439/n28 ), .S(\C33/DATA3_4 ) );
  FA_X1 \DP_OP_61J1_122_4439/U28  ( .A(\DP_OP_61J1_122_4439/n63 ), .B(
        \DP_OP_61J1_122_4439/n139 ), .CI(\DP_OP_61J1_122_4439/n28 ), .CO(
        \DP_OP_61J1_122_4439/n27 ), .S(\C33/DATA3_5 ) );
  FA_X1 \DP_OP_61J1_122_4439/U27  ( .A(\DP_OP_61J1_122_4439/n62 ), .B(
        \U8/RSOP_50/C2/Z_6 ), .CI(\DP_OP_61J1_122_4439/n27 ), .CO(
        \DP_OP_61J1_122_4439/n26 ), .S(\C33/DATA3_6 ) );
  FA_X1 \DP_OP_61J1_122_4439/U26  ( .A(\DP_OP_61J1_122_4439/n61 ), .B(
        \U8/RSOP_50/C2/Z_7 ), .CI(\DP_OP_61J1_122_4439/n26 ), .CO(
        \DP_OP_61J1_122_4439/n25 ), .S(\C33/DATA3_7 ) );
  FA_X1 \DP_OP_61J1_122_4439/U25  ( .A(\DP_OP_61J1_122_4439/n60 ), .B(
        \U8/RSOP_50/C2/Z_8 ), .CI(\DP_OP_61J1_122_4439/n25 ), .CO(
        \DP_OP_61J1_122_4439/n24 ), .S(\C33/DATA3_8 ) );
  FA_X1 \DP_OP_61J1_122_4439/U24  ( .A(\DP_OP_61J1_122_4439/n59 ), .B(
        \U8/RSOP_50/C2/Z_9 ), .CI(\DP_OP_61J1_122_4439/n24 ), .CO(
        \DP_OP_61J1_122_4439/n23 ), .S(\C33/DATA3_9 ) );
  FA_X1 \DP_OP_61J1_122_4439/U23  ( .A(\DP_OP_61J1_122_4439/n58 ), .B(
        \U8/RSOP_50/C2/Z_10 ), .CI(\DP_OP_61J1_122_4439/n23 ), .CO(
        \DP_OP_61J1_122_4439/n22 ), .S(\C33/DATA3_10 ) );
  FA_X1 \DP_OP_61J1_122_4439/U22  ( .A(\DP_OP_61J1_122_4439/n57 ), .B(
        \U8/RSOP_50/C2/Z_11 ), .CI(\DP_OP_61J1_122_4439/n22 ), .CO(
        \DP_OP_61J1_122_4439/n21 ), .S(\C33/DATA3_11 ) );
  FA_X1 \DP_OP_61J1_122_4439/U21  ( .A(\DP_OP_61J1_122_4439/n56 ), .B(
        \U8/RSOP_50/C2/Z_12 ), .CI(\DP_OP_61J1_122_4439/n21 ), .CO(
        \DP_OP_61J1_122_4439/n20 ), .S(\C33/DATA3_12 ) );
  FA_X1 \DP_OP_61J1_122_4439/U20  ( .A(\DP_OP_61J1_122_4439/n55 ), .B(
        \U8/RSOP_50/C2/Z_13 ), .CI(\DP_OP_61J1_122_4439/n20 ), .CO(
        \DP_OP_61J1_122_4439/n19 ), .S(\C33/DATA3_13 ) );
  FA_X1 \DP_OP_61J1_122_4439/U19  ( .A(\DP_OP_61J1_122_4439/n54 ), .B(
        \U8/RSOP_50/C2/Z_14 ), .CI(\DP_OP_61J1_122_4439/n19 ), .CO(
        \DP_OP_61J1_122_4439/n18 ), .S(\C33/DATA3_14 ) );
  FA_X1 \DP_OP_61J1_122_4439/U18  ( .A(\DP_OP_61J1_122_4439/n53 ), .B(
        \U8/RSOP_50/C2/Z_15 ), .CI(\DP_OP_61J1_122_4439/n18 ), .CO(
        \DP_OP_61J1_122_4439/n17 ), .S(\C33/DATA3_15 ) );
  FA_X1 \DP_OP_61J1_122_4439/U17  ( .A(\DP_OP_61J1_122_4439/n52 ), .B(
        \U8/RSOP_50/C2/Z_16 ), .CI(\DP_OP_61J1_122_4439/n17 ), .CO(
        \DP_OP_61J1_122_4439/n16 ), .S(\C33/DATA3_16 ) );
  FA_X1 \DP_OP_61J1_122_4439/U16  ( .A(\DP_OP_61J1_122_4439/n51 ), .B(
        \U8/RSOP_50/C2/Z_17 ), .CI(\DP_OP_61J1_122_4439/n16 ), .CO(
        \DP_OP_61J1_122_4439/n15 ), .S(\C33/DATA3_17 ) );
  FA_X1 \DP_OP_61J1_122_4439/U15  ( .A(\DP_OP_61J1_122_4439/n50 ), .B(
        \U8/RSOP_50/C2/Z_18 ), .CI(\DP_OP_61J1_122_4439/n15 ), .CO(
        \DP_OP_61J1_122_4439/n14 ), .S(\C33/DATA3_18 ) );
  FA_X1 \DP_OP_61J1_122_4439/U14  ( .A(\DP_OP_61J1_122_4439/n49 ), .B(
        \U8/RSOP_50/C2/Z_19 ), .CI(\DP_OP_61J1_122_4439/n14 ), .CO(
        \DP_OP_61J1_122_4439/n13 ), .S(\C33/DATA3_19 ) );
  FA_X1 \DP_OP_61J1_122_4439/U13  ( .A(\DP_OP_61J1_122_4439/n48 ), .B(
        \U8/RSOP_50/C2/Z_20 ), .CI(\DP_OP_61J1_122_4439/n13 ), .CO(
        \DP_OP_61J1_122_4439/n12 ), .S(\C33/DATA3_20 ) );
  FA_X1 \DP_OP_61J1_122_4439/U12  ( .A(\DP_OP_61J1_122_4439/n47 ), .B(
        \U8/RSOP_50/C2/Z_21 ), .CI(\DP_OP_61J1_122_4439/n12 ), .CO(
        \DP_OP_61J1_122_4439/n11 ), .S(\C33/DATA3_21 ) );
  FA_X1 \DP_OP_61J1_122_4439/U11  ( .A(\DP_OP_61J1_122_4439/n46 ), .B(
        \U8/RSOP_50/C2/Z_22 ), .CI(\DP_OP_61J1_122_4439/n11 ), .CO(
        \DP_OP_61J1_122_4439/n10 ), .S(\C33/DATA3_22 ) );
  FA_X1 \DP_OP_61J1_122_4439/U10  ( .A(\DP_OP_61J1_122_4439/n45 ), .B(
        \U8/RSOP_50/C2/Z_23 ), .CI(\DP_OP_61J1_122_4439/n10 ), .CO(
        \DP_OP_61J1_122_4439/n9 ), .S(\C33/DATA3_23 ) );
  FA_X1 \DP_OP_61J1_122_4439/U9  ( .A(\DP_OP_61J1_122_4439/n44 ), .B(
        \U8/RSOP_50/C2/Z_24 ), .CI(\DP_OP_61J1_122_4439/n9 ), .CO(
        \DP_OP_61J1_122_4439/n8 ), .S(\C33/DATA3_24 ) );
  FA_X1 \DP_OP_61J1_122_4439/U8  ( .A(\DP_OP_61J1_122_4439/n43 ), .B(
        \U8/RSOP_50/C2/Z_25 ), .CI(\DP_OP_61J1_122_4439/n8 ), .CO(
        \DP_OP_61J1_122_4439/n7 ), .S(\C33/DATA3_25 ) );
  FA_X1 \DP_OP_61J1_122_4439/U7  ( .A(\DP_OP_61J1_122_4439/n42 ), .B(
        \U8/RSOP_50/C2/Z_26 ), .CI(\DP_OP_61J1_122_4439/n7 ), .CO(
        \DP_OP_61J1_122_4439/n6 ), .S(\C33/DATA3_26 ) );
  FA_X1 \DP_OP_61J1_122_4439/U6  ( .A(\DP_OP_61J1_122_4439/n41 ), .B(
        \U8/RSOP_50/C2/Z_27 ), .CI(\DP_OP_61J1_122_4439/n6 ), .CO(
        \DP_OP_61J1_122_4439/n5 ), .S(\C33/DATA3_27 ) );
  FA_X1 \DP_OP_61J1_122_4439/U5  ( .A(\DP_OP_61J1_122_4439/n40 ), .B(
        \U8/RSOP_50/C2/Z_28 ), .CI(\DP_OP_61J1_122_4439/n5 ), .CO(
        \DP_OP_61J1_122_4439/n4 ), .S(\C33/DATA3_28 ) );
  FA_X1 \DP_OP_61J1_122_4439/U4  ( .A(\DP_OP_61J1_122_4439/n39 ), .B(
        \U8/RSOP_50/C2/Z_29 ), .CI(\DP_OP_61J1_122_4439/n4 ), .CO(
        \DP_OP_61J1_122_4439/n3 ), .S(\C33/DATA3_29 ) );
  FA_X1 \DP_OP_61J1_122_4439/U3  ( .A(\DP_OP_61J1_122_4439/n38 ), .B(
        \U8/RSOP_50/C2/Z_30 ), .CI(\DP_OP_61J1_122_4439/n3 ), .CO(
        \DP_OP_61J1_122_4439/n2 ), .S(\C33/DATA3_30 ) );
  DFFR_X1 \stato_reg[1]  ( .D(n254), .CK(clock), .RN(n550), .Q(stato[1]), .QN(
        n506) );
  DFFR_X1 \r_in_reg[2]  ( .D(n249), .CK(clock), .RN(n550), .Q(r_in[2]), .QN(
        n509) );
  CLKBUF_X1 U301 ( .A(reset), .Z(n298) );
  CLKBUF_X1 U302 ( .A(stbi), .Z(n299) );
  NOR2_X1 U303 ( .A1(n459), .A2(n344), .ZN(n457) );
  INV_X1 U304 ( .A(n298), .ZN(n551) );
  CLKBUF_X1 U305 ( .A(n551), .Z(n550) );
  CLKBUF_X1 U306 ( .A(n551), .Z(n549) );
  NOR3_X1 U307 ( .A1(stato[2]), .A2(stato[1]), .A3(stato[0]), .ZN(n465) );
  INV_X1 U308 ( .A(n465), .ZN(n498) );
  NOR2_X1 U309 ( .A1(n516), .A2(n498), .ZN(n499) );
  AOI22_X1 U310 ( .A1(n498), .A2(x_out[0]), .B1(N503), .B2(n499), .ZN(n300) );
  INV_X1 U311 ( .A(n300), .ZN(n215) );
  AND2_X1 U312 ( .A1(N501), .A2(N503), .ZN(n301) );
  XOR2_X1 U313 ( .A(cont1[1]), .B(n301), .Z(n302) );
  AOI22_X1 U314 ( .A1(n498), .A2(x_out[1]), .B1(n302), .B2(n499), .ZN(n303) );
  INV_X1 U315 ( .A(n303), .ZN(n214) );
  NOR2_X1 U316 ( .A1(cont1[7]), .A2(cont1[6]), .ZN(n305) );
  NOR3_X1 U317 ( .A1(cont1[15]), .A2(cont1[22]), .A3(cont1[21]), .ZN(n304) );
  NAND2_X1 U318 ( .A1(n305), .A2(n304), .ZN(n316) );
  NOR2_X1 U319 ( .A1(cont1[9]), .A2(cont1[8]), .ZN(n320) );
  INV_X1 U320 ( .A(n320), .ZN(n308) );
  OAI221_X1 U321 ( .B1(cont1[2]), .B2(cont1[1]), .C1(cont1[2]), .C2(N503), .A(
        cont1[3]), .ZN(n306) );
  NOR2_X1 U322 ( .A1(cont1[24]), .A2(cont1[23]), .ZN(n319) );
  OAI211_X1 U323 ( .C1(n510), .C2(n306), .A(n319), .B(n503), .ZN(n307) );
  NOR4_X1 U324 ( .A1(cont1[25]), .A2(n316), .A3(n308), .A4(n307), .ZN(n314) );
  NOR3_X1 U325 ( .A1(cont1[10]), .A2(cont1[12]), .A3(cont1[11]), .ZN(n309) );
  NAND2_X1 U326 ( .A1(n309), .A2(n547), .ZN(n317) );
  NOR4_X1 U327 ( .A1(cont1[27]), .A2(cont1[26]), .A3(cont1[28]), .A4(cont1[30]), .ZN(n310) );
  NAND2_X1 U328 ( .A1(n310), .A2(n515), .ZN(n323) );
  OR4_X1 U329 ( .A1(cont1[17]), .A2(cont1[16]), .A3(cont1[18]), .A4(cont1[20]), 
        .ZN(n311) );
  NOR2_X1 U330 ( .A1(n311), .A2(cont1[19]), .ZN(n321) );
  INV_X1 U331 ( .A(n321), .ZN(n312) );
  NOR4_X1 U332 ( .A1(cont1[13]), .A2(n317), .A3(n323), .A4(n312), .ZN(n313) );
  AOI21_X1 U333 ( .B1(n314), .B2(n313), .A(N501), .ZN(n448) );
  NAND2_X1 U334 ( .A1(n516), .A2(stato[2]), .ZN(n344) );
  NAND2_X1 U335 ( .A1(n506), .A2(stato[0]), .ZN(n315) );
  NOR2_X1 U336 ( .A1(n344), .A2(n315), .ZN(n466) );
  NAND2_X1 U337 ( .A1(n448), .A2(n466), .ZN(n330) );
  OR2_X1 U338 ( .A1(n344), .A2(stato[0]), .ZN(n468) );
  NOR4_X1 U339 ( .A1(cont1[25]), .A2(cont1[13]), .A3(n317), .A4(n316), .ZN(
        n318) );
  NAND4_X1 U340 ( .A1(n321), .A2(n320), .A3(n319), .A4(n318), .ZN(n322) );
  OAI21_X1 U341 ( .B1(n323), .B2(n322), .A(n512), .ZN(n436) );
  NAND3_X1 U342 ( .A1(stato[1]), .A2(stato[0]), .A3(n516), .ZN(n324) );
  OAI221_X1 U343 ( .B1(n468), .B2(stato[1]), .C1(n468), .C2(n436), .A(n324), 
        .ZN(n328) );
  NOR4_X1 U344 ( .A1(r_in[0]), .A2(r_in[5]), .A3(r_in[1]), .A4(r_in[4]), .ZN(
        n327) );
  NAND4_X1 U345 ( .A1(r_in[0]), .A2(r_in[5]), .A3(r_in[1]), .A4(r_in[4]), .ZN(
        n325) );
  OAI21_X1 U346 ( .B1(n325), .B2(n505), .A(r_in[2]), .ZN(n326) );
  OAI221_X1 U347 ( .B1(n327), .B2(r_in[2]), .C1(r_in[2]), .C2(n505), .A(n326), 
        .ZN(n432) );
  NOR2_X1 U348 ( .A1(stato[2]), .A2(stato[3]), .ZN(n439) );
  NAND3_X1 U349 ( .A1(stato[1]), .A2(n439), .A3(n514), .ZN(n433) );
  NOR2_X1 U350 ( .A1(n432), .A2(n433), .ZN(n471) );
  NOR2_X1 U351 ( .A1(n328), .A2(n471), .ZN(n329) );
  AND2_X1 U352 ( .A1(n330), .A2(n329), .ZN(n459) );
  CLKBUF_X1 U353 ( .A(n457), .Z(n451) );
  INV_X1 U354 ( .A(n459), .ZN(n386) );
  CLKBUF_X1 U355 ( .A(n386), .Z(n357) );
  NAND2_X1 U356 ( .A1(n471), .A2(r_in[5]), .ZN(n454) );
  NAND3_X1 U357 ( .A1(stato[1]), .A2(stato[0]), .A3(n439), .ZN(n467) );
  NOR2_X1 U358 ( .A1(r_in[0]), .A2(n467), .ZN(n458) );
  NOR2_X1 U359 ( .A1(n507), .A2(n467), .ZN(n452) );
  AOI22_X1 U360 ( .A1(n458), .A2(cont[2]), .B1(cont[1]), .B2(n452), .ZN(n331)
         );
  OAI211_X1 U361 ( .C1(n357), .C2(n518), .A(n454), .B(n331), .ZN(n332) );
  AOI21_X1 U362 ( .B1(\C33/DATA3_2 ), .B2(n451), .A(n332), .ZN(n333) );
  INV_X1 U363 ( .A(n333), .ZN(n285) );
  AOI22_X1 U364 ( .A1(n458), .A2(cont[3]), .B1(n452), .B2(cont[2]), .ZN(n334)
         );
  OAI211_X1 U365 ( .C1(n357), .C2(n517), .A(n454), .B(n334), .ZN(n335) );
  AOI21_X1 U366 ( .B1(\C33/DATA3_3 ), .B2(n451), .A(n335), .ZN(n336) );
  INV_X1 U367 ( .A(n336), .ZN(n284) );
  AOI22_X1 U368 ( .A1(n458), .A2(cont[4]), .B1(n452), .B2(cont[3]), .ZN(n337)
         );
  OAI211_X1 U369 ( .C1(n357), .C2(n510), .A(n454), .B(n337), .ZN(n338) );
  AOI21_X1 U370 ( .B1(\C33/DATA3_4 ), .B2(n457), .A(n338), .ZN(n339) );
  INV_X1 U371 ( .A(n339), .ZN(n283) );
  NAND2_X1 U372 ( .A1(n452), .A2(cont[4]), .ZN(n340) );
  OAI211_X1 U373 ( .C1(n357), .C2(n503), .A(n454), .B(n340), .ZN(n341) );
  AOI21_X1 U374 ( .B1(\C33/DATA3_5 ), .B2(n451), .A(n341), .ZN(n342) );
  INV_X1 U375 ( .A(n342), .ZN(n282) );
  NAND2_X1 U376 ( .A1(stato[0]), .A2(stato[1]), .ZN(n343) );
  OR2_X1 U377 ( .A1(n344), .A2(n343), .ZN(n464) );
  NAND2_X1 U378 ( .A1(n505), .A2(r_in[2]), .ZN(n345) );
  OR2_X1 U379 ( .A1(n464), .A2(n345), .ZN(n413) );
  INV_X1 U380 ( .A(n466), .ZN(n447) );
  OR2_X1 U381 ( .A1(stato[1]), .A2(r_in[1]), .ZN(n346) );
  NOR2_X1 U382 ( .A1(n468), .A2(n346), .ZN(n375) );
  INV_X1 U383 ( .A(n375), .ZN(n348) );
  OR2_X1 U384 ( .A1(r_in[2]), .A2(r_in[3]), .ZN(n347) );
  NOR2_X1 U385 ( .A1(n464), .A2(n347), .ZN(n378) );
  INV_X1 U386 ( .A(n378), .ZN(n428) );
  NAND4_X1 U387 ( .A1(n413), .A2(n447), .A3(n348), .A4(n428), .ZN(n425) );
  CLKBUF_X1 U388 ( .A(n425), .Z(n548) );
  NAND2_X1 U389 ( .A1(\C33/DATA3_7 ), .A2(n457), .ZN(n349) );
  OAI21_X1 U390 ( .B1(n357), .B2(n527), .A(n349), .ZN(n280) );
  NAND2_X1 U391 ( .A1(\C33/DATA3_6 ), .A2(n451), .ZN(n350) );
  OAI21_X1 U392 ( .B1(n357), .B2(n524), .A(n350), .ZN(n281) );
  NAND2_X1 U393 ( .A1(\C33/DATA3_8 ), .A2(n451), .ZN(n351) );
  OAI21_X1 U394 ( .B1(n357), .B2(n523), .A(n351), .ZN(n279) );
  NAND2_X1 U395 ( .A1(\C33/DATA3_9 ), .A2(n451), .ZN(n352) );
  OAI21_X1 U396 ( .B1(n357), .B2(n526), .A(n352), .ZN(n278) );
  NAND2_X1 U397 ( .A1(\C33/DATA3_10 ), .A2(n451), .ZN(n353) );
  OAI21_X1 U398 ( .B1(n357), .B2(n528), .A(n353), .ZN(n277) );
  NAND2_X1 U399 ( .A1(\C33/DATA3_11 ), .A2(n451), .ZN(n354) );
  OAI21_X1 U400 ( .B1(n357), .B2(n522), .A(n354), .ZN(n276) );
  NAND2_X1 U401 ( .A1(\C33/DATA3_12 ), .A2(n457), .ZN(n355) );
  OAI21_X1 U402 ( .B1(n357), .B2(n525), .A(n355), .ZN(n275) );
  NAND2_X1 U403 ( .A1(\C33/DATA3_13 ), .A2(n457), .ZN(n356) );
  OAI21_X1 U404 ( .B1(n357), .B2(n521), .A(n356), .ZN(n274) );
  NAND2_X1 U405 ( .A1(\C33/DATA3_14 ), .A2(n457), .ZN(n358) );
  OAI21_X1 U406 ( .B1(n386), .B2(n547), .A(n358), .ZN(n273) );
  NAND2_X1 U407 ( .A1(\C33/DATA3_15 ), .A2(n457), .ZN(n359) );
  OAI21_X1 U408 ( .B1(n386), .B2(n536), .A(n359), .ZN(n272) );
  NAND2_X1 U409 ( .A1(\C33/DATA3_16 ), .A2(n457), .ZN(n360) );
  OAI21_X1 U410 ( .B1(n386), .B2(n539), .A(n360), .ZN(n271) );
  NAND2_X1 U411 ( .A1(\C33/DATA3_17 ), .A2(n457), .ZN(n361) );
  OAI21_X1 U412 ( .B1(n386), .B2(n540), .A(n361), .ZN(n270) );
  NAND2_X1 U413 ( .A1(\C33/DATA3_18 ), .A2(n457), .ZN(n362) );
  OAI21_X1 U414 ( .B1(n386), .B2(n538), .A(n362), .ZN(n269) );
  NAND2_X1 U415 ( .A1(\C33/DATA3_19 ), .A2(n457), .ZN(n363) );
  OAI21_X1 U416 ( .B1(n386), .B2(n533), .A(n363), .ZN(n268) );
  NAND2_X1 U417 ( .A1(\C33/DATA3_20 ), .A2(n451), .ZN(n364) );
  OAI21_X1 U418 ( .B1(n386), .B2(n537), .A(n364), .ZN(n267) );
  NAND2_X1 U419 ( .A1(\C33/DATA3_21 ), .A2(n451), .ZN(n365) );
  OAI21_X1 U420 ( .B1(n386), .B2(n532), .A(n365), .ZN(n266) );
  NAND2_X1 U421 ( .A1(\C33/DATA3_22 ), .A2(n451), .ZN(n366) );
  OAI21_X1 U422 ( .B1(n386), .B2(n534), .A(n366), .ZN(n265) );
  NAND2_X1 U423 ( .A1(\C33/DATA3_23 ), .A2(n451), .ZN(n367) );
  OAI21_X1 U424 ( .B1(n386), .B2(n531), .A(n367), .ZN(n264) );
  NAND2_X1 U425 ( .A1(\C33/DATA3_24 ), .A2(n451), .ZN(n368) );
  OAI21_X1 U426 ( .B1(n386), .B2(n535), .A(n368), .ZN(n263) );
  NAND2_X1 U427 ( .A1(\C33/DATA3_25 ), .A2(n451), .ZN(n369) );
  OAI21_X1 U428 ( .B1(n386), .B2(n543), .A(n369), .ZN(n262) );
  NAND2_X1 U429 ( .A1(\C33/DATA3_26 ), .A2(n451), .ZN(n370) );
  OAI21_X1 U430 ( .B1(n386), .B2(n545), .A(n370), .ZN(n261) );
  NAND2_X1 U431 ( .A1(\C33/DATA3_27 ), .A2(n451), .ZN(n371) );
  OAI21_X1 U432 ( .B1(n386), .B2(n546), .A(n371), .ZN(n260) );
  NAND2_X1 U433 ( .A1(\C33/DATA3_28 ), .A2(n451), .ZN(n372) );
  OAI21_X1 U434 ( .B1(n386), .B2(n544), .A(n372), .ZN(n259) );
  NAND2_X1 U435 ( .A1(\C33/DATA3_29 ), .A2(n451), .ZN(n373) );
  OAI21_X1 U436 ( .B1(n386), .B2(n515), .A(n373), .ZN(n258) );
  NAND2_X1 U437 ( .A1(\C33/DATA3_30 ), .A2(n451), .ZN(n374) );
  OAI21_X1 U438 ( .B1(n386), .B2(n513), .A(n374), .ZN(n257) );
  NOR3_X1 U439 ( .A1(n468), .A2(stato[1]), .A3(n508), .ZN(n435) );
  NOR2_X1 U440 ( .A1(n435), .A2(n375), .ZN(n408) );
  CLKBUF_X1 U441 ( .A(n408), .Z(n430) );
  NOR2_X1 U442 ( .A1(n430), .A2(n512), .ZN(n376) );
  XOR2_X1 U443 ( .A(n548), .B(n376), .Z(n382) );
  NOR2_X1 U444 ( .A1(n468), .A2(n506), .ZN(n442) );
  NOR2_X1 U445 ( .A1(n442), .A2(n466), .ZN(n416) );
  NAND2_X1 U446 ( .A1(n416), .A2(n413), .ZN(n418) );
  NAND2_X1 U447 ( .A1(r_in[2]), .A2(r_in[3]), .ZN(n377) );
  NOR2_X1 U448 ( .A1(n464), .A2(n377), .ZN(n419) );
  NOR2_X1 U449 ( .A1(n378), .A2(n419), .ZN(n415) );
  INV_X1 U450 ( .A(n464), .ZN(n380) );
  NOR2_X1 U451 ( .A1(n505), .A2(r_in[2]), .ZN(n379) );
  NAND2_X1 U452 ( .A1(n380), .A2(n379), .ZN(n429) );
  NAND2_X1 U453 ( .A1(n415), .A2(n429), .ZN(n422) );
  NOR2_X1 U454 ( .A1(n418), .A2(n422), .ZN(n449) );
  CLKBUF_X1 U455 ( .A(n449), .Z(n463) );
  NOR2_X1 U456 ( .A1(n463), .A2(n512), .ZN(n381) );
  XOR2_X1 U457 ( .A(n382), .B(n381), .Z(n383) );
  XOR2_X1 U458 ( .A(\DP_OP_61J1_122_4439/n2 ), .B(n383), .Z(n384) );
  NAND2_X1 U459 ( .A1(n384), .A2(n451), .ZN(n385) );
  OAI21_X1 U460 ( .B1(n386), .B2(n512), .A(n385), .ZN(n288) );
  CLKBUF_X1 U461 ( .A(n408), .Z(n462) );
  NOR2_X1 U462 ( .A1(n462), .A2(n513), .ZN(n387) );
  XOR2_X1 U463 ( .A(n425), .B(n387), .Z(\DP_OP_61J1_122_4439/n38 ) );
  NOR2_X1 U464 ( .A1(n430), .A2(n515), .ZN(n388) );
  XOR2_X1 U465 ( .A(n548), .B(n388), .Z(\DP_OP_61J1_122_4439/n39 ) );
  NOR2_X1 U466 ( .A1(n462), .A2(n544), .ZN(n389) );
  XOR2_X1 U467 ( .A(n425), .B(n389), .Z(\DP_OP_61J1_122_4439/n40 ) );
  NOR2_X1 U468 ( .A1(n430), .A2(n546), .ZN(n390) );
  XOR2_X1 U469 ( .A(n425), .B(n390), .Z(\DP_OP_61J1_122_4439/n41 ) );
  NOR2_X1 U470 ( .A1(n462), .A2(n545), .ZN(n391) );
  XOR2_X1 U471 ( .A(n548), .B(n391), .Z(\DP_OP_61J1_122_4439/n42 ) );
  NOR2_X1 U472 ( .A1(n430), .A2(n543), .ZN(n392) );
  XOR2_X1 U473 ( .A(n425), .B(n392), .Z(\DP_OP_61J1_122_4439/n43 ) );
  NOR2_X1 U474 ( .A1(n462), .A2(n535), .ZN(n393) );
  XOR2_X1 U475 ( .A(n425), .B(n393), .Z(\DP_OP_61J1_122_4439/n44 ) );
  NOR2_X1 U476 ( .A1(n430), .A2(n531), .ZN(n394) );
  XOR2_X1 U477 ( .A(n548), .B(n394), .Z(\DP_OP_61J1_122_4439/n45 ) );
  NOR2_X1 U478 ( .A1(n462), .A2(n534), .ZN(n395) );
  XOR2_X1 U479 ( .A(n425), .B(n395), .Z(\DP_OP_61J1_122_4439/n46 ) );
  NOR2_X1 U480 ( .A1(n430), .A2(n532), .ZN(n396) );
  XOR2_X1 U481 ( .A(n548), .B(n396), .Z(\DP_OP_61J1_122_4439/n47 ) );
  NOR2_X1 U482 ( .A1(n408), .A2(n537), .ZN(n397) );
  XOR2_X1 U483 ( .A(n548), .B(n397), .Z(\DP_OP_61J1_122_4439/n48 ) );
  NOR2_X1 U484 ( .A1(n408), .A2(n533), .ZN(n398) );
  XOR2_X1 U485 ( .A(n425), .B(n398), .Z(\DP_OP_61J1_122_4439/n49 ) );
  NOR2_X1 U486 ( .A1(n408), .A2(n538), .ZN(n399) );
  XOR2_X1 U487 ( .A(n425), .B(n399), .Z(\DP_OP_61J1_122_4439/n50 ) );
  NOR2_X1 U488 ( .A1(n408), .A2(n540), .ZN(n400) );
  XOR2_X1 U489 ( .A(n548), .B(n400), .Z(\DP_OP_61J1_122_4439/n51 ) );
  NOR2_X1 U490 ( .A1(n408), .A2(n539), .ZN(n401) );
  XOR2_X1 U491 ( .A(n425), .B(n401), .Z(\DP_OP_61J1_122_4439/n52 ) );
  NOR2_X1 U492 ( .A1(n408), .A2(n536), .ZN(n402) );
  XOR2_X1 U493 ( .A(n425), .B(n402), .Z(\DP_OP_61J1_122_4439/n53 ) );
  NOR2_X1 U494 ( .A1(n408), .A2(n547), .ZN(n403) );
  XOR2_X1 U495 ( .A(n548), .B(n403), .Z(\DP_OP_61J1_122_4439/n54 ) );
  NOR2_X1 U496 ( .A1(n462), .A2(n521), .ZN(n404) );
  XOR2_X1 U497 ( .A(n425), .B(n404), .Z(\DP_OP_61J1_122_4439/n55 ) );
  NOR2_X1 U498 ( .A1(n462), .A2(n525), .ZN(n405) );
  XOR2_X1 U499 ( .A(n425), .B(n405), .Z(\DP_OP_61J1_122_4439/n56 ) );
  NOR2_X1 U500 ( .A1(n408), .A2(n522), .ZN(n406) );
  XOR2_X1 U501 ( .A(n548), .B(n406), .Z(\DP_OP_61J1_122_4439/n57 ) );
  NOR2_X1 U502 ( .A1(n408), .A2(n528), .ZN(n407) );
  XOR2_X1 U503 ( .A(n425), .B(n407), .Z(\DP_OP_61J1_122_4439/n58 ) );
  NOR2_X1 U504 ( .A1(n408), .A2(n526), .ZN(n409) );
  XOR2_X1 U505 ( .A(n548), .B(n409), .Z(\DP_OP_61J1_122_4439/n59 ) );
  NOR2_X1 U506 ( .A1(n462), .A2(n523), .ZN(n410) );
  XOR2_X1 U507 ( .A(n548), .B(n410), .Z(\DP_OP_61J1_122_4439/n60 ) );
  NOR2_X1 U508 ( .A1(n462), .A2(n527), .ZN(n411) );
  XOR2_X1 U509 ( .A(n425), .B(n411), .Z(\DP_OP_61J1_122_4439/n61 ) );
  NOR2_X1 U510 ( .A1(n462), .A2(n524), .ZN(n412) );
  XOR2_X1 U511 ( .A(n548), .B(n412), .Z(\DP_OP_61J1_122_4439/n62 ) );
  OAI21_X1 U512 ( .B1(n462), .B2(n503), .A(n413), .ZN(n414) );
  XOR2_X1 U513 ( .A(n548), .B(n414), .Z(\DP_OP_61J1_122_4439/n63 ) );
  OAI211_X1 U514 ( .C1(n462), .C2(n510), .A(n416), .B(n415), .ZN(n417) );
  XOR2_X1 U515 ( .A(n425), .B(n417), .Z(\DP_OP_61J1_122_4439/n64 ) );
  INV_X1 U516 ( .A(n418), .ZN(n426) );
  INV_X1 U517 ( .A(n419), .ZN(n420) );
  OAI211_X1 U518 ( .C1(n462), .C2(n517), .A(n426), .B(n420), .ZN(n421) );
  XOR2_X1 U519 ( .A(n548), .B(n421), .Z(\DP_OP_61J1_122_4439/n65 ) );
  INV_X1 U520 ( .A(n422), .ZN(n423) );
  OAI21_X1 U521 ( .B1(n462), .B2(n518), .A(n423), .ZN(n424) );
  XOR2_X1 U522 ( .A(n425), .B(n424), .Z(\DP_OP_61J1_122_4439/n66 ) );
  OAI211_X1 U523 ( .C1(n430), .C2(n520), .A(n426), .B(n429), .ZN(n427) );
  XOR2_X1 U524 ( .A(n548), .B(n427), .Z(\DP_OP_61J1_122_4439/n67 ) );
  OAI211_X1 U525 ( .C1(n430), .C2(n519), .A(n429), .B(n428), .ZN(n431) );
  XOR2_X1 U526 ( .A(n548), .B(n431), .Z(\DP_OP_61J1_122_4439/n68 ) );
  OAI221_X1 U527 ( .B1(stato[3]), .B2(n299), .C1(stato[3]), .C2(n506), .A(
        stato[0]), .ZN(n438) );
  INV_X1 U528 ( .A(n432), .ZN(n434) );
  NOR2_X1 U529 ( .A1(n434), .A2(n433), .ZN(n443) );
  AOI211_X1 U530 ( .C1(n442), .C2(n436), .A(n435), .B(n443), .ZN(n437) );
  NAND4_X1 U531 ( .A1(n438), .A2(n437), .A3(n447), .A4(n498), .ZN(n256) );
  NAND2_X1 U532 ( .A1(n506), .A2(n439), .ZN(n450) );
  NOR3_X1 U533 ( .A1(n299), .A2(n514), .A3(n450), .ZN(n441) );
  OAI22_X1 U534 ( .A1(r_in[1]), .A2(n468), .B1(n516), .B2(n506), .ZN(n440) );
  NOR3_X1 U535 ( .A1(n442), .A2(n441), .A3(n440), .ZN(n446) );
  OAI221_X1 U536 ( .B1(r_in[2]), .B2(r_in[0]), .C1(r_in[2]), .C2(r_in[1]), .A(
        r_in[4]), .ZN(n444) );
  OAI211_X1 U537 ( .C1(n505), .C2(n444), .A(n443), .B(n529), .ZN(n445) );
  OAI211_X1 U538 ( .C1(n448), .C2(n447), .A(n446), .B(n445), .ZN(n254) );
  MUX2_X1 U539 ( .A(x_in[0]), .B(r_in[0]), .S(n450), .Z(n253) );
  MUX2_X1 U540 ( .A(x_in[3]), .B(r_in[3]), .S(n450), .Z(n250) );
  MUX2_X1 U541 ( .A(x_in[2]), .B(r_in[2]), .S(n450), .Z(n249) );
  NOR2_X1 U542 ( .A1(n463), .A2(n513), .ZN(\U8/RSOP_50/C2/Z_30 ) );
  NOR2_X1 U543 ( .A1(n463), .A2(n515), .ZN(\U8/RSOP_50/C2/Z_29 ) );
  NOR2_X1 U544 ( .A1(n463), .A2(n544), .ZN(\U8/RSOP_50/C2/Z_28 ) );
  NOR2_X1 U545 ( .A1(n463), .A2(n546), .ZN(\U8/RSOP_50/C2/Z_27 ) );
  NOR2_X1 U546 ( .A1(n463), .A2(n545), .ZN(\U8/RSOP_50/C2/Z_26 ) );
  NOR2_X1 U547 ( .A1(n463), .A2(n543), .ZN(\U8/RSOP_50/C2/Z_25 ) );
  NOR2_X1 U548 ( .A1(n463), .A2(n535), .ZN(\U8/RSOP_50/C2/Z_24 ) );
  NOR2_X1 U549 ( .A1(n463), .A2(n531), .ZN(\U8/RSOP_50/C2/Z_23 ) );
  NOR2_X1 U550 ( .A1(n463), .A2(n534), .ZN(\U8/RSOP_50/C2/Z_22 ) );
  NOR2_X1 U551 ( .A1(n449), .A2(n532), .ZN(\U8/RSOP_50/C2/Z_21 ) );
  NOR2_X1 U552 ( .A1(n449), .A2(n537), .ZN(\U8/RSOP_50/C2/Z_20 ) );
  NOR2_X1 U553 ( .A1(n449), .A2(n533), .ZN(\U8/RSOP_50/C2/Z_19 ) );
  NOR2_X1 U554 ( .A1(n449), .A2(n538), .ZN(\U8/RSOP_50/C2/Z_18 ) );
  NOR2_X1 U555 ( .A1(n449), .A2(n540), .ZN(\U8/RSOP_50/C2/Z_17 ) );
  NOR2_X1 U556 ( .A1(n449), .A2(n539), .ZN(\U8/RSOP_50/C2/Z_16 ) );
  NOR2_X1 U557 ( .A1(n449), .A2(n536), .ZN(\U8/RSOP_50/C2/Z_15 ) );
  NOR2_X1 U558 ( .A1(n449), .A2(n547), .ZN(\U8/RSOP_50/C2/Z_14 ) );
  NOR2_X1 U559 ( .A1(n449), .A2(n521), .ZN(\U8/RSOP_50/C2/Z_13 ) );
  NOR2_X1 U560 ( .A1(n449), .A2(n525), .ZN(\U8/RSOP_50/C2/Z_12 ) );
  NOR2_X1 U561 ( .A1(n449), .A2(n522), .ZN(\U8/RSOP_50/C2/Z_11 ) );
  NOR2_X1 U562 ( .A1(n463), .A2(n528), .ZN(\U8/RSOP_50/C2/Z_10 ) );
  NOR2_X1 U563 ( .A1(n463), .A2(n526), .ZN(\U8/RSOP_50/C2/Z_9 ) );
  NOR2_X1 U564 ( .A1(n463), .A2(n523), .ZN(\U8/RSOP_50/C2/Z_8 ) );
  NOR2_X1 U565 ( .A1(n463), .A2(n527), .ZN(\U8/RSOP_50/C2/Z_7 ) );
  NOR2_X1 U566 ( .A1(n463), .A2(n524), .ZN(\U8/RSOP_50/C2/Z_6 ) );
  MUX2_X1 U567 ( .A(x_in[5]), .B(r_in[5]), .S(n450), .Z(n252) );
  MUX2_X1 U568 ( .A(x_in[1]), .B(r_in[1]), .S(n450), .Z(n248) );
  OAI22_X1 U569 ( .A1(n463), .A2(n503), .B1(n462), .B2(n529), .ZN(
        \DP_OP_61J1_122_4439/n139 ) );
  MUX2_X1 U570 ( .A(x_in[4]), .B(r_in[4]), .S(n450), .Z(n251) );
  OAI22_X1 U571 ( .A1(n463), .A2(n510), .B1(n462), .B2(n530), .ZN(
        \DP_OP_61J1_122_4439/n138 ) );
  OAI22_X1 U572 ( .A1(n463), .A2(n517), .B1(n462), .B2(n505), .ZN(
        \DP_OP_61J1_122_4439/n137 ) );
  OAI22_X1 U573 ( .A1(n463), .A2(n518), .B1(n462), .B2(n509), .ZN(
        \DP_OP_61J1_122_4439/n136 ) );
  NAND2_X1 U574 ( .A1(\C33/DATA3_1 ), .A2(n451), .ZN(n456) );
  AOI22_X1 U575 ( .A1(cont[0]), .A2(n452), .B1(n458), .B2(cont[1]), .ZN(n455)
         );
  NAND2_X1 U576 ( .A1(n459), .A2(cont1[1]), .ZN(n453) );
  NAND4_X1 U577 ( .A1(n456), .A2(n455), .A3(n454), .A4(n453), .ZN(n286) );
  OAI22_X1 U578 ( .A1(n463), .A2(n520), .B1(n462), .B2(n508), .ZN(
        \DP_OP_61J1_122_4439/n135 ) );
  INV_X1 U579 ( .A(n471), .ZN(n470) );
  NAND2_X1 U580 ( .A1(\C33/DATA3_0 ), .A2(n457), .ZN(n461) );
  AOI22_X1 U581 ( .A1(n459), .A2(N503), .B1(n458), .B2(cont[0]), .ZN(n460) );
  OAI211_X1 U582 ( .C1(n470), .C2(n507), .A(n461), .B(n460), .ZN(n289) );
  OAI22_X1 U583 ( .A1(n463), .A2(n519), .B1(n462), .B2(n507), .ZN(
        \DP_OP_61J1_122_4439/n134 ) );
  OAI211_X1 U584 ( .C1(n465), .C2(n516), .A(n464), .B(n470), .ZN(n287) );
  AOI21_X1 U585 ( .B1(stato[3]), .B2(stato[2]), .A(n466), .ZN(n469) );
  NAND3_X1 U586 ( .A1(n469), .A2(n468), .A3(n467), .ZN(n255) );
  OAI21_X1 U587 ( .B1(n498), .B2(stato[3]), .A(n470), .ZN(n478) );
  NOR3_X1 U588 ( .A1(cont[0]), .A2(cont[1]), .A3(cont[2]), .ZN(n473) );
  NAND2_X1 U589 ( .A1(cont[3]), .A2(cont[4]), .ZN(n472) );
  OAI21_X1 U590 ( .B1(n473), .B2(n472), .A(n471), .ZN(n480) );
  AOI22_X1 U591 ( .A1(cont[0]), .A2(n478), .B1(n480), .B2(n511), .ZN(n246) );
  INV_X1 U592 ( .A(n478), .ZN(n482) );
  NOR2_X1 U593 ( .A1(cont[0]), .A2(n480), .ZN(n474) );
  NOR2_X1 U594 ( .A1(n482), .A2(n474), .ZN(n477) );
  INV_X1 U595 ( .A(n480), .ZN(n483) );
  NAND2_X1 U596 ( .A1(n483), .A2(n542), .ZN(n476) );
  OAI22_X1 U597 ( .A1(n477), .A2(n542), .B1(n511), .B2(n476), .ZN(n245) );
  NAND4_X1 U598 ( .A1(cont[1]), .A2(cont[0]), .A3(n483), .A4(n504), .ZN(n475)
         );
  OAI221_X1 U599 ( .B1(n504), .B2(n477), .C1(n504), .C2(n476), .A(n475), .ZN(
        n244) );
  NOR3_X1 U600 ( .A1(n511), .A2(n542), .A3(n504), .ZN(n481) );
  XOR2_X1 U601 ( .A(n541), .B(n481), .Z(n479) );
  OAI22_X1 U602 ( .A1(n480), .A2(n479), .B1(n541), .B2(n478), .ZN(n243) );
  NAND2_X1 U603 ( .A1(n483), .A2(n481), .ZN(n485) );
  OAI21_X1 U604 ( .B1(n483), .B2(n482), .A(cont[4]), .ZN(n484) );
  OAI21_X1 U605 ( .B1(n485), .B2(n541), .A(n484), .ZN(n242) );
  NAND2_X1 U606 ( .A1(n499), .A2(n512), .ZN(n496) );
  NOR3_X1 U607 ( .A1(cont1[2]), .A2(cont1[1]), .A3(N503), .ZN(n491) );
  NAND2_X1 U608 ( .A1(N501), .A2(n499), .ZN(n492) );
  NOR2_X1 U609 ( .A1(n491), .A2(n492), .ZN(n488) );
  OAI21_X1 U610 ( .B1(cont1[1]), .B2(N503), .A(cont1[2]), .ZN(n486) );
  AOI22_X1 U611 ( .A1(n488), .A2(n486), .B1(x_out[2]), .B2(n498), .ZN(n487) );
  OAI21_X1 U612 ( .B1(n518), .B2(n496), .A(n487), .ZN(n213) );
  AOI22_X1 U613 ( .A1(x_out[3]), .A2(n498), .B1(n488), .B2(n517), .ZN(n490) );
  OAI211_X1 U614 ( .C1(n491), .C2(n512), .A(cont1[3]), .B(n499), .ZN(n489) );
  NAND2_X1 U615 ( .A1(n490), .A2(n489), .ZN(n212) );
  NAND2_X1 U616 ( .A1(n491), .A2(n517), .ZN(n493) );
  NOR2_X1 U617 ( .A1(cont1[4]), .A2(n493), .ZN(n500) );
  NOR2_X1 U618 ( .A1(n500), .A2(n492), .ZN(n497) );
  NAND2_X1 U619 ( .A1(cont1[4]), .A2(n493), .ZN(n494) );
  AOI22_X1 U620 ( .A1(n497), .A2(n494), .B1(x_out[4]), .B2(n498), .ZN(n495) );
  OAI21_X1 U621 ( .B1(n510), .B2(n496), .A(n495), .ZN(n211) );
  AOI22_X1 U622 ( .A1(x_out[5]), .A2(n498), .B1(n497), .B2(n503), .ZN(n502) );
  OAI211_X1 U623 ( .C1(n500), .C2(n512), .A(cont1[5]), .B(n499), .ZN(n501) );
  NAND2_X1 U624 ( .A1(n502), .A2(n501), .ZN(n210) );
endmodule

