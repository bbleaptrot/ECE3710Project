/*
 * Fourth attempt VGA bitgen. 
 * Given a foreground and background pixel, display the correct pixel on the screen. 
 * 
 *
 *
 */
module bitgen (vga_blank_n, hcount, vcount, pixel_en, fg_pixel, bg_pixel, rgb);
	input vga_blank_n;
	input [9:0] hcount, vcount;
	input pixel_en;
	input [23:0] fg_pixel;
	input [23:0] bg_pixel;
	
	output reg [23:0] rgb;
	
	always@(*)
		if(vga_blank_n) 
			if(pixel_en) 
				if(fg_pixel == 24'h000000) rgb = bg_pixel;
				else rgb = fg_pixel;
			else rgb = bg_pixel;
		else rgb = 24'h000000;

endmodule
