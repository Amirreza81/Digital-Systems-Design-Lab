`include "one_bit_comparator.v"

module one_bit_comparator_test;
    reg input_greater_than, input_equal, x, y;
    wire output_greater_than, output_equal;
    one_bit_comparator c(input_greater_than, input_equal, x, y, output_greater_than, output_equal);

    initial begin
        // Simple even tests
        input_greater_than = 1'b0;
        input_equal = 1'b1;
        x = 1'b0;
        y = 1'b0;
        #10
        x = 1'b1;
        y = 1'b0;
        #10 
        x = 1'b0;
        y = 1'b1;
        // Before was greater
        #20
        input_greater_than = 1'b1;
        input_equal = 1'b0;
        x = 1'b0;
        y = 1'b0;
        #10
        x = 1'b1;
        y = 1'b0;
        #10 
        x = 1'b0;
        y = 1'b1;
        // Before was smaller
        #20
        input_greater_than = 1'b0;
        input_equal = 1'b0;
        x = 1'b0;
        y = 1'b0;
        #10
        x = 1'b1;
        y = 1'b0;
        #10 
        x = 1'b0;
        y = 1'b1;
        $stop;
    end

    initial begin
        $monitor("input_greater_than=%d input_equal=%d x=%d y=%d output_greater_than=%d output_equal=%d\n",
          input_greater_than,
          input_equal,
          x,
          y, 
          output_greater_than, 
          output_equal);
    end
endmodule
