set CLK_PERIOD 10.000
create_clock -name clock -period $CLK_PERIOD [get_ports clock]
set_input_delay 1.000 -clock clock [all_inputs]
set_output_delay 1.000 -clock clock [all_outputs]
set_drive 0.1 [all_inputs]
set_load 1.0 [all_outputs]
set_false_path -from [get_ports reset]
