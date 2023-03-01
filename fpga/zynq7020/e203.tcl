#set PART xq7z020cl400-1I
set PART xc7z020clg400-2
set design_top fpga_top

# STEP#0: define output directory area.
set outputDir ./work
file mkdir $outputDir

# STEP#1: setup design sources and constraints
read_verilog filelist.v
read_xdc ./e203.xdc

# STEP#2: run synthesis, report utilization and timing estimates, write checkpoint design
synth_design -top $design_top -part $PART -flatten none  -include_dirs "../../rtl/e203/core/ ../../rtl/e203/perips/apb_i2c/" -verilog_define "FPGA_SOURCE"
write_checkpoint -force $outputDir/post_synth
report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
write_verilog -force $outputDir/syn_netlist.v

# STEP#3: run placement and logic optimization, report utilization and timing 
# estimates, write checkpoint design
opt_design
place_design
phys_opt_design
#write_checkpoint -force $outputDir/post_place
report_timing_summary -file $outputDir/post_place_timing_summary.rpt

# STEP#4: run router, report actual utilization and timing, write checkpoint design, 
# run drc, write verilog and xdc out
route_design
#write_checkpoint -force $outputDir/post_route
report_timing_summary -file post_route_timing_summary.rpt
#report_timing -sort_by group -max_paths 10 -path_type summary -file $output-Dir/post_route_timing.rpt
report_clock_utilization -file $outputDir/clock_util.rpt
report_utilization -file $outputDir/post_route_util.rpt
#report_power -file $outputDir/post_route_power.rpt
report_drc -file $outputDir/post_imp_drc.rpt
write_verilog -force $outputDir/impl_netlist.v
write_xdc -no_fixed_only -force $outputDir/impl.xdc

# STEP#5: generate a bitstream 
write_bitstream -force e203.bit
