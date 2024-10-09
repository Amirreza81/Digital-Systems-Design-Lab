`timescale 1ns/1ns

module booth(input clk, input start, input [7:0] multiplicand, input [7:0] multiplier, output finish, output [15:0] out);
	wire [3:0] shift_amount;
	wire load, math_operation, shift;
	data_path dp(clk, multiplicand, multiplier, out[15:8], out[7:0], load, math_operation, shift, shift_amount);
	control_unit cu(clk, start, finish, out[7:0], load, math_operation, shift, shift_amount);
endmodule


module control_unit(input clk, input start, output finish, input [7:0] output_register, output load, output math_operation, output shift, output [3:0] shift_amount);
	reg[3:0] current_state, next_state, counter;
	assign load = current_state[0];
	assign math_operation = current_state[1];
	assign shift = current_state[2];
	assign finish = current_state[3];
	always @(current_state, counter)
	begin
		next_state <= 0;
		if(current_state[0]) 
			next_state[1] <= 1'b1;
		if(current_state[1]) 
			next_state[2] <= 1'b1;
		if(current_state[2])
			if (counter > shift_amount) 
				next_state[1] <= 1'b1;
			else 
				next_state[3] <= 1'b1;
		if(current_state[3]) 
			next_state[3] <= 1'b1;
	end
	always @(posedge clk)
		if (start)
		begin
			current_state <= 1;
			counter <= 8;
		end
		else
		begin
			current_state <= next_state;
			if (current_state[2]) 
				counter <= counter - shift_amount;
		end
	wire [7:0] difference_register = ( output_register ^ (output_register >> 1) ) | (8'b10000000);
	reg [3:0] lsb_one;
	integer loop_counter;
	always @(*)
	begin
		lsb_one = 0;
		for (loop_counter = 0; loop_counter <= 7; loop_counter = loop_counter + 1)
			if (difference_register[loop_counter] && lsb_one == 0) 
				lsb_one = loop_counter + 1;
	end
	assign shift_amount = (counter > lsb_one) ? lsb_one : counter;
endmodule


module data_path(input clk, input [7:0] multiplicand_input, input [7:0] multiplier_input, output reg [7:0] output_HI, output reg [7:0] output_LO, input load, input math_operation, input shift, input [3:0] shift_amount);
	reg [7:0] multiplicand_register;
	reg previous_state_LSB;
	always @(posedge clk)
	begin
		if (load)
		begin
			 multiplicand_register <= multiplicand_input;
			 output_HI <= 0;
			 output_LO <= multiplier_input;
			 previous_state_LSB <= 0;
		end
		else if (math_operation)
		begin
			if (output_LO[0] == 1 && previous_state_LSB == 0)
				output_HI <= output_HI - multiplicand_register;
			else if (output_LO[0] == 0 && previous_state_LSB == 1)
				output_HI <= output_HI + multiplicand_register;
		end
		else if (shift)
			{output_HI, output_LO, previous_state_LSB} <= $signed({output_HI, output_LO, previous_state_LSB}) >>> shift_amount;
	end
endmodule



