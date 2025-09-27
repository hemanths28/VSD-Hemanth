`timescale 1ns / 1ps
module tb_blocking_caveat;
    reg a,b,c;
    wire d;

    blocking_caveat uut(.a(a),.b(b),.c(c),.d(d));

    initial begin
        $dumpfile("tb_blocking_caveat.vcd");
        $dumpvars(0,tb_blocking_caveat);
        a=0; b=0; c=0;
        #300 $finish;
    end

    always #75 a = ~a;
    always #10 b = ~b;
    always #55 c = ~c;
endmodule
