`timescale 1ns / 1ps
module tb_dff_const1;
    reg clk, reset;
    wire q;

    dff_const1 uut(.clk(clk),.reset(reset),.q(q));

    initial begin
        $dumpfile("tb_dff_const1.vcd");
        $dumpvars(0,tb_dff_const1);
        clk = 0; reset = 1;
        #3000 $finish;
    end

    always #10 clk = ~clk;
    always #1547 reset = ~reset;
endmodule
