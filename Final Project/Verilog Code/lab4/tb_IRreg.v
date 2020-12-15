`timescale 1ns / 1ps

module tb_IRreg;
reg IEn, clk, rst;
reg [15:0] dataIn;

//reg [7:0] Op;

wire[3:0] RsrcOut, RdstOut, ImmOut;
wire[7:0] Opcode;

IRreg uut(
	.clk(clk),
	.rst(rst),
	.dataIn(dataIn),
	.IEn(IEn),
	.Opcode(Opcode),
	.RsrcOut(RsrcOut),
	.RdstOut(RdstOut),
	.ImmOut(ImmOut)
);

initial
	begin
	
		$monitor("dataIn: (%0d), Opcode: (%0d), RsrcOut: (%0d), RdstOut: (%0d), ImmOut: (%0d), time:%0d", dataIn, Opcode, RsrcOut, RdstOut, ImmOut, $time);
		
		clk = 0;
		rst = 1;
		IEn = 0;
		dataIn = 0;
		
		#3;
		
		
		rst = 1'b0;
		IEn = 1;
		dataIn = 16'h1234;
		#10;
		
		#100;
		
		$stop;
		
	end
	
	always #5 clk = !clk; 

endmodule