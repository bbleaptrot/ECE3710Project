module IRreg(clk, rst, dataIn, IEn, Opcode, RsrcOut, RdstOut, ImmOut, bDisp);
input IEn, clk, rst;
input [15:0] dataIn;

//reg [7:0] Op;

output reg[3:0] RsrcOut, RdstOut;
output reg[7:0] Opcode, bDisp, ImmOut;

parameter LOAD = 8'b01000000; // *

always@(posedge clk)
	begin
		if(rst)begin
			RsrcOut <= 4'b0;
			RdstOut <= 4'b0;
			ImmOut  <= 4'b0;
			Opcode  <= 8'b0;
			bDisp   <= 8'b0;
		end
		else if(IEn)
		begin
			if({dataIn[15:12],dataIn[7:4]} == LOAD) // Load instruction
			begin  
				Opcode[7:4] <= dataIn[15:12];
				Opcode[3:0] <= dataIn[7:4];
				RdstOut     <= dataIn[3:0];
				ImmOut      <= dataIn[7:0];
				RsrcOut     <= dataIn[11:8];
				bDisp[7:4]  <= dataIn[7:4];
				bDisp[3:0]  <= dataIn[3:0];
			end
			else
			begin
				Opcode[7:4] <= dataIn[15:12];
				Opcode[3:0] <= dataIn[7:4];
				RdstOut     <= dataIn[11:8];
				ImmOut      <= dataIn[7:0];
				RsrcOut     <= dataIn[3:0];
				bDisp[7:4]  <= dataIn[7:4];
				bDisp[3:0]  <= dataIn[3:0];
			end
		end
		else
		begin
			Opcode      <= Opcode;
			RdstOut     <= RdstOut;
			ImmOut      <= ImmOut;
			RsrcOut     <= RsrcOut;
			bDisp       <= bDisp;
		end

	end

endmodule