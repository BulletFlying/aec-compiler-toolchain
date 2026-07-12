module PENetwork_16(
  output [7:0] io_to_pes_0_in_bits,
  input  [7:0] io_to_pes_0_out_bits,
  output [7:0] io_to_pes_1_in_bits,
  input  [7:0] io_to_pes_1_out_bits,
  output [7:0] io_to_pes_2_in_bits,
  input  [7:0] io_to_pes_2_out_bits,
  output [7:0] io_to_pes_3_in_bits,
  input  [7:0] io_to_pes_3_out_bits,
  output [7:0] io_to_pes_4_in_bits,
  input  [7:0] io_to_pes_4_out_bits,
  output [7:0] io_to_pes_5_in_bits,
  input  [7:0] io_to_pes_5_out_bits,
  output [7:0] io_to_pes_6_in_bits,
  input  [7:0] io_to_pes_6_out_bits,
  output [7:0] io_to_pes_7_in_bits,
  input  [7:0] io_to_pes_7_out_bits,
  output [7:0] io_to_pes_8_in_bits,
  input  [7:0] io_to_pes_8_out_bits,
  output [7:0] io_to_pes_9_in_bits,
  input  [7:0] io_to_pes_9_out_bits,
  output [7:0] io_to_pes_10_in_bits,
  input  [7:0] io_to_pes_10_out_bits,
  output [7:0] io_to_pes_11_in_bits,
  input  [7:0] io_to_pes_11_out_bits,
  output [7:0] io_to_pes_12_in_bits,
  input  [7:0] io_to_pes_12_out_bits,
  output [7:0] io_to_pes_13_in_bits,
  input  [7:0] io_to_pes_13_out_bits,
  output [7:0] io_to_pes_14_in_bits,
  input  [7:0] io_to_pes_14_out_bits,
  output [7:0] io_to_pes_15_in_bits,
  input  [7:0] io_to_mem_bits
);
  assign io_to_pes_0_in_bits = io_to_mem_bits; // @[pearray.scala 41:23]
  assign io_to_pes_1_in_bits = io_to_pes_0_out_bits; // @[pearray.scala 38:23]
  assign io_to_pes_2_in_bits = io_to_pes_1_out_bits; // @[pearray.scala 38:23]
  assign io_to_pes_3_in_bits = io_to_pes_2_out_bits; // @[pearray.scala 38:23]
  assign io_to_pes_4_in_bits = io_to_pes_3_out_bits; // @[pearray.scala 38:23]
  assign io_to_pes_5_in_bits = io_to_pes_4_out_bits; // @[pearray.scala 38:23]
  assign io_to_pes_6_in_bits = io_to_pes_5_out_bits; // @[pearray.scala 38:23]
  assign io_to_pes_7_in_bits = io_to_pes_6_out_bits; // @[pearray.scala 38:23]
  assign io_to_pes_8_in_bits = io_to_pes_7_out_bits; // @[pearray.scala 38:23]
  assign io_to_pes_9_in_bits = io_to_pes_8_out_bits; // @[pearray.scala 38:23]
  assign io_to_pes_10_in_bits = io_to_pes_9_out_bits; // @[pearray.scala 38:23]
  assign io_to_pes_11_in_bits = io_to_pes_10_out_bits; // @[pearray.scala 38:23]
  assign io_to_pes_12_in_bits = io_to_pes_11_out_bits; // @[pearray.scala 38:23]
  assign io_to_pes_13_in_bits = io_to_pes_12_out_bits; // @[pearray.scala 38:23]
  assign io_to_pes_14_in_bits = io_to_pes_13_out_bits; // @[pearray.scala 38:23]
  assign io_to_pes_15_in_bits = io_to_pes_14_out_bits; // @[pearray.scala 38:23]
endmodule
