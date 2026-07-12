module ShiftRegister(
  input         clock,
  input  [31:0] io_input,
  input         io_enable,
  output [31:0] io_output_1,
  output [31:0] io_output_6,
  output [31:0] io_output_14,
  output [31:0] io_output_15
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] reg_0; // @[ShiftRegister.scala 34:18]
  reg [31:0] reg_1; // @[ShiftRegister.scala 34:18]
  reg [31:0] reg_2; // @[ShiftRegister.scala 34:18]
  reg [31:0] reg_3; // @[ShiftRegister.scala 34:18]
  reg [31:0] reg_4; // @[ShiftRegister.scala 34:18]
  reg [31:0] reg_5; // @[ShiftRegister.scala 34:18]
  reg [31:0] reg_6; // @[ShiftRegister.scala 34:18]
  reg [31:0] reg_7; // @[ShiftRegister.scala 34:18]
  reg [31:0] reg_8; // @[ShiftRegister.scala 34:18]
  reg [31:0] reg_9; // @[ShiftRegister.scala 34:18]
  reg [31:0] reg_10; // @[ShiftRegister.scala 34:18]
  reg [31:0] reg_11; // @[ShiftRegister.scala 34:18]
  reg [31:0] reg_12; // @[ShiftRegister.scala 34:18]
  reg [31:0] reg_13; // @[ShiftRegister.scala 34:18]
  reg [31:0] reg_14; // @[ShiftRegister.scala 34:18]
  reg [31:0] reg_15; // @[ShiftRegister.scala 34:18]
  assign io_output_1 = reg_1; // @[ShiftRegister.scala 53:15]
  assign io_output_6 = reg_6; // @[ShiftRegister.scala 53:15]
  assign io_output_14 = reg_14; // @[ShiftRegister.scala 53:15]
  assign io_output_15 = reg_15; // @[ShiftRegister.scala 53:15]
  always @(posedge clock) begin
    if (io_enable) begin // @[ShiftRegister.scala 36:22]
      reg_0 <= io_input;
    end
    if (io_enable) begin // @[ShiftRegister.scala 36:22]
      reg_1 <= reg_0;
    end
    if (io_enable) begin // @[ShiftRegister.scala 36:22]
      reg_2 <= reg_1;
    end
    if (io_enable) begin // @[ShiftRegister.scala 36:22]
      reg_3 <= reg_2;
    end
    if (io_enable) begin // @[ShiftRegister.scala 36:22]
      reg_4 <= reg_3;
    end
    if (io_enable) begin // @[ShiftRegister.scala 36:22]
      reg_5 <= reg_4;
    end
    if (io_enable) begin // @[ShiftRegister.scala 36:22]
      reg_6 <= reg_5;
    end
    if (io_enable) begin // @[ShiftRegister.scala 36:22]
      reg_7 <= reg_6;
    end
    if (io_enable) begin // @[ShiftRegister.scala 36:22]
      reg_8 <= reg_7;
    end
    if (io_enable) begin // @[ShiftRegister.scala 36:22]
      reg_9 <= reg_8;
    end
    if (io_enable) begin // @[ShiftRegister.scala 36:22]
      reg_10 <= reg_9;
    end
    if (io_enable) begin // @[ShiftRegister.scala 36:22]
      reg_11 <= reg_10;
    end
    if (io_enable) begin // @[ShiftRegister.scala 36:22]
      reg_12 <= reg_11;
    end
    if (io_enable) begin // @[ShiftRegister.scala 36:22]
      reg_13 <= reg_12;
    end
    if (io_enable) begin // @[ShiftRegister.scala 36:22]
      reg_14 <= reg_13;
    end
    if (io_enable) begin // @[ShiftRegister.scala 36:22]
      reg_15 <= reg_14;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  reg_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  reg_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  reg_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  reg_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  reg_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  reg_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  reg_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  reg_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  reg_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  reg_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  reg_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  reg_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  reg_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  reg_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  reg_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  reg_15 = _RAND_15[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MessageScheduleArray(
  input         clock,
  input         reset,
  input         io_first,
  input         io_shiftIn,
  input  [31:0] io_wordIn,
  output [31:0] io_wOut
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  shreg_clock; // @[MessageScheduleArray.scala 50:23]
  wire [31:0] shreg_io_input; // @[MessageScheduleArray.scala 50:23]
  wire  shreg_io_enable; // @[MessageScheduleArray.scala 50:23]
  wire [31:0] shreg_io_output_1; // @[MessageScheduleArray.scala 50:23]
  wire [31:0] shreg_io_output_6; // @[MessageScheduleArray.scala 50:23]
  wire [31:0] shreg_io_output_14; // @[MessageScheduleArray.scala 50:23]
  wire [31:0] shreg_io_output_15; // @[MessageScheduleArray.scala 50:23]
  reg [5:0] iReg; // @[MessageScheduleArray.scala 32:23]
  reg [31:0] out; // @[MessageScheduleArray.scala 36:22]
  wire [5:0] _i_T_1 = iReg + 6'h1; // @[MessageScheduleArray.scala 44:19]
  wire [5:0] _GEN_0 = io_shiftIn ? _i_T_1 : iReg; // @[MessageScheduleArray.scala 43:30 44:11 47:11]
  wire [5:0] i = io_first ? 6'h0 : _GEN_0; // @[MessageScheduleArray.scala 40:21 41:11]
  wire [31:0] _s0_T_2 = {shreg_io_output_14[6:0],shreg_io_output_14[31:7]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _s0_T_5 = {shreg_io_output_14[17:0],shreg_io_output_14[31:18]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _s0_T_6 = _s0_T_2 ^ _s0_T_5; // @[MessageScheduleArray.scala 63:58]
  wire [31:0] _GEN_6 = {{3'd0}, shreg_io_output_14[31:3]}; // @[MessageScheduleArray.scala 63:97]
  wire [31:0] s0 = _s0_T_6 ^ _GEN_6; // @[MessageScheduleArray.scala 63:97]
  wire [31:0] _s1_T_2 = {shreg_io_output_1[16:0],shreg_io_output_1[31:17]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _s1_T_5 = {shreg_io_output_1[18:0],shreg_io_output_1[31:19]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _s1_T_6 = _s1_T_2 ^ _s1_T_5; // @[MessageScheduleArray.scala 64:58]
  wire [31:0] _GEN_7 = {{10'd0}, shreg_io_output_1[31:10]}; // @[MessageScheduleArray.scala 64:96]
  wire [31:0] s1 = _s1_T_6 ^ _GEN_7; // @[MessageScheduleArray.scala 64:96]
  wire [31:0] _outWire_T_1 = shreg_io_output_15 + s0; // @[MessageScheduleArray.scala 65:44]
  wire [31:0] _outWire_T_3 = _outWire_T_1 + shreg_io_output_6; // @[MessageScheduleArray.scala 65:49]
  wire [31:0] _outWire_T_5 = _outWire_T_3 + s1; // @[MessageScheduleArray.scala 65:70]
  wire [31:0] _GEN_4 = i < 6'h10 ? io_wordIn : _outWire_T_5; // @[MessageScheduleArray.scala 60:25 61:21 65:21]
  ShiftRegister shreg ( // @[MessageScheduleArray.scala 50:23]
    .clock(shreg_clock),
    .io_input(shreg_io_input),
    .io_enable(shreg_io_enable),
    .io_output_1(shreg_io_output_1),
    .io_output_6(shreg_io_output_6),
    .io_output_14(shreg_io_output_14),
    .io_output_15(shreg_io_output_15)
  );
  assign io_wOut = out; // @[MessageScheduleArray.scala 37:13]
  assign shreg_clock = clock;
  assign shreg_io_input = io_shiftIn ? _GEN_4 : 32'h0; // @[MessageScheduleArray.scala 58:13 59:23]
  assign shreg_io_enable = io_shiftIn; // @[MessageScheduleArray.scala 55:21]
  always @(posedge clock) begin
    if (reset) begin // @[MessageScheduleArray.scala 32:23]
      iReg <= 6'h0; // @[MessageScheduleArray.scala 32:23]
    end else if (io_first) begin // @[MessageScheduleArray.scala 40:21]
      iReg <= 6'h0; // @[MessageScheduleArray.scala 41:11]
    end else if (io_shiftIn) begin // @[MessageScheduleArray.scala 43:30]
      iReg <= _i_T_1; // @[MessageScheduleArray.scala 44:11]
    end
    if (reset) begin // @[MessageScheduleArray.scala 36:22]
      out <= 32'h0; // @[MessageScheduleArray.scala 36:22]
    end else if (io_shiftIn) begin // @[MessageScheduleArray.scala 59:23]
      if (i < 6'h10) begin // @[MessageScheduleArray.scala 60:25]
        out <= io_wordIn; // @[MessageScheduleArray.scala 61:21]
      end else begin
        out <= _outWire_T_5; // @[MessageScheduleArray.scala 65:21]
      end
    end else begin
      out <= 32'h0; // @[MessageScheduleArray.scala 58:13]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  iReg = _RAND_0[5:0];
  _RAND_1 = {1{`RANDOM}};
  out = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module CompressionFunction(
  input         clock,
  input         reset,
  input         io_first,
  input         io_newChunk,
  input         io_shiftIn,
  input  [31:0] io_wordIn,
  output        io_valid,
  output [31:0] io_out_0,
  output [31:0] io_out_1,
  output [31:0] io_out_2,
  output [31:0] io_out_3,
  output [31:0] io_out_4,
  output [31:0] io_out_5,
  output [31:0] io_out_6,
  output [31:0] io_out_7
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
`endif // RANDOMIZE_REG_INIT
  wire  messageScheduleArray_clock; // @[CompressionFunction.scala 49:38]
  wire  messageScheduleArray_reset; // @[CompressionFunction.scala 49:38]
  wire  messageScheduleArray_io_first; // @[CompressionFunction.scala 49:38]
  wire  messageScheduleArray_io_shiftIn; // @[CompressionFunction.scala 49:38]
  wire [31:0] messageScheduleArray_io_wordIn; // @[CompressionFunction.scala 49:38]
  wire [31:0] messageScheduleArray_io_wOut; // @[CompressionFunction.scala 49:38]
  reg  valid; // @[CompressionFunction.scala 32:24]
  reg [5:0] i; // @[CompressionFunction.scala 35:20]
  reg [31:0] hash_val_0; // @[CompressionFunction.scala 37:27]
  reg [31:0] hash_val_1; // @[CompressionFunction.scala 37:27]
  reg [31:0] hash_val_2; // @[CompressionFunction.scala 37:27]
  reg [31:0] hash_val_3; // @[CompressionFunction.scala 37:27]
  reg [31:0] hash_val_4; // @[CompressionFunction.scala 37:27]
  reg [31:0] hash_val_5; // @[CompressionFunction.scala 37:27]
  reg [31:0] hash_val_6; // @[CompressionFunction.scala 37:27]
  reg [31:0] hash_val_7; // @[CompressionFunction.scala 37:27]
  reg [31:0] a; // @[CompressionFunction.scala 40:20]
  reg [31:0] b; // @[CompressionFunction.scala 41:20]
  reg [31:0] c; // @[CompressionFunction.scala 42:20]
  reg [31:0] d; // @[CompressionFunction.scala 43:20]
  reg [31:0] e; // @[CompressionFunction.scala 44:20]
  reg [31:0] f; // @[CompressionFunction.scala 45:20]
  reg [31:0] g; // @[CompressionFunction.scala 46:20]
  reg [31:0] h; // @[CompressionFunction.scala 47:20]
  wire  _messageScheduleArray_io_first_T = io_first | io_newChunk; // @[CompressionFunction.scala 50:47]
  reg  shiftIn; // @[CompressionFunction.scala 57:26]
  wire [31:0] _GEN_18 = io_first ? 32'h6a09e667 : hash_val_0; // @[CompressionFunction.scala 64:21 73:18 37:27]
  wire [31:0] _GEN_19 = io_first ? 32'hbb67ae85 : hash_val_1; // @[CompressionFunction.scala 64:21 73:18 37:27]
  wire [31:0] _GEN_20 = io_first ? 32'h3c6ef372 : hash_val_2; // @[CompressionFunction.scala 64:21 73:18 37:27]
  wire [31:0] _GEN_21 = io_first ? 32'ha54ff53a : hash_val_3; // @[CompressionFunction.scala 64:21 73:18 37:27]
  wire [31:0] _GEN_22 = io_first ? 32'h510e527f : hash_val_4; // @[CompressionFunction.scala 64:21 73:18 37:27]
  wire [31:0] _GEN_23 = io_first ? 32'h9b05688c : hash_val_5; // @[CompressionFunction.scala 64:21 73:18 37:27]
  wire [31:0] _GEN_24 = io_first ? 32'h1f83d9ab : hash_val_6; // @[CompressionFunction.scala 64:21 73:18 37:27]
  wire [31:0] _GEN_25 = io_first ? 32'h5be0cd19 : hash_val_7; // @[CompressionFunction.scala 64:21 73:18 37:27]
  wire [31:0] _S1_T_2 = {e[5:0],e[31:6]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _S1_T_5 = {e[10:0],e[31:11]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _S1_T_6 = _S1_T_2 ^ _S1_T_5; // @[CompressionFunction.scala 89:36]
  wire [31:0] _S1_T_9 = {e[24:0],e[31:25]}; // @[RotateLeft.scala 24:38]
  wire [31:0] S1 = _S1_T_6 ^ _S1_T_9; // @[CompressionFunction.scala 89:57]
  wire [31:0] _ch_T = e & f; // @[CompressionFunction.scala 90:21]
  wire [31:0] _ch_T_1 = ~e; // @[CompressionFunction.scala 90:30]
  wire [31:0] _ch_T_2 = _ch_T_1 & g; // @[CompressionFunction.scala 90:41]
  wire [31:0] ch = _ch_T ^ _ch_T_2; // @[CompressionFunction.scala 90:26]
  wire [31:0] _temp1_T_1 = h + S1; // @[CompressionFunction.scala 91:23]
  wire [31:0] _temp1_T_3 = _temp1_T_1 + ch; // @[CompressionFunction.scala 91:28]
  wire [31:0] _GEN_27 = 6'h1 == i ? 32'h71374491 : 32'h428a2f98; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_28 = 6'h2 == i ? 32'hb5c0fbcf : _GEN_27; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_29 = 6'h3 == i ? 32'he9b5dba5 : _GEN_28; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_30 = 6'h4 == i ? 32'h3956c25b : _GEN_29; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_31 = 6'h5 == i ? 32'h59f111f1 : _GEN_30; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_32 = 6'h6 == i ? 32'h923f82a4 : _GEN_31; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_33 = 6'h7 == i ? 32'hab1c5ed5 : _GEN_32; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_34 = 6'h8 == i ? 32'hd807aa98 : _GEN_33; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_35 = 6'h9 == i ? 32'h12835b01 : _GEN_34; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_36 = 6'ha == i ? 32'h243185be : _GEN_35; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_37 = 6'hb == i ? 32'h550c7dc3 : _GEN_36; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_38 = 6'hc == i ? 32'h72be5d74 : _GEN_37; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_39 = 6'hd == i ? 32'h80deb1fe : _GEN_38; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_40 = 6'he == i ? 32'h9bdc06a7 : _GEN_39; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_41 = 6'hf == i ? 32'hc19bf174 : _GEN_40; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_42 = 6'h10 == i ? 32'he49b69c1 : _GEN_41; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_43 = 6'h11 == i ? 32'hefbe4786 : _GEN_42; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_44 = 6'h12 == i ? 32'hfc19dc6 : _GEN_43; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_45 = 6'h13 == i ? 32'h240ca1cc : _GEN_44; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_46 = 6'h14 == i ? 32'h2de92c6f : _GEN_45; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_47 = 6'h15 == i ? 32'h4a7484aa : _GEN_46; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_48 = 6'h16 == i ? 32'h5cb0a9dc : _GEN_47; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_49 = 6'h17 == i ? 32'h76f988da : _GEN_48; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_50 = 6'h18 == i ? 32'h983e5152 : _GEN_49; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_51 = 6'h19 == i ? 32'ha831c66d : _GEN_50; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_52 = 6'h1a == i ? 32'hb00327c8 : _GEN_51; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_53 = 6'h1b == i ? 32'hbf597fc7 : _GEN_52; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_54 = 6'h1c == i ? 32'hc6e00bf3 : _GEN_53; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_55 = 6'h1d == i ? 32'hd5a79147 : _GEN_54; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_56 = 6'h1e == i ? 32'h6ca6351 : _GEN_55; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_57 = 6'h1f == i ? 32'h14292967 : _GEN_56; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_58 = 6'h20 == i ? 32'h27b70a85 : _GEN_57; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_59 = 6'h21 == i ? 32'h2e1b2138 : _GEN_58; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_60 = 6'h22 == i ? 32'h4d2c6dfc : _GEN_59; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_61 = 6'h23 == i ? 32'h53380d13 : _GEN_60; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_62 = 6'h24 == i ? 32'h650a7354 : _GEN_61; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_63 = 6'h25 == i ? 32'h766a0abb : _GEN_62; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_64 = 6'h26 == i ? 32'h81c2c92e : _GEN_63; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_65 = 6'h27 == i ? 32'h92722c85 : _GEN_64; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_66 = 6'h28 == i ? 32'ha2bfe8a1 : _GEN_65; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_67 = 6'h29 == i ? 32'ha81a664b : _GEN_66; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_68 = 6'h2a == i ? 32'hc24b8b70 : _GEN_67; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_69 = 6'h2b == i ? 32'hc76c51a3 : _GEN_68; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_70 = 6'h2c == i ? 32'hd192e819 : _GEN_69; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_71 = 6'h2d == i ? 32'hd6990624 : _GEN_70; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_72 = 6'h2e == i ? 32'hf40e3585 : _GEN_71; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_73 = 6'h2f == i ? 32'h106aa070 : _GEN_72; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_74 = 6'h30 == i ? 32'h19a4c116 : _GEN_73; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_75 = 6'h31 == i ? 32'h1e376c08 : _GEN_74; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_76 = 6'h32 == i ? 32'h2748774c : _GEN_75; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_77 = 6'h33 == i ? 32'h34b0bcb5 : _GEN_76; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_78 = 6'h34 == i ? 32'h391c0cb3 : _GEN_77; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_79 = 6'h35 == i ? 32'h4ed8aa4a : _GEN_78; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_80 = 6'h36 == i ? 32'h5b9cca4f : _GEN_79; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_81 = 6'h37 == i ? 32'h682e6ff3 : _GEN_80; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_82 = 6'h38 == i ? 32'h748f82ee : _GEN_81; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_83 = 6'h39 == i ? 32'h78a5636f : _GEN_82; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_84 = 6'h3a == i ? 32'h84c87814 : _GEN_83; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_85 = 6'h3b == i ? 32'h8cc70208 : _GEN_84; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_86 = 6'h3c == i ? 32'h90befffa : _GEN_85; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_87 = 6'h3d == i ? 32'ha4506ceb : _GEN_86; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_88 = 6'h3e == i ? 32'hbef9a3f7 : _GEN_87; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _GEN_89 = 6'h3f == i ? 32'hc67178f2 : _GEN_88; // @[CompressionFunction.scala 91:{33,33}]
  wire [31:0] _temp1_T_5 = _temp1_T_3 + _GEN_89; // @[CompressionFunction.scala 91:33]
  wire [31:0] temp1 = _temp1_T_5 + messageScheduleArray_io_wOut; // @[CompressionFunction.scala 91:69]
  wire [31:0] _S0_T_2 = {a[1:0],a[31:2]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _S0_T_5 = {a[12:0],a[31:13]}; // @[RotateLeft.scala 24:38]
  wire [31:0] _S0_T_6 = _S0_T_2 ^ _S0_T_5; // @[CompressionFunction.scala 92:36]
  wire [31:0] _S0_T_9 = {a[21:0],a[31:22]}; // @[RotateLeft.scala 24:38]
  wire [31:0] S0 = _S0_T_6 ^ _S0_T_9; // @[CompressionFunction.scala 92:57]
  wire [31:0] _maj_T = a & b; // @[CompressionFunction.scala 93:22]
  wire [31:0] _maj_T_1 = a & c; // @[CompressionFunction.scala 93:32]
  wire [31:0] _maj_T_2 = _maj_T ^ _maj_T_1; // @[CompressionFunction.scala 93:27]
  wire [31:0] _maj_T_3 = b & c; // @[CompressionFunction.scala 93:42]
  wire [31:0] maj = _maj_T_2 ^ _maj_T_3; // @[CompressionFunction.scala 93:37]
  wire [31:0] temp2 = S0 + maj; // @[CompressionFunction.scala 94:24]
  wire [31:0] _e_T_1 = d + temp1; // @[CompressionFunction.scala 99:16]
  wire [31:0] _a_T_1 = temp1 + temp2; // @[CompressionFunction.scala 103:20]
  wire [5:0] _i_T_1 = i + 6'h1; // @[CompressionFunction.scala 105:20]
  wire  _T_1 = i == 6'h3f; // @[CompressionFunction.scala 107:17]
  wire [31:0] _a_T_5 = _a_T_1 + hash_val_0; // @[CompressionFunction.scala 110:32]
  wire [31:0] _b_T_1 = a + hash_val_1; // @[CompressionFunction.scala 111:20]
  wire [31:0] _c_T_1 = b + hash_val_2; // @[CompressionFunction.scala 112:20]
  wire [31:0] _d_T_1 = c + hash_val_3; // @[CompressionFunction.scala 113:20]
  wire [31:0] _e_T_5 = _e_T_1 + hash_val_4; // @[CompressionFunction.scala 114:28]
  wire [31:0] _f_T_1 = e + hash_val_5; // @[CompressionFunction.scala 115:20]
  wire [31:0] _g_T_1 = f + hash_val_6; // @[CompressionFunction.scala 116:20]
  wire [31:0] _h_T_1 = g + hash_val_7; // @[CompressionFunction.scala 117:20]
  wire [31:0] _hash_val_0_T_1 = hash_val_0 + temp1; // @[CompressionFunction.scala 119:40]
  wire [31:0] _hash_val_0_T_3 = _hash_val_0_T_1 + temp2; // @[CompressionFunction.scala 119:48]
  wire [31:0] _hash_val_1_T_1 = hash_val_1 + a; // @[CompressionFunction.scala 120:40]
  wire [31:0] _hash_val_2_T_1 = hash_val_2 + b; // @[CompressionFunction.scala 121:40]
  wire [31:0] _hash_val_3_T_1 = hash_val_3 + c; // @[CompressionFunction.scala 122:40]
  wire [31:0] _hash_val_4_T_1 = hash_val_4 + d; // @[CompressionFunction.scala 123:40]
  wire [31:0] _hash_val_4_T_3 = _hash_val_4_T_1 + temp1; // @[CompressionFunction.scala 123:44]
  wire [31:0] _hash_val_5_T_1 = hash_val_5 + e; // @[CompressionFunction.scala 124:40]
  wire [31:0] _hash_val_6_T_1 = hash_val_6 + f; // @[CompressionFunction.scala 125:40]
  wire [31:0] _hash_val_7_T_1 = hash_val_7 + g; // @[CompressionFunction.scala 126:40]
  MessageScheduleArray messageScheduleArray ( // @[CompressionFunction.scala 49:38]
    .clock(messageScheduleArray_clock),
    .reset(messageScheduleArray_reset),
    .io_first(messageScheduleArray_io_first),
    .io_shiftIn(messageScheduleArray_io_shiftIn),
    .io_wordIn(messageScheduleArray_io_wordIn),
    .io_wOut(messageScheduleArray_io_wOut)
  );
  assign io_valid = valid; // @[CompressionFunction.scala 33:14]
  assign io_out_0 = hash_val_0; // @[CompressionFunction.scala 38:12]
  assign io_out_1 = hash_val_1; // @[CompressionFunction.scala 38:12]
  assign io_out_2 = hash_val_2; // @[CompressionFunction.scala 38:12]
  assign io_out_3 = hash_val_3; // @[CompressionFunction.scala 38:12]
  assign io_out_4 = hash_val_4; // @[CompressionFunction.scala 38:12]
  assign io_out_5 = hash_val_5; // @[CompressionFunction.scala 38:12]
  assign io_out_6 = hash_val_6; // @[CompressionFunction.scala 38:12]
  assign io_out_7 = hash_val_7; // @[CompressionFunction.scala 38:12]
  assign messageScheduleArray_clock = clock;
  assign messageScheduleArray_reset = reset;
  assign messageScheduleArray_io_first = io_first | io_newChunk; // @[CompressionFunction.scala 50:47]
  assign messageScheduleArray_io_shiftIn = io_shiftIn; // @[CompressionFunction.scala 51:37]
  assign messageScheduleArray_io_wordIn = io_wordIn; // @[CompressionFunction.scala 52:36]
  always @(posedge clock) begin
    if (reset) begin // @[CompressionFunction.scala 32:24]
      valid <= 1'h0; // @[CompressionFunction.scala 32:24]
    end else if (shiftIn) begin // @[CompressionFunction.scala 86:20]
      valid <= _T_1;
    end else if (_messageScheduleArray_io_first_T) begin // @[CompressionFunction.scala 59:35]
      valid <= 1'h0; // @[CompressionFunction.scala 60:15]
    end
    if (reset) begin // @[CompressionFunction.scala 35:20]
      i <= 6'h0; // @[CompressionFunction.scala 35:20]
    end else if (shiftIn) begin // @[CompressionFunction.scala 86:20]
      i <= _i_T_1; // @[CompressionFunction.scala 105:11]
    end else if (_messageScheduleArray_io_first_T) begin // @[CompressionFunction.scala 59:35]
      i <= 6'h0; // @[CompressionFunction.scala 61:11]
    end
    if (reset) begin // @[CompressionFunction.scala 37:27]
      hash_val_0 <= 32'h6a09e667; // @[CompressionFunction.scala 37:27]
    end else if (shiftIn) begin // @[CompressionFunction.scala 86:20]
      if (i == 6'h3f) begin // @[CompressionFunction.scala 107:27]
        hash_val_0 <= _hash_val_0_T_3; // @[CompressionFunction.scala 119:25]
      end else begin
        hash_val_0 <= _GEN_18;
      end
    end else begin
      hash_val_0 <= _GEN_18;
    end
    if (reset) begin // @[CompressionFunction.scala 37:27]
      hash_val_1 <= 32'hbb67ae85; // @[CompressionFunction.scala 37:27]
    end else if (shiftIn) begin // @[CompressionFunction.scala 86:20]
      if (i == 6'h3f) begin // @[CompressionFunction.scala 107:27]
        hash_val_1 <= _hash_val_1_T_1; // @[CompressionFunction.scala 120:25]
      end else begin
        hash_val_1 <= _GEN_19;
      end
    end else begin
      hash_val_1 <= _GEN_19;
    end
    if (reset) begin // @[CompressionFunction.scala 37:27]
      hash_val_2 <= 32'h3c6ef372; // @[CompressionFunction.scala 37:27]
    end else if (shiftIn) begin // @[CompressionFunction.scala 86:20]
      if (i == 6'h3f) begin // @[CompressionFunction.scala 107:27]
        hash_val_2 <= _hash_val_2_T_1; // @[CompressionFunction.scala 121:25]
      end else begin
        hash_val_2 <= _GEN_20;
      end
    end else begin
      hash_val_2 <= _GEN_20;
    end
    if (reset) begin // @[CompressionFunction.scala 37:27]
      hash_val_3 <= 32'ha54ff53a; // @[CompressionFunction.scala 37:27]
    end else if (shiftIn) begin // @[CompressionFunction.scala 86:20]
      if (i == 6'h3f) begin // @[CompressionFunction.scala 107:27]
        hash_val_3 <= _hash_val_3_T_1; // @[CompressionFunction.scala 122:25]
      end else begin
        hash_val_3 <= _GEN_21;
      end
    end else begin
      hash_val_3 <= _GEN_21;
    end
    if (reset) begin // @[CompressionFunction.scala 37:27]
      hash_val_4 <= 32'h510e527f; // @[CompressionFunction.scala 37:27]
    end else if (shiftIn) begin // @[CompressionFunction.scala 86:20]
      if (i == 6'h3f) begin // @[CompressionFunction.scala 107:27]
        hash_val_4 <= _hash_val_4_T_3; // @[CompressionFunction.scala 123:25]
      end else begin
        hash_val_4 <= _GEN_22;
      end
    end else begin
      hash_val_4 <= _GEN_22;
    end
    if (reset) begin // @[CompressionFunction.scala 37:27]
      hash_val_5 <= 32'h9b05688c; // @[CompressionFunction.scala 37:27]
    end else if (shiftIn) begin // @[CompressionFunction.scala 86:20]
      if (i == 6'h3f) begin // @[CompressionFunction.scala 107:27]
        hash_val_5 <= _hash_val_5_T_1; // @[CompressionFunction.scala 124:25]
      end else begin
        hash_val_5 <= _GEN_23;
      end
    end else begin
      hash_val_5 <= _GEN_23;
    end
    if (reset) begin // @[CompressionFunction.scala 37:27]
      hash_val_6 <= 32'h1f83d9ab; // @[CompressionFunction.scala 37:27]
    end else if (shiftIn) begin // @[CompressionFunction.scala 86:20]
      if (i == 6'h3f) begin // @[CompressionFunction.scala 107:27]
        hash_val_6 <= _hash_val_6_T_1; // @[CompressionFunction.scala 125:25]
      end else begin
        hash_val_6 <= _GEN_24;
      end
    end else begin
      hash_val_6 <= _GEN_24;
    end
    if (reset) begin // @[CompressionFunction.scala 37:27]
      hash_val_7 <= 32'h5be0cd19; // @[CompressionFunction.scala 37:27]
    end else if (shiftIn) begin // @[CompressionFunction.scala 86:20]
      if (i == 6'h3f) begin // @[CompressionFunction.scala 107:27]
        hash_val_7 <= _hash_val_7_T_1; // @[CompressionFunction.scala 126:25]
      end else begin
        hash_val_7 <= _GEN_25;
      end
    end else begin
      hash_val_7 <= _GEN_25;
    end
    if (reset) begin // @[CompressionFunction.scala 40:20]
      a <= 32'h6a09e667; // @[CompressionFunction.scala 40:20]
    end else if (shiftIn) begin // @[CompressionFunction.scala 86:20]
      if (i == 6'h3f) begin // @[CompressionFunction.scala 107:27]
        a <= _a_T_5; // @[CompressionFunction.scala 110:15]
      end else begin
        a <= _a_T_1; // @[CompressionFunction.scala 103:11]
      end
    end else if (io_first) begin // @[CompressionFunction.scala 64:21]
      a <= 32'h6a09e667; // @[CompressionFunction.scala 65:11]
    end else if (io_newChunk) begin // @[CompressionFunction.scala 75:31]
      a <= hash_val_0; // @[CompressionFunction.scala 76:11]
    end
    if (reset) begin // @[CompressionFunction.scala 41:20]
      b <= 32'hbb67ae85; // @[CompressionFunction.scala 41:20]
    end else if (shiftIn) begin // @[CompressionFunction.scala 86:20]
      if (i == 6'h3f) begin // @[CompressionFunction.scala 107:27]
        b <= _b_T_1; // @[CompressionFunction.scala 111:15]
      end else begin
        b <= a; // @[CompressionFunction.scala 102:11]
      end
    end else if (io_first) begin // @[CompressionFunction.scala 64:21]
      b <= 32'hbb67ae85; // @[CompressionFunction.scala 66:11]
    end else if (io_newChunk) begin // @[CompressionFunction.scala 75:31]
      b <= hash_val_1; // @[CompressionFunction.scala 77:11]
    end
    if (reset) begin // @[CompressionFunction.scala 42:20]
      c <= 32'h3c6ef372; // @[CompressionFunction.scala 42:20]
    end else if (shiftIn) begin // @[CompressionFunction.scala 86:20]
      if (i == 6'h3f) begin // @[CompressionFunction.scala 107:27]
        c <= _c_T_1; // @[CompressionFunction.scala 112:15]
      end else begin
        c <= b; // @[CompressionFunction.scala 101:11]
      end
    end else if (io_first) begin // @[CompressionFunction.scala 64:21]
      c <= 32'h3c6ef372; // @[CompressionFunction.scala 67:11]
    end else if (io_newChunk) begin // @[CompressionFunction.scala 75:31]
      c <= hash_val_2; // @[CompressionFunction.scala 78:11]
    end
    if (reset) begin // @[CompressionFunction.scala 43:20]
      d <= 32'ha54ff53a; // @[CompressionFunction.scala 43:20]
    end else if (shiftIn) begin // @[CompressionFunction.scala 86:20]
      if (i == 6'h3f) begin // @[CompressionFunction.scala 107:27]
        d <= _d_T_1; // @[CompressionFunction.scala 113:15]
      end else begin
        d <= c; // @[CompressionFunction.scala 100:11]
      end
    end else if (io_first) begin // @[CompressionFunction.scala 64:21]
      d <= 32'ha54ff53a; // @[CompressionFunction.scala 68:11]
    end else if (io_newChunk) begin // @[CompressionFunction.scala 75:31]
      d <= hash_val_3; // @[CompressionFunction.scala 79:11]
    end
    if (reset) begin // @[CompressionFunction.scala 44:20]
      e <= 32'h510e527f; // @[CompressionFunction.scala 44:20]
    end else if (shiftIn) begin // @[CompressionFunction.scala 86:20]
      if (i == 6'h3f) begin // @[CompressionFunction.scala 107:27]
        e <= _e_T_5; // @[CompressionFunction.scala 114:15]
      end else begin
        e <= _e_T_1; // @[CompressionFunction.scala 99:11]
      end
    end else if (io_first) begin // @[CompressionFunction.scala 64:21]
      e <= 32'h510e527f; // @[CompressionFunction.scala 69:11]
    end else if (io_newChunk) begin // @[CompressionFunction.scala 75:31]
      e <= hash_val_4; // @[CompressionFunction.scala 80:11]
    end
    if (reset) begin // @[CompressionFunction.scala 45:20]
      f <= 32'h9b05688c; // @[CompressionFunction.scala 45:20]
    end else if (shiftIn) begin // @[CompressionFunction.scala 86:20]
      if (i == 6'h3f) begin // @[CompressionFunction.scala 107:27]
        f <= _f_T_1; // @[CompressionFunction.scala 115:15]
      end else begin
        f <= e; // @[CompressionFunction.scala 98:11]
      end
    end else if (io_first) begin // @[CompressionFunction.scala 64:21]
      f <= 32'h9b05688c; // @[CompressionFunction.scala 70:11]
    end else if (io_newChunk) begin // @[CompressionFunction.scala 75:31]
      f <= hash_val_5; // @[CompressionFunction.scala 81:11]
    end
    if (reset) begin // @[CompressionFunction.scala 46:20]
      g <= 32'h1f83d9ab; // @[CompressionFunction.scala 46:20]
    end else if (shiftIn) begin // @[CompressionFunction.scala 86:20]
      if (i == 6'h3f) begin // @[CompressionFunction.scala 107:27]
        g <= _g_T_1; // @[CompressionFunction.scala 116:15]
      end else begin
        g <= f; // @[CompressionFunction.scala 97:11]
      end
    end else if (io_first) begin // @[CompressionFunction.scala 64:21]
      g <= 32'h1f83d9ab; // @[CompressionFunction.scala 71:11]
    end else if (io_newChunk) begin // @[CompressionFunction.scala 75:31]
      g <= hash_val_6; // @[CompressionFunction.scala 82:11]
    end
    if (reset) begin // @[CompressionFunction.scala 47:20]
      h <= 32'h5be0cd19; // @[CompressionFunction.scala 47:20]
    end else if (shiftIn) begin // @[CompressionFunction.scala 86:20]
      if (i == 6'h3f) begin // @[CompressionFunction.scala 107:27]
        h <= _h_T_1; // @[CompressionFunction.scala 117:15]
      end else begin
        h <= g; // @[CompressionFunction.scala 96:11]
      end
    end else if (io_first) begin // @[CompressionFunction.scala 64:21]
      h <= 32'h5be0cd19; // @[CompressionFunction.scala 72:11]
    end else if (io_newChunk) begin // @[CompressionFunction.scala 75:31]
      h <= hash_val_7; // @[CompressionFunction.scala 83:11]
    end
    shiftIn <= io_shiftIn; // @[CompressionFunction.scala 57:26]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  valid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  i = _RAND_1[5:0];
  _RAND_2 = {1{`RANDOM}};
  hash_val_0 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  hash_val_1 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  hash_val_2 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  hash_val_3 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  hash_val_4 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  hash_val_5 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  hash_val_6 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  hash_val_7 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  a = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  b = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  c = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  d = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  e = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  f = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  g = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  h = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  shiftIn = _RAND_18[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Sha256Accel(
  input         clock,
  input         reset,
  input         io_first,
  input  [31:0] io_inputData,
  input         io_inputValid,
  output        io_inputReady,
  output [31:0] io_outputData_0,
  output [31:0] io_outputData_1,
  output [31:0] io_outputData_2,
  output [31:0] io_outputData_3,
  output [31:0] io_outputData_4,
  output [31:0] io_outputData_5,
  output [31:0] io_outputData_6,
  output [31:0] io_outputData_7,
  output        io_outputValid
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  accel_clock; // .scala 35:23]
  wire  accel_reset; // .scala 35:23]
  wire  accel_io_first; // .scala 35:23]
  wire  accel_io_newChunk; // .scala 35:23]
  wire  accel_io_shiftIn; // .scala 35:23]
  wire [31:0] accel_io_wordIn; // .scala 35:23]
  wire  accel_io_valid; // .scala 35:23]
  wire [31:0] accel_io_out_0; // .scala 35:23]
  wire [31:0] accel_io_out_1; // .scala 35:23]
  wire [31:0] accel_io_out_2; // .scala 35:23]
  wire [31:0] accel_io_out_3; // .scala 35:23]
  wire [31:0] accel_io_out_4; // .scala 35:23]
  wire [31:0] accel_io_out_5; // .scala 35:23]
  wire [31:0] accel_io_out_6; // .scala 35:23]
  wire [31:0] accel_io_out_7; // .scala 35:23]
  reg  first; // .scala 39:24]
  wire  _GEN_0 = io_first | first; // .scala 40:21 39:24 40:29]
  wire  _GEN_1 = accel_io_shiftIn ? 1'h0 : _GEN_0; // .scala 41:{29,37}]
  reg [7:0] ctr; // .scala 43:22]
  reg [7:0] io_inputReady_REG; // .scala 49:30]
  wire [7:0] _ctr_T_1 = ctr + 8'h1; // .scala 54:20]
  CompressionFunction accel ( // .scala 35:23]
    .clock(accel_clock),
    .reset(accel_reset),
    .io_first(accel_io_first),
    .io_newChunk(accel_io_newChunk),
    .io_shiftIn(accel_io_shiftIn),
    .io_wordIn(accel_io_wordIn),
    .io_valid(accel_io_valid),
    .io_out_0(accel_io_out_0),
    .io_out_1(accel_io_out_1),
    .io_out_2(accel_io_out_2),
    .io_out_3(accel_io_out_3),
    .io_out_4(accel_io_out_4),
    .io_out_5(accel_io_out_5),
    .io_out_6(accel_io_out_6),
    .io_out_7(accel_io_out_7)
  );
  assign io_inputReady = ctr >= 8'h10 ? 1'h0 : io_inputReady_REG < 8'h10 & ctr < 8'h10 & ~io_first; // .scala 49:19 50:24 51:23]
  assign io_outputData_0 = accel_io_out_0; // .scala 36:19]
  assign io_outputData_1 = accel_io_out_1; // .scala 36:19]
  assign io_outputData_2 = accel_io_out_2; // .scala 36:19]
  assign io_outputData_3 = accel_io_out_3; // .scala 36:19]
  assign io_outputData_4 = accel_io_out_4; // .scala 36:19]
  assign io_outputData_5 = accel_io_out_5; // .scala 36:19]
  assign io_outputData_6 = accel_io_out_6; // .scala 36:19]
  assign io_outputData_7 = accel_io_out_7; // .scala 36:19]
  assign io_outputValid = accel_io_valid; // .scala 37:20]
  assign accel_clock = clock;
  assign accel_reset = reset;
  assign accel_io_first = first & accel_io_shiftIn; // .scala 45:29]
  assign accel_io_newChunk = ctr == 8'h0 & accel_io_shiftIn; // .scala 44:40]
  assign accel_io_shiftIn = ctr >= 8'h10 | io_inputValid; // .scala 50:24 52:26]
  assign accel_io_wordIn = io_inputData; // .scala 48:21]
  always @(posedge clock) begin
    first <= reset | _GEN_1; // .scala 39:{24,24}]
    if (reset) begin // .scala 43:22]
      ctr <= 8'h0; // .scala 43:22]
    end else if (io_first) begin // .scala 61:21]
      ctr <= 8'h0; // .scala 61:27]
    end else if (ctr >= 8'h10) begin // .scala 50:24]
      if (ctr == 8'h3f) begin // .scala 55:29]
        ctr <= 8'h0; // .scala 55:35]
      end else begin
        ctr <= _ctr_T_1; // .scala 54:13]
      end
    end else if (io_inputValid) begin // .scala 56:33]
      ctr <= _ctr_T_1; // .scala 58:13]
    end
    io_inputReady_REG <= ctr; // .scala 49:30]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  first = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  ctr = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  io_inputReady_REG = _RAND_2[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Sha256Wishbone(
  input         clock,
  input         reset,
  input         io_bus_cyc,
  input         io_bus_stb,
  input         io_bus_we,
  input  [3:0]  io_bus_sel,
  input  [31:0] io_bus_addr,
  input  [31:0] io_bus_data_wr,
  output        io_bus_ack,
  output        io_bus_err,
  output [31:0] io_bus_data_rd
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  accel_clock; // .scala 54:23]
  wire  accel_reset; // .scala 54:23]
  wire  accel_io_first; // .scala 54:23]
  wire [31:0] accel_io_inputData; // .scala 54:23]
  wire  accel_io_inputValid; // .scala 54:23]
  wire  accel_io_inputReady; // .scala 54:23]
  wire [31:0] accel_io_outputData_0; // .scala 54:23]
  wire [31:0] accel_io_outputData_1; // .scala 54:23]
  wire [31:0] accel_io_outputData_2; // .scala 54:23]
  wire [31:0] accel_io_outputData_3; // .scala 54:23]
  wire [31:0] accel_io_outputData_4; // .scala 54:23]
  wire [31:0] accel_io_outputData_5; // .scala 54:23]
  wire [31:0] accel_io_outputData_6; // .scala 54:23]
  wire [31:0] accel_io_outputData_7; // .scala 54:23]
  wire  accel_io_outputValid; // .scala 54:23]
  reg [31:0] data_rd; // .scala 47:22]
  reg  ack; // .scala 50:22]
  wire  _T_4 = 30'h0 == io_bus_addr[31:2]; // .scala 64:34]
  wire  _data_rd_T = accel_io_outputValid; // .scala 65:70]
  wire  _data_rd_T_1 = accel_io_inputReady; // .scala 65:94]
  wire [31:0] _data_rd_T_2 = {29'h0,_data_rd_T,_data_rd_T_1,1'h0}; // @[Cat.scala 33:92]
  wire [31:0] _data_rd_T_4 = _data_rd_T ? accel_io_outputData_0 : 32'h0; // .scala 69:38]
  wire [31:0] _data_rd_T_6 = _data_rd_T ? accel_io_outputData_1 : 32'h0; // .scala 70:38]
  wire [31:0] _data_rd_T_8 = _data_rd_T ? accel_io_outputData_2 : 32'h0; // .scala 71:38]
  wire [31:0] _data_rd_T_10 = _data_rd_T ? accel_io_outputData_3 : 32'h0; // .scala 72:38]
  wire [31:0] _data_rd_T_12 = _data_rd_T ? accel_io_outputData_4 : 32'h0; // .scala 73:38]
  wire [31:0] _data_rd_T_14 = _data_rd_T ? accel_io_outputData_5 : 32'h0; // .scala 74:38]
  wire [31:0] _data_rd_T_16 = _data_rd_T ? accel_io_outputData_6 : 32'h0; // .scala 75:38]
  wire [31:0] _data_rd_T_18 = _data_rd_T ? accel_io_outputData_7 : 32'h0; // .scala 76:38]
  wire [31:0] _GEN_0 = 30'hb == io_bus_addr[31:2] ? _data_rd_T_18 : 32'h0; // .scala 63:17 64:34 76:32]
  wire [31:0] _GEN_1 = 30'ha == io_bus_addr[31:2] ? _data_rd_T_16 : _GEN_0; // .scala 64:34 75:32]
  wire [31:0] _GEN_2 = 30'h9 == io_bus_addr[31:2] ? _data_rd_T_14 : _GEN_1; // .scala 64:34 74:32]
  wire [31:0] _GEN_3 = 30'h8 == io_bus_addr[31:2] ? _data_rd_T_12 : _GEN_2; // .scala 64:34 73:32]
  wire [31:0] _GEN_4 = 30'h7 == io_bus_addr[31:2] ? _data_rd_T_10 : _GEN_3; // .scala 64:34 72:32]
  wire [31:0] _GEN_5 = 30'h6 == io_bus_addr[31:2] ? _data_rd_T_8 : _GEN_4; // .scala 64:34 71:32]
  wire [31:0] _GEN_6 = 30'h5 == io_bus_addr[31:2] ? _data_rd_T_6 : _GEN_5; // .scala 64:34 70:32]
  wire [31:0] _GEN_7 = 30'h4 == io_bus_addr[31:2] ? _data_rd_T_4 : _GEN_6; // .scala 64:34 69:32]
  wire [31:0] _GEN_8 = 30'h0 == io_bus_addr[31:2] ? _data_rd_T_2 : _GEN_7; // .scala 64:34 65:32]
  wire  _T_23 = io_bus_sel[0] & io_bus_data_wr[0]; // .scala 90:41]
  wire  _GEN_15 = 30'h1 == io_bus_addr[31:2] ? _data_rd_T_1 : 1'h1; // .scala 85:13 88:38]
  wire  _GEN_16 = _T_4 & _T_23; // .scala 58:20 88:38]
  wire  _GEN_17 = _T_4 ? 1'h0 : 30'h1 == io_bus_addr[31:2] & _data_rd_T_1; // .scala 56:25 88:38]
  wire  _GEN_18 = _T_4 | _GEN_15; // .scala 85:13 88:38]
  wire  _GEN_19 = io_bus_we & _GEN_16; // .scala 58:20 86:25]
  wire  _GEN_20 = io_bus_we & _GEN_17; // .scala 56:25 86:25]
  wire  _GEN_21 = io_bus_we ? _GEN_18 : 1'h1; // .scala 85:13 86:25]
  wire  _GEN_23 = io_bus_cyc & io_bus_stb & ~io_bus_ack & _GEN_21; // .scala 61:51 60:9]
  Sha256Accel accel ( // .scala 54:23]
    .clock(accel_clock),
    .reset(accel_reset),
    .io_first(accel_io_first),
    .io_inputData(accel_io_inputData),
    .io_inputValid(accel_io_inputValid),
    .io_inputReady(accel_io_inputReady),
    .io_outputData_0(accel_io_outputData_0),
    .io_outputData_1(accel_io_outputData_1),
    .io_outputData_2(accel_io_outputData_2),
    .io_outputData_3(accel_io_outputData_3),
    .io_outputData_4(accel_io_outputData_4),
    .io_outputData_5(accel_io_outputData_5),
    .io_outputData_6(accel_io_outputData_6),
    .io_outputData_7(accel_io_outputData_7),
    .io_outputValid(accel_io_outputValid)
  );
  assign io_bus_ack = ack; // .scala 51:16]
  assign io_bus_err = 1'h0; // .scala 52:16]
  assign io_bus_data_rd = data_rd; // .scala 48:20]
  assign accel_clock = clock;
  assign accel_reset = reset;
  assign accel_io_first = io_bus_cyc & io_bus_stb & ~io_bus_ack & _GEN_19; // .scala 58:20 61:51]
  assign accel_io_inputData = io_bus_data_wr; // .scala 57:24]
  assign accel_io_inputValid = io_bus_cyc & io_bus_stb & ~io_bus_ack & _GEN_20; // .scala 56:25 61:51]
  always @(posedge clock) begin
    if (io_bus_cyc & io_bus_stb & ~io_bus_ack) begin // .scala 61:51]
      if (io_bus_addr[31:2] == 30'h16) begin // .scala 80:60]
        data_rd <= 32'h65726f; // .scala 81:25]
      end else if (io_bus_addr[31:2] == 30'h15) begin // .scala 80:60]
        data_rd <= 32'h43203635; // .scala 81:25]
      end else if (io_bus_addr[31:2] == 30'h14) begin // .scala 80:60]
        data_rd <= 32'h32414853; // .scala 81:25]
      end else begin
        data_rd <= _GEN_8;
      end
    end
    if (reset) begin // .scala 50:22]
      ack <= 1'h0; // .scala 50:22]
    end else begin
      ack <= _GEN_23;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  data_rd = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  ack = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
