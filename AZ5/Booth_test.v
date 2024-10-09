`timescale 1ns/1ns
module booth_test;
	reg clk, start;
	reg [7:0] multiplicand, multiplier;
	wire finish;
	wire [15:0] out;
	booth b(clk, start, multiplicand, multiplier, finish, out);

	initial clk = 1;
	always #5 clk = ~clk;

	initial
	begin
		start <= 1;
		multiplicand <= 7;
		multiplier <= 5;
		#10;
		start <= 0;

		#500;
		start <= 1;
		multiplicand <= 9;
		multiplier <= 9;
		#10;
		start <= 0;

		#500;
		start <= 1;
		multiplicand <= -6;
		multiplier <= 3;
		#10;
		start <= 0;
	end
endmodule

