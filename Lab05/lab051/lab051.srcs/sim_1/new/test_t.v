`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/30 22:01:10
// Design Name: 
// Module Name: test_t
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
`define BCD_BIT_WIDTH 4
//`include "global2.v"
module test_t;
    wire [`BCD_BIT_WIDTH-1:0]digit1;
    wire [`BCD_BIT_WIDTH-1:0]digit0;
    wire [15:0]leds;
    reg clk;
    reg rst;
    reg mode;
    reg en;
    
    stopwatch2 uut(.digit1(digit1), .digit0(digit0), .leds(leds), .clk(clk), .rst(rst), .mode(mode), .en(en));
    
    initial begin
    clk = 1; rst = 0; mode = 1; en = 1;
    #2 rst = 1;
    #4 rst = 0;
    end
    always
    #1 clk = ~clk;
    
endmodule
