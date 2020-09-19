

module mux(r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, C_in, A);

input [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15; 

input [3:0] C_in;


output reg [15:0] A; 

always @*
	begin
		case (C_in) 
			4'd0: A = r0; 
			4'd1: A = r1; 
			4'd2: A = r2; 
			4'd3: A = r3; 
			4'd4: A = r4; 
			4'd5: A = r5; 
			4'd6: A = r6; 
			4'd7: A = r7; 
			4'd8: A = r8; 
			4'd9: A = r9; 
			4'd10: A = r10; 
			4'd11: A = r11; 
			4'd12: A = r12; 
			4'd13: A = r13; 
			4'd14: A = r14; 
			4'd15: A = r15; 
			
			
			
				
			
		endcase
	end
endmodule 
	
