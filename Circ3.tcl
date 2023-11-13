vcom -2008 *.vhd

vsim Circ3_calculator_toplevel_tb
add wave -radix unsigned *
run 100 ps;