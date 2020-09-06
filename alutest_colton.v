`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:25:01 08/30/2011
// Design Name:   alu
// Module Name:   C:/Documents and Settings/Administrator/ALU/alutest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alutest_colton;

	// Inputs
	reg [15:0] A;
	reg [15:0] B;
	reg [7:0] Opcode;

	// Outputs
	wire [15:0] C;
	wire [4:0] Flags;

	integer i;
	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.A(A), 
		.B(B), 
		.C(C), 
		.Opcode(Opcode), 
		.Flags(Flags)
	);

	initial begin
			$monitor("A: %0d, B: %0d, C: %0d, Flags[4:0]: %b, time:%0d", $signed(A), $signed(B), $signed(C), Flags[4:0], $time );
//Instead of the $display stmt in the loop, you could use just this
//monitor statement which is executed everytime there is an event on any
//signal in the argument list.

		// Initialize Inputs
		A = 0;
		B = 0;
		Opcode = 8'b00000101; // ADD

	
		//Random simulation
		for( i = 0; i< 50; i = i+ 1)
		begin
			#10
			A = $random % 65536;
			B = $random % 65536;
			//$display("A: %0d, B: %0d, C: %0d, Flags[1:0]: %b, time:%0d", A, B, C, Flags[1:0], $time );
		end
		#100
		
		A = 0;
		B = 0;
		Opcode = 8'b01010000; // ADDI
		for( i = 0; i< 50; i = i+ 1)
		begin
			#10
			A = $random % 65536;
			B = $random % 65536;
			#10
			$display("A: %0d, B: %0d, C: %0d, Flags[4:0]: %b, time:%0d", A, B, C, Flags[4:0], $time );
		end
		
		$finish(2);
		
		// Add stimulus here

	end
      
endmodule

