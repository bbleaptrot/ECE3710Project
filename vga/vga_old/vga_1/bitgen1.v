/*
 * First attempt VGA bitgen - Make the entire screen one color.
 * Can output 2^9 ~ 512 colors. Most look decent enough.
 * 
 *
 * inputs:
 *    vga_blank_n - "bright" signal meaning we're drawing to the screen.
 * 	sw - switches on the board. The 3 most significant control red, 
 *											 the next 3 control green,
 *											 the final 3 control blue.
 *
 * outputs:
 *		r - 8-bit signal representing the intensity of red.  
 *		g - 8-bit signal representing the intensity of green.
 *		b - 8-bit signal representing the intensity of blue.
 */
module bitgen1 (vga_blank_n, sw, r, g, b);
	input vga_blank_n; // bright
	input [8:0] sw; // switches 8-0
	output reg [7:0] r, g, b;
	
	always@(*) begin
		if(vga_blank_n) begin
			r = {sw[8], sw[7], {6{sw[6]}}};
			g = {sw[5], sw[4], {6{sw[3]}}};
			b = {sw[2], sw[1], {6{sw[0]}}};
		end
		
		else begin
			r = 8'd0;
			g = 8'd0;
			b = 8'd0;
		end
	end
	
endmodule
