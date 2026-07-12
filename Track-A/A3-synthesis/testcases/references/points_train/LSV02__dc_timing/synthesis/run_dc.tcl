
set target_library [list /tmp/logic_synth_ref/lib/NangateOpenCellLibrary_typical.db]
set link_library [concat "*" $target_library]
analyze -format sverilog /tmp/logic_synth_ref/runs/LSV02_dc_timing_1513faf012f34557a6f8148884c24bde/case/design.v
elaborate top
current_design top
link
check_design > /tmp/logic_synth_ref/runs/LSV02_dc_timing_1513faf012f34557a6f8148884c24bde/case/check_design.rpt
source /tmp/logic_synth_ref/runs/LSV02_dc_timing_1513faf012f34557a6f8148884c24bde/case/constraints.sdc

if {[catch {compile_ultra -no_autoungroup} err]} {
  puts "compile_ultra failed, falling back to compile: $err"
  compile
}

write -format verilog -hierarchy -output /tmp/logic_synth_ref/runs/LSV02_dc_timing_1513faf012f34557a6f8148884c24bde/case/netlist.v
write_sdc /tmp/logic_synth_ref/runs/LSV02_dc_timing_1513faf012f34557a6f8148884c24bde/case/final.sdc
report_qor > /tmp/logic_synth_ref/runs/LSV02_dc_timing_1513faf012f34557a6f8148884c24bde/case/qor.rpt
report_area -hierarchy > /tmp/logic_synth_ref/runs/LSV02_dc_timing_1513faf012f34557a6f8148884c24bde/case/area.rpt
report_timing -delay max -max_paths 20 > /tmp/logic_synth_ref/runs/LSV02_dc_timing_1513faf012f34557a6f8148884c24bde/case/timing.rpt
report_constraint -all_violators > /tmp/logic_synth_ref/runs/LSV02_dc_timing_1513faf012f34557a6f8148884c24bde/case/constraints.rpt
exit
