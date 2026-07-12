module tb2;

reg clk = 1'b0;
reg rstn = 1'b0;
reg cs = 1'b0;
reg we = 1'b0;
reg [7:0] adr = 8'h00;
reg [31:0] din = 32'h00000000;

wire [31:0] dout;
wire err;

reg [4095:0] in_head = 0;
reg [4095:0] out_head = 0;

reg gold_rstn = 1'b0;
reg gold_cs = 1'b0;
reg gold_we = 1'b0;
reg [7:0] gold_adr = 8'h00;
reg [31:0] gold_din = 32'h00000000;

reg [31:0] gold_dout = 32'h00000000;
reg gold_err = 1'b0;

integer in_fd;
integer out_fd;
integer scan_count;
integer cycle;
reg done_reading;

always #5 clk = ~clk;

sha256 dut(
    .clk(clk),
    .reset_n(rstn),
    .cs(cs),
    .we(we),
    .address(adr),
    .write_data(din),
    .read_data(dout),
    .error(err)
);

initial begin
    in_fd = $fopen("tb/input.mem", "r");
    out_fd = $fopen("tb/output.mem", "w");
    if (in_fd == 0 || out_fd == 0) begin
        $display("FAIL could not open pair files");
        $finish;
    end

    scan_count = $fgets(in_head, in_fd);
    $fdisplay(out_fd, "dout[31:0],err");

    cycle = 0;
    done_reading = 0;
    while (!done_reading) begin
        scan_count = $fscanf(in_fd, "%b,%b,%b,%b,%b\n",
            gold_rstn, gold_cs, gold_we, gold_adr, gold_din);

        if (scan_count == -1 || scan_count == 0) begin
            done_reading = 1;
        end else if (scan_count != 5) begin
            $display("FAIL read input cycle=%0d count=%0d", cycle, scan_count);
            $finish;
        end else begin

            rstn = gold_rstn;
            cs = gold_cs;
            we = gold_we;
            adr = gold_adr;
            din = gold_din;

            @(posedge clk);
            #1;

            $fdisplay(out_fd, "%b,%b",
                dout,
                err);

            cycle = cycle + 1;
        end
    end

    $fclose(in_fd);
    $fclose(out_fd);
    $display("PASS cycles=%0d", cycle);
    $finish;
end

endmodule
