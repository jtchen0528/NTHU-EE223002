`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/18 18:39:47
// Design Name: 
// Module Name: lab034_ssd
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


module lab034_ssd(
    input clk,
    input rst,
    output [7:0]D_ssd,
    output [3:0]ssd_ctl
    );
    
    lab034 U0(.clk(clk), .D_ssd(D_ssd), .rst(rst));
    
    assign ssd_ctl = 4'b1110;
    
endmodule
