module top(input [15:0] a, input [15:0] b, input sel, output [31:0] y, output cmp, output red);
  wire [15:0] sumv;
  wire [15:0] diffv;
  wire low_all_ones;
  assign sumv = a + b;
  assign diffv = a - b;
  assign cmp = ({1'b0, a} + {1'b0, b}) >= 17'h08000;
  assign red = ^{a[3:0], b[3:0]};
  assign low_all_ones = &a[7:0];
  assign y = sel ? {sumv, diffv} : {a[15:8], b[7:0], 7'b0, a[0], 7'b0, low_all_ones};
endmodule
