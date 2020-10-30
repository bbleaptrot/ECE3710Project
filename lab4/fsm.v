module fsm(clk, rst, instruction, branch, jump, FLAGS, PCen, Ren, RegOrImm, WE, IEn, ALU_MUX_CNTL, LS_CNTL);

input clk, rst;
input [15:0] instruction;
input [4:0] FLAGS;

output reg PCen, RegOrImm, WE, ALU_MUX_CNTL, LS_CNTL, branch, jump, IEn;
output reg [15:0] Ren;

reg [3:0] state_counter = 4'b0000;

	parameter LOAD = 8'b01000000; // *
	parameter STOR = 8'b01000100; // *
	parameter Bcond= 8'b1100xxxx; // *
	parameter Jcond= 8'b01001100; // *
	parameter JAL  = 8'b01001000; // *

	
	// Next state logic
always @(posedge clk)
 begin
	if(rst == 1) state_counter <= 4'b0000;
	
	// Else, check if the state counter is at the end and if not increment it to the next state.
	else
	begin
		case(state_counter)
			0: state_counter <= 1;
			1: begin
					if(instruction[15:12] == 4'b0 || instruction[15:12] == 4'b0101) state_counter <= 4'b0010; // R-type instruction
					else if({instruction[15:12],instruction[7:4]} == STOR) state_counter <= 4'b0011; // Store instruction
					else if({instruction[15:12],instruction[7:4]} == LOAD) state_counter <= 4'b0100; // Load instruction
					else if({instruction[15:12],instruction[7:4]} == Bcond)state_counter <= 4'b0110; // Branch instruction
					else if({instruction[15:12],instruction[7:4]} == Jcond)state_counter <= 4'b0111; // Jump instruction
					else                         state_counter <= 4'b1000; // Everything else right now
				end
			2: state_counter <= 4'b0000;
			3: state_counter <= 4'b0000;
			4: state_counter <= 4'b0101;
			5: state_counter <= 4'b0000;
			default: state_counter <= 0;
		endcase
	end
 end
 
 // Output logic
 always @(state_counter)
 begin
	case(state_counter)
		0: begin // Fetch stage
				Ren           = 16'h0; // Data isn't getting written back in this stage
				PCen          = 1'b0;  // Grab the counter at it's current state
				RegOrImm      = 1'b0;  // Shouldn't matter
				WE            = 1'b0;  // Do not write into memory
				ALU_MUX_CNTL  = 1'b0;  // Should be garbage data
				LS_CNTL       = 1'b1;  // Needs to be 1 to get PC value unless rewired in lab4
				branch        = 1'b0;  // Don't branch
				jump          = 1'b0;  // Don't jump
				IEn           = 1'b0;  // Grab instruction
			end
		1: begin // Decode Stage
				Ren           = 16'h0; // Don't write to registers yet
				PCen          = 1'b0;  // Increment at the end of the instruction 
				RegOrImm      = 1'b0;  // Shouldn't matter
				WE            = 1'b0;  // Don't write into memory 
				ALU_MUX_CNTL  = 1'b0;  // Should still be garbage data
				LS_CNTL       = 1'b1;  // Needs to be 1 to get PC value unless rewired in lab4
				branch        = 1'b0;  // Don't branch
				jump          = 1'b0;  // Don't jump
				IEn           = 1'b1;  // Hold instruction
				
			end
		2: begin // R-Type
				Ren           = instruction[11:8];
				PCen          = 1'b1;
				RegOrImm      = 1'b1;
				WE            = 1'b0;
				ALU_MUX_CNTL  = 1'b0;
				LS_CNTL       = 1'b0;
				branch        = 1'b0;
				jump          = 1'b0;
				IEn           = 1'b0;
			end
		3: begin // Store into memory
				Ren           = 16'h0; // Not writing to registers
				PCen          = 1'b1;  // Move to next instruction
				RegOrImm      = 1'b0;  // Probably garbage?
				WE            = 1'b1;  // Write into memory
				ALU_MUX_CNTL  = 1'b0;  // Should be junk
				LS_CNTL       = 1'b0;  // Store into memory
				branch        = 1'b0;  // not branching
				jump          = 1'b0;  // not jumping
				IEn           = 1'b0;  // holding instruction
			end
		4: begin // Load
				Ren           = 16'h0; // Not writing to registers
				PCen          = 1'b0;  // One more step in Loads
				RegOrImm      = 1'b0;  // Doesn't matter
				WE            = 1'b0;  // Not writing to memory 
				ALU_MUX_CNTL  = 1'b0;  // Garbage 
				LS_CNTL       = 1'b0;  // Need the address
				branch        = 1'b0;  // Not branching
				jump          = 1'b0;  // Not jumping
				IEn           = 1'b0;  // holding instruction
			end
		5: begin // DOUT store to regfile via ALU_Mux
				Ren           = instruction[11:8]; // Write to register
				PCen          = 1'b1;  // Move to next instruction
				RegOrImm      = 1'b0;  // shoudn't matter?
				WE            = 1'b0;  // Not writing to memory
				ALU_MUX_CNTL  = 1'b1;  // Write data from memory into registers
				LS_CNTL       = 1'b0;  // Not storing data
				branch        = 1'b0;  // not branching
				jump          = 1'b0;  // not jumping
				IEn           = 1'b0;  // holding instruction
			end
		6: begin // Branch
				Ren           = 16'h0;
				PCen          = 1'b0;
				RegOrImm      = 1'b0;
				WE            = 1'b0;
				ALU_MUX_CNTL  = 1'b0;
				LS_CNTL       = 1'b0;
				branch        = 1'b0;
				jump          = 1'b0;
				IEn           = 1'b0;
			end
		7: begin // Jump
				Ren           = 16'h0;
				PCen          = 1'b0;
				RegOrImm      = 1'b0;
				WE            = 1'b0;
				ALU_MUX_CNTL  = 1'b0;
				LS_CNTL       = 1'b0;
				branch        = 1'b0;
				jump          = 1'b0;
				IEn           = 1'b0;
			end
		default: begin
				Ren           = 16'hx;
				PCen          = 1'bx;
				RegOrImm      = 1'bx;
				WE            = 1'bx;
				ALU_MUX_CNTL  = 1'bx;
				LS_CNTL       = 1'bx;
				branch        = 1'bx;
				jump          = 1'bx;
				IEn           = 1'bx;
			end
	endcase
 end
 
endmodule