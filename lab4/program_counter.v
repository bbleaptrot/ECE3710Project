/*
 * Program counter for Group 9 [Attempt #1]
 * Group Members: Ben Leaptrot, Christian Giauque, Colton Watson, Nathan Hummel
 * 
 * Inputs:
 *		clk:    clock
 *    reset:  active high reset signal
 *    branch: signal specifing a branch instruction.
 *    jump:   signal specifing a jump instruction.
 *    PCen:   program counter enable. If low, PC remains at the same state
 *    b_offset: branch offset, signed 8-bit number from instruction.
 *    j_target: value to assign to PC when jumps occur.
 *
 * Outputs:
 * 	PC: value of the program counter.
 *
 * Last updated: October 14, 2020
 */
module program_counter(clk, reset, branch, jump, PCen, b_offset, j_target, PC);
	input clk;
	input reset;
	
	input branch;
	input jump;
	
	input PCen;
	
	// Probably could just make these the same thing and save a little space, but this keeps it simple.
	input signed [7:0] b_offset;
	input [15:0] j_target;
	
	output reg [15:0] PC;
   		
	// It needs to be sequential since PC needs to maintain state.
	always@(posedge clk)
	begin
		// Default address to read from. Probably want to adjust for final, maybe make it an input parameter?
		if(reset) PC <= 16'b0; 
		
		// Only update PC when PCen goes high
		else if(PCen)
		begin
			if(branch)		PC <= PC + b_offset; 
			else if(jump)  PC <= j_target;
			else			   PC <= PC + 1'b1;
		end	
	
		else PC <= PC;
	end

endmodule
