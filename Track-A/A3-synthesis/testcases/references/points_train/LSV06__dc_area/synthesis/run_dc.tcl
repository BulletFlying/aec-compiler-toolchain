
set target_library [list /tmp/logic_synth_ref/lib/NangateOpenCellLibrary_typical.db]
set link_library [concat "*" $target_library]
analyze -format sverilog /tmp/logic_synth_ref/runs/LSV06_dc_area_5f37302617644f2c800b6c9497516243/case/design.v
elaborate pfpu_f2i
current_design pfpu_f2i
link
check_design > /tmp/logic_synth_ref/runs/LSV06_dc_area_5f37302617644f2c800b6c9497516243/case/check_design.rpt
source /tmp/logic_synth_ref/runs/LSV06_dc_area_5f37302617644f2c800b6c9497516243/case/constraints.sdc

set_max_area 0
if {[catch {compile -area_effort high -map_effort high} err]} {
  puts "area compile failed, falling back to compile: $err"
  compile
}

write -format verilog -hierarchy -output /tmp/logic_synth_ref/runs/LSV06_dc_area_5f37302617644f2c800b6c9497516243/case/netlist.v
write_sdc /tmp/logic_synth_ref/runs/LSV06_dc_area_5f37302617644f2c800b6c9497516243/case/final.sdc
report_qor > /tmp/logic_synth_ref/runs/LSV06_dc_area_5f37302617644f2c800b6c9497516243/case/qor.rpt
report_area -hierarchy > /tmp/logic_synth_ref/runs/LSV06_dc_area_5f37302617644f2c800b6c9497516243/case/area.rpt
report_timing -delay max -max_paths 20 > /tmp/logic_synth_ref/runs/LSV06_dc_area_5f37302617644f2c800b6c9497516243/case/timing.rpt
report_constraint -all_violators > /tmp/logic_synth_ref/runs/LSV06_dc_area_5f37302617644f2c800b6c9497516243/case/constraints.rpt
exit
