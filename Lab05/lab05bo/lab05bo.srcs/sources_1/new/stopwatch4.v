`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/02 17:28:46
// Design Name: 
// Module Name: stopwatch4
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
`define INCREMENT 1'b1
`define BCD_ZERO 4'd0
`define BCD_ONE 4'd1
`define BCD_TWO 4'd2
`define BCD_THREE 4'd3
`define BCD_FOUR 4'd4
`define BCD_FIVE 4'd5
`define BCD_SIX 4'd6
`define BCD_SEVEN 4'd7
`define BCD_EIGHT 4'd8
`define BCD_NINE 4'd9
`define BCD_DEF 4'd15
`define BCD_BIT_WIDTH 4
//`include "global.v"
module stopwatch4(
    output [`BCD_BIT_WIDTH-1:0]digit1,
    output [`BCD_BIT_WIDTH-1:0]digit0,
    output [`BCD_BIT_WIDTH-1:0]digit2,
    output [15:0]leds,
    input clk,
    input rst,
    input mode,
    input en
    );
    
    wire br0, br1;
    wire decrease_enable;
    
    reg [2:0]ctl;
    reg [`BCD_BIT_WIDTH-1:0]init_dig2;
    reg [`BCD_BIT_WIDTH-1:0]init_dig0;
    reg [`BCD_BIT_WIDTH-1:0]init_dig1;
    reg [15:0]leds;
    
    always @(mode)
    case(mode)
    1'b0:
    begin
        ctl = 3'b111;
        init_dig0 = `BCD_ZERO;
        init_dig1 = `BCD_ZERO;
        init_dig2 = `BCD_ONE;
    end
    1'b1:
    begin
        ctl = 3'b111;
        init_dig0 = `BCD_ZERO;
        init_dig1 = `BCD_THREE;
        init_dig2 = `BCD_ZERO;
    end
    default:
    begin
        ctl = 3'b000;
        init_dig0 = `BCD_ZERO;
        init_dig1 = `BCD_ZERO;
        init_dig2 = `BCD_ZERO;
    end
    endcase
    
    assign decrease_enable = en && (~((digit0==`BCD_ZERO) && (digit1==`BCD_ZERO)&& (digit2==`BCD_ZERO)));
    
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
    
    downcounter Udc2(
    .value(digit2),
    .borrow(br2),
    .clk(clk),
    .rst(rst),
    .decrease(br1),
    .init_value(init_dig2),
    .limit(`BCD_NINE),
    .en(ctl[2])
    );
    
    always @(digit1 or digit0)
    if((digit1 == 0) && (digit0 == 0))
    leds = 16'b1111111111111111;
    else if((digit1 == 0) && (digit0 == 1))
    leds = 16'b0000000000000000;
    else
    leds = 16'b0000000000000000;
    
    
endmodule
