module clk_divider(clk_50MHz, rst, clk_1Hz);

	input clk_50MHz, rst;
	output reg clk_1Hz;
	reg [24:0] count;
	
	always@(posedge clk_50MHz) begin
	if(rst == 1) begin
			count <= 25'd0;
		if(clk_1Hz == 0)
			clk_1Hz <= 1;
		else
			clk_1Hz <= 0;
		end
	else if(count == 25000000) begin
		count <= 25'd0;
		clk_1Hz <= ~clk_1Hz;
		end
	else begin
		count <= count + 1'b1;
		clk_1Hz <= clk_1Hz;
	end

end

endmodule