module ComputeCell_Latency(
  input        clock,
  input        reset,
  input  [7:0] io_data_2_in,
  input  [7:0] io_data_1_in,
  input  [7:0] io_data_0_in,
  output [7:0] io_data_0_out
);
  reg [7:0] delay_a_0; // @[Reg.scala 27:20]
  reg [7:0] delay_b_0; // @[Reg.scala 27:20]
  reg [7:0] delay_c_0; // @[Reg.scala 27:20]
  wire [15:0] _T_9 = delay_a_0 * delay_b_0; // @[cell.scala 145:63]
  wire [15:0] _GEN_3 = {{8'd0}, delay_c_0}; // @[cell.scala 145:50]
  wire [15:0] _T_11 = _GEN_3 + _T_9; // @[cell.scala 145:50]
  assign io_data_0_out = _T_11[7:0]; // @[cell.scala 125:23 145:28]
  always @(posedge clock) begin
    if (reset) begin // @[Reg.scala 27:20]
      delay_a_0 <= 8'h0; // @[Reg.scala 27:20]
    end else begin
      delay_a_0 <= io_data_1_in;
    end
    if (reset) begin // @[Reg.scala 27:20]
      delay_b_0 <= 8'h0; // @[Reg.scala 27:20]
    end else begin
      delay_b_0 <= io_data_2_in;
    end
    if (reset) begin // @[Reg.scala 27:20]
      delay_c_0 <= 8'h0; // @[Reg.scala 27:20]
    end else begin
      delay_c_0 <= io_data_0_in;
    end
  end
// Register and memory initialization
endmodule
