module lab4(clk, rst);
//Inputs
input clk, rst;

//Registers
wire[15:0] BUS, Ren, r0_out, r1_out, r2_out, r3_out, r4_out, r5_out, r6_out, r7_out;
wire[15:0] r8_out, r9_out, r10_out, r11_out, r12_out, r13_out, r14_out, r15_out;

//Muxes
wire[15:0] srcMux_out, dstMux_out, immMux_out, ALUMux_out; 

//ALU
wire[4:0] Flags;
wire[15:0] ALU_out;

//BRAM
wire[15:0] data_a, data_b, addr_a, addr_b, q_a, q_b;
wire we_a, we_b;

//IRreg
wire IEn;
wire[3:0] RsrcOut, RdstOut, ImmOut;
wire[7:0] Opcode, bDisp;
wire[15:0] MemOut;


//Program Counter
wire[15:0] PCOut;

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
		.r1(ImmOut),
		.S_in(), // FSM
		.mux_out(immMux_out)
);

	mux_2_to_1 LScntl(
		.r0(dstMux_out),
		.r1(PCOut),
		.S_in(), // FSM
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
		.r1(MemOut),
		.S_in(), // FSM
		.mux_out(BUS)
	
	);
	
	bram memory(
	.data_a(srcMux_out),
	.data_b(), // VGA Stuff
	.addr_a(addr_a),
	.addr_b(), // VGA Stuff
	.we_a(),   // FSM
	.we_b(),   // VGA Stuff
	.clk(clk),
	.q_a(q_a),
	.q_b()    // VGA Stuff
	);
	
	program_counter prog_count(
	.clk(clk),
	.reset(rst),
	.branch(),  // FSM
	.jump(),    // FSM
	.PCen(),    // FSM
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
	.MemOut(MemOut),
	.bDisp(bDisp)
	);
endmodule