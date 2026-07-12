`timescale 1ns / 1ps

module tb2;

parameter CYCLES = 1056;
parameter IN_WIDTH = 32;
parameter OUT_WIDTH = 38;
parameter WIDTH = 32;
parameter LSB_HIGH_PRIORITY = 0;

reg clk = 1'b0;

reg [1023:0] input_header = 0;
reg [1023:0] output_header = 0;

reg [IN_WIDTH-1:0] in_word = 0;
reg [OUT_WIDTH-1:0] out_word = 0;
reg [OUT_WIDTH-1:0] exp_word = 0;
reg [OUT_WIDTH-1:0] diff = 0;

reg [WIDTH-1:0] input_unencoded = 0;

wire output_valid;
wire [4:0] output_encoded;
wire [WIDTH-1:0] output_unencoded;

reg exp_output_valid = 0;
reg [4:0] exp_output_encoded = 0;
reg [WIDTH-1:0] exp_output_unencoded = 0;

integer cycle;
integer input_fd;
integer output_fd;
integer scan_count;

always #5 clk = ~clk;

priority_encoder #(
    .WIDTH(WIDTH),
    .LSB_HIGH_PRIORITY(LSB_HIGH_PRIORITY)
)
UUT (
    .input_unencoded(input_unencoded),
    .output_valid(output_valid),
    .output_encoded(output_encoded),
    .output_unencoded(output_unencoded)
);

initial begin
    input_fd = $fopen("tb/input.mem", "r");
    output_fd = $fopen("tb/output.mem", "w");

    if (input_fd == 0 || output_fd == 0) begin
        $display("FAIL could not open input-output pair files");
        $finish;
    end

    scan_count = $fgets(input_header, input_fd);
    $fdisplay(output_fd, "output_valid,output_encoded[4:0],output_unencoded[31:0]");

    input_unencoded = 0;

    for (cycle = 0; cycle < CYCLES; cycle = cycle + 1) begin
        scan_count = $fscanf(input_fd, "%b\n", in_word);
        if (scan_count != 1) begin
            $display("FAIL failed to read input cycle=%0d", cycle);
            $finish;
        end


        input_unencoded = in_word[WIDTH-1:0];

        @(posedge clk);
        #1;

        out_word = {output_valid, output_encoded, output_unencoded};
        exp_word = {exp_output_valid, exp_output_encoded, exp_output_unencoded};
        diff = out_word ^ exp_word;

        $fdisplay(output_fd, "%b,%b,%b",
            output_valid,
            output_encoded,
            output_unencoded);

        @(negedge clk);
    end

    $fclose(input_fd);
    $fclose(output_fd);

    $display("PASS");
    $finish;
end

endmodule
