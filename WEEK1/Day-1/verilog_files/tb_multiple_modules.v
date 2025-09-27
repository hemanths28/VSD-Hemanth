`timescale 1ns / 1ps
module tb_multiple_modules;
    reg a,b,c;
    wire y;
    
    multiple_modules uut(.a(a),.b(b),.c(c),.y(y));
    
    initial begin
        $dumpfile("tb_multiple_modules.vcd");
        $dumpvars(0,tb_multiple_modules);
        a=1'b0; b=1'b0; c=1'b0;
        #300 $finish;
    end
    
    always #75 a = ~a;
    always #10 b = ~b;
    always #55 c = ~c;
endmodule
