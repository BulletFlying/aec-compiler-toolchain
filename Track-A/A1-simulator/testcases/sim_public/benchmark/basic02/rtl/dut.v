module top(input [1:0] op, input [15:0] a, input [15:0] b, input [15:0] c, output reg [17:0] y, output reg hit);
  integer i;
  reg [4:0] pop;
  always @(*) begin
    pop = 5'd0;
    for (i = 0; i < 16; i = i + 1) begin
      pop = pop + a[i];
    end
    hit = 1'b0;
    case (op)
      2'd0: y = {2'b0, a} + {2'b0, b};
      2'd1: y = {2'b0, (a & b)};
      2'd2: begin
        if (c[0]) begin
          y = {13'd0, pop};
        end else begin
          y = {2'b0, (a ^ b)};
        end
      end
      default: begin
        y = {2'b0, ((a > b) ? a : b)};
        hit = 1'b1;
      end
    endcase
  end
endmodule
