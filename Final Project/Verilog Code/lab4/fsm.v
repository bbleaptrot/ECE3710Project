module fsm(clk, rst, instruction, data_from_mem, branch, jump, FLAGS, PCen, Ren, RegOrImm, WE, IEn, ALU_MUX_CNTL, LS_CNTL, flagEn, phoneEn);

input clk, rst;
input [15:0] instruction, data_from_mem;
input [4:0] FLAGS;

output reg PCen, RegOrImm, WE, ALU_MUX_CNTL, LS_CNTL, branch, jump, IEn, flagEn, phoneEn;
output reg [15:0] Ren;

reg [15:0] delay_Ren = 16'h0;
reg [3:0] state_counter = 4'b0000;

	parameter LOAD = 8'b01000000; // *
	parameter STOR = 8'b01000100; // *
	parameter Bcond= 4'b1100; // *
	parameter Jcond= 8'b01001100; // *
	parameter JAL  = 8'b01001000; // *
	parameter PHONE= 8'b11111111;

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
					if(data_from_mem[15:12] == 4'b0000 && data_from_mem[7:4] != 4'b0000) state_counter <= 4'b0010; // R-type instruction
					else if({data_from_mem[15:12],data_from_mem[7:4]} == STOR) state_counter <= 4'b0011; // Store instruction
					else if({data_from_mem[15:12],data_from_mem[7:4]} == LOAD) state_counter <= 4'b0100; // Load instruction
					else if(data_from_mem[15:12] == Bcond)                   state_counter <= 4'b0110; // Branch instruction
					else if({data_from_mem[15:12],data_from_mem[7:4]} == Jcond)state_counter <= 4'b0111; // Jump instruction
					else if({data_from_mem[15:12],data_from_mem[7:4]} == PHONE)state_counter <= 4'b1000; // Jump instruction
					else state_counter <= 4'b0010;// Everything else right now
				end
			2: state_counter <= 4'b0000;
			3: state_counter <= 4'b0000;
			4: state_counter <= 4'b0101;
			5: state_counter <= 4'b0000;
			6: state_counter <= 4'b0000;
			7: state_counter <= 4'b0000;
			8: state_counter <= 4'b0000;
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
				delay_Ren     = 16'h0;
				flagEn        = 1'b0;
				phoneEn       = 1'b0;
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
				delay_Ren     = 16'h0;
				flagEn        = 1'b0;
				phoneEn       = 1'b0;
			end
		2: begin // R-Type
				PCen          = 1'b1;
				WE            = 1'b0;
				ALU_MUX_CNTL  = 1'b0;
				LS_CNTL       = 1'b0;
				branch        = 1'b0;
				jump          = 1'b0;
				IEn           = 1'b0;
				flagEn        = 1'b1;
				if(instruction[15:12] == 4'b0101 ||
					instruction[15:12] == 4'b0110 ||
					instruction[15:12] == 4'b0111 ||
					instruction[15:12] == 4'b1001 ||
					instruction[15:12] == 4'b1010 ||
					instruction[15:12] == 4'b1011 ||
					instruction[15:12] == 4'b0001 ||
					instruction[15:12] == 4'b0010 ||
					instruction[15:12] == 4'b0011 ||
					instruction[15:12] == 4'b1101 ||
					instruction[15:12] == 4'b1111) RegOrImm = 1'b1;
				else RegOrImm = 1'b0;
				case(instruction[11:8])
					0:  Ren = 16'h0001;
					1:  Ren = 16'h0002;
					2:  Ren = 16'h0004;
					3:  Ren = 16'h0008;
					4:  Ren = 16'h0010;
					5:  Ren = 16'h0020;
					6:  Ren = 16'h0040;
					7:  Ren = 16'h0080;
					8:  Ren = 16'h0100;
					9:  Ren = 16'h0200;
					10: Ren = 16'h0400;
					11: Ren = 16'h0800;
					12: Ren = 16'h1000;
					13: Ren = 16'h2000;
					14: Ren = 16'h4000;
					15: Ren = 16'h8000;
				endcase
				delay_Ren = 16'h0;
				phoneEn       = 1'b0;
			end
		3: begin // Store into memory
				PCen          = 1'b1;  // Move to next instruction
				RegOrImm      = 1'b0;  // Probably garbage?
				WE            = 1'b1;  // Write into memory
				ALU_MUX_CNTL  = 1'b0;  // Should be junk
				LS_CNTL       = 1'b0;  // Store into memory
				branch        = 1'b0;  // not branching
				jump          = 1'b0;  // not jumping
				IEn           = 1'b0;  // holding instruction
				Ren           = 16'h0;
				delay_Ren     = 16'h0;
				flagEn        = 1'b0;
				phoneEn       = 1'b0;
			end
		4: begin // Load
				PCen          = 1'b0;  // One more step in Loads
				RegOrImm      = 1'b0;  // Doesn't matter
				WE            = 1'b0;  // Not writing to memory 
				ALU_MUX_CNTL  = 1'b0;  // Garbage 
				LS_CNTL       = 1'b0;  // Need the address
				branch        = 1'b0;  // Not branching
				jump          = 1'b0;  // Not jumping
				//IEn           = 1'b1;  // holding instruction current working simulation line
				IEn           = 1'b0;
				Ren           = 16'h0;
				flagEn        = 1'b0;
				phoneEn       = 1'b0;
				case(instruction[11:8])
					0:  delay_Ren = 16'h0001;
					1:  delay_Ren = 16'h0002;
					2:  delay_Ren = 16'h0004;
					3:  delay_Ren = 16'h0008;
					4:  delay_Ren = 16'h0010;
					5:  delay_Ren = 16'h0020;
					6:  delay_Ren = 16'h0040;
					7:  delay_Ren = 16'h0080;
					8:  delay_Ren = 16'h0100;
					9:  delay_Ren = 16'h0200;
					10: delay_Ren = 16'h0400;
					11: delay_Ren = 16'h0800;
					12: delay_Ren = 16'h1000;
					13: delay_Ren = 16'h2000;
					14: delay_Ren = 16'h4000;
					15: delay_Ren = 16'h8000;
				endcase
			end
		5: begin // DOUT store to regfile via ALU_Mux
				PCen          = 1'b1;  // Move to next instruction
				RegOrImm      = 1'b0;  // shoudn't matter?
				WE            = 1'b0;  // Not writing to memory
				ALU_MUX_CNTL  = 1'b1;  // Write data from memory into registers
				LS_CNTL       = 1'b0;  // Not storing data
				branch        = 1'b0;  // not branching
				jump          = 1'b0;  // not jumping
				IEn           = 1'b0;  // holding instruction
				case(instruction[11:8])
					0:  Ren = 16'h0001;
					1:  Ren = 16'h0002;
					2:  Ren = 16'h0004;
					3:  Ren = 16'h0008;
					4:  Ren = 16'h0010;
					5:  Ren = 16'h0020;
					6:  Ren = 16'h0040;
					7:  Ren = 16'h0080;
					8:  Ren = 16'h0100;
					9:  Ren = 16'h0200;
					10: Ren = 16'h0400;
					11: Ren = 16'h0800;
					12: Ren = 16'h1000;
					13: Ren = 16'h2000;
					14: Ren = 16'h4000;
					15: Ren = 16'h8000;
				endcase
				flagEn        = 1'b0;
				delay_Ren     = 16'h0;
				phoneEn       = 1'b0;
			end
		6: begin // Branch
			// FLAGS [C,L,F,Z,N]
				case(instruction[11:8])
					0: // EQ Z=1
						if(FLAGS[1]) branch = 1;
						else branch = 0;
					1: // NE Z=0
						if(~FLAGS[1]) branch = 1;
						else branch = 0;
					2: // CS C=1
						if(FLAGS[4]) branch = 1;
						else branch = 0;
					3: // CC C=0
						if(~FLAGS[4]) branch = 1;
						else branch = 0;
					4: // HI L=1
						if(FLAGS[3]) branch = 1;
						else branch = 0;
					5: // LS L=0
						if(~FLAGS[3]) branch = 1;
						else branch = 0;
					6: // GT N=1
						if(FLAGS[0]) branch = 1;
						else branch = 0;
					7: // LE N=0
						if(~FLAGS[0]) branch = 1;
						else branch = 0;
					8: // FS F=1
						if(FLAGS[2]) branch = 1;
						else branch = 0;
					9: // FC F=0
						if(~FLAGS[2]) branch = 1;
						else branch = 0;
					10: // L0 L=0 AND Z=0
						if(~FLAGS[3] & ~FLAGS[1]) branch = 1;
						else branch = 0;
					11: // HS L=1 OR Z=1
						if(FLAGS[3] | FLAGS[1]) branch = 1;
						else branch = 0;
					12: // LS N=0 AND Z=0
						if(~FLAGS[0] & ~FLAGS[1]) branch = 1;
						else branch = 0;
					13: // GE N=1 Or Z=1
						if(FLAGS[0] | FLAGS[1]) branch = 1;
						else branch = 0;
					14: // Uncondtional NA
						branch = 1;
					15: // NEVER JUMP EVER
						branch = 0;
				endcase
				
				PCen          = 1'b1; // Logic needed to determine if high or not
				RegOrImm      = 1'b0; // No arithmetic logic
				WE            = 1'b0; // Not writing
				ALU_MUX_CNTL  = 1'b0; // 
				LS_CNTL       = 1'b0; 
				jump          = 1'b0;
				IEn           = 1'b0;
				Ren           = 16'b0;
				delay_Ren 	  = 16'h0;
				flagEn        = 1'b0;
				phoneEn       = 1'b0;
			end
		7: begin // Jump
				// FLAGS [C,L,F,Z,N]
				case(instruction[11:8])
					0: // EQ Z=1
						if(FLAGS[1]) jump = 1;
						else jump = 0;
					1: // NE Z=0
						if(~FLAGS[1]) jump = 1;
						else jump = 0;
					2: // CS C=1
						if(FLAGS[4]) jump = 1;
						else jump = 0;
					3: // CC C=0
						if(~FLAGS[4]) jump = 1;
						else jump = 0;
					4: // HI L=1
						if(FLAGS[3]) jump = 1;
						else jump = 0;
					5: // LS L=0
						if(~FLAGS[3]) jump = 1;
						else jump = 0;
					6: // GT N=1
						if(FLAGS[0]) jump = 1;
						else jump = 0;
					7: // LE N=0
						if(~FLAGS[0]) jump = 1;
						else jump = 0;
					8: // FS F=1
						if(FLAGS[2]) jump = 1;
						else jump = 0;
					9: // FC F=0
						if(~FLAGS[2]) jump = 1;
						else jump = 0;
					10: // L0 L=0 AND Z=0
						if(~FLAGS[3] & ~FLAGS[1]) jump = 1;
						else jump = 0;
					11: // HS L=1 OR Z=1
						if(FLAGS[3] | FLAGS[1]) jump = 1;
						else jump = 0;
					12: // LS N=0 AND Z=0
						if(~FLAGS[0] & ~FLAGS[1]) jump = 1;
						else jump = 0;
					13: // GE N=1 Or Z=1
						if(FLAGS[0] | FLAGS[1]) jump = 1;
						else jump = 0;
					14: // Uncondtional NA
						jump = 1;
					15: // NEVER JUMP EVER
						jump = 0;
				endcase
				PCen          = 1'b1;
				RegOrImm      = 1'b0;
				WE            = 1'b0;
				ALU_MUX_CNTL  = 1'b0;
				LS_CNTL       = 1'b1;
				branch        = 1'b0;
				IEn           = 1'b0;
				Ren           = 1'b0;
				delay_Ren     = 16'h0;
				flagEn        = 1'b0;
				phoneEn       = 1'b0;
			end
			8: begin // Phone
				PCen          = 1'b1;
				WE            = 1'b0;
				ALU_MUX_CNTL  = 1'b0;
				LS_CNTL       = 1'b0;
				branch        = 1'b0;
				jump          = 1'b0;
				IEn           = 1'b0;
				flagEn        = 1'b0;
				RegOrImm      = 1'b0;
				case(instruction[11:8])
					0:  Ren = 16'h0001;
					1:  Ren = 16'h0002;
					2:  Ren = 16'h0004;
					3:  Ren = 16'h0008;
					4:  Ren = 16'h0010;
					5:  Ren = 16'h0020;
					6:  Ren = 16'h0040;
					7:  Ren = 16'h0080;
					8:  Ren = 16'h0100;
					9:  Ren = 16'h0200;
					10: Ren = 16'h0400;
					11: Ren = 16'h0800;
					12: Ren = 16'h1000;
					13: Ren = 16'h2000;
					14: Ren = 16'h4000;
					15: Ren = 16'h8000;
				endcase
				delay_Ren = 16'h0;
				phoneEn   = 1'b1;
			end
		default: begin
				PCen          = 1'bx;
				RegOrImm      = 1'bx;
				WE            = 1'bx;
				ALU_MUX_CNTL  = 1'bx;
				LS_CNTL       = 1'bx;
				branch        = 1'bx;
				jump          = 1'bx;
				IEn           = 1'bx;
				flagEn        = 1'b0;
				delay_Ren     = 16'h0;
				case(instruction[11:8])
					0:  Ren = 16'h0001;
					1:  Ren = 16'h0002;
					2:  Ren = 16'h0004;
					3:  Ren = 16'h0008;
					4:  Ren = 16'h0010;
					5:  Ren = 16'h0020;
					6:  Ren = 16'h0040;
					7:  Ren = 16'h0080;
					8:  Ren = 16'h0100;
					9:  Ren = 16'h0200;
					10: Ren = 16'h0400;
					11: Ren = 16'h0800;
					12: Ren = 16'h1000;
					13: Ren = 16'h2000;
					14: Ren = 16'h4000;
					15: Ren = 16'h8000;
				endcase
			end
	endcase
 end
 
endmodule