`timescale 1ps / 1ps

module tb_clk_divider;

//Inputs
reg clk_50MHz, rst;

wire clk_1Hz;

	clk_divider UUT(
		clk_50MHz, rst, clk_1Hz
	);

	initial 
	begin
		clk_50MHz = 1'b0;
		rst = 1'b1;
		#10;
		
		rst = 1'b0; // reset has been pushed.
		

		
		
		
	
	end
	
	always 
		#5 clk_50MHz = !clk_50MHz; // Simulate clock.
		

endmodule