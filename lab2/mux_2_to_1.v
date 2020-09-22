/*
 * Simple 2 to 1 multiplexer for Group 9.
 *
 */
module mux_2_to_1(r0, r1, S_in, mux_out);

input [15:0] r0, r1; 

input S_in; // Select in

output reg [15:0] mux_out; 

always @*
	begin
		case (S_in) 
			1'b0: mux_out = r0; 
			1'b1: mux_out = r1; 			
		endcase
	end
endmodule 