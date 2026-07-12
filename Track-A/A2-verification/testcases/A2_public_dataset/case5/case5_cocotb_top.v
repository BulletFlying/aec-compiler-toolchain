`timescale 1ns / 1ps

module case5_cocotb_top;

parameter S = 1;
parameter S_COUNT = 2;
parameter M_COUNT = 4;
parameter ADDR_WIDTH = 32;
parameter ID_WIDTH = 4;
parameter S_THREADS = 8;
parameter S_ACCEPT = 4;
parameter M_REGIONS = 2;

localparam [M_COUNT*M_REGIONS*ADDR_WIDTH-1:0] M_BASE_ADDR_VALUE = {
    32'h13000000,
    32'h03000000,
    32'h12000000,
    32'h02000000,
    32'h11000000,
    32'h01000000,
    32'h10000000,
    32'h00000000
};

localparam [M_COUNT*M_REGIONS*32-1:0] M_ADDR_WIDTH_VALUE = {M_COUNT*M_REGIONS{32'd24}};
localparam [M_COUNT*S_COUNT-1:0] M_CONNECT_VALUE = {M_COUNT*S_COUNT{1'b1}};
localparam [M_COUNT-1:0] M_SECURE_VALUE = 4'b0100;

reg clk = 1'b0;
reg rst = 1'b0;

reg [ID_WIDTH-1:0] s_axi_aid = 0;
reg [ADDR_WIDTH-1:0] s_axi_aaddr = 0;
reg [2:0] s_axi_aprot = 0;
reg [3:0] s_axi_aqos = 0;
reg s_axi_avalid = 0;
wire s_axi_aready;

wire [3:0] m_axi_aregion;
wire [$clog2(M_COUNT)-1:0] m_select;
wire m_axi_avalid;
reg m_axi_aready = 0;

wire [$clog2(M_COUNT)-1:0] m_wc_select;
wire m_wc_decerr;
wire m_wc_valid;
reg m_wc_ready = 0;

wire m_rc_decerr;
wire m_rc_valid;
reg m_rc_ready = 0;

reg [ID_WIDTH-1:0] s_cpl_id = 0;
reg s_cpl_valid = 0;

axi_crossbar_addr #(
    .S(S),
    .S_COUNT(S_COUNT),
    .M_COUNT(M_COUNT),
    .ADDR_WIDTH(ADDR_WIDTH),
    .ID_WIDTH(ID_WIDTH),
    .S_THREADS(S_THREADS),
    .S_ACCEPT(S_ACCEPT),
    .M_REGIONS(M_REGIONS),
    .M_BASE_ADDR(M_BASE_ADDR_VALUE),
    .M_ADDR_WIDTH(M_ADDR_WIDTH_VALUE),
    .M_CONNECT(M_CONNECT_VALUE),
    .M_SECURE(M_SECURE_VALUE),
    .WC_OUTPUT(1)
)
dut (
    .clk(clk),
    .rst(rst),
    .s_axi_aid(s_axi_aid),
    .s_axi_aaddr(s_axi_aaddr),
    .s_axi_aprot(s_axi_aprot),
    .s_axi_aqos(s_axi_aqos),
    .s_axi_avalid(s_axi_avalid),
    .s_axi_aready(s_axi_aready),
    .m_axi_aregion(m_axi_aregion),
    .m_select(m_select),
    .m_axi_avalid(m_axi_avalid),
    .m_axi_aready(m_axi_aready),
    .m_wc_select(m_wc_select),
    .m_wc_decerr(m_wc_decerr),
    .m_wc_valid(m_wc_valid),
    .m_wc_ready(m_wc_ready),
    .m_rc_decerr(m_rc_decerr),
    .m_rc_valid(m_rc_valid),
    .m_rc_ready(m_rc_ready),
    .s_cpl_id(s_cpl_id),
    .s_cpl_valid(s_cpl_valid)
);

endmodule
