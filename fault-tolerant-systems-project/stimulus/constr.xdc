##Clock signal
create_clock -add -name clk_s -period 10.00 -waveform {0 5} [get_ports { clk }];
