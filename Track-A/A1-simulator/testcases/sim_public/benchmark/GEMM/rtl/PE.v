module PE(
  input        clock,
  input        reset,
  input  [7:0] io_data_2_in_bits,
  output [7:0] io_data_2_out_bits,
  input  [7:0] io_data_1_in_bits,
  output [7:0] io_data_1_out_bits,
  input        io_data_0_in_valid,
  input  [7:0] io_data_0_in_bits,
  output       io_data_0_out_valid,
  output [7:0] io_data_0_out_bits,
  input        io_sig_stat2trans
);
  wire  ComputeCell_Latency_clock; // @[pe.scala 37:104]
  wire  ComputeCell_Latency_reset; // @[pe.scala 37:104]
  wire [7:0] ComputeCell_Latency_io_data_2_in; // @[pe.scala 37:104]
  wire [7:0] ComputeCell_Latency_io_data_1_in; // @[pe.scala 37:104]
  wire [7:0] ComputeCell_Latency_io_data_0_in; // @[pe.scala 37:104]
  wire [7:0] ComputeCell_Latency_io_data_0_out; // @[pe.scala 37:104]
  wire  StationaryOutput_clock; // @[pe.scala 39:11]
  wire  StationaryOutput_reset; // @[pe.scala 39:11]
  wire  StationaryOutput_io_port_in_valid; // @[pe.scala 39:11]
  wire [7:0] StationaryOutput_io_port_in_bits; // @[pe.scala 39:11]
  wire  StationaryOutput_io_port_out_valid; // @[pe.scala 39:11]
  wire [7:0] StationaryOutput_io_port_out_bits; // @[pe.scala 39:11]
  wire [7:0] StationaryOutput_io_from_cell_bits; // @[pe.scala 39:11]
  wire [7:0] StationaryOutput_io_to_cell_bits; // @[pe.scala 39:11]
  wire  StationaryOutput_io_sig_stat2trans; // @[pe.scala 39:11]
  wire  SystolicInput_clock; // @[pe.scala 39:11]
  wire  SystolicInput_reset; // @[pe.scala 39:11]
  wire [7:0] SystolicInput_io_port_in_bits; // @[pe.scala 39:11]
  wire [7:0] SystolicInput_io_port_out_bits; // @[pe.scala 39:11]
  wire [7:0] SystolicInput_io_to_cell_bits; // @[pe.scala 39:11]
  wire  SystolicInput_1_clock; // @[pe.scala 39:11]
  wire  SystolicInput_1_reset; // @[pe.scala 39:11]
  wire [7:0] SystolicInput_1_io_port_in_bits; // @[pe.scala 39:11]
  wire [7:0] SystolicInput_1_io_port_out_bits; // @[pe.scala 39:11]
  wire [7:0] SystolicInput_1_io_to_cell_bits; // @[pe.scala 39:11]
  ComputeCell_Latency ComputeCell_Latency ( // @[pe.scala 37:104]
    .clock(ComputeCell_Latency_clock),
    .reset(ComputeCell_Latency_reset),
    .io_data_2_in(ComputeCell_Latency_io_data_2_in),
    .io_data_1_in(ComputeCell_Latency_io_data_1_in),
    .io_data_0_in(ComputeCell_Latency_io_data_0_in),
    .io_data_0_out(ComputeCell_Latency_io_data_0_out)
  );
  StationaryOutput StationaryOutput ( // @[pe.scala 39:11]
    .clock(StationaryOutput_clock),
    .reset(StationaryOutput_reset),
    .io_port_in_valid(StationaryOutput_io_port_in_valid),
    .io_port_in_bits(StationaryOutput_io_port_in_bits),
    .io_port_out_valid(StationaryOutput_io_port_out_valid),
    .io_port_out_bits(StationaryOutput_io_port_out_bits),
    .io_from_cell_bits(StationaryOutput_io_from_cell_bits),
    .io_to_cell_bits(StationaryOutput_io_to_cell_bits),
    .io_sig_stat2trans(StationaryOutput_io_sig_stat2trans)
  );
  SystolicInput SystolicInput ( // @[pe.scala 39:11]
    .clock(SystolicInput_clock),
    .reset(SystolicInput_reset),
    .io_port_in_bits(SystolicInput_io_port_in_bits),
    .io_port_out_bits(SystolicInput_io_port_out_bits),
    .io_to_cell_bits(SystolicInput_io_to_cell_bits)
  );
  SystolicInput SystolicInput_1 ( // @[pe.scala 39:11]
    .clock(SystolicInput_1_clock),
    .reset(SystolicInput_1_reset),
    .io_port_in_bits(SystolicInput_1_io_port_in_bits),
    .io_port_out_bits(SystolicInput_1_io_port_out_bits),
    .io_to_cell_bits(SystolicInput_1_io_to_cell_bits)
  );
  assign io_data_2_out_bits = SystolicInput_1_io_port_out_bits; // @[pe.scala 42:17]
  assign io_data_1_out_bits = SystolicInput_io_port_out_bits; // @[pe.scala 42:17]
  assign io_data_0_out_valid = StationaryOutput_io_port_out_valid; // @[pe.scala 42:17]
  assign io_data_0_out_bits = StationaryOutput_io_port_out_bits; // @[pe.scala 42:17]
  assign ComputeCell_Latency_clock = clock;
  assign ComputeCell_Latency_reset = reset;
  assign ComputeCell_Latency_io_data_2_in = SystolicInput_1_io_to_cell_bits; // @[pe.scala 43:19]
  assign ComputeCell_Latency_io_data_1_in = SystolicInput_io_to_cell_bits; // @[pe.scala 43:19]
  assign ComputeCell_Latency_io_data_0_in = StationaryOutput_io_to_cell_bits; // @[pe.scala 43:19]
  assign StationaryOutput_clock = clock;
  assign StationaryOutput_reset = reset;
  assign StationaryOutput_io_port_in_valid = io_data_0_in_valid; // @[pe.scala 42:17]
  assign StationaryOutput_io_port_in_bits = io_data_0_in_bits; // @[pe.scala 42:17]
  assign StationaryOutput_io_from_cell_bits = ComputeCell_Latency_io_data_0_out; // @[pe.scala 45:33]
  assign StationaryOutput_io_sig_stat2trans = io_sig_stat2trans; // @[pe.scala 50:33]
  assign SystolicInput_clock = clock;
  assign SystolicInput_reset = reset;
  assign SystolicInput_io_port_in_bits = io_data_1_in_bits; // @[pe.scala 42:17]
  assign SystolicInput_1_clock = clock;
  assign SystolicInput_1_reset = reset;
  assign SystolicInput_1_io_port_in_bits = io_data_2_in_bits; // @[pe.scala 42:17]
endmodule
