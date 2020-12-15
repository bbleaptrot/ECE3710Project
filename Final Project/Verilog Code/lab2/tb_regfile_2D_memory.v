module tb_regfile_2D_memory;

reg [15:0] ALUBus, regEnable;
reg clk, reset;

wire[15:0] r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15;

always #5 clk = ~clk;

	regfile_2D_memory uut(
	.ALUBus(ALUBus),
	.regEnable(regEnable),
	.clk(clk),
	.reset(reset),
	.r0(r0),
	.r1(r1),
	.r2(r2),
	.r3(r3),
	.r4(r4),
	.r5(r5),
	.r6(r6),
	.r7(r7),
	.r8(r8),
	.r9(r9),
	.r10(r10),
	.r11(r11),
	.r12(r12),
	.r13(r13),
	.r14(r14),
	.r15(r15)
	);
	                       
	initial 
		begin
			$monitor("ALUBus: 0x%0h (%0d), regEnable: 0x%0h (%0d), r0: 0x%0h (%0d), r1: 0x%0h (%0d), time:%0d", ALUBus, $signed(ALUBus), regEnable, $signed(regEnable), r0, $signed(r0), r1, $signed(r1), $time );
			
			//Initialize Inputs
			
			ALUBus = 0;
			regEnable = 0;
			clk = 0;
			reset = 0;
			
			#2;
			reset = 1;
			#10;
			reset = 0;
			#10;
			
			ALUBus = 1;
			regEnable = 16'b0100000000000000;
			#10;
			ALUBus = 15;
			#10;
			reset = 1;
			#10;
			reset = 0;
			#10;
			regEnable = 16'b1000000000000000;
			#10;
			
			end
			
endmodule

	