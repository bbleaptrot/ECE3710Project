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
		
		$monitor("A: 0x%0h (%0d), B: 0x%0h (%0d), C: 0x%0h (%0d), Flags[4:0]: %b, time:%0d", A, $signed(A), B, $signed(B), C, $signed(C), Flags[4:0], $time );


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
		Opcode = 8'b0101xxxx; // ADDI
		
		#10;
		
		//Random simulation
		for( i = 0; i< 10; i = i + 1)
		begin
			#10;
			A = $random % 65536;
			B = $random % 256;
		end
		
		
		
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
		Opcode = 8'b1001xxxx; // SUBI
		
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
		Opcode = 8'b1011xxxx; // CMPI
		
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
		Opcode = 8'b0001xxxx; // ANDI
		
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
		Opcode = 8'b001xxxx; // ORI
		
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
		
		
		$display("\nTesting MOV instruction\n");
		#100;
		
		A = 0;
		B = 0;
		Opcode = 8'b00001101; // MOV
		
		//Random simulation
		for( i = 0; i< 10; i = i + 1)
		begin
			A = $random % 65536;
			B = $random % 65536;
			#10;
		end
		
		
		$display("\nTesting MOVI instruction\n");
		#100;
		
		A = 0;
		B = 0;
		Opcode = 8'b1101xxxx; // MOVI
		
		//Random simulation
		for( i = 0; i< 10; i = i + 1)
		begin
			A = $random % 65536;
			B = $random % 256;
			#10;
		end
		
		$display("\nTesting LUI instruction\n");
		#100;
		
		A = 0;
		B = 0;
		Opcode = 8'b1111xxxx; // LUI
		
		//Random simulation
		for( i = 0; i< 10; i = i + 1)
		begin
			A = $random % 65536;
			B = $random % 256;
			#10;
		end
		
		$display("\nTesting LSH instruction\n");
		#100;
		
		A = 0;
		B = 0;
		Opcode = 8'b10000100; // LSH
		#10;
		
		
		// Left shift
		// C should be 0x5656
		A = 16'h2b2b;
		B = 1;
		#10;
		
		// Right shift
		// C should be 0x1595
		A = 16'h2b2b;
		B = -1;
		#10;
		
		// Left shift
		// C should be 0x5554
		A = 16'hAAAA;
		B = 1;
		#10;
		
		// Right shift
		// C should be 0x5555
		A = 16'hAAAA;
		B = -1;
		#10;
		
		
		// Zero shift?
		// Effectively a move: C = A
		A = 16'hFFFF;
		B = 0;
		#10;
		
		// General multiplication
		A = 4;
		B = 5;
		#10;
		
		// General division
		A = 100;
		B = -2;
		#10;
		
		
		//Random simulation
		for( i = 0; i< 10; i = i + 1)
		begin
			A = $random % 65536;
			B = $random % 16;
			#10;
		end
		
		$display("\nTesting LSHI instruction\n");
		#100;
		
		A = 0;
		B = 0;
		// Opcode = 8'b1000000x // LSHI
		// Opcode = 8'b10000000 // left shift
		// Opcode = 8'b10000001 // 2'comp
		Opcode = 8'b10000000; 		
		#10;
		
		//Left shift:
		Opcode = 8'b10000000;
		A = 8;
		B = 2;
		// C = 32
		#10;
		
		//Right shift:
		Opcode = 8'b10000001;
		A = 16'hFFFF;
		B = 16'h000F;
		#10;
		
		
		//Random simulation
		for( i = 0; i< 10; i = i + 1)
		begin
			Opcode[0] = $random % 2;
			$display("\nShift: %0b", Opcode[0]);
			A = $random % 65536;
			B = {12'h000, $random % 16};
			#10;
			
		end
		
				
		
		$finish(2);
		
		// Add stimulus here

	end
      
endmodule

