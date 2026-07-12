`include "def.v"

module basic05_leaf
#(
  parameter WIDTH = `BASIC05_WIDTH,
  parameter OFFSET = 0
)
(
  input  [WIDTH-1:0] in,
  output [WIDTH:0]   out
);
  wire [WIDTH:0] extended_in;
  assign extended_in = {1'b0, in};
  assign out = extended_in + OFFSET[WIDTH:0];
endmodule

module top
#(
  parameter WIDTH = `BASIC05_WIDTH,
  parameter DEPTH = `BASIC05_DEPTH
)
(
  input              clk,
  input              rst,
  input              en,
  input      [1:0]   op,
  input      [3:0]   addr,
  input      [WIDTH-1:0] din,
  output reg [WIDTH-1:0] q,
  output reg [WIDTH:0]   y,
  output                 active
);
  integer i;
  reg [WIDTH-1:0] mem [0:DEPTH-1];
  reg [WIDTH-1:0] selected;
  reg [4:0] popcount;
  wire [WIDTH:0] leaf_a;
  wire [WIDTH:0] leaf_b;

  assign active = |q;

  initial begin
    $readmemh("tb/init.hex", mem);
  end

  always @(*) begin
    selected = mem[addr];
    popcount = 5'd0;
    for (i = 0; i < WIDTH; i = i + 1) begin
      popcount = popcount + {4'd0, selected[i]};
    end

    if (en) begin
      case (op)
        2'd0: y = {1'b0, din} + leaf_a;
        2'd1: y = {1'b0, selected} + leaf_b;
        2'd2: y = {4'd0, popcount};
        default: y = {1'b0, q};
      endcase
    end else begin
      y = {1'b0, selected};
    end
  end

  always @(posedge clk) begin
    if (rst) begin
      q <= {WIDTH{1'b0}};
    end else if (en) begin
      q <= y[WIDTH-1:0];
    end else begin
      q <= q;
    end
  end

  basic05_leaf #(.WIDTH(WIDTH), .OFFSET(1)) u_leaf_a(.in(din), .out(leaf_a));
  basic05_leaf #(.WIDTH(WIDTH), .OFFSET(3)) u_leaf_b(.in(q), .out(leaf_b));
endmodule

module basic05_sys_probe;
  initial begin
    $dumpvars(0, basic05_sys_probe);
    $display("basic05 full syntax smoke test time=%0t", $time);
    $finish;
  end
endmodule
