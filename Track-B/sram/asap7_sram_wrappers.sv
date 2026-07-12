// SPDX-License-Identifier: BSD-3-Clause
// Optional adapters for the locked ASAP7 SRAM macros used by this competition.
// The native macros and their timing/physical views are not redefined here.

module aec_sram_256x32 (
    input  logic        clk,
    input  logic        en,
    input  logic        read_en,
    input  logic        write_en,
    input  logic [7:0]  addr,
    input  logic [31:0] write_data,
    output logic [31:0] read_data
);
    srambank_64x4x32_6t122 u_sram (
        .clk     (clk),
        .ADDRESS (addr),
        .wd      (write_data),
        .banksel (en),
        .read    (read_en),
        .write   (write_en),
        .dataout (read_data)
    );
endmodule

module aec_sram_512x32 (
    input  logic        clk,
    input  logic        en,
    input  logic        read_en,
    input  logic        write_en,
    input  logic [8:0]  addr,
    input  logic [31:0] write_data,
    output logic [31:0] read_data
);
    srambank_128x4x32_6t122 u_sram (
        .clk     (clk),
        .ADDRESS (addr),
        .wd      (write_data),
        .banksel (en),
        .read    (read_en),
        .write   (write_en),
        .dataout (read_data)
    );
endmodule

module aec_sram_1024x32 (
    input  logic         clk,
    input  logic         en,
    input  logic         read_en,
    input  logic         write_en,
    input  logic [9:0]   addr,
    input  logic [31:0]  write_data,
    output logic [31:0]  read_data
);
    srambank_256x4x32_6t122 u_sram (
        .clk     (clk),
        .ADDRESS (addr),
        .wd      (write_data),
        .banksel (en),
        .read    (read_en),
        .write   (write_en),
        .dataout (read_data)
    );
endmodule

module aec_sram_256x64 (
    input  logic        clk,
    input  logic        en,
    input  logic        read_en,
    input  logic        write_en,
    input  logic [7:0]  addr,
    input  logic [63:0] write_data,
    output logic [63:0] read_data
);
    srambank_64x4x64_6t122 u_sram (
        .clk     (clk),
        .ADDRESS (addr),
        .wd      (write_data),
        .banksel (en),
        .read    (read_en),
        .write   (write_en),
        .dataout (read_data)
    );
endmodule
