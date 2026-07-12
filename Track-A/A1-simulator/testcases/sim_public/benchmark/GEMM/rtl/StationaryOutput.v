module StationaryOutput(
  input        clock,
  input        reset,
  input        io_port_in_valid,
  input  [7:0] io_port_in_bits,
  output       io_port_out_valid,
  output [7:0] io_port_out_bits,
  input  [7:0] io_from_cell_bits,
  output [7:0] io_to_cell_bits,
  input        io_sig_stat2trans
);
  wire  Queue_clock; // @[pe_modules.scala 173:21]
  wire  Queue_reset; // @[pe_modules.scala 173:21]
  wire  Queue_io_enq_ready; // @[pe_modules.scala 173:21]
  wire  Queue_io_enq_valid; // @[pe_modules.scala 173:21]
  wire [7:0] Queue_io_enq_bits; // @[pe_modules.scala 173:21]
  wire  Queue_io_deq_ready; // @[pe_modules.scala 173:21]
  wire  Queue_io_deq_valid; // @[pe_modules.scala 173:21]
  wire [7:0] Queue_io_deq_bits; // @[pe_modules.scala 173:21]
  reg  move_valid; // @[pe_modules.scala 174:21]
  reg [7:0] move_bits; // @[pe_modules.scala 174:21]
  reg  reg_stat2trans; // @[pe_modules.scala 179:31]
  Queue Queue ( // @[pe_modules.scala 173:21]
    .clock(Queue_clock),
    .reset(Queue_reset),
    .io_enq_ready(Queue_io_enq_ready),
    .io_enq_valid(Queue_io_enq_valid),
    .io_enq_bits(Queue_io_enq_bits),
    .io_deq_ready(Queue_io_deq_ready),
    .io_deq_valid(Queue_io_deq_valid),
    .io_deq_bits(Queue_io_deq_bits)
  );
  assign io_port_out_valid = move_valid; // @[pe_modules.scala 195:15]
  assign io_port_out_bits = move_bits; // @[pe_modules.scala 195:15]
  assign io_to_cell_bits = reg_stat2trans ? 8'h0 : io_from_cell_bits; // @[pe_modules.scala 198:25]
  assign Queue_clock = clock;
  assign Queue_reset = reset;
  assign Queue_io_enq_valid = reg_stat2trans; // @[pe_modules.scala 183:36]
  assign Queue_io_enq_bits = io_from_cell_bits; // @[pe_modules.scala 182:18]
  assign Queue_io_deq_ready = ~io_port_in_valid; // @[pe_modules.scala 187:8]
  always @(posedge clock) begin
    if (reset) begin // @[pe_modules.scala 174:21]
      move_valid <= 1'h0; // @[pe_modules.scala 174:21]
    end else if (~io_port_in_valid) begin // @[pe_modules.scala 187:26]
      move_valid <= Queue_io_deq_valid; // @[pe_modules.scala 189:16]
    end else begin
      move_valid <= io_port_in_valid; // @[pe_modules.scala 192:10]
    end
    if (reset) begin // @[pe_modules.scala 174:21]
      move_bits <= 8'h0; // @[pe_modules.scala 174:21]
    end else if (~io_port_in_valid) begin // @[pe_modules.scala 187:26]
      move_bits <= Queue_io_deq_bits; // @[pe_modules.scala 188:15]
    end else begin
      move_bits <= io_port_in_bits; // @[pe_modules.scala 192:10]
    end
    if (reset) begin // @[pe_modules.scala 179:31]
      reg_stat2trans <= 1'h0; // @[pe_modules.scala 179:31]
    end else begin
      reg_stat2trans <= io_sig_stat2trans; // @[pe_modules.scala 180:18]
    end
  end
// Register and memory initialization
endmodule
