set CLK_PERIOD 0.000
create_clock -name i_clk -period $CLK_PERIOD [get_ports i_clk]
set_input_delay 0.000 -clock i_clk [all_inputs]
set_output_delay 0.000 -clock i_clk [all_outputs]
set_drive 0.1 [all_inputs]
set_load 1.0 [all_outputs]
