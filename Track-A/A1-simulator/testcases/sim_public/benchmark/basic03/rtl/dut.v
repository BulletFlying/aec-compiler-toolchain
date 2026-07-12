module gen_cell #(
  parameter INDEX = 0
) (
  input a,
  input b,
  output y
);
  generate
    if ((INDEX % 2) == 0) begin : gen_even
      assign y = a ^ b;
    end else begin : gen_odd
      assign y = ~(a ^ b);
    end
  endgenerate
endmodule

module top #(
  parameter WIDTH = 8
) (
  input clk,
  input rst,
  input en,
  input [WIDTH-1:0] a,
  input [WIDTH-1:0] b,
  input [1:0] mode,
  output reg [WIDTH-1:0] q,
  output [WIDTH-1:0] y,
  output parity
);
  wire [WIDTH-1:0] cell_y;
  wire [WIDTH-1:0] rot_y;

  genvar i;

  generate
    for (i = 0; i < WIDTH; i = i + 1) begin : gen_cells
      gen_cell #(
        .INDEX(i)
      ) u_cell (
        .a(a[i]),
        .b(b[i]),
        .y(cell_y[i])
      );
    end
  endgenerate

  generate
    case (WIDTH)
      8: begin : gen_width_8
        assign rot_y = {cell_y[6:0], cell_y[7]};
        assign parity = ^cell_y;
      end
      default: begin : gen_width_default
        assign rot_y = cell_y;
        assign parity = 1'b0;
      end
    endcase
  endgenerate

  assign y = (mode == 2'd0) ? cell_y :
             (mode == 2'd1) ? (a + b) :
             (mode == 2'd2) ? rot_y :
                               ~cell_y;

  always @(posedge clk) begin
    if (rst) begin
      q <= {WIDTH{1'b0}};
    end else if (en) begin
      q <= y;
    end
  end
endmodule
