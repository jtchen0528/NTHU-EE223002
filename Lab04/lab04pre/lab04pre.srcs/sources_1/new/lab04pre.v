`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/21 00:22:39
// Design Name: 
// Module Name: lab04pre
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
module lab04pre(
    q,
    clk,
    rst
    );
    
    output [`BIT_WIDTH-1:0]q;
    input clk;
    input rst;
    wire clk_d;
    wire [`BIT_WIDTH-1:0]q;
    
    frequency U_FD(.clk_out(clk_d), .clk(clk), .rst(rst));
    
    shifter U_D(.q(q), .clk(clk_d), .rst(rst));
    
endmodule
