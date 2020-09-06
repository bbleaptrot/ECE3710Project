/*
 * Note: fix extended immediate! with opcode extension!
 *
 */


module alu(A, B, C, Opcode, Flags);

	input  [15:0] A, B;
	input  [7:0]  Opcode;
	
	output reg [15:0] C;
	output reg [4:0]  Flags; // CLFZN
	
	parameter carry_f    = 5'd4;
	parameter low_f      = 5'd3;
	parameter overflow_f = 5'd2;
	parameter zero_f     = 5'd1;
	parameter negative_f = 5'd0;

	// * = Baseline instructions
	// Obviously delete unused/unneeded parameters.
	parameter ADD  = 8'b00000101; // *
	parameter ADDI = 8'b0101xxxx; // *
	parameter ADDU = 8'b00000110;
	parameter ADDUI= 8'b0110xxxx;
	parameter ADDC = 8'b00000111;
	parameter ADDCI= 8'b0111xxxx;
	
	parameter SUB  = 8'b00001001; // *
	parameter SUBI = 8'b1001xxxx; // *
	parameter SUBC = 8'b00001010;
	parameter SUBCI= 8'b1010xxxx; 
	parameter CMP  = 8'b00001011; // *
	parameter CMPI = 8'b1011xxxx; // *
	parameter AND  = 8'b00000001; // *
	parameter ANDI = 8'b0001xxxx; // *
	parameter OR   = 8'b00000010; // *
	parameter ORI  = 8'b0010xxxx; // *
	parameter XOR  = 8'b00000011; // *
	parameter XORI = 8'b0011xxxx; // *
	parameter MOV  = 8'b00001101; // *
	parameter MOVI = 8'b1101xxxx; // *
	parameter LSH  = 8'b10000100; // *
	parameter LSHI = 8'b1000000x; // x -> sign (0=left, 2s comp)
	parameter ASHU = 8'b10000110;
	parameter ASHUI= 8'b1000001x;
	parameter LUI  = 8'b1111xxxx; // *
	
	/* How should these be done in the ALU? */
	parameter LOAD = 8'b01000000; // *
	parameter STOR = 8'b01000100; // *
	parameter Bcond= 8'b1100xxxx; // *
	parameter Jcond= 8'b01001100; // *
	parameter JAL  = 8'b01001000; // *
	
	
	always@(A, B, Opcode)
	begin		
		Flags = 5'b0;
		C = 16'b0;
		casex (Opcode)
		
		ADD: // Integer add
			begin
			{Flags[carry_f], C} = A + B; 
			
			
//			if(C == 16'b0) 
//				Flags[zero_f] = 1'b1;
			
			if((~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15])) 
				Flags[overflow_f] = 1'b1;
				
			end
			

		ADDI: // Integer add immediate
			begin
			
			{Flags[carry_f], C} = A + {{8{B[7]}} , B[7:0]}; // sign-extended Just Leave B if already sign-extended?
			
			
			if((~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15])) 
				Flags[overflow_f] = 1'b1;
			
			end
			
		ADDU: // Integer add, no change to PSR (Flags)
			begin
			C = A + B; 
			end
			
		SUB: // Integer sub
			begin
			// Is this how to check for borrowing?
			{Flags[carry_f], C} = A - B; // How to incorporate C flag? 
			
			
			if(C == 16'b0) 
				Flags[zero_f] = 1'b1; 
			
			// Is this how overflow works for subtraction?
			if((~A[15] & ~B[15] & C[15]) | (A[15] & B[15] & ~C[15])) 
				Flags[overflow_f] = 1'b1;
			
			if(A < B)
				Flags[low_f] = 1'b1;
				
			if($signed(A) < $signed(B))
				Flags[negative_f] = 1'b1;			
			
			end
			
		SUBI: // Integer sub immediate
			begin
			// Is this how to check for borrowing?
			{Flags[carry_f], C} = A - {{8{B[7]}} , B[7:0]};
			
			
			// Is this how overflow works for subtraction?
			if((~A[15] & ~B[7] & C[15]) | (A[15] & B[7] & ~C[15])) 
				Flags[overflow_f] = 1'b1;
			
			if(A < B)
				Flags[low_f] = 1'b1;
			
			if($signed(A) < $signed(B))
				Flags[negative_f] = 1'b1;
			
			end
			
		
		CMP:
			begin
			
			if(A == B)
				Flags[zero_f] = 1'b1;
				
			if($signed(A) < $signed(B))
				Flags[negative_f] = 1'b1;
				
			if(A < B)
				Flags[low_f] = 1'b1;
			
			end
			
		CMPI:
			begin 
			if(A == {{8{B[7]}} , B[7:0]})
				Flags[zero_f] = 1'b1;
				
			if($signed(A) < $signed({{8{B[7]}} , B[7:0]}))
				Flags[negative_f] = 1'b1;
				
			if(A < {8'b0 , B[7:0]})
				Flags[low_f] = 1'b1;
			end

		AND:
			begin
			C = A & B;
			
			if(C == 16'b0)
				Flags[zero_f] = 1'b1;
			end
		ANDI:
			begin
			C = A & {8'b0 , B[7:0]}; 
			
			if(C == 16'b0)
				Flags[zero_f] = 1'b1;
			end
		OR:
			begin
			C = A | B; // No flags
			end
		ORI:
			begin
			C = A | {8'b0 , B[7:0]}; // No flags
			end
		XOR:
			begin
			C = A ^ B; // No flags
			end
		XORI:
			begin
			C = A ^ {8'b0 , B[7:0]}; // No flags
			end
		MOV:
			begin
			C = B; 
			end
		MOVI:
			begin
			C = {8'b0 , B[7:0]}; // Zero extended Imm
			end
		LSH: // Logical Shift
			begin
			C = A << B; // Need to check if B is weird?
			end
		LSHI:
			begin
			if(Opcode[0] == 1'b0)
				begin
				C = A << B;
				end
			else
				begin
				C = A <<< B;
				end
			end
			/*
		ASHU: // Arithmetic Left Shift
			begin
			C = A <<< B;
			end
		ASHUI:
			begin
			C = A <<< B;
			end
			*/
		LUI:
			begin
			C = {B [7:0], 8'b0}; // Load & 8 bit left shift
			end
//		LOAD:
//			begin
//       // Get memory[Addr]?
//			C = mem[B]; // ???
//			end
//    STOR:
//			begin
//       // Place
//			// mem[A] = B; ???
//			end
//		Bcond:
//			begin
//       // A = COND
//       // 
//			PC - $signed(
//			end
//		Jcond:
//			begin
//			end
//		JAL:
//			begin
//			end
			
		default:
			begin
				C = 16'b0;
				Flags = 5'b0;
			end		
			
		endcase
	end



endmodule
