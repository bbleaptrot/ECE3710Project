module lab4(clk, rst, PCen, RegEn, IRen);
input clk, rst;
output PCen, IRen;
output [15:0] RegEn;
wire [15:0] ALUBUS, RsrcOut, RdstOut;
wire [4:0] FLAGS

alu logic(
	.A(RscOut),
	.B(RdstOut),
	.C(ALUBUS),
	.Opcode(),
	.Flags(FLAGS)
);

regfile_2D_memory registers(
	.ALUBus(ALUBUS),
	.r0(ALUBUS),
	.r1(ALUBUS),
	.r2(ALUBUS),
	.r3(ALUBUS),
	.r4(ALUBUS),
	.r5(ALUBUS),
	.r6(ALUBUS),
	.r7(ALUBUS),
	.r8(ALUBUS),
	.r9(ALUBUS),
	.r10(ALUBUS),
	.r11(ALUBUS),
	.r12(ALUBUS),
	.r13(ALUBUS),
	.r14(ALUBUS),
	.r15(ALUBUS),
	.regEnable(RegEn),
	.clk(clk),
	.reset(rst)
);

bram memory(
	.data_a(),
	.data_b(),
	.addr_a(),
	.addr_b(),
	.we_a(),
	.we_b(),
	.clk(),	
	.q_a(),
	.q_b()
);

mux Rsrc(
	.r0(ALUBUS),
	.r1(ALUBUS),
	.r2(ALUBUS),
	.r3(ALUBUS),
	.r4(ALUBUS),
	.r5(ALUBUS),
	.r6(ALUBUS),
	.r7(ALUBUS),
	.r8(ALUBUS),
	.r9(ALUBUS),
	.r10(ALUBUS),
	.r11(ALUBUS),
	.r12(ALUBUS),
	.r13(ALUBUS),
	.r14(ALUBUS),
	.r15(ALUBUS),
	.S_in(),
	.mux_out(RsrcOut)
);

mux Rdest(
	.r0(ALUBUS),
	.r1(ALUBUS),
	.r2(ALUBUS),
	.r3(ALUBUS),
	.r4(ALUBUS),
	.r5(ALUBUS),
	.r6(ALUBUS),
	.r7(ALUBUS),
	.r8(ALUBUS),
	.r9(ALUBUS),
	.r10(ALUBUS),
	.r11(ALUBUS),
	.r12(ALUBUS),
	.r13(ALUBUS),
	.r14(ALUBUS),
	.r15(ALUBUS),
	.S_in(),
	.mux_out(RdstOut)
);


mux_2_to_1 RegOrImm(
	.r0(RdstOut),
	.r1(),
	.S_in(),
	.mux_out()
);

program_counter counter(
	.PCen(),
	.incrementor(),
	.counter()
);

incrementor PCinc(
	.program_count(),
	.incremented_count()
);


fsm state_machine(
	.clk(),
	.rst(),
	.PCen(),
	.Ren(),
	.RegOrImm()
);
endmodule