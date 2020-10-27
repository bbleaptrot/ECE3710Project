module fsm(clk, rst, instruction, branch, jump, FLAGS, PCen, Ren, RegOrImm, WE, IEn, ALU_MUX_CNTL, LS_CNTL);

input clk, rst;
input [7:0] instruction;
input [4:0] FLAGS;

output reg PCen, RegOrImm, WE, ALU_MUX_CNTL, LS_CNTL, branch, jump, IEn;
output reg [15:0] Ren;

reg [2:0] state_counter = 3'b000;

	parameter LOAD = 8'b01000000; // *
	parameter STOR = 8'b01000100; // *
	parameter Bcond= 8'b1100xxxx; // *
	parameter Jcond= 8'b01001100; // *
	parameter JAL  = 8'b01001000; // *

	
	// Next state logic
always @(negedge rst, posedge clk)
 begin
	if(rst == 1) state_counter <= 4'b0000;
	
	// Else, check if the state counter is at the end and if not increment it to the next state.
	else
	begin
		case(state_counter)
			0: state_counter <= 1;
			1: begin
					if(instruction[7:4] == 4'b0) state_counter <= 4'b0010; // R-type instruction
					else if(instruction == STOR) state_counter <= 4'b0011; // Store instruction
					else if(instruction == LOAD) state_counter <= 4'b0100; // Load instruction
					else if(instruction == Bcond)state_counter <= 4'b0110; // Branch instruction
					else if(instruction == Jcond)state_counter <= 4'b0111; // Jump instruction
					else                         state_counter <= 4'b1000; // Everything else right now
				end
		endcase
	end
 end
 
 // Output logic
 always @(state_counter)
 begin
	case(state_counter)
		0: begin // Fetch stage
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
		1: begin // Decode Stage
				Ren           = 16'h0;
				PCen          = 1'b0;
				RegOrImm      = 1'b0;
				WE            = 1'b0;
				ALU_MUX_CNTL  = 1'b0;
				LS_CNTL       = 1'b0;
				branch        = 1'b0;
				jump          = 1'b0;
				IEn           = 1'b1;
				
			end
		2: begin // R-Type
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
		3: begin // Store
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
		4: begin // Load
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
		5: begin // DOUT store to regfile via ALU_Mux
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