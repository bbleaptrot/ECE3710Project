module flags_register(flagEn, flags_in, flags_out, clk, rst);
input flagEn, clk, rst;
input [4:0] flags_in;
output reg[4:0] flags_out = 5'b0;


always@(posedge clk)
begin
	if(rst) flags_out = 5'b0;
	else if(flagEn) flags_out <= flags_in;
	else       flags_out <= flags_out;
end

endmodule 
