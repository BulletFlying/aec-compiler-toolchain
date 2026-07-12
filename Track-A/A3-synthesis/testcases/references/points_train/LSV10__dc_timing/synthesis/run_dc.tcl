
set target_library [list /tmp/logic_synth_ref/lib/NangateOpenCellLibrary_typical.db]
set link_library [concat "*" $target_library]
analyze -format sverilog /tmp/logic_synth_ref/runs/LSV10_dc_timing_8e2d038b9f784d5cabf34199a4231f46/case/design.v
elaborate VexRiscv_small
current_design VexRiscv_small
link
check_design > /tmp/logic_synth_ref/runs/LSV10_dc_timing_8e2d038b9f784d5cabf34199a4231f46/case/check_design.rpt
source /tmp/logic_synth_ref/runs/LSV10_dc_timing_8e2d038b9f784d5cabf34199a4231f46/case/constraints.sdc

if {[catch {compile_ultra -no_autoungroup} err]} {
  puts "compile_ultra failed, falling back to compile: $err"
  compile
}

write -format verilog -hierarchy -output /tmp/logic_synth_ref/runs/LSV10_dc_timing_8e2d038b9f784d5cabf34199a4231f46/case/netlist.v
write_sdc /tmp/logic_synth_ref/runs/LSV10_dc_timing_8e2d038b9f784d5cabf34199a4231f46/case/final.sdc
report_qor > /tmp/logic_synth_ref/runs/LSV10_dc_timing_8e2d038b9f784d5cabf34199a4231f46/case/qor.rpt
report_area -hierarchy > /tmp/logic_synth_ref/runs/LSV10_dc_timing_8e2d038b9f784d5cabf34199a4231f46/case/area.rpt
report_timing -delay max -max_paths 20 > /tmp/logic_synth_ref/runs/LSV10_dc_timing_8e2d038b9f784d5cabf34199a4231f46/case/timing.rpt
report_constraint -all_violators > /tmp/logic_synth_ref/runs/LSV10_dc_timing_8e2d038b9f784d5cabf34199a4231f46/case/constraints.rpt
exit
