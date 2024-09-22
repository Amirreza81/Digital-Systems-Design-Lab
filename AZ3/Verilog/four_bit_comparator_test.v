`include "four_bit_comparator.v"

module four_bit_comparator_test;
    reg[3:0] x;
    reg[3:0] y;
    wire output_greater_than, output_equal;
    four_bit_comparator c(x, y, output_greater_than, output_equal);

    initial begin
        x = 4'd0;
        y = 4'd0;
        #10 
        x = 4'd5;
        y = 4'd4;
        #10 
        x = 4'd6;
        y = 4'd9;
        #10 
        x = 4'd3;
        y = 4'd3;
        $stop;
    end

    initial begin
        $monitor("x=%d y=%d output_greater_than=%d output_equal=%d", x, y, output_greater_than, output_equal);
    end
endmodule
