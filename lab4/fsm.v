module fsm(clk, rst, instruction, branch, jump, FLAGS, PCen, Ren, RegOrImm, WE, IEn, ALU_MUX_CNTL, LS_CNTL);
input clk, rst;
input [15:0] instruction;
input [4:0] FLAGS;
output PCen, RegOrImm, WE, ALU_MUX_CNTL, LS_CNTL, branch, jump, IEn;
output [15:0] Ren;

endmodule