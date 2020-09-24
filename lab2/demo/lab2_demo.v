`timescale 1ns / 1ps
module lab2_demo(clk, rst, hex1, hex2, hex3, hex4, Flags);

input clk, rst;

reg [3:0] h1, h2, h3, h4, h5;

output [4:0] Flags;

output [0:6] hex1, hex2, hex3, hex4; // HEX5, HEX3, HEX2, HEX1, HEX0

wire[15:0] rEnable, BUS, r0_out, r1_out, r2_out, r3_out, r4_out, r5_out, r6_out, r7_out, r8_out, r9_out, r10_out, r11_out, r12_out, r13_out, r14_out, r15_out;

wire[15:0] srcMux_out, dstMux_out, immMux_out;

wire[3:0]  srcMux, dstMux; 

wire immMux;

wire[7:0] ALUcodes;

//wire [3:0] h1, h2, h3, h4, h5;

wire FlagEn;

	hex2seg hx1 (.hex(r8_out[15:12]), .seg(hex1));
	hex2seg hx2 (.hex(r8_out[11:8]), .seg(hex2));
	hex2seg hx3 (.hex(r8_out[7:4]), .seg(hex3));
	hex2seg hx4 (.hex(r8_out[3:0]), .seg(hex4));


	FSM fib(
		.clk(clk),
		.rst(rst),
		.R_en(rEnable),
		.R_src(srcMux),
		.R_dest(dstMux),
		.R_or_I(immMux),
		.ALU_op(ALUcodes),
		.Flag_en(FlagEn)
	);
	
	regfile_2D_memory registers(
		.ALUBus(BUS),
		.r0(r0_out),
		.r1(r1_out),
		.r2(r2_out),
		.r3(r3_out),
		.r4(r4_out),
		.r5(r5_out),
		.r6(r6_out),
		.r7(r7_out),
		.r8(r8_out),
		.r9(r9_out),
		.r10(r10_out),
		.r11(r11_out),
		.r12(r12_out),
		.r13(r13_out),
		.r14(r14_out),
		.r15(r15_out),
		.regEnable(rEnable),
		.clk(clk),
		.reset(rst)
	);
	
	mux muxSrc(
		.r0(r0_out),
		.r1(r1_out),
		.r2(r2_out),
		.r3(r3_out),
		.r4(r4_out),
		.r5(r5_out),
		.r6(r6_out),
		.r7(r7_out),
		.r8(r8_out),
		.r9(r9_out),
		.r10(r10_out),
		.r11(r11_out),
		.r12(r12_out),
		.r13(r13_out),
		.r14(r14_out),
		.r15(r15_out),
		.S_in(srcMux),
		.mux_out(srcMux_out)
		);
	
	mux muxDst(
		.r0(r0_out),
		.r1(r1_out),
		.r2(r2_out),
		.r3(r3_out),
		.r4(r4_out),
		.r5(r5_out),
		.r6(r6_out),
		.r7(r7_out),
		.r8(r8_out),
		.r9(r9_out),
		.r10(r10_out),
		.r11(r11_out),
		.r12(r12_out),
		.r13(r13_out),
		.r14(r14_out),
		.r15(r15_out),
		.S_in(dstMux),
		.mux_out(dstMux_out)
	);
	
	mux_2_to_1 immBoiii(
		.r0(dstMux_out),
		.r1(16'd1),
		.S_in(immMux),
		.mux_out(immMux_out)
	);
	
	alu awhooo(
		.A(srcMux_out),
		.B(immMux_out),
		.C(BUS),
		.Opcode(ALUcodes),
		.Flags(Flags)
	);

endmodule 