module alu_demo(clk, reset, cont, sw, hex1, hex2, hex3, hex4, hex5, flag_leds);
	input clk;
	input reset; // KEY0
	input cont;  // KEY3
	input [9:0] sw; // switches 9-0
	
	output [0:6] hex1, hex2, hex3, hex4, hex5;
	output [4:0] flag_leds;
	
	reg [15:0] A, prev_A;
	reg [15:0] B, prev_B;
	reg [7:0] Opcode, prev_Op;
	
	wire [15:0] C;
	
	reg prev_cont;
	
	reg [3:0] h1, h2, h3, h4, h5;
	
	
	// ALU and 7-segment displays
	alu aludem (.A(A), .B(B), .C(C),	.Opcode(Opcode), .Flags(flag_leds));
	hex2seg hx1 (.hex(h1), .seg(hex1));
	hex2seg hx2 (.hex(h2), .seg(hex2));
	hex2seg hx3 (.hex(h3), .seg(hex3));
	hex2seg hx4 (.hex(h4), .seg(hex4));
	hex2seg hx5 (.hex(h5), .seg(hex5));
	
	
	// FSM
	reg [3:0] current_state;
	reg [3:0] next_state;
	
	parameter reset_s  = 3'd0;
	parameter input_a  = 3'd1;
	parameter input_b  = 3'd2;
	parameter input_op = 3'd3;
	parameter output_c = 3'd4;
	
	
	always@(*)
	begin		
		prev_A <= A;
		prev_B <= B;
		prev_Op <= Opcode;
		prev_cont <= cont;
	
		
		case(current_state)
			reset_s:
			begin				
				A <= 16'b0;
				B <= 16'b0;
				Opcode <= 8'b0;
				
				h1 <= 4'hb; // HEX 5
				h2 <= 4'he; // HEX 3
				h3 <= 4'he; // HEX 2
				h4 <= 4'he; // HEX 1
				h5 <= 4'hf; // HEX 0
			end
			
			input_a:
			begin
				A <= {sw[9], sw[9], sw[8], sw[8], sw[7], sw[7], sw[6], sw[6], sw[5], sw[5], sw[4], sw[4], sw[3], sw[2], sw[1], sw[0]};
				B <= prev_B;
				Opcode <= prev_Op;
				
				h1 <= 4'ha; // A					
				h2 <= A[15:12];
				h3 <= A[11:8];
				h4 <= A[7:4];
				h5 <= A[3:0];
			end
				
			input_b:
			begin					
				A <= prev_A;
				B <= {sw[9], sw[9], sw[8], sw[8], sw[7], sw[7], sw[6], sw[6], sw[5], sw[5], sw[4], sw[4], sw[3], sw[2], sw[1], sw[0]};
				Opcode <= prev_Op;
				
				h1 <= 4'hb; // B					
				h2 <= B[15:12];
				h3 <= B[11:8];
				h4 <= B[7:4];
				h5 <= B[3:0];				
			end
				
			input_op:
			begin
				A <= prev_A;
				B <= prev_B;
				Opcode <= {sw[7], sw[6], sw[5], sw[4], sw[3], sw[2], sw[1], sw[0]}; 
				
				h1 <= 4'h0; // 0 (I'm too lazy to make an o)	
				h2 <= 4'b0000;
				h3 <= 4'b0000;
				h4 <= Opcode[7:4];
				h5 <= Opcode[3:0];
			end
			
			output_c:
			begin
				A <= prev_A;
				B <= prev_B;
				Opcode <= prev_Op;
					
				h1 <= 4'hc; // C
				h2 <= C[15:12];
				h3 <= C[11:8];
				h4 <= C[7:4];
				h5 <= C[3:0];
			end
			
			default:
			begin				
				A <= 16'd0;
				B <= 16'd0;
				Opcode <= 8'b0;
				
				h1 <= 4'd8;
				h2 <= 4'd8;
				h3 <= 4'd8;
				h4 <= 4'd8;
				h5 <= 4'd8;
			end
			
		endcase
	end
	
	
	/* FSM CONTROL */
	always@(posedge clk)
	begin
		if (!reset) current_state <= reset_s;
		else			current_state <= next_state;	
	end
	
	always@(*)
	begin
		next_state = current_state;
		
		case(current_state)
			reset_s:
			begin
				next_state = input_a;
			end
			
			input_a:
			begin
				if(!cont) next_state = input_b;
			end
			
			input_b:
			begin
				if(!cont) next_state = input_op;
			end
			
			input_op:
			begin
				if(!cont) next_state = output_c;
			end
			
			output_c:
			begin
				if(!cont) next_state = input_a;
			end
			
			default:
			begin
				next_state = reset_s;
			end		
		endcase
	end
	
	

endmodule
