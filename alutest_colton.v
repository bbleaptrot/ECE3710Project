`timescale 1ns / 1ps

/*
 * Colton's ALU tests
 * Last updated: September 7, 2020
 *
 */

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

	initial 
		begin
		
		$monitor("A: %0d, B: %0d, C: %0d, Flags[4:0]: %b, time:%0d", $signed(A), $signed(B), $signed(C), Flags[4:0], $time );


		// Initialize Inputs
		A = 0;
		B = 0;
		Opcode = 8'b00000101; // ADD
		
		
		$display("\nTesting ADD instruction\n");
		
		#10;
	
		//Random simulation
		for( i = 0; i< 10; i = i + 1)
		begin
			#10;
			A = $random % 65536;
			B = $random % 65536;
		end
		
		
		$display("\nTesting ADDI instruction\n");
		#100;
		
		A = 0;
		B = 0;
		Opcode = 8'b01010000; // ADDI
		
		#10;
		
		
		
		// Try to get overflow flag.
		// It seems to work, uncomment to see full output
		/*
		A = 16'hFFFF; // -1
		
		for( i = 0; i< 257; i = i+1)
		begin
		  B = i;
		  #10;
		end
		
		#10	
		
		A = 16'h8000; // -32768
		
		for( i = 0; i< 257; i = i+1)
		begin
		  B = i;
		  #10;
		end
		
		#10		
		
		A = 16'h7FFF; // 32767
		
		for( i = 0; i< 257; i = i+1)
		begin
		  B = i;
		  #10;
		end
		
		*/
		
		$display("\nTesting SUB instruction\n");
		#100;
		
		A = 0;
		B = 0;
		Opcode = 8'b00001001; // SUB
		
		#10;
		
		// 0 - 1 = -1, set borrow flag
		A = 0;
		B = 1;
		
		#10;		
		
		//Random simulation
		for( i = 0; i< 10; i = i + 1)
		begin
			A = $random % 65536;
			B = $random % 65536;
			#10;
		end
		
		
		$display("\nTesting SUBI instruction\n");
		#100;
		
		A = 0;
		B = 0;
		Opcode = 8'b10010000; // SUBI
		
		#10;
		
		// 0 - 1 = -1, set borrow flag
		A = 0;
		B = 1;
		
		#10;	
	
		// Test overflow
		A = 16'h7FFF; // +32767
		B = -1;
		
		#10
		
	
		A = 16'h8000; // -32768
		B = 1;
		
		#10
		
		//Random simulation
		for( i = 0; i< 10; i = i + 1)
		begin
			A = $random % 65536;
			B = $random % 256;
			#10;
		end
		
		
		$display("\nTesting CMP instruction\n");
		#100;
		
		A = 0;
		B = 0;
		Opcode = 8'b00001011; // CMP
		
		#10
		
		//Random simulation
		for( i = 0; i< 10; i = i + 1)
		begin
			A = $random % 65536;
			B = $random % 65536;
			#10;
		end
		
		$display("\nTesting CMPI instruction\n");
		#100;
		
		A = 0;
		B = 0;
		Opcode = 8'b10110000; // CMPI
		
		#10
		
		// Low flag
		A = 10;
		B = 20;
		
		#10
		
		
		//Random simulation
		for( i = 0; i< 10; i = i + 1)
		begin
			A = $random % 65536;
			B = $random % 256;
			#10;
		end
		
		$display("\nTesting AND instruction\n");
		#100;
		
		A = 0;
		B = 0;
		Opcode = 8'b00000001; // AND
		
		#10
		
		//Random simulation
		for( i = 0; i< 10; i = i + 1)
		begin
			A = $random % 65536;
			B = $random % 65536;
			#10;
		end
		
		
		$display("\nTesting ANDI instruction\n");
		#100;
		
		A = 0;
		B = 0;
		Opcode = 8'b00010000; // ANDI
		
		#10
		
		
		
		//Random simulation
		for( i = 0; i< 10; i = i + 1)
		begin
			A = $random % 65536;
			B = $random % 256;
			#10;
		end
		
		
		
		
		$display("\nTesting OR instruction\n");
		#100;
		
		A = 0;
		B = 0;
		Opcode = 8'b00000010; // OR
		
		#10
		
			//Random simulation
		for( i = 0; i< 10; i = i + 1)
		begin
			A = $random % 65536;
			B = $random % 65536;
			#10;
		end
		
		
		$display("\nTesting ORI instruction\n");
		#100;
		
		A = 0;
		B = 0;
		Opcode = 8'b00100000; // ORI
		
		#10
		
		//Random simulation
		for( i = 0; i< 10; i = i + 1)
		begin
			A = $random % 65536;
			B = $random % 256;
			#10;
		end
		
		$display("\nTesting XOR instruction\n");
		#100;
		
		A = 0;
		B = 0;
		Opcode = 8'b00000011; // XOR
		
		#10
		
			//Random simulation
		for( i = 0; i< 10; i = i + 1)
		begin
			A = $random % 65536;
			B = $random % 65536;
			#10;
		end
		
		
		$display("\nTesting XORI instruction\n");
		#100;
		
		A = 0;
		B = 0;
		Opcode = 8'b0011xxxx; // XORI
		
		#10
		
		//Random simulation
		for( i = 0; i< 10; i = i + 1)
		begin
			A = $random % 65536;
			B = $random % 256;
			#10;
		end
		
		

		
		
		
		$finish(2);
		
		// Add stimulus here

	end
      
endmodule

