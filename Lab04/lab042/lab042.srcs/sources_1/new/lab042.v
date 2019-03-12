`define BIT_WIDTH 8
module lab042(
    in,
    q,
    clk,
    rst
    );
    
    output [`BIT_WIDTH-1:0]q;
    input [`BIT_WIDTH-1:0]in;
    input clk;
    input rst;
    wire clk_d;
    wire [`BIT_WIDTH-1:0]q;
    
    freq2 U_FD(.clk_out(clk_d), .clk(clk), .rst(rst));
    
    shif2 U_D(.q(q), .clk(clk_d), .rst(rst), .in(in));
    
endmodule