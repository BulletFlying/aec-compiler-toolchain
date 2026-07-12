module tb2;
  localparam CYCLE_COUNT = 16;

  reg [3:0] addr;
  reg [7:0] din;
  reg use_din;
  wire [8:0] y;

  reg [3:0] in_addr;
  reg [7:0] in_din;
  reg in_use_din;
  reg [8:0] want_y;
  reg [1023:0] in_head;
  reg [1023:0] out_head;

  integer in_fd;
  integer out_fd;
  integer scan_count;
  integer cycle;

  top dut(.addr(addr), .din(din), .use_din(use_din), .y(y));

  initial begin
    addr = 4'd0;
    din = 8'd0;
    use_din = 1'b0;
    #1;

    in_fd = $fopen("tb/input.mem", "r");
    out_fd = $fopen("tb/output.mem", "w");
    if (in_fd == 0 || out_fd == 0) begin
      $display("FAIL cannot open pair files");
      $finish;
    end

    scan_count = $fgets(in_head, in_fd);
    $fdisplay(out_fd, "y[8:0]");

    for (cycle = 0; cycle < CYCLE_COUNT; cycle = cycle + 1) begin
      scan_count = $fscanf(in_fd, "%h,%h,%h\n", in_addr, in_din, in_use_din);
      if (scan_count != 3) begin
        $display("FAIL read input row cycle=%0d count=%0d", cycle, scan_count);
        $finish;
      end
      addr = in_addr;
      din = in_din;
      use_din = in_use_din;
      #1;

      $fdisplay(out_fd, "%h", y);
    end

    $display("PASS cycles=%0d", CYCLE_COUNT);
    $finish;
  end
endmodule
