module Queue(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [7:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [7:0] io_deq_bits
);
  reg [7:0] _T [0:0]; // @[Decoupled.scala 218:24]
  wire  _T__T_14_en; // @[Decoupled.scala 218:24]
  wire  _T__T_14_addr; // @[Decoupled.scala 218:24]
  wire [7:0] _T__T_14_data; // @[Decoupled.scala 218:24]
  wire [7:0] _T__T_10_data; // @[Decoupled.scala 218:24]
  wire  _T__T_10_addr; // @[Decoupled.scala 218:24]
  wire  _T__T_10_mask; // @[Decoupled.scala 218:24]
  wire  _T__T_10_en; // @[Decoupled.scala 218:24]
  reg  _T_1; // @[Decoupled.scala 221:35]
  wire  _T_3 = ~_T_1; // @[Decoupled.scala 224:36]
  wire  _T_6 = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  _T_8 = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  assign _T__T_14_en = 1'h1;
  assign _T__T_14_addr = 1'h0;
  assign _T__T_14_data = _T[_T__T_14_addr]; // @[Decoupled.scala 218:24]
  assign _T__T_10_data = io_enq_bits;
  assign _T__T_10_addr = 1'h0;
  assign _T__T_10_mask = 1'h1;
  assign _T__T_10_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~_T_1; // @[Decoupled.scala 241:19]
  assign io_deq_valid = ~_T_3; // @[Decoupled.scala 240:19]
  assign io_deq_bits = _T__T_14_data; // @[Decoupled.scala 242:15]
  always @(posedge clock) begin
    if (_T__T_10_en & _T__T_10_mask) begin
      _T[_T__T_10_addr] <= _T__T_10_data; // @[Decoupled.scala 218:24]
    end
    if (reset) begin // @[Decoupled.scala 221:35]
      _T_1 <= 1'h0; // @[Decoupled.scala 221:35]
    end else if (_T_6 != _T_8) begin // @[Decoupled.scala 236:28]
      _T_1 <= _T_6; // @[Decoupled.scala 237:16]
    end
  end
// Register and memory initialization
endmodule
