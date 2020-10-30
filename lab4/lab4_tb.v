`timescale 1ns / 1ps
/*
 * Simple test bench that advances the state of the lab 4.
 *
 * September 29, 2020
 *
 */
module lab4_tb;

	reg clk;
	reg reset;
	


	lab4 UUT(
		.clk(clk), 
		.rst(reset)
	);

	initial 
	begin
		clk = 1'b0;
		reset = 1'b1;
		#10;
		
		reset = 1'b0; // reset has been pushed.
		
		#1000;
		
		
		$finish;
		
	
	end
	
	always 
		#5 clk = !clk; // Simulate clock.
		

endmodule