`timescale 1ns / 1ps

module tb_program_counter;
	reg clk;
	reg reset;
	reg branch;
	reg jump;
	reg PCen;
	reg signed [7:0] b_offset;
	reg [15:0] j_target;
	
	wire [15:0] PC;
	
	program_counter UUT (.clk(clk), .reset(reset), .branch(branch), .jump(jump), .PCen(PCen), .b_offset(b_offset), .j_target(j_target), .PC(PC));
	
	initial
	begin
	
		$monitor("PC: 0x%0h (%0d), time:%0d", PC, PC, $time);
		
		clk = 0;
		reset = 1;
		branch = 0;
		jump = 0;
		PCen = 0;
		b_offset = 0;
		j_target = 0;
		
		#10;
		
		
		reset = 1'b0;
		
		#10;
		
		PCen = 1'b1;
		
		#100;
		
		$stop;
		
	end
	
	always #5 clk = !clk; 

endmodule
