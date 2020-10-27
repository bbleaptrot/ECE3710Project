module fsm(clk, rst, instruction, branch, jump, FLAGS, PCen, Ren, RegOrImm, WE, IEn, ALU_MUX_CNTL, LS_CNTL);

input clk, rst;
input [15:0] instruction;
input [4:0] FLAGS;

output reg PCen, RegOrImm, WE, ALU_MUX_CNTL, LS_CNTL, branch, jump, IEn;
output reg [15:0] Ren;

reg [2:0] state_counter = 3'b000;

always @(negedge rst, posedge clk)
 begin
	if(rst == 0) state_counter = 3'b000;
	
	// Else, check if the state counter is at the end and if not increment it to the next state.
	else
	begin
		if(state_counter < 3'b101) state_counter = state_counter + 1'b1;
		
		else state_counter = state_counter;
	end
 end
 
 always @(state_counter)
 begin
	case(state_counter)
		0: begin // Fetch stage
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
				PCen          = 1'b0;
				RegOrImm      = 1'b0;
				WE            = 1'b0;
				ALU_MUX_CNTL  = 1'b0;
				LS_CNTL       = 1'b0;
				branch        = 1'b0;
				jump          = 1'b0;
				IEn           = 1'b0;
			end
		2: begin // R-Type
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
				PCen          = 1'b0;
				RegOrImm      = 1'b0;
				WE            = 1'b0;
				ALU_MUX_CNTL  = 1'b0;
				LS_CNTL       = 1'b0;
				branch        = 1'b0;
				jump          = 1'b0;
				IEn           = 1'b0;
			end
	endcase
 end

endmodule