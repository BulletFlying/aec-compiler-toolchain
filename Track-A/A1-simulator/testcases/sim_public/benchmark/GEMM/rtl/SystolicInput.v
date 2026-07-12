module SystolicInput(
  input        clock,
  input        reset,
  input  [7:0] io_port_in_bits,
  output [7:0] io_port_out_bits,
  output [7:0] io_to_cell_bits
);
  reg [7:0] reg_0_bits; // @[pe_modules.scala 82:20]
  reg [7:0] to_cell_delay1_bits; // @[pe_modules.scala 83:31]
  reg [7:0] to_cell_delay2_bits; // @[pe_modules.scala 84:31]
  assign io_port_out_bits = reg_0_bits; // @[pe_modules.scala 91:15]
  assign io_to_cell_bits = to_cell_delay2_bits; // @[pe_modules.scala 92:14]
  always @(posedge clock) begin
    if (reset) begin // @[pe_modules.scala 82:20]
      reg_0_bits <= 8'h0; // @[pe_modules.scala 82:20]
    end else begin
      reg_0_bits <= io_port_in_bits; // @[pe_modules.scala 87:10]
    end
    if (reset) begin // @[pe_modules.scala 83:31]
      to_cell_delay1_bits <= 8'h0; // @[pe_modules.scala 83:31]
    end else begin
      to_cell_delay1_bits <= reg_0_bits; // @[pe_modules.scala 85:18]
    end
    if (reset) begin // @[pe_modules.scala 84:31]
      to_cell_delay2_bits <= 8'h0; // @[pe_modules.scala 84:31]
    end else begin
      to_cell_delay2_bits <= to_cell_delay1_bits; // @[pe_modules.scala 86:18]
    end
  end
// Register and memory initialization
endmodule
