`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/22 20:13:58
// Design Name: 
// Module Name: lab04pre_t
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
`define BIT_WIDTH 8

module lab04pre_t;

    wire [`BIT_WIDTH-1:0]q;
    reg clk;
    reg rst;
    
    lab04pre uut(.q(q), .clk(clk), .rst(rst));
    initial begin
     clk = 1; rst = 0; 
     #10 rst = 1;
     #20 rst = 0;
    end
    always
    #1 clk = ~clk;
    

endmodule
