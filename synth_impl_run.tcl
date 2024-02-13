open_project [pwd]/ALEF2/Automated_synthesis2.xpr  
##open the created vivado project

# The command allows the user to set the top module manually

set_property source_mgmt_mode None [current_project]  
update_compile_order -fileset sources_1	

set folder_name [lindex $argv 0]
set file_list1 [glob -nocomplain $folder_name/*]
set file_list2 [split $file_list1]


#looping over all the top modules and running the synthesis and implementation
foreach  file_name $file_list2 {
    set_property top $file_name [current_fileset]
    set_property source_mgmt_mode None [current_project]
    update_compile_order -fileset sources_1

    # reset and launch the synthesis and implementation. THe process waits till next command is executed

    reset_run synth_1  
    launch_runs synth_1 -jobs 12
    wait_on_run synth_1
        

    reset_run impl_1
    launch_runs impl_1 -jobs 12
    wait_on_run impl_1

    #set direc $file_name
    #file mkdir -p -[pwd]/$direc

    # If implementation is run, the reports are generated and saved in Impl folder
    open_run impl_1
    #report_power > $direc/power.txt
    #report_timing > $direc/timing.txt
    #report_utilization > $direc/utilization.txt

    report_power > power.txt
    report_timing > timing.txt
    report_utilization > utilization.txt
}
close_project
