/*
 * Simple 16 to 1 multiplexer for Group 9.
 *
 */
module mux(r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, S_in, mux_out);

input [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15; 

input [3:0] S_in; // Select in

output reg [15:0] mux_out; 

always @*
	begin
		case (S_in) 
			4'd0: mux_out = r0; 
			4'd1: mux_out = r1; 
			4'd2: mux_out = r2; 
			4'd3: mux_out = r3; 
			4'd4: mux_out = r4; 
			4'd5: mux_out = r5; 
			4'd6: mux_out = r6; 
			4'd7: mux_out = r7; 
			4'd8: mux_out = r8; 
			4'd9: mux_out = r9; 
			4'd10: mux_out = r10; 
			4'd11: mux_out = r11; 
			4'd12: mux_out = r12; 
			4'd13: mux_out = r13; 
			4'd14: mux_out = r14; 
			4'd15: mux_out = r15; 			
		endcase
	end
endmodule 
	
