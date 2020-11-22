/*
 * VGA attempt #4 - Draw a specific sprite on the screen.
 * Only a little more and we can interface with the computer!
 *
 *
 *
 */
module vga4(clk, rst, hsync, vsync, vga_blank_n, vga_clk, rgb);
	input clk, rst;
	output hsync, vsync;
	output vga_blank_n, vga_clk;
	output [23:0] rgb;
	
	
	/* BRAM - Implement differently for final ram design... */
	// Only really care about port b, and we're only reading.
	wire [15:0] q_a;
	wire [15:0] ram_addr;
	wire [15:0] ram_q;
	
	bram br (.data_a(16'b0), 
				.data_b(16'b0), 	
				.addr_a(16'b0), 
				.addr_b(ram_addr), 
				.we_a(1'b0), 
				.we_b(1'b0), 
				.clk(clk), 
				.q_a(q_a), 
				.q_b(ram_q)
				);
	
	
	/* Control */
	wire [9:0] hcount, vcount;
	
	vga_control control (.clk(clk), 
								.rst(rst),
								.hsync(hsync),
								.vsync(vsync),
								.vga_blank_n(vga_blank_n),
								.vga_clk(vga_clk),
								.hcount(hcount),
								.vcount(vcount)
								);	
	
	/* Generator */
	wire [23:0] pixel_out;
	address_generator addr_gen (.clk(clk), 
										 .vga_blank_n(vga_blank_n), 
										 .hcount(hcount), 
										 .vcount(vcount), 
										 .ram_q(ram_q), 
										 .ram_addr(ram_addr), 
										 .pixel_out(pixel_out)
										 );
	
	
	/* bitgen */	
	wire px_en;
	bitgen4 bgen (.vga_blank_n(vga_blank_n), 
					  .pixel_en(1'b1), 
					  .fg_pixel(pixel_out), 
					  .bg_pixel(24'h32174D), 
					  .rgb(rgb)
					  );
endmodule
