/*
 * Third attempt VGA - Draw a static glyph.
 * It works. BUT Timing isn't the best, so watch out for that. It needs more work.
 *
 */
module bitgen3 (clk, rst, vga_blank_n, hcount, vcount, rgb);
	input clk, rst;
	input vga_blank_n;
	input [9:0] hcount, vcount;
	output reg [23:0] rgb;
	
	wire [9:0] x_pos, y_pos;
	assign x_pos = hcount - 10'd158;
	assign y_pos = vcount;
	
	reg [7:0] addr;
	wire [23:0] glyph_pixel;
	glyph_rom glyphs (clk, addr, glyph_pixel);
	
	always@(posedge clk) begin
		if(rst) addr = 8'h00;
		rgb = 24'h000000;
		
		if(vga_blank_n) begin
			// Range to draw glyph
			if(x_pos >= 100 && x_pos < 108 && y_pos >= 100 && y_pos < 108) begin
				rgb = glyph_pixel;
				addr = (y_pos % 10'd10) * 8 + (x_pos % 10'd10);
			end
		end
			
	end
endmodule
