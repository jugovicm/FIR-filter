add_wave {{/fix_fir_tb/fir_under_test/gen_voter/c_vot}} 
add_wave {{/fix_fir_tb/fir_under_test/c_mod}}
add_wave {{/fix_fir_tb/fir_under_test/\gen_elem_sw(0)\/unit_esw/c_esw}} 
add_wave {{/fix_fir_tb/fir_under_test/\gen_elem_sw(1)\/unit_esw/c_esw}}
add_wave {{/fix_fir_tb/fir_under_test/\gen_elem_sw(2)\/unit_esw/c_esw}} 
add_wave {{/fix_fir_tb/fir_under_test/\gen_elem_sw(3)\/unit_esw/c_esw}} 
add_wave {{/fix_fir_tb/fir_under_test/\gen_elem_sw(4)\/unit_esw/c_esw}} 
add_force {/fix_fir_tb/fir_under_test/c_mod[0]} -radix hex {0 350ns} -cancel_after 700ns
add_force {/fix_fir_tb/fir_under_test/c_mod[2]} -radix hex {1 100ns} -cancel_after 500ns
run 800 ns