module tb2;
  localparam CYCLE_COUNT = 24;

  reg clk = 1'b0;
  reg rst;
  reg en;
  reg [1:0] op;
  reg [3:0] addr;
  reg [7:0] din;
  wire [7:0] q;
  wire [8:0] y;
  wire active;

  reg in_rst;
  reg in_en;
  reg [1:0] in_op;
  reg [3:0] in_addr;
  reg [7:0] in_din;
  reg [7:0] want_q;
  reg [8:0] want_y;
  reg want_active;
  reg [1023:0] in_head;
  reg [1023:0] out_head;

  integer in_fd;
  integer out_fd;
  integer scan_count;
  integer cycle;

  always #5 clk = ~clk;

  top dut(.clk(clk), .rst(rst), .en(en), .op(op), .addr(addr), .din(din), .q(q), .y(y), .active(active));

  initial begin
    rst = 1'b1;
    en = 1'b0;
    op = 2'd0;
    addr = 4'd0;
    din = 8'd0;
    #1;

    in_fd = $fopen("tb/input.mem", "r");
    out_fd = $fopen("tb/output.mem", "w");
    if (in_fd == 0 || out_fd == 0) begin
      $display("FAIL cannot open pair files");
      $finish;
    end

    scan_count = $fgets(in_head, in_fd);
    $fdisplay(out_fd, "q[7:0],y[8:0],active");

    for (cycle = 0; cycle < CYCLE_COUNT; cycle = cycle + 1) begin
      scan_count = $fscanf(in_fd, "%h,%h,%h,%h,%h\n", in_rst, in_en, in_op, in_addr, in_din);
      if (scan_count != 5) begin
        $display("FAIL read input row cycle=%0d count=%0d", cycle, scan_count);
        $finish;
      end
      rst = in_rst;
      en = in_en;
      op = in_op;
      addr = in_addr;
      din = in_din;
      @(posedge clk);
      #1;

      $fdisplay(out_fd, "%h,%h,%h",
          q,
          y,
          active);
    end

    $display("PASS cycles=%0d", CYCLE_COUNT);
    $finish;
  end
endmodule
