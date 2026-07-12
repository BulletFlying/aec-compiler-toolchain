module MultiDimMem_16(
  input        clock,
  input        reset,
  input        io_rd_addr_valid,
  input  [1:0] io_rd_addr_bits_0,
  input  [1:0] io_rd_addr_bits_1,
  output [7:0] io_rd_data_bits,
  input  [1:0] io_wr_addr_bits_0,
  input  [1:0] io_wr_addr_bits_1,
  input        io_wr_data_valid,
  input  [7:0] io_wr_data_bits
);
  reg [8:0] mem [0:19]; // @[mem.scala 131:24]
  wire  mem_mem_output_en; // @[mem.scala 131:24]
  wire [4:0] mem_mem_output_addr; // @[mem.scala 131:24]
  wire [8:0] mem_mem_output_data; // @[mem.scala 131:24]
  wire [8:0] mem__T_43_data; // @[mem.scala 131:24]
  wire [4:0] mem__T_43_addr; // @[mem.scala 131:24]
  wire  mem__T_43_mask; // @[mem.scala 131:24]
  wire  mem__T_43_en; // @[mem.scala 131:24]
  reg  mem_mem_output_en_pipe_0;
  reg [4:0] mem_mem_output_addr_pipe_0;
  reg  rd_addr_reg_valid; // @[mem.scala 132:28]
  reg [15:0] rd_addr_reg_bits_1; // @[mem.scala 132:28]
  reg [15:0] rd_addr_reg_bits_0; // @[mem.scala 132:28]
  wire [15:0] _T_6 = rd_addr_reg_bits_0 + 16'h1; // @[mem.scala 143:102]
  wire [15:0] _T_11 = rd_addr_reg_bits_1 + 16'h1; // @[mem.scala 143:102]
  wire [15:0] mem_rd_addr = rd_addr_reg_bits_0 + rd_addr_reg_bits_1; // @[mem.scala 146:46]
  reg  mem_req_valid; // @[mem.scala 151:30]
  reg [15:0] wr_addr_reg_bits_1; // @[mem.scala 152:28]
  reg [15:0] wr_addr_reg_bits_0; // @[mem.scala 152:28]
  wire [15:0] _T_22 = wr_addr_reg_bits_0 + 16'h1; // @[mem.scala 164:102]
  wire [15:0] _T_27 = wr_addr_reg_bits_1 + 16'h1; // @[mem.scala 164:102]
  wire [15:0] mem_wr_addr = wr_addr_reg_bits_0 + wr_addr_reg_bits_1; // @[mem.scala 166:46]
  reg  wr_data_1_valid; // @[mem.scala 171:26]
  reg [7:0] wr_data_1_bits; // @[mem.scala 171:26]
  reg  wr_data_2_valid; // @[mem.scala 178:26]
  reg [7:0] wr_data_2_bits; // @[mem.scala 178:26]
  reg [15:0] wr_addr_2; // @[mem.scala 180:26]
  reg [7:0] wr_data_final; // @[mem.scala 186:30]
  reg [15:0] wr_addr_3; // @[mem.scala 187:26]
  reg  wr_valid_3; // @[mem.scala 188:27]
  wire [8:0] _GEN_9 = {wr_valid_3, 8'h0}; // @[mem.scala 191:38]
  wire [15:0] _T_39 = {{7'd0}, _GEN_9}; // @[mem.scala 191:38]
  wire [15:0] _GEN_10 = {{8'd0}, wr_data_final}; // @[mem.scala 191:52]
  wire [15:0] _T_40 = _T_39 | _GEN_10; // @[mem.scala 191:52]
  reg [7:0] _T_49; // @[mem.scala 195:29]
  assign mem_mem_output_en = mem_mem_output_en_pipe_0;
  assign mem_mem_output_addr = mem_mem_output_addr_pipe_0;
  assign mem__T_43_data = _T_40[8:0];
  assign mem__T_43_addr = wr_addr_3[4:0];
  assign mem__T_43_mask = 1'h1;
  assign mem__T_43_en = wr_valid_3;
  assign io_rd_data_bits = _T_49; // @[mem.scala 195:19]
  always @(posedge clock) begin
    if (mem__T_43_en & mem__T_43_mask) begin
      mem[mem__T_43_addr] <= mem__T_43_data; // @[mem.scala 131:24]
    end
    mem_mem_output_en_pipe_0 <= rd_addr_reg_valid;
    if (rd_addr_reg_valid) begin
      mem_mem_output_addr_pipe_0 <= mem_rd_addr[4:0];
    end
    if (reset) begin // @[mem.scala 132:28]
      rd_addr_reg_valid <= 1'h0; // @[mem.scala 132:28]
    end else begin
      rd_addr_reg_valid <= io_rd_addr_valid; // @[mem.scala 147:21]
    end
    if (reset) begin // @[mem.scala 132:28]
      rd_addr_reg_bits_1 <= 16'h0; // @[mem.scala 132:28]
    end else if (2'h0 == io_rd_addr_bits_1) begin // @[Mux.scala 68:16]
      rd_addr_reg_bits_1 <= 16'h0;
    end else if (2'h1 == io_rd_addr_bits_1) begin // @[Mux.scala 68:16]
      rd_addr_reg_bits_1 <= _T_11;
    end
    if (reset) begin // @[mem.scala 132:28]
      rd_addr_reg_bits_0 <= 16'h0; // @[mem.scala 132:28]
    end else if (2'h0 == io_rd_addr_bits_0) begin // @[Mux.scala 68:16]
      rd_addr_reg_bits_0 <= 16'h0;
    end else if (2'h1 == io_rd_addr_bits_0) begin // @[Mux.scala 68:16]
      rd_addr_reg_bits_0 <= _T_6;
    end
    if (reset) begin // @[mem.scala 151:30]
      mem_req_valid <= 1'h0; // @[mem.scala 151:30]
    end else begin
      mem_req_valid <= rd_addr_reg_valid; // @[mem.scala 151:30]
    end
    if (reset) begin // @[mem.scala 152:28]
      wr_addr_reg_bits_1 <= 16'h0; // @[mem.scala 152:28]
    end else if (2'h0 == io_wr_addr_bits_1) begin // @[Mux.scala 68:16]
      wr_addr_reg_bits_1 <= 16'h0;
    end else if (2'h1 == io_wr_addr_bits_1) begin // @[Mux.scala 68:16]
      wr_addr_reg_bits_1 <= _T_27;
    end
    if (reset) begin // @[mem.scala 152:28]
      wr_addr_reg_bits_0 <= 16'h0; // @[mem.scala 152:28]
    end else if (2'h0 == io_wr_addr_bits_0) begin // @[Mux.scala 68:16]
      wr_addr_reg_bits_0 <= 16'h0;
    end else if (2'h1 == io_wr_addr_bits_0) begin // @[Mux.scala 68:16]
      wr_addr_reg_bits_0 <= _T_22;
    end
    if (reset) begin // @[mem.scala 171:26]
      wr_data_1_valid <= 1'h0; // @[mem.scala 171:26]
    end else begin
      wr_data_1_valid <= io_wr_data_valid; // @[mem.scala 171:26]
    end
    if (reset) begin // @[mem.scala 171:26]
      wr_data_1_bits <= 8'h0; // @[mem.scala 171:26]
    end else begin
      wr_data_1_bits <= io_wr_data_bits; // @[mem.scala 171:26]
    end
    if (reset) begin // @[mem.scala 178:26]
      wr_data_2_valid <= 1'h0; // @[mem.scala 178:26]
    end else begin
      wr_data_2_valid <= wr_data_1_valid; // @[mem.scala 178:26]
    end
    if (reset) begin // @[mem.scala 178:26]
      wr_data_2_bits <= 8'h0; // @[mem.scala 178:26]
    end else begin
      wr_data_2_bits <= wr_data_1_bits; // @[mem.scala 178:26]
    end
    if (reset) begin // @[mem.scala 180:26]
      wr_addr_2 <= 16'h0; // @[mem.scala 180:26]
    end else begin
      wr_addr_2 <= mem_wr_addr; // @[mem.scala 180:26]
    end
    wr_data_final <= wr_data_2_bits; // @[mem.scala 186:34]
    if (reset) begin // @[mem.scala 187:26]
      wr_addr_3 <= 16'h0; // @[mem.scala 187:26]
    end else begin
      wr_addr_3 <= wr_addr_2; // @[mem.scala 187:26]
    end
    wr_valid_3 <= wr_data_2_valid; // @[mem.scala 188:27]
    if (mem_req_valid) begin // @[mem.scala 195:33]
      _T_49 <= mem_mem_output_data[7:0];
    end else begin
      _T_49 <= 8'h0;
    end
  end
// Register and memory initialization
endmodule
