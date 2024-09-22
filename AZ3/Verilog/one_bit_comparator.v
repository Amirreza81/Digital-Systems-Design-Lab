module one_bit_comparator (
    input input_greater_than,
    input input_equal,
    input x,
    input y,
    output output_greater_than,
    output output_equal
);
    assign output_greater_than = input_greater_than | (input_equal & (x > y));
    assign output_equal = input_equal & (x == y);
endmodule
