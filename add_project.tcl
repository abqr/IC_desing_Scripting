#creates a new vivado project
create_project -force [pwd]/ALEF2/Automated_synthesis2 -part xc7a200tfbg676-2
set_property board_part xilinx.com:ac701:part0:1.4 [current_project]

# loop to add all design files
set folder_name [lindex $argv 0]
set file_list1 [glob -nocomplain $folder_name/*]
set file_list2 [split $file_list1]

foreach  file_name $file_list2 {
    add_files -norecurse [pwd]/$file_name
    update_compile_order -fileset sources_1
}
    close_project
