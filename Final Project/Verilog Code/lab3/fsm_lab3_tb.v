module fsm_lab3_tb;

	reg clk, rst;
 
 wire we_a, we_b;
 wire [15:0] data_a, data_b;
 wire [9:0] addr_a, addr_b;
 
 FSM UUT (
	.clk(clk),
	.rst(rst),
	.we_a(we_a),
	.we_b(we_b),
	.data_a(data_a),
	.data_b(data_b),
	.addr_a(addr_a),
	.addr_b(addr_b)
 );
 
 initial 
	begin
		clk = 1'b0;
		rst = 1'b1;
		#10;
		
		rst = 1'b0; // reset has been pushed.
		
		#10;
		
		
		#1000;
		
		$display("%0h %0h %0h %0h", we_a, we_b, data_a, data_b);
		
		$finish;
		
	
	end
	
	always 
		#5 clk = !clk; // Simulate clock.
		

endmodule