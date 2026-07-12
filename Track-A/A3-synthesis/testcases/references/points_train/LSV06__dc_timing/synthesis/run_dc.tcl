
set target_library [list /tmp/logic_synth_ref/lib/NangateOpenCellLibrary_typical.db]
set link_library [concat "*" $target_library]
analyze -format sverilog /tmp/logic_synth_ref/runs/LSV06_dc_timing_72c3879fa0fc4664b6cd77293e51d642/case/design.v
elaborate pfpu_f2i
current_design pfpu_f2i
link
check_design > /tmp/logic_synth_ref/runs/LSV06_dc_timing_72c3879fa0fc4664b6cd77293e51d642/case/check_design.rpt
source /tmp/logic_synth_ref/runs/LSV06_dc_timing_72c3879fa0fc4664b6cd77293e51d642/case/constraints.sdc

if {[catch {compile_ultra -no_autoungroup} err]} {
  puts "compile_ultra failed, falling back to compile: $err"
  compile
}

write -format verilog -hierarchy -output /tmp/logic_synth_ref/runs/LSV06_dc_timing_72c3879fa0fc4664b6cd77293e51d642/case/netlist.v
write_sdc /tmp/logic_synth_ref/runs/LSV06_dc_timing_72c3879fa0fc4664b6cd77293e51d642/case/final.sdc
report_qor > /tmp/logic_synth_ref/runs/LSV06_dc_timing_72c3879fa0fc4664b6cd77293e51d642/case/qor.rpt
report_area -hierarchy > /tmp/logic_synth_ref/runs/LSV06_dc_timing_72c3879fa0fc4664b6cd77293e51d642/case/area.rpt
report_timing -delay max -max_paths 20 > /tmp/logic_synth_ref/runs/LSV06_dc_timing_72c3879fa0fc4664b6cd77293e51d642/case/timing.rpt
report_constraint -all_violators > /tmp/logic_synth_ref/runs/LSV06_dc_timing_72c3879fa0fc4664b6cd77293e51d642/case/constraints.rpt
exit
