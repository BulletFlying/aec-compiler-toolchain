
set target_library [list /tmp/logic_synth_ref/lib/NangateOpenCellLibrary_typical.db]
set link_library [concat "*" $target_library]
analyze -format sverilog /tmp/logic_synth_ref/runs/LSV09_dc_area_b590157decb244b7af3af6ab603ea06c/case/design.v
elaborate Sha256Wishbone
current_design Sha256Wishbone
link
check_design > /tmp/logic_synth_ref/runs/LSV09_dc_area_b590157decb244b7af3af6ab603ea06c/case/check_design.rpt
source /tmp/logic_synth_ref/runs/LSV09_dc_area_b590157decb244b7af3af6ab603ea06c/case/constraints.sdc

set_max_area 0
if {[catch {compile -area_effort high -map_effort high} err]} {
  puts "area compile failed, falling back to compile: $err"
  compile
}

write -format verilog -hierarchy -output /tmp/logic_synth_ref/runs/LSV09_dc_area_b590157decb244b7af3af6ab603ea06c/case/netlist.v
write_sdc /tmp/logic_synth_ref/runs/LSV09_dc_area_b590157decb244b7af3af6ab603ea06c/case/final.sdc
report_qor > /tmp/logic_synth_ref/runs/LSV09_dc_area_b590157decb244b7af3af6ab603ea06c/case/qor.rpt
report_area -hierarchy > /tmp/logic_synth_ref/runs/LSV09_dc_area_b590157decb244b7af3af6ab603ea06c/case/area.rpt
report_timing -delay max -max_paths 20 > /tmp/logic_synth_ref/runs/LSV09_dc_area_b590157decb244b7af3af6ab603ea06c/case/timing.rpt
report_constraint -all_violators > /tmp/logic_synth_ref/runs/LSV09_dc_area_b590157decb244b7af3af6ab603ea06c/case/constraints.rpt
exit
