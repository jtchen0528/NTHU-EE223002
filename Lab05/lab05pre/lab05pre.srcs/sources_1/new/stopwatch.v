`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/28 01:05:17
// Design Name: 
// Module Name: stopwatch
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

`include "global.v"
module stopwatch(
    output [`BCD_BIT_WIDTH-1:0]digit1,
    output [`BCD_BIT_WIDTH-1:0]digit0,
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
    
endmodule
