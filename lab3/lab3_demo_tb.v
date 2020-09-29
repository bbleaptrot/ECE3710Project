`timescale 1ns / 1ps
/*
 * Simple test bench that advances the state of the demo for lab 3.
 *
 * September 29, 2020
 *
 */
module lab3_demo_tb;

	reg clk;
	reg reset;
	reg start_button;
	
	wire[0:6] hex3;
	wire[0:6] hex2;
	wire[0:6] hex1;
	wire[0:6] hex0;
	


	lab3_demo UUT(
		.clk(clk), 
		.reset(reset), 
		.start_button(start_button), 
		.hex3(hex3), 
		.hex2(hex2),
		.hex1(hex1),
	   .hex0(hex0)
	);

	initial 
	begin
		clk = 1'b0;
		reset = 1'b1;
		start_button = 1'b1;
		#10;
		
		reset = 1'b0; // reset has been pushed.
		
		#20;
		
		reset = 1'b1;
		
		#1000;
		
		$display("%0h %0h %0h %0h", hex3, hex2, hex1, hex0);
		
		$finish;
		
	
	end
	
	always 
		#5 clk = !clk; // Simulate clock.
		
	always
		#50 start_button = !start_button; // Simulate button being pushed.

endmodule
