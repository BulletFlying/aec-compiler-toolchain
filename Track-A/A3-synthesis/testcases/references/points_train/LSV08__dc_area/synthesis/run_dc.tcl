
set target_library [list /tmp/logic_synth_ref/lib/NangateOpenCellLibrary_typical.db]
set link_library [concat "*" $target_library]
analyze -format sverilog /tmp/logic_synth_ref/runs/LSV08_dc_area_b04ec938500c4caf9cb8db0a82cae42f/case/design.v
elaborate stage_mult
current_design stage_mult
link
check_design > /tmp/logic_synth_ref/runs/LSV08_dc_area_b04ec938500c4caf9cb8db0a82cae42f/case/check_design.rpt
source /tmp/logic_synth_ref/runs/LSV08_dc_area_b04ec938500c4caf9cb8db0a82cae42f/case/constraints.sdc

set_max_area 0
if {[catch {compile -area_effort high -map_effort high} err]} {
  puts "area compile failed, falling back to compile: $err"
  compile
}

write -format verilog -hierarchy -output /tmp/logic_synth_ref/runs/LSV08_dc_area_b04ec938500c4caf9cb8db0a82cae42f/case/netlist.v
write_sdc /tmp/logic_synth_ref/runs/LSV08_dc_area_b04ec938500c4caf9cb8db0a82cae42f/case/final.sdc
report_qor > /tmp/logic_synth_ref/runs/LSV08_dc_area_b04ec938500c4caf9cb8db0a82cae42f/case/qor.rpt
report_area -hierarchy > /tmp/logic_synth_ref/runs/LSV08_dc_area_b04ec938500c4caf9cb8db0a82cae42f/case/area.rpt
report_timing -delay max -max_paths 20 > /tmp/logic_synth_ref/runs/LSV08_dc_area_b04ec938500c4caf9cb8db0a82cae42f/case/timing.rpt
report_constraint -all_violators > /tmp/logic_synth_ref/runs/LSV08_dc_area_b04ec938500c4caf9cb8db0a82cae42f/case/constraints.rpt
exit
