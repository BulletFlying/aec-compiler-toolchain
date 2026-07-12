
set target_library [list /tmp/logic_synth_ref/lib/NangateOpenCellLibrary_typical.db]
set link_library [concat "*" $target_library]
analyze -format sverilog /tmp/logic_synth_ref/runs/LSV08_dc_timing_e5fd609b580b47fbbdf5f83f31ace395/case/design.v
elaborate stage_mult
current_design stage_mult
link
check_design > /tmp/logic_synth_ref/runs/LSV08_dc_timing_e5fd609b580b47fbbdf5f83f31ace395/case/check_design.rpt
source /tmp/logic_synth_ref/runs/LSV08_dc_timing_e5fd609b580b47fbbdf5f83f31ace395/case/constraints.sdc

if {[catch {compile_ultra -no_autoungroup} err]} {
  puts "compile_ultra failed, falling back to compile: $err"
  compile
}

write -format verilog -hierarchy -output /tmp/logic_synth_ref/runs/LSV08_dc_timing_e5fd609b580b47fbbdf5f83f31ace395/case/netlist.v
write_sdc /tmp/logic_synth_ref/runs/LSV08_dc_timing_e5fd609b580b47fbbdf5f83f31ace395/case/final.sdc
report_qor > /tmp/logic_synth_ref/runs/LSV08_dc_timing_e5fd609b580b47fbbdf5f83f31ace395/case/qor.rpt
report_area -hierarchy > /tmp/logic_synth_ref/runs/LSV08_dc_timing_e5fd609b580b47fbbdf5f83f31ace395/case/area.rpt
report_timing -delay max -max_paths 20 > /tmp/logic_synth_ref/runs/LSV08_dc_timing_e5fd609b580b47fbbdf5f83f31ace395/case/timing.rpt
report_constraint -all_violators > /tmp/logic_synth_ref/runs/LSV08_dc_timing_e5fd609b580b47fbbdf5f83f31ace395/case/constraints.rpt
exit
