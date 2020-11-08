`timescale 1ns / 1ps
/*
 * Simple test bench that advances the state of the lab 4.
 *
 * September 29, 2020
 *
 */
module lab4_tb;

//Inputs
reg clk_in, rst;

//outputs
wire[0:6] seg_4, seg_3, seg_2, seg_1;

	lab4 UUT(
		clk_in, rst, seg_4, seg_3, seg_2, seg_1
	);

	initial 
	begin
		clk_in = 1'b0;
		rst = 1'b1;
		#10;
		
		rst = 1'b0; // reset has been pushed.
		
		#1000;
		
		
		
	
	end
	
	always 
		#5 clk_in = !clk_in; // Simulate clock.
		

endmodule