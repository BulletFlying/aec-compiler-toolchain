###################################################################

# Created by write_sdc on Sun Jul  5 15:01:13 2026

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_max_area 0
set_load -pin_load 1 [get_ports {coeff_token[0]}]
set_load -pin_load 1 [get_ports {coeff_token[1]}]
set_load -pin_load 1 [get_ports {coeff_token[2]}]
set_load -pin_load 1 [get_ports {coeff_token[3]}]
set_load -pin_load 1 [get_ports {coeff_token[4]}]
set_load -pin_load 1 [get_ports {coeff_token[5]}]
set_load -pin_load 1 [get_ports {ctoken_len[0]}]
set_load -pin_load 1 [get_ports {ctoken_len[1]}]
set_load -pin_load 1 [get_ports {ctoken_len[2]}]
set_load -pin_load 1 [get_ports {ctoken_len[3]}]
set_load -pin_load 1 [get_ports {ctoken_len[4]}]
create_clock -name virtual_clk  -period 100  -waveform {0 50}
set_max_delay 100  -from [list [get_ports {totalcoeffs[0]}] [get_ports {totalcoeffs[1]}]         \
[get_ports {totalcoeffs[2]}] [get_ports {totalcoeffs[3]}] [get_ports           \
{totalcoeffs[4]}] [get_ports {ctable[0]}] [get_ports {ctable[1]}] [get_ports   \
{ctable[2]}] [get_ports {trailingones[0]}] [get_ports {trailingones[1]}]]  -to [list [get_ports {coeff_token[0]}] [get_ports {coeff_token[1]}]           \
[get_ports {coeff_token[2]}] [get_ports {coeff_token[3]}] [get_ports           \
{coeff_token[4]}] [get_ports {coeff_token[5]}] [get_ports {ctoken_len[0]}]     \
[get_ports {ctoken_len[1]}] [get_ports {ctoken_len[2]}] [get_ports             \
{ctoken_len[3]}] [get_ports {ctoken_len[4]}]]
set_input_delay -clock virtual_clk  1  [get_ports {totalcoeffs[0]}]
set_input_delay -clock virtual_clk  1  [get_ports {totalcoeffs[1]}]
set_input_delay -clock virtual_clk  1  [get_ports {totalcoeffs[2]}]
set_input_delay -clock virtual_clk  1  [get_ports {totalcoeffs[3]}]
set_input_delay -clock virtual_clk  1  [get_ports {totalcoeffs[4]}]
set_input_delay -clock virtual_clk  1  [get_ports {ctable[0]}]
set_input_delay -clock virtual_clk  1  [get_ports {ctable[1]}]
set_input_delay -clock virtual_clk  1  [get_ports {ctable[2]}]
set_input_delay -clock virtual_clk  1  [get_ports {trailingones[0]}]
set_input_delay -clock virtual_clk  1  [get_ports {trailingones[1]}]
set_output_delay -clock virtual_clk  1  [get_ports {coeff_token[0]}]
set_output_delay -clock virtual_clk  1  [get_ports {coeff_token[1]}]
set_output_delay -clock virtual_clk  1  [get_ports {coeff_token[2]}]
set_output_delay -clock virtual_clk  1  [get_ports {coeff_token[3]}]
set_output_delay -clock virtual_clk  1  [get_ports {coeff_token[4]}]
set_output_delay -clock virtual_clk  1  [get_ports {coeff_token[5]}]
set_output_delay -clock virtual_clk  1  [get_ports {ctoken_len[0]}]
set_output_delay -clock virtual_clk  1  [get_ports {ctoken_len[1]}]
set_output_delay -clock virtual_clk  1  [get_ports {ctoken_len[2]}]
set_output_delay -clock virtual_clk  1  [get_ports {ctoken_len[3]}]
set_output_delay -clock virtual_clk  1  [get_ports {ctoken_len[4]}]
set_drive 0.1  [get_ports {totalcoeffs[0]}]
set_drive 0.1  [get_ports {totalcoeffs[1]}]
set_drive 0.1  [get_ports {totalcoeffs[2]}]
set_drive 0.1  [get_ports {totalcoeffs[3]}]
set_drive 0.1  [get_ports {totalcoeffs[4]}]
set_drive 0.1  [get_ports {ctable[0]}]
set_drive 0.1  [get_ports {ctable[1]}]
set_drive 0.1  [get_ports {ctable[2]}]
set_drive 0.1  [get_ports {trailingones[0]}]
set_drive 0.1  [get_ports {trailingones[1]}]
