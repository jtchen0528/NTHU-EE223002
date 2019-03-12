`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/17 20:01:06
// Design Name: 
// Module Name: lab03pre_t
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lab03pre_t;

    reg clk; reg reset;
    wire [3:0] out;
    
    lab03pre uut(.clk(clk), .reset(reset), .out(out));
    
    initial begin
     clk = 1; reset = 0; 
     #10 reset = 1;
     #20 reset = 0;
     end
     always
     #1 clk = ~clk;
     

endmodule
