/*
 * Current working FSM design for Group 9 
 * Group Members: Ben Leaptrot, Christian Giauque, Colton Watson, Nathan Hummel
 *
 * Last updated: September 22, 2020
 *
 * Inputs: 
 *   clk: Overall timing control
 *   rst: 1-bit to reset state back to 0
 *
 * Outputs:
 *   R_en:    4-bit value to determine which regesters are enabled.
 *	  R_src:   4-bit value to control the mux allowing the correct register value to pass through
 *   R_dest:  4-bit value to control the mux allowing the correct register value to pass through
 *   R_or_I:  1-bit to control the mux allowing either the R_dest or an Immediate value to pass through
 *   ALU_op:  8-bit value for contolling the ALU function
 *   Flag_en: 1-bit value for controlling if the flags register is enabled
 */
 module FSM(clk, rst, R_en, R_src, R_dest, R_or_I, ALU_op, Flag_en);
 
 input clk, rst;
 
 output reg [4:0] R_en;
 output reg [3:0] R_src, R_dest;
 output reg R_or_I;
 output reg [7:0] ALU_op;
 output reg Flag_en;
 
 reg [3:0] state_counter = 4'b0000;
 
 parameter ADD  = 8'b00000101;
 
 always @(negedge rst, posedge clk)
 begin
	if(rst == 0) state_counter = 4'b0000;
	
	// Else, check if the state counter is at the end and if not increment it to the next state.
	else
	begin
		if(state_counter < 4'b1111) state_counter = state_counter + 1'b1;
		
		else state_counter = state_counter;
	end
 end
 
 always @(state_counter)
 begin
	case(state_counter)
		0: begin // Do nothing, this is just a starting state
				R_en    = 4'b0000;
				R_src   = 4'b0000;
				R_dest  = 4'b0000;
				R_or_I  = 1'bx;
				ALU_op  = 8'bxxxx;
				Flag_en = 1'b0;
			end
		1: begin // R2 = R0 + R1
				R_en    = 4'b0010;
				R_src   = 4'b0000;
				R_dest  = 4'b0001;
				R_or_I  = 1'b0;
				ALU_op  = ADD;
				Flag_en = 1'b1;
			end
		2: begin // R3 = R1 + R2
				R_en    = 4'b0011;
				R_src   = 4'b0001;
				R_dest  = 4'b0010;
				R_or_I  = 1'b0;
				ALU_op  = ADD;
				Flag_en = 1'b1;
			end
		3: begin // R4 = R2 + R3
				R_en    = 4'b0100;
				R_src   = 4'b0010;
				R_dest  = 4'b0011;
				R_or_I  = 1'b0;
				ALU_op  = ADD;
				Flag_en = 1'b1;
			end
		4: begin // R5 = R3 + R4
				R_en    = 4'b0101;
				R_src   = 4'b0011;
				R_dest  = 4'b0100;
				R_or_I  = 1'b0;
				ALU_op  = ADD;
				Flag_en = 1'b1;
			end
		5: begin // R6 = R4 + R5
				R_en    = 4'b0110;
				R_src   = 4'b0100;
				R_dest  = 4'b0101;
				R_or_I  = 1'b0;
				ALU_op  = ADD;
				Flag_en = 1'b1;
			end
		6: begin // R7 = R5 + R6
				R_en    = 4'b0111;
				R_src   = 4'b0101;
				R_dest  = 4'b0110;
				R_or_I  = 1'b0;
				ALU_op  = ADD;
				Flag_en = 1'b1;
			end
		7: begin // R8 = R6 + R7
				R_en    = 4'b01000;
				R_src   = 4'b0110;
				R_dest  = 4'b0111;
				R_or_I  = 1'b0;
				ALU_op  = ADD;
				Flag_en = 1'b1;
			end
		8: begin // R9 = R7 + R8
				R_en    = 4'b1001;
				R_src   = 4'b0111;
				R_dest  = 4'b1000;
				R_or_I  = 1'b0;
				ALU_op  = ADD;
				Flag_en = 1'b1;
			end
		9: begin // R10 = R8 + R9
				R_en    = 4'b1010;
				R_src   = 4'b1000;
				R_dest  = 4'b1001;
				R_or_I  = 1'b0;
				ALU_op  = ADD;
				Flag_en = 1'b1;
			end
		10: begin // R11 = R9 + R10
				R_en    = 4'b1011;
				R_src   = 4'b1001;
				R_dest  = 4'b1010;
				R_or_I  = 1'b0;
				ALU_op  = ADD;
				Flag_en = 1'b1;
			end
		11: begin // R12 = R10 + R11
				R_en    = 4'b1100;
				R_src   = 4'b1010;
				R_dest  = 4'b1011;
				R_or_I  = 1'b0;
				ALU_op  = ADD;
				Flag_en = 1'b1;
			end
		12: begin // R13 = R11 + R12
				R_en    = 4'b1101;
				R_src   = 4'b1011;
				R_dest  = 4'b1100;
				R_or_I  = 1'b0;
				ALU_op  = ADD;
				Flag_en = 1'b1;
			end
		13: begin // R14 = R12 + R13
				R_en    = 4'b1110;
				R_src   = 4'b1100;
				R_dest  = 4'b1101;
				R_or_I  = 1'b0;
				ALU_op  = ADD;
				Flag_en = 1'b1;
			end
		14: begin // R15 = R13 + R14
				R_en    = 4'b1111;
				R_src   = 4'b1101;
				R_dest  = 4'b1110;
				R_or_I  = 1'b0;
				ALU_op  = ADD;
				Flag_en = 1'b1;
			end
		default: begin
				R_en    = 4'b0000;
				R_src   = 4'b0000;
				R_dest  = 4'b0000;
				R_or_I  = 1'bx;
				ALU_op  = 8'bxxxxxxxx;
				Flag_en = 1'b0;
			end
	endcase
 end
 
 endmodule
 