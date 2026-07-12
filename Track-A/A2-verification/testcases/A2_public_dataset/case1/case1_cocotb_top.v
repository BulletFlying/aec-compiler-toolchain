`timescale 1ns / 1ps

module case1_cocotb_top;

parameter ADDR_WIDTH = 16;
parameter S_DATA_WIDTH = 32;
parameter S_STRB_WIDTH = S_DATA_WIDTH/8;
parameter M_DATA_WIDTH = 16;
parameter M_STRB_WIDTH = M_DATA_WIDTH/8;
parameter ID_WIDTH = 8;
parameter ARUSER_ENABLE = 0;
parameter ARUSER_WIDTH = 1;
parameter RUSER_ENABLE = 0;
parameter RUSER_WIDTH = 1;
parameter CONVERT_BURST = 1;
parameter CONVERT_NARROW_BURST = 1;
parameter FORWARD_ID = 1;

reg clk = 1'b0;
reg rst = 1'b0;

reg [ID_WIDTH-1:0] s_axi_arid = 0;
reg [ADDR_WIDTH-1:0] s_axi_araddr = 0;
reg [7:0] s_axi_arlen = 0;
reg [2:0] s_axi_arsize = 0;
reg [1:0] s_axi_arburst = 0;
reg s_axi_arlock = 0;
reg [3:0] s_axi_arcache = 0;
reg [2:0] s_axi_arprot = 0;
reg [3:0] s_axi_arqos = 0;
reg [3:0] s_axi_arregion = 0;
reg [ARUSER_WIDTH-1:0] s_axi_aruser = 0;
reg s_axi_arvalid = 0;
wire s_axi_arready;
wire [ID_WIDTH-1:0] s_axi_rid;
wire [S_DATA_WIDTH-1:0] s_axi_rdata;
wire [1:0] s_axi_rresp;
wire s_axi_rlast;
wire [RUSER_WIDTH-1:0] s_axi_ruser;
wire s_axi_rvalid;
reg s_axi_rready = 0;

wire [ID_WIDTH-1:0] m_axi_arid;
wire [ADDR_WIDTH-1:0] m_axi_araddr;
wire [7:0] m_axi_arlen;
wire [2:0] m_axi_arsize;
wire [1:0] m_axi_arburst;
wire m_axi_arlock;
wire [3:0] m_axi_arcache;
wire [2:0] m_axi_arprot;
wire [3:0] m_axi_arqos;
wire [3:0] m_axi_arregion;
wire [ARUSER_WIDTH-1:0] m_axi_aruser;
wire m_axi_arvalid;
reg m_axi_arready = 0;
reg [ID_WIDTH-1:0] m_axi_rid = 0;
reg [M_DATA_WIDTH-1:0] m_axi_rdata = 0;
reg [1:0] m_axi_rresp = 0;
reg m_axi_rlast = 0;
reg [RUSER_WIDTH-1:0] m_axi_ruser = 0;
reg m_axi_rvalid = 0;
wire m_axi_rready;

axi_adapter_rd #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .S_DATA_WIDTH(S_DATA_WIDTH),
    .S_STRB_WIDTH(S_STRB_WIDTH),
    .M_DATA_WIDTH(M_DATA_WIDTH),
    .M_STRB_WIDTH(M_STRB_WIDTH),
    .ID_WIDTH(ID_WIDTH),
    .ARUSER_ENABLE(ARUSER_ENABLE),
    .ARUSER_WIDTH(ARUSER_WIDTH),
    .RUSER_ENABLE(RUSER_ENABLE),
    .RUSER_WIDTH(RUSER_WIDTH),
    .CONVERT_BURST(CONVERT_BURST),
    .CONVERT_NARROW_BURST(CONVERT_NARROW_BURST),
    .FORWARD_ID(FORWARD_ID)
)
dut (
    .clk(clk),
    .rst(rst),
    .s_axi_arid(s_axi_arid),
    .s_axi_araddr(s_axi_araddr),
    .s_axi_arlen(s_axi_arlen),
    .s_axi_arsize(s_axi_arsize),
    .s_axi_arburst(s_axi_arburst),
    .s_axi_arlock(s_axi_arlock),
    .s_axi_arcache(s_axi_arcache),
    .s_axi_arprot(s_axi_arprot),
    .s_axi_arqos(s_axi_arqos),
    .s_axi_arregion(s_axi_arregion),
    .s_axi_aruser(s_axi_aruser),
    .s_axi_arvalid(s_axi_arvalid),
    .s_axi_arready(s_axi_arready),
    .s_axi_rid(s_axi_rid),
    .s_axi_rdata(s_axi_rdata),
    .s_axi_rresp(s_axi_rresp),
    .s_axi_rlast(s_axi_rlast),
    .s_axi_ruser(s_axi_ruser),
    .s_axi_rvalid(s_axi_rvalid),
    .s_axi_rready(s_axi_rready),
    .m_axi_arid(m_axi_arid),
    .m_axi_araddr(m_axi_araddr),
    .m_axi_arlen(m_axi_arlen),
    .m_axi_arsize(m_axi_arsize),
    .m_axi_arburst(m_axi_arburst),
    .m_axi_arlock(m_axi_arlock),
    .m_axi_arcache(m_axi_arcache),
    .m_axi_arprot(m_axi_arprot),
    .m_axi_arqos(m_axi_arqos),
    .m_axi_arregion(m_axi_arregion),
    .m_axi_aruser(m_axi_aruser),
    .m_axi_arvalid(m_axi_arvalid),
    .m_axi_arready(m_axi_arready),
    .m_axi_rid(m_axi_rid),
    .m_axi_rdata(m_axi_rdata),
    .m_axi_rresp(m_axi_rresp),
    .m_axi_rlast(m_axi_rlast),
    .m_axi_ruser(m_axi_ruser),
    .m_axi_rvalid(m_axi_rvalid),
    .m_axi_rready(m_axi_rready)
);

endmodule
