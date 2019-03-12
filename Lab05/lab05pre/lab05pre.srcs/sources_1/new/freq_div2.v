`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/30 23:23:30
// Design Name: 
// Module Name: freq_div2
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


    `define FREQ_DIV_BIT 2
module freq_div2(clk_out, clk,rst,ssd_ctl_en);
    output clk_out; 
    output [1:0]ssd_ctl_en;
    input clk; 
    input rst; 
    reg[`FREQ_DIV_BIT-1:0] cnt;
    reg[`FREQ_DIV_BIT-1:0] cnt_next; 
    wire clk_out;
    wire [1:0]ssd_ctl_en;
    
    assign ssd_ctl_en = cnt[1:0];
    assign clk_out = cnt[`FREQ_DIV_BIT-1];
    
    always @(cnt)
    cnt_next = cnt + 1'b1;
    
    always @(posedge clk or posedge rst)
    if (rst)
    cnt<=`FREQ_DIV_BIT'd0;
    else
    cnt<=cnt_next;

endmodule
