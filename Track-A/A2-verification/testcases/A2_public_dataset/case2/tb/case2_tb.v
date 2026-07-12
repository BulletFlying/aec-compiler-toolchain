`timescale 1ns / 1ps

module tb;

parameter DEPTH = 32;
parameter S_DATA_WIDTH = 64;
parameter S_KEEP_ENABLE = (S_DATA_WIDTH>8);
parameter S_KEEP_WIDTH = (S_DATA_WIDTH/8);
parameter M_DATA_WIDTH = 8;
parameter M_KEEP_ENABLE = (M_DATA_WIDTH>8);
parameter M_KEEP_WIDTH = (M_DATA_WIDTH/8);
parameter ID_ENABLE = 1;
parameter ID_WIDTH = 8;
parameter DEST_ENABLE = 1;
parameter DEST_WIDTH = 8;
parameter USER_ENABLE = 1;
parameter USER_WIDTH = 1;
parameter FRAME_FIFO = 0;
parameter USER_BAD_FRAME_VALUE = 1'b1;
parameter USER_BAD_FRAME_MASK = 1'b1;
parameter DROP_BAD_FRAME = 0;
parameter DROP_WHEN_FULL = 0;
parameter CYCLE_COUNT = 7403;

reg clk = 1'b0;
reg rst = 1'b0;

reg [S_DATA_WIDTH-1:0] s_axis_tdata = 0;
reg [S_KEEP_WIDTH-1:0] s_axis_tkeep = 0;
reg s_axis_tvalid = 0;
reg s_axis_tlast = 0;
reg [ID_WIDTH-1:0] s_axis_tid = 0;
reg [DEST_WIDTH-1:0] s_axis_tdest = 0;
reg [USER_WIDTH-1:0] s_axis_tuser = 0;
reg m_axis_tready = 0;

wire s_axis_tready;
wire [M_DATA_WIDTH-1:0] m_axis_tdata;
wire [M_KEEP_WIDTH-1:0] m_axis_tkeep;
wire m_axis_tvalid;
wire m_axis_tlast;
wire [ID_WIDTH-1:0] m_axis_tid;
wire [DEST_WIDTH-1:0] m_axis_tdest;
wire [USER_WIDTH-1:0] m_axis_tuser;

reg exp_s_axis_tready = 0;
reg [M_DATA_WIDTH-1:0] exp_m_axis_tdata = 0;
reg [M_KEEP_WIDTH-1:0] exp_m_axis_tkeep = 0;
reg exp_m_axis_tvalid = 0;
reg exp_m_axis_tlast = 0;
reg [ID_WIDTH-1:0] exp_m_axis_tid = 0;
reg [DEST_WIDTH-1:0] exp_m_axis_tdest = 0;
reg [USER_WIDTH-1:0] exp_m_axis_tuser = 0;

reg [4095:0] input_header = 0;
reg [4095:0] output_header = 0;

integer input_fd;
integer output_fd;
integer scan_count;
integer cycle;

always #5 clk = ~clk;

axis_fifo_adapter #(
    .DEPTH(DEPTH),
    .S_DATA_WIDTH(S_DATA_WIDTH),
    .S_KEEP_ENABLE(S_KEEP_ENABLE),
    .S_KEEP_WIDTH(S_KEEP_WIDTH),
    .M_DATA_WIDTH(M_DATA_WIDTH),
    .M_KEEP_ENABLE(M_KEEP_ENABLE),
    .M_KEEP_WIDTH(M_KEEP_WIDTH),
    .ID_ENABLE(ID_ENABLE),
    .ID_WIDTH(ID_WIDTH),
    .DEST_ENABLE(DEST_ENABLE),
    .DEST_WIDTH(DEST_WIDTH),
    .USER_ENABLE(USER_ENABLE),
    .USER_WIDTH(USER_WIDTH),
    .FRAME_FIFO(FRAME_FIFO),
    .USER_BAD_FRAME_VALUE(USER_BAD_FRAME_VALUE),
    .USER_BAD_FRAME_MASK(USER_BAD_FRAME_MASK),
    .DROP_BAD_FRAME(DROP_BAD_FRAME),
    .DROP_WHEN_FULL(DROP_WHEN_FULL)
)
UUT (
    .clk(clk),
    .rst(rst),
    .s_axis_tdata(s_axis_tdata),
    .s_axis_tkeep(s_axis_tkeep),
    .s_axis_tvalid(s_axis_tvalid),
    .s_axis_tready(s_axis_tready),
    .s_axis_tlast(s_axis_tlast),
    .s_axis_tid(s_axis_tid),
    .s_axis_tdest(s_axis_tdest),
    .s_axis_tuser(s_axis_tuser),
    .m_axis_tdata(m_axis_tdata),
    .m_axis_tkeep(m_axis_tkeep),
    .m_axis_tvalid(m_axis_tvalid),
    .m_axis_tready(m_axis_tready),
    .m_axis_tlast(m_axis_tlast),
    .m_axis_tid(m_axis_tid),
    .m_axis_tdest(m_axis_tdest),
    .m_axis_tuser(m_axis_tuser),
    .pause_req(1'b0),
    .pause_ack(),
    .status_depth(),
    .status_depth_commit(),
    .status_overflow(),
    .status_bad_frame(),
    .status_good_frame()
);

initial begin : main
    input_fd = $fopen("tb/input.mem", "r");
    output_fd = $fopen("tb/output.mem", "r");

    if (input_fd == 0 || output_fd == 0) begin
        $display("FAIL could not open input-output pair files");
        $finish;
    end

    scan_count = $fgets(input_header, input_fd);
    scan_count = $fgets(output_header, output_fd);

    for (cycle = 0; cycle < CYCLE_COUNT; cycle = cycle + 1) begin
        scan_count = $fscanf(input_fd, "%b,%b,%b,%b,%b,%b,%b,%b,%b\n",
            rst,
            s_axis_tdata,
            s_axis_tkeep,
            s_axis_tvalid,
            s_axis_tlast,
            s_axis_tid,
            s_axis_tdest,
            s_axis_tuser,
            m_axis_tready);

        if (scan_count != 9) begin
            $display("FAIL failed to read input cycle=%0d count=%0d", cycle, scan_count);
            $finish;
        end

        scan_count = $fscanf(output_fd, "%b,%b,%b,%b,%b,%b,%b,%b\n",
            exp_s_axis_tready,
            exp_m_axis_tdata,
            exp_m_axis_tkeep,
            exp_m_axis_tvalid,
            exp_m_axis_tlast,
            exp_m_axis_tid,
            exp_m_axis_tdest,
            exp_m_axis_tuser);

        if (scan_count != 8) begin
            $display("FAIL failed to read output cycle=%0d count=%0d", cycle, scan_count);
            $finish;
        end

        @(posedge clk);
        #1;

        if (s_axis_tready !== exp_s_axis_tready ||
            m_axis_tdata !== exp_m_axis_tdata ||
            m_axis_tkeep !== exp_m_axis_tkeep ||
            m_axis_tvalid !== exp_m_axis_tvalid ||
            m_axis_tlast !== exp_m_axis_tlast ||
            m_axis_tid !== exp_m_axis_tid ||
            m_axis_tdest !== exp_m_axis_tdest ||
            m_axis_tuser !== exp_m_axis_tuser) begin
            $display("FAIL cycle=%0d", cycle);
            $display("  expected: %b,%b,%b,%b,%b,%b,%b,%b",
                exp_s_axis_tready,
                exp_m_axis_tdata,
                exp_m_axis_tkeep,
                exp_m_axis_tvalid,
                exp_m_axis_tlast,
                exp_m_axis_tid,
                exp_m_axis_tdest,
                exp_m_axis_tuser);
            $display("  actual:   %b,%b,%b,%b,%b,%b,%b,%b",
                s_axis_tready,
                m_axis_tdata,
                m_axis_tkeep,
                m_axis_tvalid,
                m_axis_tlast,
                m_axis_tid,
                m_axis_tdest,
                m_axis_tuser);
            $finish;
        end

        @(negedge clk);
    end

    scan_count = $fscanf(input_fd, "%b,%b,%b,%b,%b,%b,%b,%b,%b\n",
        rst,
        s_axis_tdata,
        s_axis_tkeep,
        s_axis_tvalid,
        s_axis_tlast,
        s_axis_tid,
        s_axis_tdest,
        s_axis_tuser,
        m_axis_tready);
    if (scan_count != -1) begin
        $display("FAIL input has extra data after CYCLE_COUNT=%0d", CYCLE_COUNT);
        $finish;
    end

    scan_count = $fscanf(output_fd, "%b,%b,%b,%b,%b,%b,%b,%b\n",
        exp_s_axis_tready,
        exp_m_axis_tdata,
        exp_m_axis_tkeep,
        exp_m_axis_tvalid,
        exp_m_axis_tlast,
        exp_m_axis_tid,
        exp_m_axis_tdest,
        exp_m_axis_tuser);
    if (scan_count != -1) begin
        $display("FAIL output has extra data after CYCLE_COUNT=%0d", CYCLE_COUNT);
        $finish;
    end

    $fclose(input_fd);
    $fclose(output_fd);

    $display("PASS cycles=%0d", cycle);
    $finish;
end

endmodule
