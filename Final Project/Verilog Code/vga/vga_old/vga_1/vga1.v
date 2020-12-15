module vga1(clk, rst, hsync, vsync, vga_blank_n, vga_clk, sw, r, g, b);
	input clk, rst;
	input [8:0] sw;
	output hsync, vsync;
	output vga_blank_n, vga_clk;
	//output [9:0] hcount, vcount;
	output [7:0] r, g, b;
	
	wire [9:0] hcount, vcount;
	
	vga_control control (clk, rst, hsync, vsync, vga_blank_n, vga_clk, hcount, vcount);
	bitgen1 bitgen1 (vga_blank_n, sw, r, g, b);
endmodule
