transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Documents/GitHub/ECE3710Project/lab2 {D:/Documents/GitHub/ECE3710Project/lab2/regfile_2D_memory.v}
vlog -vlog01compat -work work +incdir+D:/Documents/GitHub/ECE3710Project/lab2 {D:/Documents/GitHub/ECE3710Project/lab2/mux_2_to_1.v}
vlog -vlog01compat -work work +incdir+D:/Documents/GitHub/ECE3710Project/lab2 {D:/Documents/GitHub/ECE3710Project/lab2/mux.v}
vlog -vlog01compat -work work +incdir+D:/Documents/GitHub/ECE3710Project/lab1 {D:/Documents/GitHub/ECE3710Project/lab1/alu.v}
vlog -vlog01compat -work work +incdir+D:/Documents/GitHub/ECE3710Project/lab4 {D:/Documents/GitHub/ECE3710Project/lab4/lab4.v}
vlog -vlog01compat -work work +incdir+D:/Documents/GitHub/ECE3710Project/lab4 {D:/Documents/GitHub/ECE3710Project/lab4/program_counter.v}
vlog -vlog01compat -work work +incdir+D:/Documents/GitHub/ECE3710Project/lab4 {D:/Documents/GitHub/ECE3710Project/lab4/fsm.v}
vlog -vlog01compat -work work +incdir+D:/Documents/GitHub/ECE3710Project/lab4 {D:/Documents/GitHub/ECE3710Project/lab4/IRreg.v}
vlog -vlog01compat -work work +incdir+D:/Documents/GitHub/ECE3710Project/lab3 {D:/Documents/GitHub/ECE3710Project/lab3/bram.v}

