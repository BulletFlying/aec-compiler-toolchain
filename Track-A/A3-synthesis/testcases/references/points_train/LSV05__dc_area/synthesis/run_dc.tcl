
set target_library [list /tmp/logic_synth_ref/lib/NangateOpenCellLibrary_typical.db]
set link_library [concat "*" $target_library]
analyze -format sverilog /tmp/logic_synth_ref/runs/LSV05_dc_area_ac204cb6520a40aab54fecad279df2ea/case/design.v
elaborate axi_dwidth_converter_v2_1_b_downsizer
current_design axi_dwidth_converter_v2_1_b_downsizer
link
check_design > /tmp/logic_synth_ref/runs/LSV05_dc_area_ac204cb6520a40aab54fecad279df2ea/case/check_design.rpt
source /tmp/logic_synth_ref/runs/LSV05_dc_area_ac204cb6520a40aab54fecad279df2ea/case/constraints.sdc

set_max_area 0
if {[catch {compile -area_effort high -map_effort high} err]} {
  puts "area compile failed, falling back to compile: $err"
  compile
}

write -format verilog -hierarchy -output /tmp/logic_synth_ref/runs/LSV05_dc_area_ac204cb6520a40aab54fecad279df2ea/case/netlist.v
write_sdc /tmp/logic_synth_ref/runs/LSV05_dc_area_ac204cb6520a40aab54fecad279df2ea/case/final.sdc
report_qor > /tmp/logic_synth_ref/runs/LSV05_dc_area_ac204cb6520a40aab54fecad279df2ea/case/qor.rpt
report_area -hierarchy > /tmp/logic_synth_ref/runs/LSV05_dc_area_ac204cb6520a40aab54fecad279df2ea/case/area.rpt
report_timing -delay max -max_paths 20 > /tmp/logic_synth_ref/runs/LSV05_dc_area_ac204cb6520a40aab54fecad279df2ea/case/timing.rpt
report_constraint -all_violators > /tmp/logic_synth_ref/runs/LSV05_dc_area_ac204cb6520a40aab54fecad279df2ea/case/constraints.rpt
exit
