module demux_generate (input i, input [2:0] sel, output [7:0] y);
    reg [7:0] y_int;
    assign y = y_int;
    integer k;
    always @ (*)
    begin
        y_int = 8'b0;
        for(k = 0; k < 8; k++) begin
            if(k == sel)
                y_int[k] = i;
        end
    end
endmodule
