
set target_library [list /tmp/logic_synth_ref/lib/NangateOpenCellLibrary_typical.db]
set link_library [concat "*" $target_library]
analyze -format sverilog /tmp/logic_synth_ref/runs/LSV09_dc_timing_a2ae0294d455408c8a96b6be562eac28/case/design.v
elaborate Sha256Wishbone
current_design Sha256Wishbone
link
check_design > /tmp/logic_synth_ref/runs/LSV09_dc_timing_a2ae0294d455408c8a96b6be562eac28/case/check_design.rpt
source /tmp/logic_synth_ref/runs/LSV09_dc_timing_a2ae0294d455408c8a96b6be562eac28/case/constraints.sdc

if {[catch {compile_ultra -no_autoungroup} err]} {
  puts "compile_ultra failed, falling back to compile: $err"
  compile
}

write -format verilog -hierarchy -output /tmp/logic_synth_ref/runs/LSV09_dc_timing_a2ae0294d455408c8a96b6be562eac28/case/netlist.v
write_sdc /tmp/logic_synth_ref/runs/LSV09_dc_timing_a2ae0294d455408c8a96b6be562eac28/case/final.sdc
report_qor > /tmp/logic_synth_ref/runs/LSV09_dc_timing_a2ae0294d455408c8a96b6be562eac28/case/qor.rpt
report_area -hierarchy > /tmp/logic_synth_ref/runs/LSV09_dc_timing_a2ae0294d455408c8a96b6be562eac28/case/area.rpt
report_timing -delay max -max_paths 20 > /tmp/logic_synth_ref/runs/LSV09_dc_timing_a2ae0294d455408c8a96b6be562eac28/case/timing.rpt
report_constraint -all_violators > /tmp/logic_synth_ref/runs/LSV09_dc_timing_a2ae0294d455408c8a96b6be562eac28/case/constraints.rpt
exit
