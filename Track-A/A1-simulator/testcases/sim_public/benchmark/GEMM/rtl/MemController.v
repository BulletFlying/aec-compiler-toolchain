module MemController(
  input        clock,
  input        reset,
  input        io_rd_valid,
  input        io_wr_valid,
  output       io_rd_data_valid,
  output [7:0] io_rd_data_bits,
  input        io_wr_data_valid,
  input  [7:0] io_wr_data_bits
);
  wire  MultiDimMem_clock; // @[mem.scala 33:19]
  wire  MultiDimMem_reset; // @[mem.scala 33:19]
  wire  MultiDimMem_io_rd_addr_valid; // @[mem.scala 33:19]
  wire [1:0] MultiDimMem_io_rd_addr_bits_0; // @[mem.scala 33:19]
  wire [1:0] MultiDimMem_io_rd_addr_bits_1; // @[mem.scala 33:19]
  wire  MultiDimMem_io_rd_data_valid; // @[mem.scala 33:19]
  wire [7:0] MultiDimMem_io_rd_data_bits; // @[mem.scala 33:19]
  wire [1:0] MultiDimMem_io_wr_addr_bits_0; // @[mem.scala 33:19]
  wire [1:0] MultiDimMem_io_wr_addr_bits_1; // @[mem.scala 33:19]
  wire  MultiDimMem_io_wr_data_valid; // @[mem.scala 33:19]
  wire [7:0] MultiDimMem_io_wr_data_bits; // @[mem.scala 33:19]
  wire  MultiDimTime_clock; // @[mem.scala 34:23]
  wire  MultiDimTime_reset; // @[mem.scala 34:23]
  wire  MultiDimTime_io_in; // @[mem.scala 34:23]
  wire [1:0] MultiDimTime_io_out_0; // @[mem.scala 34:23]
  wire [1:0] MultiDimTime_io_out_1; // @[mem.scala 34:23]
  wire  MultiDimTime_1_clock; // @[mem.scala 35:23]
  wire  MultiDimTime_1_reset; // @[mem.scala 35:23]
  wire  MultiDimTime_1_io_in; // @[mem.scala 35:23]
  wire [1:0] MultiDimTime_1_io_out_0; // @[mem.scala 35:23]
  wire [1:0] MultiDimTime_1_io_out_1; // @[mem.scala 35:23]
  MultiDimMem MultiDimMem ( // @[mem.scala 33:19]
    .clock(MultiDimMem_clock),
    .reset(MultiDimMem_reset),
    .io_rd_addr_valid(MultiDimMem_io_rd_addr_valid),
    .io_rd_addr_bits_0(MultiDimMem_io_rd_addr_bits_0),
    .io_rd_addr_bits_1(MultiDimMem_io_rd_addr_bits_1),
    .io_rd_data_valid(MultiDimMem_io_rd_data_valid),
    .io_rd_data_bits(MultiDimMem_io_rd_data_bits),
    .io_wr_addr_bits_0(MultiDimMem_io_wr_addr_bits_0),
    .io_wr_addr_bits_1(MultiDimMem_io_wr_addr_bits_1),
    .io_wr_data_valid(MultiDimMem_io_wr_data_valid),
    .io_wr_data_bits(MultiDimMem_io_wr_data_bits)
  );
  MultiDimTime_4 MultiDimTime ( // @[mem.scala 34:23]
    .clock(MultiDimTime_clock),
    .reset(MultiDimTime_reset),
    .io_in(MultiDimTime_io_in),
    .io_out_0(MultiDimTime_io_out_0),
    .io_out_1(MultiDimTime_io_out_1)
  );
  MultiDimTime_4 MultiDimTime_1 ( // @[mem.scala 35:23]
    .clock(MultiDimTime_1_clock),
    .reset(MultiDimTime_1_reset),
    .io_in(MultiDimTime_1_io_in),
    .io_out_0(MultiDimTime_1_io_out_0),
    .io_out_1(MultiDimTime_1_io_out_1)
  );
  assign io_rd_data_valid = MultiDimMem_io_rd_data_valid; // @[mem.scala 53:14]
  assign io_rd_data_bits = MultiDimMem_io_rd_data_bits; // @[mem.scala 53:14]
  assign MultiDimMem_clock = clock;
  assign MultiDimMem_reset = reset;
  assign MultiDimMem_io_rd_addr_valid = io_rd_valid; // @[mem.scala 50:21]
  assign MultiDimMem_io_rd_addr_bits_0 = MultiDimTime_1_io_out_0; // @[mem.scala 49:20]
  assign MultiDimMem_io_rd_addr_bits_1 = MultiDimTime_1_io_out_1; // @[mem.scala 49:20]
  assign MultiDimMem_io_wr_addr_bits_0 = MultiDimTime_io_out_0; // @[mem.scala 45:20]
  assign MultiDimMem_io_wr_addr_bits_1 = MultiDimTime_io_out_1; // @[mem.scala 45:20]
  assign MultiDimMem_io_wr_data_valid = io_wr_data_valid; // @[mem.scala 54:15]
  assign MultiDimMem_io_wr_data_bits = io_wr_data_bits; // @[mem.scala 54:15]
  assign MultiDimTime_clock = clock;
  assign MultiDimTime_reset = reset;
  assign MultiDimTime_io_in = io_wr_valid; // @[mem.scala 44:14]
  assign MultiDimTime_1_clock = clock;
  assign MultiDimTime_1_reset = reset;
  assign MultiDimTime_1_io_in = io_rd_valid; // @[mem.scala 48:14]
endmodule
