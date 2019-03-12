module top2(
    input clk,
    input rst,
    input in1,
    output [3:0]led
    );
    
    wire clk_out;
    wire up_down;
    wire [3:0]l3, l2, l1, l0;
    
    freq_div2(.clk(clk), .rst(rst), .clk_out(clk_out));
    
    FSM2(.clk(clk), .rst(rst), .in1(in1), .up_down(up_down));
    
    counter(.clk(clk_out), .rst(rst), .up_down(up_down), .led(led));
    
endmodule