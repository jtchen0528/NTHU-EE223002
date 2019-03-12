module top(
    input clk,
    input rst,
    input PS2_CLK,	
    input PS2_DATA,
    output [3:0]led
    );
    
    wire clk_out;
    wire up_down;
    wire [4:0]key;
    
    freq_div2(.clk(clk), .rst(rst), .clk_out(clk_out));
    
    keyboard2(.CLK(clk), .PS2_CLK(PS2_CLK), .PS2_DATA(PS2_DATA), .key(key));
    
    counter2(.clk(clk_out), .rst(rst), .key(key), .led(led));
    
endmodule
