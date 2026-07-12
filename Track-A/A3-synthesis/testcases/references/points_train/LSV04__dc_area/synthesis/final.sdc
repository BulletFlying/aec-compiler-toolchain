###################################################################

# Created by write_sdc on Sun Jul  5 15:01:26 2026

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_max_area 0
set_load -pin_load 1 [get_ports {x_out[5]}]
set_load -pin_load 1 [get_ports {x_out[4]}]
set_load -pin_load 1 [get_ports {x_out[3]}]
set_load -pin_load 1 [get_ports {x_out[2]}]
set_load -pin_load 1 [get_ports {x_out[1]}]
set_load -pin_load 1 [get_ports {x_out[0]}]
create_clock [get_ports clock]  -period 100  -waveform {0 50}
set_false_path   -from [get_ports reset]
set_input_delay -clock clock  1  [get_ports clock]
set_input_delay -clock clock  1  [get_ports reset]
set_input_delay -clock clock  1  [get_ports {x_in[5]}]
set_input_delay -clock clock  1  [get_ports {x_in[4]}]
set_input_delay -clock clock  1  [get_ports {x_in[3]}]
set_input_delay -clock clock  1  [get_ports {x_in[2]}]
set_input_delay -clock clock  1  [get_ports {x_in[1]}]
set_input_delay -clock clock  1  [get_ports {x_in[0]}]
set_input_delay -clock clock  1  [get_ports stbi]
set_output_delay -clock clock  1  [get_ports {x_out[5]}]
set_output_delay -clock clock  1  [get_ports {x_out[4]}]
set_output_delay -clock clock  1  [get_ports {x_out[3]}]
set_output_delay -clock clock  1  [get_ports {x_out[2]}]
set_output_delay -clock clock  1  [get_ports {x_out[1]}]
set_output_delay -clock clock  1  [get_ports {x_out[0]}]
set_drive 0.1  [get_ports {x_in[5]}]
set_drive 0.1  [get_ports {x_in[4]}]
set_drive 0.1  [get_ports {x_in[3]}]
set_drive 0.1  [get_ports {x_in[2]}]
set_drive 0.1  [get_ports {x_in[1]}]
set_drive 0.1  [get_ports {x_in[0]}]
set_drive 0.1  [get_ports stbi]
set_drive 0.1  [get_ports clock]
set_drive 0.1  [get_ports reset]
