vcom -2008 *.vhd
vsim Circ1_minfinder_tb
add wave -radix unsigned *
run 20 ps;
vsim Circ1_toplevel_tb
add wave -radix unsigned *
run 20 ps;