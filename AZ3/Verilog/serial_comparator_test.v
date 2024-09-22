`include "serial_comparator.v"

module serial_comparator_test;
    reg x, y, clk, reset;
    wire greater_than, less_than;

    serial_comparator sc(x, y, reset, clk, greater_than, less_than);

    initial clk = 1'b1;
    always #5 clk = ~clk;

    initial begin
        // x = 0100, y = 0010
        reset = 1'b1;
        x = 1'b0;
        y = 1'b0;
        #10
        reset = 1'b0;
        x = 1'b0;
        y = 1'b0;
        #10
        x = 1'b1;
        y = 1'b0;
        #10
        x = 1'b0;
        y = 1'b1;
        #10
        x = 1'b0;
        y = 1'b0;
        #10
        
        reset = 1'b1;
        #10
        reset = 1'b0;

        // x = 0000, y = 0001
        x = 1'b0;
        y = 1'b0;
        #10
        x = 1'b0;
        y = 1'b0;
        #10
        x = 1'b0;
        y = 1'b0;
        #10
        x = 1'b0;
        y = 1'b1;
        #10
        $stop;
    end

    initial begin
        $monitor("reset=%d clk=%d x=%d y=%d greater_than=%d less_than=%d\n",
          reset,
          clk,
          x,
          y, 
          greater_than, 
          less_than);
    end
endmodule
