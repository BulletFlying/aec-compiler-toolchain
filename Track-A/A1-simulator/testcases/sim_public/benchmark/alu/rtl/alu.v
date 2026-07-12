`timescale 1ns / 1ps

module ALU(
  input [31:0] a,
  input [31:0] b,
  input [5:0] opCode,
  output reg [31:0] ans1,
  output reg ans2,
  output reg Z,
  output reg N
);
  reg [32:0] add_result;
  reg [32:0] sub_result;
  reg signed [31:0] signed_a;

  always @(*) begin
    ans1 = 32'h00000000;
    ans2 = 1'b0;
    add_result = {1'b0, a} + {1'b0, b};
    sub_result = {1'b0, a} - {1'b0, b};
    signed_a = a;

    case (opCode)
      6'b010000: begin
        ans1 = add_result[31:0];
        ans2 = add_result[32];
      end
      6'b010001: begin
        ans1 = sub_result[31:0];
        ans2 = (a < b);
      end
      6'b100000: begin
        ans1 = (a == b) ? 32'h00000001 : 32'h00000000;
      end
      6'b100001: begin
        ans1 = (a != b) ? 32'h00000001 : 32'h00000000;
      end
      6'b100010: begin
        ans1 = (a <= b) ? 32'h00000001 : 32'h00000000;
      end
      6'b100011: begin
        ans1 = (a > b) ? 32'h00000001 : 32'h00000000;
      end
      6'b110000: begin
        ans1 = a << b[4:0];
      end
      6'b110001: begin
        ans1 = a >> b[4:0];
      end
      6'b110010: begin
        ans1 = signed_a >>> b[4:0];
      end
      default: begin
        ans1 = 32'h00000000;
        ans2 = 1'b0;
      end
    endcase

    Z = (ans1 == 32'h00000000);
    N = ans1[31];
  end
endmodule
