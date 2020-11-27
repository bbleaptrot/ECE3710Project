transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/bblea/source/repos/ECE3710Project/mobile_controller {C:/Users/bblea/source/repos/ECE3710Project/mobile_controller/mobile_receiver.v}
vlog -vlog01compat -work work +incdir+C:/Users/bblea/source/repos/ECE3710Project/lab2 {C:/Users/bblea/source/repos/ECE3710Project/lab2/regfile_2D_memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/bblea/source/repos/ECE3710Project/lab2 {C:/Users/bblea/source/repos/ECE3710Project/lab2/mux_2_to_1.v}
vlog -vlog01compat -work work +incdir+C:/Users/bblea/source/repos/ECE3710Project/lab2 {C:/Users/bblea/source/repos/ECE3710Project/lab2/mux.v}
vlog -vlog01compat -work work +incdir+C:/Users/bblea/source/repos/ECE3710Project/lab1 {C:/Users/bblea/source/repos/ECE3710Project/lab1/hex2seg.v}
vlog -vlog01compat -work work +incdir+C:/Users/bblea/source/repos/ECE3710Project/lab1 {C:/Users/bblea/source/repos/ECE3710Project/lab1/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/bblea/source/repos/ECE3710Project/lab4 {C:/Users/bblea/source/repos/ECE3710Project/lab4/lab4.v}
vlog -vlog01compat -work work +incdir+C:/Users/bblea/source/repos/ECE3710Project/lab4 {C:/Users/bblea/source/repos/ECE3710Project/lab4/program_counter.v}
vlog -vlog01compat -work work +incdir+C:/Users/bblea/source/repos/ECE3710Project/lab4 {C:/Users/bblea/source/repos/ECE3710Project/lab4/fsm.v}
vlog -vlog01compat -work work +incdir+C:/Users/bblea/source/repos/ECE3710Project/lab4 {C:/Users/bblea/source/repos/ECE3710Project/lab4/IRreg.v}
vlog -vlog01compat -work work +incdir+C:/Users/bblea/source/repos/ECE3710Project/lab4 {C:/Users/bblea/source/repos/ECE3710Project/lab4/flags_register.v}
vlog -vlog01compat -work work +incdir+C:/Users/bblea/source/repos/ECE3710Project/lab3 {C:/Users/bblea/source/repos/ECE3710Project/lab3/bram.v}

