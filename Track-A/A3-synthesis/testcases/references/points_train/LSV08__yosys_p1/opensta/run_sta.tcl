read_liberty /data0/home/sunbin/workspace/constrain_sensor/raw_data/logic_synthesis_question_bank/lib/nangate45/NangateOpenCellLibrary_typical.lib
read_verilog /data0/home/sunbin/workspace/constrain_sensor/raw_data/logic_synthesis_question_bank/reports/reference_runs/yosys_p1/LSV08/opensta/netlist.opensta.v
link_design stage_mult
read_sdc /data0/home/sunbin/workspace/constrain_sensor/raw_data/logic_synthesis_question_bank/reports/reference_runs/yosys_p1/LSV08/constraints.sdc
report_checks -path_delay max -fields {slew cap input nets fanout} -digits 3 -group_count 10 > /data0/home/sunbin/workspace/constrain_sensor/raw_data/logic_synthesis_question_bank/reports/reference_runs/yosys_p1/LSV08/opensta/checks.rpt
report_worst_slack > /data0/home/sunbin/workspace/constrain_sensor/raw_data/logic_synthesis_question_bank/reports/reference_runs/yosys_p1/LSV08/opensta/wns.rpt
report_tns > /data0/home/sunbin/workspace/constrain_sensor/raw_data/logic_synthesis_question_bank/reports/reference_runs/yosys_p1/LSV08/opensta/tns.rpt
report_checks -unconstrained > /data0/home/sunbin/workspace/constrain_sensor/raw_data/logic_synthesis_question_bank/reports/reference_runs/yosys_p1/LSV08/opensta/unconstrained.rpt
exit
