module FSM(clk, rst, reg0, reg1, we_a, we_b, data_a, data_b, addr_a, addr_b, state, wreg0, wreg1);
 
 input clk, rst;
 input [15:0] reg0, reg1;
 
 output reg we_a, we_b;
 output reg [15:0] data_a, data_b;
 output reg [9:0] addr_a, addr_b;
 output reg [3:0] state;
 output reg wreg0, wreg1;
 
 
 
 reg [3:0] state_counter = 4'b0000;
 
 
 always @(posedge clk)
 begin
	if(rst == 1) state_counter = 4'b0000;
	
	// Else, check if the state counter is at the end and if not increment it to the next state.
	else
	begin
		if(state_counter < 4'b1111) state_counter = state_counter + 1'b1;
		
		else state_counter = state_counter;
	end
 end
 
 always @(state_counter, reg0, reg1)
 begin
	case(state_counter)
		0: //Load memory 0 into reg1
			begin
				we_a   =  1'b0;
				we_b   =  1'b0;
				
				data_a = reg0;
				data_b = reg1;
				
				addr_a = 10'h1FE;
				addr_b = 10'h0;
				
				wreg0  = 1'b0;
				wreg1  = 1'b1;
				state = state_counter;

			end
			
			1: // write Reg1 into addr h1FE
			begin
				we_a   =  1'b0;
				we_b   =  1'b1;
				
				data_a = reg0;
				data_b = reg1;
				
				addr_a = 10'h1FF;
				addr_b = 10'h1FE;
				
				wreg0  = 1'b0;
				wreg1  = 1'b0;
				state = state_counter;
				
			end
			
			2: // REad h1FE from addr_a
			begin
				we_a   =  1'b0;
				we_b   =  1'b0;
				
				data_a = reg0;
				data_b = reg1;
				
				addr_a = 10'h1FE;
				addr_b = 10'h1FF;
				
				wreg0  = 1'b0;
				wreg1  = 1'b0;
				state = state_counter;
				
			end
			
//			3: // Modify value from memory 1 by 2 through a and store in memory 3.
//			begin
//				we_a   =  1'b1;
//				we_b   =  1'b0;
//				
//				
//				data_a = reg0;
//				data_b = reg1;
//				
//				addr_a = 10'h201;
//				addr_b = 10'h1FE;
//				
//				wreg0  = 1'b0;
//				wreg1  = 1'b0;
//			state = state_counter;	
//				
//				
//			end
//			
//			4: // Store the value of r1 into memory value 5 through b.
//			begin
//				we_a   =  1'b0;
//				we_b   =  1'b0;
//				
//				data_a = reg0;
//				data_b = reg1;
//				
//				addr_a = 10'h0;
//				addr_b = 10'h1FF;	
//				
//				wreg0  = 1'b0;
//				wreg1  = 1'b0;
//				state = state_counter;
//				 
//			end
//			
//			5: // Read value from memory 510 through b.
//			begin
//				we_a   =  1'b0;
//				we_b   =  1'b0;
//				
//				data_a = reg0;
//				data_b = reg1;
//				
//				addr_a = 10'h1;
//				addr_b = 10'h1FE;	
//				
//				wreg0  = 1'b0;
//				wreg1  = 1'b0;
//				state = state_counter;
//				
//				
//			end
//			
//			6: // Read value from memory 512 through b.
//			begin
//				we_a   =  1'b0;
//				we_b   =  1'b0;
//				
//				data_a = reg0;
//				data_b = reg1;
//				
//				addr_a = 10'h2;
//				addr_b = 10'h200;	
//				
//				wreg0  = 1'b0;
//				wreg1  = 1'b0;
//				state = state_counter;
//				
//				
//			end
//			
//			7: // Read value from memory 5 through a.
//			begin
//				we_a   =  1'b0;
//				we_b   =  1'b0;
//				
//				data_a = reg0;
//				data_b = reg1;
//				
//				addr_a = 10'h5;
//				addr_b = 10'h1FE;	
//				
//				wreg0  = 1'b0;
//				wreg1  = 1'b0;
//				state = state_counter;
//				
//				 
//			end
//			
//			8: // Read value from memory 510 through b.
//			begin
//				we_a   =  1'b0;
//				we_b   =  1'b0;
//				
//				data_a = reg0;
//				data_b = reg1;
//				
//				addr_a = 10'h2;
//				addr_b = 10'h1FE;	
//				
//				wreg0  = 1'b0;
//				wreg1  = 1'b0;
//				state = state_counter;
//				
//			end
//			9: // Write to memory location 10 through A.
//			begin
//				we_a   =  1'b1;
//				we_b   =  1'b0;
//				
//				data_a = reg0;
//				data_b = reg1;
//				
//				addr_a = 10'hA;
//				addr_b = 10'h0;	
//				
//				wreg0  = 1'b0;
//				wreg1  = 1'b0;
//				state = state_counter;
//				
//			end
//			10: // Read value from memory 10 through b.
//			begin
//				we_a   =  1'b0;
//				we_b   =  1'b0;
//				
//				data_a = reg0;
//				data_b = reg1;
//				
//				addr_a = 10'h2;
//				addr_b = 10'hA;
//				
//				wreg0  = 1'b0;
//				wreg1  = 1'b0;	
//				state = state_counter;
//				
//			end
			
			default: // Shouldn't get here.
			begin
				we_a   =  1'b0;
				we_b   =  1'b0;
				
				data_a = reg0;
				data_b = reg1;
				
				addr_a = 10'h1FF;
				addr_b = 10'h1FE;	
				
				wreg0  = 1'b0;
				wreg1  = 1'b0;
				state = state_counter;
			
			end
	
	endcase
 end
 
 endmodule