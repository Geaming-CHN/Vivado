# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/lenovo/Desktop/Project14/Project14-1-1/Project-14-1-1.cache/wt [current_project]
set_property parent.project_path C:/Users/lenovo/Desktop/Project14/Project14-1-1/Project-14-1-1.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/lenovo/Desktop/Project14/Project14-1-1/Project-14-1-1.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  C:/Users/lenovo/Desktop/Project14/Project14-1-1/Project-14-1-1.srcs/sources_1/new/Syn_SinglePortRAM.v
  C:/Users/lenovo/Desktop/Project14/Project14-1-1/Project-14-1-1.srcs/sources_1/new/display7seg.v
  C:/Users/lenovo/Desktop/Project14/Project14-1-1/Project-14-1-1.srcs/sources_1/new/divider.v
  C:/Users/lenovo/Desktop/Project14/Project14-1-1/Project-14-1-1.srcs/sources_1/new/transformer.v
  C:/Users/lenovo/Desktop/Project14/Project14-1-1/Project-14-1-1.srcs/sources_1/new/top_Syn_SinglePortRAM.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/lenovo/Desktop/Project14/Project14-1-1/Project-14-1-1.srcs/constrs_2/new/Syn_SinglePortRAM_xdc.xdc
set_property used_in_implementation false [get_files C:/Users/lenovo/Desktop/Project14/Project14-1-1/Project-14-1-1.srcs/constrs_2/new/Syn_SinglePortRAM_xdc.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top top_Syn_SinglePortRAM -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef top_Syn_SinglePortRAM.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file top_Syn_SinglePortRAM_utilization_synth.rpt -pb top_Syn_SinglePortRAM_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
