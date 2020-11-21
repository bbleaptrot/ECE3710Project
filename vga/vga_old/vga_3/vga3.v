module vga3(clk, rst, hsync, vsync, vga_blank_n, vga_clk, rgb);
	input clk, rst;
	output hsync, vsync;
	output vga_blank_n, vga_clk;
	output [23:0] rgb;
	
	wire [9:0] hcount, vcount;
	
	vga_control control (clk, rst, hsync, vsync, vga_blank_n, vga_clk, hcount, vcount);	
	bitgen3 bitgen (clk, rst, vga_blank_n, hcount, vcount, rgb);
endmodule
