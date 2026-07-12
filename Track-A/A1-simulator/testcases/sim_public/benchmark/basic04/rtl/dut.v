`include "def.v"

module add_leaf #(parameter OFFSET = 0) (input [`BASIC_WIDTH-1:0] in, output [`BASIC_WIDTH:0] out);
  localparam EXTRA = OFFSET;
  assign out = {1'b0, in} + EXTRA[`BASIC_WIDTH:0];
endmodule

module top(input [3:0] addr, input [`BASIC_WIDTH-1:0] din, input use_din, output [`BASIC_WIDTH:0] y);
  reg [`BASIC_WIDTH-1:0] mem [0:`BASIC_DEPTH-1];
  reg [`BASIC_WIDTH-1:0] selected;
  wire [`BASIC_WIDTH:0] y0;
  wire [`BASIC_WIDTH:0] y1;
  initial begin
    $readmemh("tb/init.hex", mem);
  end
  always @(*) begin
    if (use_din) begin
      selected = din;
    end else begin
      selected = mem[addr];
    end
  end
  add_leaf #(.OFFSET(1)) u_add0(.in(selected), .out(y0));
  add_leaf #(.OFFSET(3)) u_add1(.in(selected), .out(y1));
  assign y = y0 + y1;
endmodule
