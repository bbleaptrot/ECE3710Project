`timescale 1ns / 1ps
/*
 * Simple test bench that advances the state of the lab 4.
 *
 * September 29, 2020
 *
 */
module lab4_tb;

//Inputs
reg clk_in, rst, in_0, in_1, in_2, in_3, in_4, in_5, in_6,in_7;

//outputs
wire[0:6] seg_4, seg_3, seg_2, seg_1;

	lab4 UUT(
		clk_in, rst, seg_4, seg_3, seg_2, seg_1, in_0, in_1, in_2, in_3, in_4, in_5, in_6,in_7
	);

	initial 
	begin
		clk_in = 1'b0;
		rst = 1'b1;
		in_0 = 1'b0;
		in_1 = 1'b0;
		in_2 = 1'b0;
		in_3 = 1'b0;
		in_4 = 1'b0;
		in_5 = 1'b0;
		in_6 = 1'b0;
		in_7 = 1'b0;
		
		
		#10;
		
		rst = 1'b0; // reset has been pushed.
		
		#100;
		
		in_0 = 1'b0;
		in_1 = 1'b0;
		in_2 = 1'b0;
		in_3 = 1'b0;
		in_4 = 1'b1;
		in_5 = 1'b0;
		in_6 = 1'b0;
		in_7 = 1'b0;
		
		#100;
		
		in_0 = 1'b1;
		in_1 = 1'b0;
		in_2 = 1'b0;
		in_3 = 1'b0;
		in_4 = 1'b0;
		in_5 = 1'b0;
		in_6 = 1'b0;
		in_7 = 1'b0;
		
		#100;
		
		rst = 1'b1;
		
		#10;
		
		rst = 1'b0;
		
		#1000;
	
		
		
		
	
	end
	
	always 
		#5 clk_in = !clk_in; // Simulate clock.
		

endmodule