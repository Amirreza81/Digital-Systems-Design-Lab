module serial_comparator (
    input x,
    input y,
    input reset,
    input clk,
    output output_greater_than,
    output output_less_than
);
    wire output_greater_than_not, output_less_than_not, input_greater_than, input_less_than;
    // Assign outputs
    assign output_greater_than = (~output_greater_than_not) | (input_greater_than & clk);
    assign output_greater_than_not = (~output_greater_than) | (~input_greater_than & clk);
    assign output_less_than = (~output_less_than_not) | (input_less_than & clk);
    assign output_less_than_not = (~output_less_than) | (~input_less_than & clk);
    // Assign inputs
    assign input_greater_than = (~reset) & (output_greater_than | ((~input_less_than) & (x > y)));
    assign input_less_than = (~reset) & (output_less_than | ((~input_greater_than) & (x < y)));
endmodule