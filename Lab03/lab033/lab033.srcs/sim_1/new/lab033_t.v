`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/18 19:45:44
// Design Name: 
// Module Name: lab033_t
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


module lab033_t;

    wire [3:0]b;
    reg clk; // global clock input
    reg rst;
    
    lab033 uut( .clk(clk), .rst(rst), .b(b));
    
    initial begin
     clk = 1; rst = 0; 
     #10 rst = 1;
     #20 rst = 0;
    end
    always
    #1 clk = ~clk;

endmodule