module lab4(clk_in, rst, seg_4, seg_3, seg_2, seg_1, in_0, in_1, in_2, in_3, in_4, in_5, in_6,in_7, hsync, vsync, vga_blank_n, vga_clk, rgb);
//Inputs
input clk_in, rst;

input in_0, in_1, in_2, in_3, in_4, in_5, in_6,in_7;
//outputs
output[0:6] seg_4, seg_3, seg_2, seg_1;

//Registers
wire[15:0] BUS, Ren, r0_out, r1_out, r2_out, r3_out, r4_out, r5_out, r6_out, r7_out;
wire[15:0] r8_out, r9_out, r10_out, r11_out, r12_out, r13_out, r14_out, r15_out;

//Muxes
wire[15:0] srcMux_out, dstMux_out, immMux_out, ALUMux_out, phone_mux_out; 

//ALU
wire[4:0] Flags;
wire[15:0] ALU_out;

//BRAM
wire[15:0] data_a, data_b, addr_a, addr_b, q_a, q_b;
wire we_a, we_b;

//IRreg
wire IEn;
wire[3:0] RsrcOut, RdstOut;
wire[7:0] Opcode, bDisp, ImmOut;
wire[15:0] MemOut;


//Program Counter
wire[15:0] PCOut;

//FSM
wire branch, jump, RorI, ALUorData, LS_cntl, WE, PCen, phone;

//Flags_register
wire flagEn;
wire [4:0] flags_for_fsm;

//Clk_divider
//wire clk;
wire clk = clk_in;

//IO from phone
wire phone_in;
wire out_0;
wire out_1;
wire out_2;
wire out_3;
wire out_4;
wire out_5;
wire out_6;
wire out_7;

//VGA
output hsync, vsync, vga_blank_n, vga_clk;
output [23:0] rgb;

regfile_2D_memory registers(
	.ALUBus(phone_mux_out),
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
	.regEnable(Ren),
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
		.S_in(RsrcOut),
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
		.S_in(RdstOut),
		.mux_out(dstMux_out)
);
	
	mux_2_to_1 immMux(
		.r0(dstMux_out),
		.r1({{8{ImmOut[7]}}, ImmOut}),
		.S_in(RorI), // FSM
		.mux_out(immMux_out)
);

	mux_2_to_1 LScntl(
		.r0(dstMux_out),
		.r1(PCOut),
		.S_in(LS_cntl), // FSM
		.mux_out(addr_a)
	);
	
	alu logicBox(
		.A(srcMux_out),
		.B(immMux_out),
		.C(ALU_out),
		.Opcode(Opcode),
		.Flags(Flags)
);
	
	mux_2_to_1 ALUcntl(
		.r0(ALU_out),
		.r1(q_a),
		.S_in(ALUorData), // FSM
		.mux_out(BUS)
	
	);
	
	mux_2_to_1 phoneCntl(
		.r0(BUS),
		.r1({8'b0, out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7}),
		.S_in(phone_in), // FSM
		.mux_out(phone_mux_out)
	
	);
	
	bram memory(
	.data_a(srcMux_out),
	.data_b(data_b), // VGA Stuff
	.addr_a(addr_a),
	.addr_b(addr_b), // VGA Stuff
	.we_a(WE),   // FSM
	.we_b(),   // VGA Stuff
	.clk(clk),
	.q_a(q_a),
	.q_b(q_b)    // VGA Stuff
	);
	
	program_counter prog_count(
	.clk(clk),
	.reset(rst),
	.branch(branch),  // FSM
	.jump(jump),    // FSM
	.PCen(PCen),    // FSM
	.b_offset(bDisp),
	.j_target(srcMux_out),
	.PC(PCOut)
	);
	
	IRreg Instr_Reg(
	.clk(clk),
	.rst(rst),
	.dataIn(q_a),
	.IEn(IEn),
	.Opcode(Opcode),
	.RsrcOut(RsrcOut),
	.RdstOut(RdstOut),
	.ImmOut(ImmOut),
	.bDisp(bDisp),
	.instruction(MemOut)
	);
	
	fsm state_machine(
	.clk(clk),
	.rst(rst),
	.instruction(MemOut),
	.branch(branch),
	.jump(jump),
	.FLAGS(flags_for_fsm),
	.PCen(PCen),
	.Ren(Ren),
	.IEn(IEn),
	.RegOrImm(RorI),
	.WE(WE),
	.ALU_MUX_CNTL(ALUorData),
	.LS_CNTL(LS_cntl),
	.flagEn(flagEn),
	.data_from_mem(q_a),
	.phoneEn(phone_in)
	);
	
	flags_register flags(
	.flagEn(flagEn),
	.flags_in(Flags),
	.flags_out(flags_for_fsm),
	.clk(clk),
	.rst(rst)
	);
	
//	clk_divider clock(
//	.clk_50MHz(clk_in),
//	.rst(rst),
//	.clk_1Hz(clk)
//	);
	
	mobile_receiver phoneoneon(
	.in_0(in_0),
	.in_1(in_1),
	.in_2(in_2),
	.in_3(in_3),
	.in_4(in_4),
	.in_5(in_5),
	.in_6(in_6),
	.in_7(in_7),
	.out_0(out_0),
	.out_1(out_1),
	.out_2(out_2),
	.out_3(out_3),
	.out_4(out_4),
	.out_5(out_5),
	.out_6(out_6),
	.out_7(out_7)
	);	
	
	vga screener(
	.clk(clk),
	.rst(rst),
	.addr_b(addr_b),
	.q_b(q_b),
	.hsync(hsync),
	.vsync(vsync),
	.vga_blank_n(vga_blank_n),
	.vga_clk(vga_clk),
	.rgb(rgb)
	);
	

	
//	hex2seg seg4(r0_out[15:12], seg_4);
//	hex2seg seg3(r0_out[11:8], seg_3);
//	hex2seg seg2(r0_out[7:4], seg_2);
//	hex2seg seg1(r0_out[3:0], seg_1);

//	hex2seg seg4(r1_out[15:12], seg_4);
//	hex2seg seg3(r1_out[11:8], seg_3);
//	hex2seg seg2(r1_out[7:4], seg_2);
//	hex2seg seg1(r1_out[3:0], seg_1);
	
//	hex2seg seg4(r2_out[15:12], seg_4);
//	hex2seg seg3(r2_out[11:8], seg_3);
//	hex2seg seg2(r2_out[7:4], seg_2);
//	hex2seg seg1(r2_out[3:0], seg_1);

//	hex2seg seg4(r3_out[15:12], seg_4);
//	hex2seg seg3(r3_out[11:8], seg_3);
//	hex2seg seg2(r3_out[7:4], seg_2);
//	hex2seg seg1(r3_out[3:0], seg_1);

//	hex2seg seg4(r4_out[15:12], seg_4);
//	hex2seg seg3(r4_out[11:8], seg_3);
//	hex2seg seg2(r4_out[7:4], seg_2);
//	hex2seg seg1(r4_out[3:0], seg_1);

//	hex2seg seg4(r5_out[15:12], seg_4);
//	hex2seg seg3(r5_out[11:8], seg_3);
//	hex2seg seg2(r5_out[7:4], seg_2);
//	hex2seg seg1(r5_out[3:0], seg_1);

//	hex2seg seg4(r6_out[15:12], seg_4);
//	hex2seg seg3(r6_out[11:8], seg_3);
//	hex2seg seg2(r6_out[7:4], seg_2);
//	hex2seg seg1(r6_out[3:0], seg_1);

//	hex2seg seg4(r7_out[15:12], seg_4);
//	hex2seg seg3(r7_out[11:8], seg_3);
//	hex2seg seg2(r7_out[7:4], seg_2);
//	hex2seg seg1(r7_out[3:0], seg_1);

//	hex2seg seg4(r8_out[15:12], seg_4);
//	hex2seg seg3(r8_out[11:8], seg_3);
//	hex2seg seg2(r8_out[7:4], seg_2);
//	hex2seg seg1(r8_out[3:0], seg_1);

//	hex2seg seg4(r9_out[15:12], seg_4);
//	hex2seg seg3(r9_out[11:8], seg_3);
//	hex2seg seg2(r9_out[7:4], seg_2);
//	hex2seg seg1(r9_out[3:0], seg_1);

//	hex2seg seg4(r10_out[15:12], seg_4);
//	hex2seg seg3(r10_out[11:8], seg_3);
//	hex2seg seg2(r10_out[7:4], seg_2);
//	hex2seg seg1(r10_out[3:0], seg_1);

//	hex2seg seg4(r11_out[15:12], seg_4);
//	hex2seg seg3(r11_out[11:8], seg_3);
//	hex2seg seg2(r11_out[7:4], seg_2);
//	hex2seg seg1(r11_out[3:0], seg_1);

	hex2seg seg4(r12_out[15:12], seg_4);
	hex2seg seg3(r12_out[11:8], seg_3);
	hex2seg seg2(r12_out[7:4], seg_2);
	hex2seg seg1(r12_out[3:0], seg_1);

//	hex2seg seg4(r13_out[15:12], seg_4);
//	hex2seg seg3(r13_out[11:8], seg_3);
//	hex2seg seg2(r13_out[7:4], seg_2);
//	hex2seg seg1(r13_out[3:0], seg_1);

//	hex2seg seg4(r14_out[15:12], seg_4);
//	hex2seg seg3(r14_out[11:8], seg_3);
//	hex2seg seg2(r14_out[7:4], seg_2);
//	hex2seg seg1(r14_out[3:0], seg_1);

//	hex2seg seg4(r15_out[15:12], seg_4);
//	hex2seg seg3(r15_out[11:8], seg_3);
//	hex2seg seg2(r15_out[7:4], seg_2);
//	hex2seg seg1(r15_out[3:0], seg_1);

//	hex2seg seg4(Opcode[7:4], seg_4);
//	hex2seg seg3(RdstOut, seg_3);
//	hex2seg seg2(Opcode[3:0], seg_2);
//	hex2seg seg1(RsrcOut, seg_1);

//	hex2seg seg4(Opcode[7:4], seg_4);
//	hex2seg seg3(RdstOut, seg_3);
//	hex2seg seg2(Opcode[3:0], seg_2);
//	hex2seg seg1(RsrcOut, seg_1);


endmodule
