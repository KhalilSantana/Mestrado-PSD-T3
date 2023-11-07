vcom -2008 *.vhd
# vsim Circ2_n_shifter_tb
# add wave -radix unsigned *
# run 20 ps;
vsim Circ2_toplevel_tb
add wave -radix unsigned *
run 20 ps;