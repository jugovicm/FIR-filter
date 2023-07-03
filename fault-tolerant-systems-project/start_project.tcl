variable dispScriptFile [file normalize [info script]]

proc getScriptDirectory {} {
    variable dispScriptFile
    set scriptFolder [file dirname $dispScriptFile]
    return $scriptFolder
}

set sdir [getScriptDirectory]
cd [getScriptDirectory]

# Specifying file path
set resultDir .\/result
file mkdir $resultDir
create_project MBIST $resultDir -part xc7z010clg400-1 -force
set_property board_part em.avnet.com:zed:part0:1.4 [current_project]
set_property target_language VHDL [current_project]


# Including files into project
add_files -norecurse 	./fir_filter/txt_util.vhd
add_files -norecurse 	./fir_filter/fixed_fir.vhd
add_files -norecurse 	./fir_filter/mac.vhd
add_files -norecurse 	./redundancy/switch_logic.vhd
add_files -norecurse 	./redundancy/voter_logic.vhd
add_files -norecurse 	./redundancy/dsong_pkg.vhd
add_files -norecurse 	./redundancy/top.vhd
add_files -norecurse 	./redundancy/voter.vhd
add_files -fileset constrs_1 ./stimulus/constr.xdc
add_files -fileset sim_1 ./fir_filter/fix_fir_tb.vhd
update_compile_order -fileset sources_1


# Start synthesis
set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value {-mode out_of_context} -objects [get_runs synth_1]
launch_runs synth_1
wait_on_run synth_1
puts "*****************************************************"
puts "* Synhtesis finished! *"
puts "*****************************************************"

# Start implementation / Mapping DSP modules to MAC
launch_runs impl_1
