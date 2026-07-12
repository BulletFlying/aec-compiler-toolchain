`timescale 1ns / 1ps

module case3_cocotb_top;

parameter SEG_WIDTH = 16;
parameter SEG_CNT = 2;
parameter AXI_DATA_WIDTH = SEG_WIDTH*SEG_CNT;
parameter AXI_ADDR_WIDTH = 16;
parameter AXI_STRB_WIDTH = AXI_DATA_WIDTH/8;
parameter AXI_ID_WIDTH = 8;
parameter AXI_MAX_BURST_LEN = 16;
parameter LEN_WIDTH = AXI_ADDR_WIDTH;
parameter WRITE_FIFO_DEPTH = 64;
parameter WRITE_MAX_BURST_LEN = WRITE_FIFO_DEPTH/4;
parameter READ_FIFO_DEPTH = 128;
parameter READ_MAX_BURST_LEN = WRITE_MAX_BURST_LEN;
parameter WATERMARK_LEVEL = WRITE_FIFO_DEPTH/2;
parameter CTRL_OUT_EN = 0;

reg clk = 1'b0;
reg rst = 1'b0;

reg input_clk = 1'b0;
reg input_rst = 1'b0;
wire input_rst_out;
wire input_watermark;
reg [SEG_CNT*SEG_WIDTH-1:0] input_data = 0;
reg [SEG_CNT-1:0] input_valid = 0;
wire [SEG_CNT-1:0] input_ready;

reg output_clk = 1'b0;
reg output_rst = 1'b0;
wire output_rst_out;
wire [SEG_CNT*SEG_WIDTH-1:0] output_data;
wire [SEG_CNT-1:0] output_valid;
reg [SEG_CNT-1:0] output_ready = 0;
wire [SEG_CNT*SEG_WIDTH-1:0] output_ctrl_data;
wire [SEG_CNT-1:0] output_ctrl_valid;
reg [SEG_CNT-1:0] output_ctrl_ready = {SEG_CNT{1'b1}};

wire [AXI_ID_WIDTH-1:0] m_axi_awid;
wire [AXI_ADDR_WIDTH-1:0] m_axi_awaddr;
wire [7:0] m_axi_awlen;
wire [2:0] m_axi_awsize;
wire [1:0] m_axi_awburst;
wire m_axi_awlock;
wire [3:0] m_axi_awcache;
wire [2:0] m_axi_awprot;
wire m_axi_awvalid;
reg m_axi_awready = 0;
wire [AXI_DATA_WIDTH-1:0] m_axi_wdata;
wire [AXI_STRB_WIDTH-1:0] m_axi_wstrb;
wire m_axi_wlast;
wire m_axi_wvalid;
reg m_axi_wready = 0;
reg [AXI_ID_WIDTH-1:0] m_axi_bid = 0;
reg [1:0] m_axi_bresp = 0;
reg m_axi_bvalid = 0;
wire m_axi_bready;
wire [AXI_ID_WIDTH-1:0] m_axi_arid;
wire [AXI_ADDR_WIDTH-1:0] m_axi_araddr;
wire [7:0] m_axi_arlen;
wire [2:0] m_axi_arsize;
wire [1:0] m_axi_arburst;
wire m_axi_arlock;
wire [3:0] m_axi_arcache;
wire [2:0] m_axi_arprot;
wire m_axi_arvalid;
reg m_axi_arready = 0;
reg [AXI_ID_WIDTH-1:0] m_axi_rid = 0;
reg [AXI_DATA_WIDTH-1:0] m_axi_rdata = 0;
reg [1:0] m_axi_rresp = 0;
reg m_axi_rlast = 0;
reg m_axi_rvalid = 0;
wire m_axi_rready;

wire rst_req_out;
reg rst_req_in = 0;

reg [AXI_ADDR_WIDTH-1:0] cfg_fifo_base_addr = 0;
reg [LEN_WIDTH-1:0] cfg_fifo_size_mask = 0;
reg cfg_enable = 0;
reg cfg_reset = 0;

wire [LEN_WIDTH+1-1:0] sts_fifo_occupancy;
wire sts_fifo_empty;
wire sts_fifo_full;
wire sts_reset;
wire sts_active;
wire sts_write_active;
wire sts_read_active;

axi_vfifo_raw #(
    .SEG_WIDTH(SEG_WIDTH),
    .SEG_CNT(SEG_CNT),
    .AXI_DATA_WIDTH(AXI_DATA_WIDTH),
    .AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
    .AXI_STRB_WIDTH(AXI_STRB_WIDTH),
    .AXI_ID_WIDTH(AXI_ID_WIDTH),
    .AXI_MAX_BURST_LEN(AXI_MAX_BURST_LEN),
    .LEN_WIDTH(LEN_WIDTH),
    .WRITE_FIFO_DEPTH(WRITE_FIFO_DEPTH),
    .WRITE_MAX_BURST_LEN(WRITE_MAX_BURST_LEN),
    .READ_FIFO_DEPTH(READ_FIFO_DEPTH),
    .READ_MAX_BURST_LEN(READ_MAX_BURST_LEN),
    .WATERMARK_LEVEL(WATERMARK_LEVEL),
    .CTRL_OUT_EN(CTRL_OUT_EN)
)
dut (
    .clk(clk),
    .rst(rst),
    .input_clk(input_clk),
    .input_rst(input_rst),
    .input_rst_out(input_rst_out),
    .input_watermark(input_watermark),
    .input_data(input_data),
    .input_valid(input_valid),
    .input_ready(input_ready),
    .output_clk(output_clk),
    .output_rst(output_rst),
    .output_rst_out(output_rst_out),
    .output_data(output_data),
    .output_valid(output_valid),
    .output_ready(output_ready),
    .output_ctrl_data(output_ctrl_data),
    .output_ctrl_valid(output_ctrl_valid),
    .output_ctrl_ready(output_ctrl_ready),
    .m_axi_awid(m_axi_awid),
    .m_axi_awaddr(m_axi_awaddr),
    .m_axi_awlen(m_axi_awlen),
    .m_axi_awsize(m_axi_awsize),
    .m_axi_awburst(m_axi_awburst),
    .m_axi_awlock(m_axi_awlock),
    .m_axi_awcache(m_axi_awcache),
    .m_axi_awprot(m_axi_awprot),
    .m_axi_awvalid(m_axi_awvalid),
    .m_axi_awready(m_axi_awready),
    .m_axi_wdata(m_axi_wdata),
    .m_axi_wstrb(m_axi_wstrb),
    .m_axi_wlast(m_axi_wlast),
    .m_axi_wvalid(m_axi_wvalid),
    .m_axi_wready(m_axi_wready),
    .m_axi_bid(m_axi_bid),
    .m_axi_bresp(m_axi_bresp),
    .m_axi_bvalid(m_axi_bvalid),
    .m_axi_bready(m_axi_bready),
    .m_axi_arid(m_axi_arid),
    .m_axi_araddr(m_axi_araddr),
    .m_axi_arlen(m_axi_arlen),
    .m_axi_arsize(m_axi_arsize),
    .m_axi_arburst(m_axi_arburst),
    .m_axi_arlock(m_axi_arlock),
    .m_axi_arcache(m_axi_arcache),
    .m_axi_arprot(m_axi_arprot),
    .m_axi_arvalid(m_axi_arvalid),
    .m_axi_arready(m_axi_arready),
    .m_axi_rid(m_axi_rid),
    .m_axi_rdata(m_axi_rdata),
    .m_axi_rresp(m_axi_rresp),
    .m_axi_rlast(m_axi_rlast),
    .m_axi_rvalid(m_axi_rvalid),
    .m_axi_rready(m_axi_rready),
    .rst_req_out(rst_req_out),
    .rst_req_in(rst_req_in),
    .cfg_fifo_base_addr(cfg_fifo_base_addr),
    .cfg_fifo_size_mask(cfg_fifo_size_mask),
    .cfg_enable(cfg_enable),
    .cfg_reset(cfg_reset),
    .sts_fifo_occupancy(sts_fifo_occupancy),
    .sts_fifo_empty(sts_fifo_empty),
    .sts_fifo_full(sts_fifo_full),
    .sts_reset(sts_reset),
    .sts_active(sts_active),
    .sts_write_active(sts_write_active),
    .sts_read_active(sts_read_active)
);

endmodule
