module glyph_rom (clk, addr, glyph_pixel);
	input clk;
	input [7:0] addr;
	output reg [23:0] glyph_pixel;
	
	reg [23:0] glyph_rom [0:63];
	
	initial begin
		$readmemh("C:\\intelFPGA_lite\\3710_lab\\vga_1\\glyph.txt", glyph_rom);
	end
	
	always@(clk)	glyph_pixel <= glyph_rom[addr];
		
endmodule
