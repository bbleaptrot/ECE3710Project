module mobile_receiver(in_0, in_1, in_2, in_3, in_4, in_5, in_6,in_7, out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7);

	input in_0, in_1, in_2, in_3, in_4, in_5, in_6,in_7;
	output reg out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7;
	initial
	begin
		out_0 = 0;
		out_1 = 0;
		out_2 = 0;
		out_3 = 0;
		out_4 = 0;
		out_5 = 0;
		out_6 = 0;
		out_7 = 0;
		end
		
	always@(in_0, in_1, in_2, in_3, in_4, in_5, in_6,in_7)
	begin
		out_0 <= in_0;
		out_1 <= in_1;
		out_2 <= in_2;
		out_3 <= in_3;
		out_4 <= in_4;
		out_5 <= in_5;
		out_6 <= in_6;
		out_7 <= in_7;
	end
	
endmodule