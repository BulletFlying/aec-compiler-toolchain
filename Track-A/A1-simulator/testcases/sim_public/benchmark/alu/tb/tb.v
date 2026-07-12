module tb2;
  localparam CYCLE_COUNT = 40;

  reg [31:0] a;
  reg [31:0] b;
  reg [5:0] opCode;
  wire [31:0] ans1;
  wire ans2;
  wire Z;
  wire N;

  reg [31:0] in_a;
  reg [31:0] in_b;
  reg [5:0] in_opCode;
  reg [31:0] want_ans1;
  reg want_ans2;
  reg want_Z;
  reg want_N;
  reg [1023:0] in_head;
  reg [1023:0] out_head;

  integer in_fd;
  integer out_fd;
  integer scan_count;
  integer cycle;

  ALU dut(
    .a(a),
    .b(b),
    .opCode(opCode),
    .ans1(ans1),
    .ans2(ans2),
    .Z(Z),
    .N(N)
  );

  initial begin
    a = 32'h00000000;
    b = 32'h00000000;
    opCode = 6'h00;

    in_fd = $fopen("tb/input.mem", "r");
    out_fd = $fopen("tb/output.mem", "w");
    if (in_fd == 0 || out_fd == 0) begin
      $display("FAIL cannot open pair files");
      $finish;
    end

    scan_count = $fgets(in_head, in_fd);
    $fdisplay(out_fd, "ans1[31:0],ans2,Z,N");

    for (cycle = 0; cycle < CYCLE_COUNT; cycle = cycle + 1) begin
      scan_count = $fscanf(in_fd, "%h,%h,%h\n", in_a, in_b, in_opCode);
      if (scan_count != 3) begin
        $display("FAIL read input row cycle=%0d count=%0d", cycle, scan_count);
        $finish;
      end
      a = in_a;
      b = in_b;
      opCode = in_opCode;
      #1;

      $fdisplay(out_fd, "%h,%h,%h,%h",
          ans1,
          ans2,
          Z,
          N);
    end

    $display("PASS cycles=%0d", CYCLE_COUNT);
    $finish;
  end
endmodule
