`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/17 20:35:53
// Design Name: 
// Module Name: lab031
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
`define FREQ_DIV_BIT 27
module lab031(clk_out, clk,rst);
output clk_out; 
input clk; 
input rst; 
reg[`FREQ_DIV_BIT-1:0] cnt;
reg[`FREQ_DIV_BIT-1:0] cnt_tmp; 
wire clk_out;

assign clk_out= cnt[`FREQ_DIV_BIT-1];

always @(cnt)
cnt_tmp= cnt+ 1'b1;

always @(posedge clk or posedge rst)
if (rst)
cnt<=`FREQ_DIV_BIT'd0;
else
cnt<=cnt_tmp;
endmodule

