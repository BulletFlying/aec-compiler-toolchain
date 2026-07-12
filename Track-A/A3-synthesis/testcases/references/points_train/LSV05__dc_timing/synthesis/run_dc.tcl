
set target_library [list /tmp/logic_synth_ref/lib/NangateOpenCellLibrary_typical.db]
set link_library [concat "*" $target_library]
analyze -format sverilog /tmp/logic_synth_ref/runs/LSV05_dc_timing_eb8d098661fb4ea4990ef4bd9e75af38/case/design.v
elaborate axi_dwidth_converter_v2_1_b_downsizer
current_design axi_dwidth_converter_v2_1_b_downsizer
link
check_design > /tmp/logic_synth_ref/runs/LSV05_dc_timing_eb8d098661fb4ea4990ef4bd9e75af38/case/check_design.rpt
source /tmp/logic_synth_ref/runs/LSV05_dc_timing_eb8d098661fb4ea4990ef4bd9e75af38/case/constraints.sdc

if {[catch {compile_ultra -no_autoungroup} err]} {
  puts "compile_ultra failed, falling back to compile: $err"
  compile
}

write -format verilog -hierarchy -output /tmp/logic_synth_ref/runs/LSV05_dc_timing_eb8d098661fb4ea4990ef4bd9e75af38/case/netlist.v
write_sdc /tmp/logic_synth_ref/runs/LSV05_dc_timing_eb8d098661fb4ea4990ef4bd9e75af38/case/final.sdc
report_qor > /tmp/logic_synth_ref/runs/LSV05_dc_timing_eb8d098661fb4ea4990ef4bd9e75af38/case/qor.rpt
report_area -hierarchy > /tmp/logic_synth_ref/runs/LSV05_dc_timing_eb8d098661fb4ea4990ef4bd9e75af38/case/area.rpt
report_timing -delay max -max_paths 20 > /tmp/logic_synth_ref/runs/LSV05_dc_timing_eb8d098661fb4ea4990ef4bd9e75af38/case/timing.rpt
report_constraint -all_violators > /tmp/logic_synth_ref/runs/LSV05_dc_timing_eb8d098661fb4ea4990ef4bd9e75af38/case/constraints.rpt
exit
