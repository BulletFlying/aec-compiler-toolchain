
set target_library [list /tmp/logic_synth_ref/lib/NangateOpenCellLibrary_typical.db]
set link_library [concat "*" $target_library]
analyze -format sverilog /tmp/logic_synth_ref/runs/LSV04_dc_area_f2a17766c820488eb8d7be961381ffae/case/design.v
elaborate b11
current_design b11
link
check_design > /tmp/logic_synth_ref/runs/LSV04_dc_area_f2a17766c820488eb8d7be961381ffae/case/check_design.rpt
source /tmp/logic_synth_ref/runs/LSV04_dc_area_f2a17766c820488eb8d7be961381ffae/case/constraints.sdc

set_max_area 0
if {[catch {compile -area_effort high -map_effort high} err]} {
  puts "area compile failed, falling back to compile: $err"
  compile
}

write -format verilog -hierarchy -output /tmp/logic_synth_ref/runs/LSV04_dc_area_f2a17766c820488eb8d7be961381ffae/case/netlist.v
write_sdc /tmp/logic_synth_ref/runs/LSV04_dc_area_f2a17766c820488eb8d7be961381ffae/case/final.sdc
report_qor > /tmp/logic_synth_ref/runs/LSV04_dc_area_f2a17766c820488eb8d7be961381ffae/case/qor.rpt
report_area -hierarchy > /tmp/logic_synth_ref/runs/LSV04_dc_area_f2a17766c820488eb8d7be961381ffae/case/area.rpt
report_timing -delay max -max_paths 20 > /tmp/logic_synth_ref/runs/LSV04_dc_area_f2a17766c820488eb8d7be961381ffae/case/timing.rpt
report_constraint -all_violators > /tmp/logic_synth_ref/runs/LSV04_dc_area_f2a17766c820488eb8d7be961381ffae/case/constraints.rpt
exit
