`timescale 1ns / 1ps
/*
 * Simple test bench for ram module.
 * Inputs data, into ram, then prints that data.
 *
 * September 29, 2020
 *
 */
module bram_tb;

  reg clk;
  reg we_a, we_b;
  reg [15:0] data_a, data_b;
  reg [9:0] addr_a, addr_b;

  wire [15:0] q_a, q_b;
  
  integer i;
  
  bram UUT(
		.data_a(data_a), 
		.data_b(data_b), 
		.addr_a(addr_a), 
		.addr_b(addr_b), 
		.we_a(we_a), 
		.we_b(we_b), 
		.clk(clk), 
		.q_a(q_a), 
		.q_b(q_b)
		);
		
	

  initial 
  begin
  
	$monitor("q_a: %0d, q_b: %0d, time: %0d", q_a, q_b, $time); 
  
  
	clk = 1'b0;
	we_a = 1'b0;
	we_b = 1'b0;
	data_a = 16'b0;
	data_b = 16'b0;
	addr_a = 10'b0;
	addr_b = 10'b0;
	
	#10;
	
	we_a = 1'b1;
	we_b = 1'b0;
	
	for(i = 0; i < 32; i=i+1)
	begin
		data_a = i;
		addr_a = i;
		#10;
	end
	
	addr_a = 10'b0;
	addr_b = 10'b0;
	
	we_a = 1'b0;
	we_b = 1'b1;
	#10;
	
	for(i = 32; i < 64; i=i+1)
	begin
		data_b = i;
		addr_b = i;
		#10;
	end
	
	addr_a = 10'b0;
	addr_b = 10'b0;
	
	we_a = 1'b0;
	we_b = 1'b0;
	
	#10;
	
	for(i = 510; i < 514; i=i+1)
	begin
		addr_a = i;
		addr_b = i;
		#10;
	end
	
	
	#100;
	$finish;
  
  
  end
  
  always
	#5 clk = !clk;
  
  

endmodule
