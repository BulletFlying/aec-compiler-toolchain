module tb2;
  localparam CYCLE_COUNT = 20;

  reg [1:0] op;
  reg [15:0] a;
  reg [15:0] b;
  reg [15:0] c;
  wire [17:0] y;
  wire hit;

  reg [1:0] in_op;
  reg [15:0] in_a;
  reg [15:0] in_b;
  reg [15:0] in_c;
  reg [17:0] want_y;
  reg want_hit;
  reg [1023:0] in_head;
  reg [1023:0] out_head;

  integer in_fd;
  integer out_fd;
  integer scan_count;
  integer cycle;

  top dut(.op(op), .a(a), .b(b), .c(c), .y(y), .hit(hit));

  initial begin
    in_fd = $fopen("tb/input.mem", "r");
    out_fd = $fopen("tb/output.mem", "w");
    if (in_fd == 0 || out_fd == 0) begin
      $display("FAIL cannot open pair files");
      $finish;
    end

    scan_count = $fgets(in_head, in_fd);
    $fdisplay(out_fd, "y[17:0],hit");

    for (cycle = 0; cycle < CYCLE_COUNT; cycle = cycle + 1) begin
      scan_count = $fscanf(in_fd, "%h,%h,%h,%h\n", in_op, in_a, in_b, in_c);
      if (scan_count != 4) begin
        $display("FAIL read input row cycle=%0d count=%0d", cycle, scan_count);
        $finish;
      end
      op = in_op;
      a = in_a;
      b = in_b;
      c = in_c;
      #1;

      $fdisplay(out_fd, "%h,%h",
          y,
          hit);
    end

    $display("PASS cycles=%0d", CYCLE_COUNT);
    $finish;
  end
endmodule
