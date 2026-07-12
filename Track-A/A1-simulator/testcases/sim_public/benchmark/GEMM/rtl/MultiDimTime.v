module MultiDimTime(
  input         clock,
  input         reset,
  input         io_in,
  output [1:0]  io_out_0,
  output [1:0]  io_out_1,
  output [17:0] io_index_1
);
  reg [15:0] regs_0; // @[mem.scala 81:12]
  reg [15:0] regs_1; // @[mem.scala 81:12]
  wire [15:0] _GEN_4 = {{15'd0}, io_in}; // @[mem.scala 95:42]
  wire [15:0] _T_1 = regs_0 + _GEN_4; // @[mem.scala 95:42]
  wire  back_0 = _T_1 == 16'h1; // @[mem.scala 95:48]
  wire [15:0] _T_3 = regs_1 + _GEN_4; // @[mem.scala 95:42]
  wire  back_1 = _T_3 == 16'h14; // @[mem.scala 95:48]
  wire  _T_4 = ~back_0; // @[mem.scala 102:20]
  wire [1:0] _T_5 = {_T_4, 1'h0}; // @[mem.scala 102:31]
  wire  _T_6 = ~back_1; // @[mem.scala 102:40]
  wire [1:0] _GEN_6 = {{1'd0}, _T_6}; // @[mem.scala 102:37]
  wire  _GEN_3 = back_0 ? 1'h0 : io_in; // @[mem.scala 112:16 114:15 117:15]
  assign io_out_0 = {{1'd0}, _GEN_3};
  assign io_out_1 = _T_5 | _GEN_6; // @[mem.scala 102:37]
  assign io_index_1 = {{2'd0}, regs_1}; // @[mem.scala 99:17]
  always @(posedge clock) begin
    if (reset) begin // @[mem.scala 81:12]
      regs_0 <= 16'h0; // @[mem.scala 81:12]
    end else if (back_0) begin // @[mem.scala 112:16]
      regs_0 <= 16'h0; // @[mem.scala 113:13]
    end else begin
      regs_0 <= _T_1; // @[mem.scala 116:13]
    end
    if (reset) begin // @[mem.scala 81:12]
      regs_1 <= 16'h0; // @[mem.scala 81:12]
    end else if (back_0) begin // @[mem.scala 103:19]
      if (back_1) begin // @[mem.scala 104:20]
        regs_1 <= 16'h0; // @[mem.scala 105:17]
      end else begin
        regs_1 <= _T_3; // @[mem.scala 107:17]
      end
    end
  end
// Register and memory initialization
endmodule
