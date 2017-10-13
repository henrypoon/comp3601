
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name musicplayer_v1.1 -dir "Y:/Desktop/Study/COMP3601/comp3601/VHDL/musicplayer_v1.1/planAhead_run_3" -part xc3s400ft256-5
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "Y:/Desktop/Study/COMP3601/comp3601/VHDL/musicplayer_v1.1/musicplayer_top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {Y:/Desktop/Study/COMP3601/comp3601/VHDL/musicplayer_v1.1} }
set_property target_constrs_file "Y:/Desktop/pins.ucf" [current_fileset -constrset]
add_files [list {Y:/Desktop/pins.ucf}] -fileset [get_property constrset [current_run]]
link_design
