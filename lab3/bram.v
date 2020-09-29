// Quartus Prime Verilog Template
// True Dual Port RAM with single clock

module bram
#(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=10)
(
	input [(DATA_WIDTH-1):0] data_a, data_b,
	input [(ADDR_WIDTH-1):0] addr_a, addr_b,
	input we_a, we_b, clk,
	output reg [(DATA_WIDTH-1):0] q_a, q_b
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	integer i;
	initial
	begin
		for(i=0;i<2**ADDR_WIDTH;i=i+1)
			ram[i] = 0; // Make everything a safe value.
	end

	// Port A 
	always @ (posedge clk)
	begin
		if (we_a) 
		begin
			ram[addr_a] <= data_a;
			q_a <= data_a;
		end
		else 
		begin
			q_a <= ram[addr_a];
		end 
	end 

	// Port B 
	always @ (posedge clk)
	begin
		if (we_b) 
		begin
			ram[addr_b] <= data_b;
			q_b <= data_b;
		end
		else 
		begin
			q_b <= ram[addr_b];
		end 
	end

endmodule

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
		if(clk_1Hz == 0)
			clk_1Hz <= 1;
		else
			clk_1Hz <= 0;
		end
	else begin
		count <= count + 1'b1;
		clk_1Hz <= clk_1Hz;
		end
//count <= count + 1'b1;
end
endmodule
