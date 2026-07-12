module tb2;
  localparam CYCLE_COUNT = 16;

  reg [15:0] a;
  reg [15:0] b;
  reg sel;
  wire [31:0] y;
  wire cmp;
  wire red;

  reg [15:0] in_a;
  reg [15:0] in_b;
  reg in_sel;
  reg [31:0] want_y;
  reg want_cmp;
  reg want_red;
  reg [1023:0] in_head;
  reg [1023:0] out_head;

  integer in_fd;
  integer out_fd;
  integer scan_count;
  integer cycle;

  top dut(.a(a), .b(b), .sel(sel), .y(y), .cmp(cmp), .red(red));

  initial begin
    in_fd = $fopen("tb/input.mem", "r");
    out_fd = $fopen("tb/output.mem", "w");
    if (in_fd == 0 || out_fd == 0) begin
      $display("FAIL cannot open pair files");
      $finish;
    end

    scan_count = $fgets(in_head, in_fd);
    $fdisplay(out_fd, "y[31:0],cmp,red");

    for (cycle = 0; cycle < CYCLE_COUNT; cycle = cycle + 1) begin
      scan_count = $fscanf(in_fd, "%h,%h,%h\n", in_a, in_b, in_sel);
      if (scan_count != 3) begin
        $display("FAIL read input row cycle=%0d count=%0d", cycle, scan_count);
        $finish;
      end
      a = in_a;
      b = in_b;
      sel = in_sel;
      #1;

      $fdisplay(out_fd, "%h,%h,%h",
          y,
          cmp,
          red);
    end

    $display("PASS cycles=%0d", CYCLE_COUNT);
    $finish;
  end
endmodule
