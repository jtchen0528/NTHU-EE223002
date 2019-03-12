`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/30 21:20:44
// Design Name: 
// Module Name: stopwatch2
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
`define BCD_ZERO 4'd0
`define BCD_ONE 4'd1
`define BCD_THREE 4'd3
`define BCD_FIVE 4'd5
`define BCD_NINE 4'd9

//`include "global2.v"
module stopwatch2(
    output [`BCD_BIT_WIDTH-1:0]digit1,
    output [`BCD_BIT_WIDTH-1:0]digit0,
    output [15:0]leds,
    input clk,
    input rst,
    input mode,
    input en
    );
    
    wire br0, br1;
    wire decrease_enable;
    
    reg [1:0]ctl;
    reg [`BCD_BIT_WIDTH-1:0]init_dig0;
    reg [`BCD_BIT_WIDTH-1:0]init_dig1;
    reg [15:0]leds;
    
    always @(mode)
    case(mode)
    1'b0:
    begin
        ctl = 2'b11;
        init_dig0 = `BCD_FIVE;
        init_dig1 = `BCD_ONE;
    end
    1'b1:
    begin
        ctl = 2'b11;
        init_dig0 = `BCD_ZERO;
        init_dig1 = `BCD_THREE;
    end
    default:
    begin
        ctl = 2'b00;
        init_dig0 = `BCD_ZERO;
        init_dig1 = `BCD_ZERO;
    end
    endcase
    
    assign decrease_enable = en && (~((digit0==`BCD_ZERO) && (digit1==`BCD_ZERO)));
    
    downcounter Udc0(
    .value(digit0),
    .borrow(br0),
    .clk(clk),
    .rst(rst),
    .decrease(decrease_enable),
    .init_value(init_dig0),
    .limit(`BCD_NINE),
    .en(ctl[0])
    );
    
    downcounter Udc1(
    .value(digit1),
    .borrow(br1),
    .clk(clk),
    .rst(rst),
    .decrease(br0),
    .init_value(init_dig1),
    .limit(`BCD_FIVE),
    .en(ctl[1])
    );
    
    always @(digit1 or digit0)
    if((digit1 == 0) && (digit0 == 0))
    leds = 16'b1111111111111111;
    else if((digit1 == 0) && (digit0 == 1))
    leds = 16'b0000000000000000;
    else
    leds = 16'b0000000000000000;
    
    
endmodule

