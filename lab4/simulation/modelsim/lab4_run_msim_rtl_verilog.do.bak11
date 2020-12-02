transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Colt/Documents/School/Fall\ 2020/ECE\ 3710-001/Lab/ECE3710Project/vga {C:/Users/Colt/Documents/School/Fall 2020/ECE 3710-001/Lab/ECE3710Project/vga/vga_control.v}
vlog -vlog01compat -work work +incdir+C:/Users/Colt/Documents/School/Fall\ 2020/ECE\ 3710-001/Lab/ECE3710Project/vga {C:/Users/Colt/Documents/School/Fall 2020/ECE 3710-001/Lab/ECE3710Project/vga/bitgen.v}
vlog -vlog01compat -work work +incdir+C:/Users/Colt/Documents/School/Fall\ 2020/ECE\ 3710-001/Lab/ECE3710Project/vga {C:/Users/Colt/Documents/School/Fall 2020/ECE 3710-001/Lab/ECE3710Project/vga/address_generator.v}
vlog -vlog01compat -work work +incdir+C:/Users/Colt/Documents/School/Fall\ 2020/ECE\ 3710-001/Lab/ECE3710Project/vga {C:/Users/Colt/Documents/School/Fall 2020/ECE 3710-001/Lab/ECE3710Project/vga/vga.v}
vlog -vlog01compat -work work +incdir+C:/Users/Colt/Documents/School/Fall\ 2020/ECE\ 3710-001/Lab/ECE3710Project/mobile_controller {C:/Users/Colt/Documents/School/Fall 2020/ECE 3710-001/Lab/ECE3710Project/mobile_controller/mobile_receiver.v}
vlog -vlog01compat -work work +incdir+C:/Users/Colt/Documents/School/Fall\ 2020/ECE\ 3710-001/Lab/ECE3710Project/lab2 {C:/Users/Colt/Documents/School/Fall 2020/ECE 3710-001/Lab/ECE3710Project/lab2/regfile_2D_memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/Colt/Documents/School/Fall\ 2020/ECE\ 3710-001/Lab/ECE3710Project/lab2 {C:/Users/Colt/Documents/School/Fall 2020/ECE 3710-001/Lab/ECE3710Project/lab2/mux_2_to_1.v}
vlog -vlog01compat -work work +incdir+C:/Users/Colt/Documents/School/Fall\ 2020/ECE\ 3710-001/Lab/ECE3710Project/lab2 {C:/Users/Colt/Documents/School/Fall 2020/ECE 3710-001/Lab/ECE3710Project/lab2/mux.v}
vlog -vlog01compat -work work +incdir+C:/Users/Colt/Documents/School/Fall\ 2020/ECE\ 3710-001/Lab/ECE3710Project/lab1 {C:/Users/Colt/Documents/School/Fall 2020/ECE 3710-001/Lab/ECE3710Project/lab1/hex2seg.v}
vlog -vlog01compat -work work +incdir+C:/Users/Colt/Documents/School/Fall\ 2020/ECE\ 3710-001/Lab/ECE3710Project/lab1 {C:/Users/Colt/Documents/School/Fall 2020/ECE 3710-001/Lab/ECE3710Project/lab1/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/Colt/Documents/School/Fall\ 2020/ECE\ 3710-001/Lab/ECE3710Project/lab4 {C:/Users/Colt/Documents/School/Fall 2020/ECE 3710-001/Lab/ECE3710Project/lab4/lab4.v}
vlog -vlog01compat -work work +incdir+C:/Users/Colt/Documents/School/Fall\ 2020/ECE\ 3710-001/Lab/ECE3710Project/lab4 {C:/Users/Colt/Documents/School/Fall 2020/ECE 3710-001/Lab/ECE3710Project/lab4/program_counter.v}
vlog -vlog01compat -work work +incdir+C:/Users/Colt/Documents/School/Fall\ 2020/ECE\ 3710-001/Lab/ECE3710Project/lab4 {C:/Users/Colt/Documents/School/Fall 2020/ECE 3710-001/Lab/ECE3710Project/lab4/fsm.v}
vlog -vlog01compat -work work +incdir+C:/Users/Colt/Documents/School/Fall\ 2020/ECE\ 3710-001/Lab/ECE3710Project/lab4 {C:/Users/Colt/Documents/School/Fall 2020/ECE 3710-001/Lab/ECE3710Project/lab4/IRreg.v}
vlog -vlog01compat -work work +incdir+C:/Users/Colt/Documents/School/Fall\ 2020/ECE\ 3710-001/Lab/ECE3710Project/lab4 {C:/Users/Colt/Documents/School/Fall 2020/ECE 3710-001/Lab/ECE3710Project/lab4/flags_register.v}
vlog -vlog01compat -work work +incdir+C:/Users/Colt/Documents/School/Fall\ 2020/ECE\ 3710-001/Lab/ECE3710Project/vga {C:/Users/Colt/Documents/School/Fall 2020/ECE 3710-001/Lab/ECE3710Project/vga/glyph_rom.v}
vlog -vlog01compat -work work +incdir+C:/Users/Colt/Documents/School/Fall\ 2020/ECE\ 3710-001/Lab/ECE3710Project/lab3 {C:/Users/Colt/Documents/School/Fall 2020/ECE 3710-001/Lab/ECE3710Project/lab3/bram.v}

vlog -vlog01compat -work work +incdir+C:/Users/Colt/Documents/School/Fall\ 2020/ECE\ 3710-001/Lab/ECE3710Project/lab4 {C:/Users/Colt/Documents/School/Fall 2020/ECE 3710-001/Lab/ECE3710Project/lab4/lab4_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  lab4_tb

add wave *
view structure
view signals
run -all
