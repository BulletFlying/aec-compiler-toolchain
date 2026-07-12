module tb2;
  localparam CYCLE_COUNT = 32;

  reg clk = 1'b0;
  reg rst;
  reg en;
  reg [7:0] a;
  reg [7:0] b;
  reg [1:0] mode;
  wire [7:0] q;
  wire [7:0] y;
  wire parity;

  reg in_rst;
  reg in_en;
  reg [7:0] in_a;
  reg [7:0] in_b;
  reg [1:0] in_mode;
  reg [7:0] want_q;
  reg [7:0] want_y;
  reg want_parity;
  reg [1023:0] in_head;
  reg [1023:0] out_head;

  integer in_fd;
  integer out_fd;
  integer scan_count;
  integer cycle;

  always #5 clk = ~clk;

  top dut(
    .clk(clk),
    .rst(rst),
    .en(en),
    .a(a),
    .b(b),
    .mode(mode),
    .q(q),
    .y(y),
    .parity(parity)
  );

  initial begin
    rst = 1'b1;
    en = 1'b0;
    a = 8'h00;
    b = 8'h00;
    mode = 2'h0;

    in_fd = $fopen("tb/input.mem", "r");
    out_fd = $fopen("tb/output.mem", "w");
    if (in_fd == 0 || out_fd == 0) begin
      $display("FAIL cannot open pair files");
      $finish;
    end

    scan_count = $fgets(in_head, in_fd);
    $fdisplay(out_fd, "q[7:0],y[7:0],parity");

    for (cycle = 0; cycle < CYCLE_COUNT; cycle = cycle + 1) begin
      scan_count = $fscanf(in_fd, "%h,%h,%h,%h,%h\n", in_rst, in_en, in_a, in_b, in_mode);
      if (scan_count != 5) begin
        $display("FAIL read input row cycle=%0d count=%0d", cycle, scan_count);
        $finish;
      end
      rst = in_rst;
      en = in_en;
      a = in_a;
      b = in_b;
      mode = in_mode;
      @(posedge clk);
      #1;

      $fdisplay(out_fd, "%h,%h,%h",
          q,
          y,
          parity);
    end

    $display("PASS cycles=%0d", CYCLE_COUNT);
    $finish;
  end
endmodule
