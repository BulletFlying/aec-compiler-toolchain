
set target_library [list /tmp/logic_synth_ref/lib/NangateOpenCellLibrary_typical.db]
set link_library [concat "*" $target_library]
analyze -format sverilog /tmp/logic_synth_ref/runs/LSV01_dc_area_2bd732ebd76e412ab268786238ff85ac/case/design.v
elaborate top
current_design top
link
check_design > /tmp/logic_synth_ref/runs/LSV01_dc_area_2bd732ebd76e412ab268786238ff85ac/case/check_design.rpt
source /tmp/logic_synth_ref/runs/LSV01_dc_area_2bd732ebd76e412ab268786238ff85ac/case/constraints.sdc

set_max_area 0
if {[catch {compile -area_effort high -map_effort high} err]} {
  puts "area compile failed, falling back to compile: $err"
  compile
}

write -format verilog -hierarchy -output /tmp/logic_synth_ref/runs/LSV01_dc_area_2bd732ebd76e412ab268786238ff85ac/case/netlist.v
write_sdc /tmp/logic_synth_ref/runs/LSV01_dc_area_2bd732ebd76e412ab268786238ff85ac/case/final.sdc
report_qor > /tmp/logic_synth_ref/runs/LSV01_dc_area_2bd732ebd76e412ab268786238ff85ac/case/qor.rpt
report_area -hierarchy > /tmp/logic_synth_ref/runs/LSV01_dc_area_2bd732ebd76e412ab268786238ff85ac/case/area.rpt
report_timing -delay max -max_paths 20 > /tmp/logic_synth_ref/runs/LSV01_dc_area_2bd732ebd76e412ab268786238ff85ac/case/timing.rpt
report_constraint -all_violators > /tmp/logic_synth_ref/runs/LSV01_dc_area_2bd732ebd76e412ab268786238ff85ac/case/constraints.rpt
exit
