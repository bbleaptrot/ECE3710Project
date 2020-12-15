transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/bblea/source/repos/ECE3710Project/lab2 {C:/Users/bblea/source/repos/ECE3710Project/lab2/regfile_2D_memory.v}

