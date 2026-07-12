`timescale 1ns / 1ps

module tb2;

reg clk = 1'b0;
reg rst = 1'b1;
reg arst = 1'b0;
reg [2:0] adr = 3'b000;
reg [7:0] din = 8'h00;
reg we = 1'b0;
reg stb = 1'b0;
reg cyc = 1'b0;
reg scl_i = 1'b1;
reg sda_i = 1'b1;

wire [7:0] dout;
wire ack;
wire irq;
wire scl_o;
wire scl_oe;
wire sda_o;
wire sda_oe;

reg [4095:0] in_head = 0;
reg [4095:0] out_head = 0;

reg gold_rst = 1'b1;
reg gold_arst = 1'b0;
reg [2:0] gold_adr = 3'b000;
reg [7:0] gold_din = 8'h00;
reg gold_we = 1'b0;
reg gold_stb = 1'b0;
reg gold_cyc = 1'b0;
reg gold_scl_i = 1'b1;
reg gold_sda_i = 1'b1;

reg [7:0] gold_dout = 8'h00;
reg gold_ack = 1'b0;
reg gold_irq = 1'b0;
reg gold_scl_o = 1'b0;
reg gold_scl_oe = 1'b0;
reg gold_sda_o = 1'b0;
reg gold_sda_oe = 1'b0;

integer in_fd;
integer out_fd;
integer scan_count;
integer cycle;
reg done_reading;

always #5 clk = ~clk;

i2c_master_top dut(
    .wb_clk_i(clk),
    .wb_rst_i(rst),
    .arst_i(arst),
    .wb_adr_i(adr),
    .wb_dat_i(din),
    .wb_dat_o(dout),
    .wb_we_i(we),
    .wb_stb_i(stb),
    .wb_cyc_i(cyc),
    .wb_ack_o(ack),
    .wb_inta_o(irq),
    .scl_pad_i(scl_i),
    .scl_pad_o(scl_o),
    .scl_padoen_o(scl_oe),
    .sda_pad_i(sda_i),
    .sda_pad_o(sda_o),
    .sda_padoen_o(sda_oe)
);

initial begin
    in_fd = $fopen("tb/input.mem", "r");
    out_fd = $fopen("tb/output.mem", "w");
    if (in_fd == 0 || out_fd == 0) begin
        $display("FAIL could not open input-output pair files");
        $finish;
    end

    scan_count = $fgets(in_head, in_fd);
    $fdisplay(out_fd, "dout[7:0],ack,irq,scl_o,scl_oe,sda_o,sda_oe");

    rst = 1'b1;
    arst = 1'b0;
    adr = 3'b000;
    din = 8'h00;
    we = 1'b0;
    stb = 1'b0;
    cyc = 1'b0;
    scl_i = 1'b1;
    sda_i = 1'b1;
    repeat (4) begin
        scl_i = scl_oe;
        sda_i = sda_oe;
        @(posedge clk);
        #1;
        scl_i = scl_oe;
        sda_i = sda_oe;
    end
    arst = 1'b1;
    rst = 1'b0;
    repeat (4) begin
        scl_i = scl_oe;
        sda_i = sda_oe;
        @(posedge clk);
        #1;
        scl_i = scl_oe;
        sda_i = sda_oe;
    end

    cycle = 0;
    done_reading = 1'b0;
    while (!done_reading) begin
        scan_count = $fscanf(in_fd, "%b,%b,%b,%b,%b,%b,%b,%b,%b\n",
            gold_rst, gold_arst, gold_adr, gold_din, gold_we,
            gold_stb, gold_cyc, gold_scl_i, gold_sda_i);

        if (scan_count == -1 || scan_count == 0) begin
            done_reading = 1'b1;
        end else if (scan_count != 9) begin
            $display("FAIL read input cycle=%0d count=%0d", cycle, scan_count);
            $finish;
        end else begin

            rst = gold_rst;
            arst = gold_arst;
            adr = gold_adr;
            din = gold_din;
            we = gold_we;
            stb = gold_stb;
            cyc = gold_cyc;
            scl_i = gold_scl_i;
            sda_i = gold_sda_i;

            @(posedge clk);
            #1;

            $fdisplay(out_fd, "%b,%b,%b,%b,%b,%b,%b",
                dout,
                ack,
                irq,
                scl_o,
                scl_oe,
                sda_o,
                sda_oe);

            cycle = cycle + 1;
        end
    end

    $fclose(in_fd);
    $fclose(out_fd);
    $display("PASS cycles=%0d", cycle);
    $finish;
end

endmodule
