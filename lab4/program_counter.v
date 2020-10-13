module program_counter(PCen, incrementor, counter);
input PCen, incrementor;
output [15:0] counter;
endmodule



module incrementor(program_count, incremented_count);
input [15:0] program_count;
output[15:0] incremented_count;



endmodule


module fsm(clk, rst, PCen,Ren, RegOrImm);
	input clk, rst;
	output PCen, RegOrImm;
	output [15:0] Ren;

endmodule