module Stack(
    output reg [3:0] data_out,
    output reg full,
    output reg empty, // active-low empty flag
    input [3:0] data_in,
    input push,
    input pop,
    input clk,
    input rstN // synchronized active-low reset signal
    );

reg [3:0] sp = 0; // points to the first empty location on the stack
reg [3:0] stack_mem [7:0];

integer index = 0;
always @(posedge clk) begin
	if (rstN == 0) begin
		for (index = 0; index < 8; index = index + 1) begin
			stack_mem [index] = 0;
		end
		sp = 0;
		empty = 0;
		full = 0;
		data_out = 0;
	end
	else begin
		if (push==1 && pop==1) begin
		// do nothing
		end
		else if (push==1 && full==0) begin
			stack_mem [sp] = data_in;
			sp = sp + 1;
		end
		else if (pop==1 && empty==1) begin
			sp = sp - 1;
			data_out = stack_mem[sp];
		end
		
		if (sp == 0) begin
			empty = 0;
			full = 0;
		end else if (sp == 8) begin
			empty = 1;
			full = 1;
		end else begin
			empty = 1;
			full = 0;
		end
	end
end
endmodule
module stack_tb;
    reg clk, rstN, push, pop;
    reg [3:0] data_in;
    wire full, empty;
    wire [3:0] data_out;
    Stack stack (data_out, full, empty, data_in, push, pop, clk, rstN);

    //clk
    initial begin
        clk = 1'b0;
    end
    always #5 clk = ~ clk;
	
    
    initial
	begin
		rstN <= 1'b1;
		push <= 1'b0;
		pop <= 1'b0;
		#10
		data_in <= 4'b1000;
		push <= 1'b1;
        //push 1000
		#10
		data_in <= 4'b1111;
		push <= 1'b1;
        //push 1111
		#10
		push <= 1'b0;
		pop <= 1'b1;
        //pop 1111
		#10
        	pop <= 1'b0;
		push <= 1'b1;
		data_in <= 4'b0111;
        //push 0111
		#10
		push <= 1'b1;
		data_in <= 4'b0110;
        //push 0110
		#10
		push <= 1'b1;
		data_in <= 4'b0101;
        //push 0101
		#10
		push <= 1'b1;
		data_in <= 4'b0100;
	//push 0100
		#10
		push <= 1'b1;
		data_in <= 4'b0011;
        //push 0011
		#10
		push <= 1'b1;
		data_in <= 4'b0010;
        //push 0010
		#10
		push <= 1'b1;
		data_in <= 4'b0001;
        //push 0001
		#10
		push <= 1'b1;
		data_in <= 4'b1111;
        //push 1111
		#10
		push <= 1'b1;
		data_in <= 4'b1110;
        //push 1110
		#10
		push <= 1'b1;
		data_in <= 4'b1100;
        //push 1100
		#10
		push <= 1'b1;
		data_in <= 4'b1000;
        //push 1000
		#10
        	push <= 1'b0;
		pop <= 1'b1;
		#10
		pop <= 1'b1;
		#10
		pop <= 1'b1;
		#10
		pop <= 1'b1;
		#10
		pop <= 1'b1;
		#10
		pop <= 1'b1;
		#10
		pop <= 1'b1;
		#10
		pop <= 1'b1;
		#10
		pop <= 1'b1;
		#10
		data_in <= 4'b0000;
		push <= 1'b1;
		pop <= 1'b1;
            //nothing!
		#10
		push <= 1'b0;
		pop <= 1'b0;
		rstN <= 1'b0;
	     //reset
		#10
		$stop;
	end
endmodule
