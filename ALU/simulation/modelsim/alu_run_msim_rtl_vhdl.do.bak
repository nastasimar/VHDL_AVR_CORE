transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -2008 -work work {C:/Users/79315/Desktop/vhdl_homework/core/ALU/alu.vhd}

vlog -sv -work work +incdir+C:/Users/79315/Desktop/vhdl_homework/core/ALU {C:/Users/79315/Desktop/vhdl_homework/core/ALU/ALU_test.sv}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive -L rtl_work -L work -voptargs="+acc"  ALU_test

add wave *
view structure
view signals
run -all
