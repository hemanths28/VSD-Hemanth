`timescale 1ns / 1ps
module tb_bad_mux;
    reg i0,i1,sel;
    wire y;

    bad_mux uut(.i0(i0),.i1(i1),.sel(sel),.y(y));

    initial begin
        $dumpfile("tb_bad_mux.vcd");
        $dumpvars(0,tb_bad_mux);
        sel = 0; i0 = 0; i1 = 0;
        #300 $finish;
    end

    always #75 sel = ~sel;
    always #10 i0 = ~i0;
    always #55 i1 = ~i1;
endmodule
