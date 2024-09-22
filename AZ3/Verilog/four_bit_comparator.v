`include "one_bit_comparator.v"

module four_bit_comparator (
    input[3:0] x,
    input[3:0] y,
    output output_greater_than,
    output output_equal
);
    wire c1_greater_than, c1_equal, c2_greater_than, c2_equal, c3_greater_than, c3_equal;
    one_bit_comparator c1(1'b0,            1'b1,     x[3], y[3], c1_greater_than,     c1_equal);
    one_bit_comparator c2(c1_greater_than, c1_equal, x[2], y[2], c2_greater_than,     c2_equal);
    one_bit_comparator c3(c2_greater_than, c2_equal, x[1], y[1], c3_greater_than,     c3_equal);
    one_bit_comparator c4(c3_greater_than, c3_equal, x[0], y[0], output_greater_than, output_equal);
endmodule
