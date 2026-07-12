set CLK_PERIOD 0.000
create_clock -name clk -period $CLK_PERIOD [get_ports clk]
set_input_delay 0.000 -clock clk [all_inputs]
set_output_delay 0.000 -clock clk [all_outputs]
set_drive 0.1 [all_inputs]
set_load 1.0 [all_outputs]
set_false_path -from [get_ports reset]
