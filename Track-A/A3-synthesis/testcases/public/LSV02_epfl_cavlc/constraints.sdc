set CLK_PERIOD 10.000
create_clock -name virtual_clk -period $CLK_PERIOD
set_input_delay 1.000 -clock virtual_clk [all_inputs]
set_output_delay 1.000 -clock virtual_clk [all_outputs]
set_max_delay $CLK_PERIOD -from [all_inputs] -to [all_outputs]
set_drive 0.1 [all_inputs]
set_load 1.0 [all_outputs]
