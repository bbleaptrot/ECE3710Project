module lab3_demo(clk, reset, start_button, hex3, hex2, hex1, hex0);
	input clk;
	input reset;
	input start_button;
	
	output [0:6] hex3, hex2, hex1, hex0;
	reg [3:0] h3, h2, h1, h0;
	
	reg we_a, we_b;
	reg [15:0] data_a, data_b;
	reg [9:0] addr_a, addr_b;

	wire [15:0] q_a, q_b;
	
	
	reg [15:0] r0, r1, r2, r3, r510, r511, r512, r513;
  
	
	
	bram ram(
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
	
	hex2seg hx3 (.hex(h3), .seg(hex3));
	hex2seg hx2 (.hex(h2), .seg(hex2));
	hex2seg hx1 (.hex(h1), .seg(hex1));
	hex2seg hx0 (.hex(h0), .seg(hex0));
		

		
	
	// FSM
	reg[3:0] current_state;
	reg[3:0] next_state;
	
	parameter reset_s      = 4'd0;
	parameter set_values_s = 4'd1;
	parameter modify_s     = 4'd2;
	parameter write_back_s = 4'd3;
	parameter display_s    = 4'd4;
	
	// set_values_s parameters and 
	reg[1:0] set_param;
   parameter set_0 = 2'd0;
	parameter set_1 = 2'd1;
	parameter set_2 = 2'd2;
	parameter set_3 = 2'd3;
	
	reg done;
	
	
	always@(posedge clk)
	begin
		we_a <= 1'b0;
		we_b <= 1'b0;
		data_a <= 16'b0;
		data_b <= 16'b0;
		addr_a <= 10'b0;
		addr_b <= 10'b0;
		set_param <= 2'b0;
		
		h3 <= 4'h0;
		h2 <= 4'h0;
		h1 <= 4'h0;
		h0 <= 4'h0;
		
		r0 <= r0;
		r1 <= r1;
		r2 <= r2;
		r3 <= r3;
		
		r510 <= r510;
		r511 <= r511;
		r512 <= r512;
		r513 <= r513;
	
		case(current_state)
			reset_s:
			begin
				we_a   <=  1'b0;
				we_b   <=  1'b0;
				data_a <= 16'b0;
				data_b <= 16'b0;
				addr_a <= 10'b0;
				addr_b <= 10'b0;	
	
				done <= 1'b0;
				
				set_param <= set_0;
				
				h0 <= q_a[15:12]; // Prevent output pins from being stuck to GND or VCC
				h1 <= q_a[11:8];  // Also prevents quartus from not making the full ram module.
				h2 <= q_a[7:4];
				h3 <= q_a[3:0];
				
				r0 <= 16'b0;
				r1 <= 16'b0;
				r2 <= 16'b0;
				r3 <= 16'b0;
		
				r510 <= 16'b0;
				r511 <= 16'b0;
				r512 <= 16'b0;
				r513 <= 16'b0;
			end
			
			set_values_s:
			begin
				we_a <= 1'b1;
				we_b <= 1'b1;
				
				data_a <= 16'd69;
				data_b <= 16'd69;
				
				case(set_param)
					set_0:
					begin
						addr_a <= 10'd0;
						addr_b <= 10'd510;
						set_param <= set_1;
						done <= 1'b0;
					end
					set_1:
					begin
						addr_a <= 10'd1;
						addr_b <= 10'd511;
						set_param <= set_2;
						done <= 1'b0;
					end
					set_2:
					begin
						addr_a <= 10'd2;
						addr_b <= 10'd512;
						set_param <= set_3;
						done <= 1'b0;
					end
					set_3:
					begin
						addr_a <= 10'd3;
						addr_b <= 10'd513;
						set_param <= set_0;
						done <= 1'b1;
					end
				endcase
			end
			
			modify_s:
			begin
				we_a <= 1'b0;
				we_b <= 1'b0;
				
				data_a <= 16'b0;
				data_b <= 16'b0;
				
				case(set_param)
					set_0:
					begin
						addr_a <= 10'd0;
						addr_b <= 10'd510;
						
						r0 <= q_a + 1'b1;
						r510 <= q_b + 1'b1;
						
						set_param <= set_1;
						done <= 1'b0;
					end
					set_1:
					begin
						addr_a <= 10'd1;
						addr_b <= 10'd511;
						
						r1 <= q_a + 1'b1;
						r511 <= q_b + 1'b1;
						
						set_param <= set_2;
						done <= 1'b0;
					end
					set_2:
					begin
						addr_a <= 10'd2;
						addr_b <= 10'd512;
						
						r2 <= q_a + 1'b1;
						r512 <= q_b + 1'b1;
						
						set_param <= set_3;
						done <= 1'b0;
					end
					set_3:
					begin
						addr_a <= 10'd3;
						addr_b <= 10'd513;
						
						r3 <= q_a + 1'b1;
						r513 <= q_b + 1'b1;
						
						set_param <= set_0;
						done <= 1'b1;
					end
				endcase
			end
			
			write_back_s:
			begin
			
				case(set_param)
					set_0:
					begin
						data_a <= r0;
						data_b <= r510;
					
						addr_a <= 10'd0;
						addr_b <= 10'd510;
						set_param <= set_1;
						done <= 1'b0;
					end
					set_1:
					begin
						data_a <= r1;
						data_b <= r511;
					
						addr_a <= 10'd1;
						addr_b <= 10'd511;
						set_param <= set_2;
						done <= 1'b0;
					end
					set_2:
					begin
						data_a <= r2;
						data_b <= r512;
					
						addr_a <= 10'd2;
						addr_b <= 10'd512;
						set_param <= set_3;
						done <= 1'b0;
					end
					set_3:
					begin
						data_a <= r3;
						data_b <= r513;
					
						addr_a <= 10'd3;
						addr_b <= 10'd513;
						set_param <= set_0;
						done <= 1'b1;
					end
				endcase
			end
			
			display_s:
			begin
			
				addr_a <= 10'h0;
				addr_b <= 10'h3;
				
				h3 <= q_b[15:12];
				h2 <= q_b[11:8];
				h1 <= q_b[7:4];
				h0 <= q_b[3:0];
			
				
			end
			
			default:
			begin
				h3 <= 4'hd;
				h2 <= 4'he;
				h1 <= 4'ha;
				h0 <= 4'hd;
			end
	
		endcase
	
	end
	
	
	/* FSM */
	always@(posedge clk)
	begin
		if(!reset) current_state <= reset_s;
		else       current_state <= next_state;
	end
	
	always@(*)
	begin
		next_state = current_state;
		
		case(current_state)
			reset_s:
			begin
				if(~start_button) next_state = set_values_s;
				else             next_state = reset_s;
			end
			
			set_values_s:
			begin
				if(done) next_state = modify_s;
				else     next_state = set_values_s;
			end
			
			modify_s:
			begin
				if(done) next_state = write_back_s;
				else     next_state = modify_s;
			end
			
			write_back_s:
			begin
				if(done) next_state = display_s;
				else     next_state = write_back_s;
			end
			
			display_s:
			begin
				next_state = display_s;
			end
			
			default:
			begin	
				next_state = reset_s;
			end
			
		endcase	
	end

endmodule
