
vlib work
vcom -93 -explicit *.vhd
vcom -93 -explicit testbench.vhd
vsim -t 1ps -lib work testbench
view wave
add wave -noupdate /testbench/reset
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/play
add wave -noupdate /testbench/tempo_mode
add wave -noupdate /testbench/tempo_val
add wave -noupdate /testbench/speaker
view structure
view signals
run -all
# 7) Run the simulation for 40 ns
run 40