`timescale 1ns / 1ps

module tblab2_demo;


reg clk, rst;

wire [4:0] Flags;

wire [0:6] hex1, hex2, hex3, hex4; // HEX5, HEX3, HEX2, HEX1, HEX0

always #5 clk = ~clk;

	lab2_demo demo(
		.clk(clk),
		.rst(rst),
		.Flags(Flags),
		.hex1(hex1),
		.hex2(hex2),
		.hex3(hex3),
		.hex4(hex4)
	);
	
	initial 
		begin
			//$monitor("ALUBus: 0x%0h (%0d), regEnable: 0x%0h (%0d), r0: 0x%0h (%0d), r1: 0x%0h (%0d), time:%0d", ALUBus, $signed(ALUBus), regEnable, $signed(regEnable), r0, $signed(r0), r1, $signed(r1), $time );
			
			//Initialize Inputs
			
			clk = 0;
			rst = 0;
			
			#2;
			rst= 1;
			#10;
			rst = 0;
			#10;
			
			#10;
			#10;
			#10;
			
			end
			
endmodule
	
