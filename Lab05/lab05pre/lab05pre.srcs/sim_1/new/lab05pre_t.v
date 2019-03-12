`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/30 22:47:35
// Design Name: 
// Module Name: lab05pre_t
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
`define SSD_DIGIT_NUM 4
`define SSD_BIT_WIDTH 8
//`include "global.v"
module lab05pre_t;
    wire [4-1:0]dig1_out;
    wire [4-1:0]dig0_out;
    reg clk;
    reg rst;
    reg mode;
    reg in;
    
    stopwatchFSM uut(.dig1_out(dig1_out), .dig0_out(dig0_out), .clk(clk), .rst(rst), .mode(mode), .in(in));
    
    initial begin
    clk = 1; rst = 0; mode = 1; in = 0;
    #2 rst = 1;
    #4 rst = 0;
    #25 in = 1;
    #50 in = 0;
    end
    always
    #1 clk = ~clk;
    
endmodule
