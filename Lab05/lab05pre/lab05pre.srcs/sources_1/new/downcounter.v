`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/28 00:16:06
// Design Name: 
// Module Name: downcounter
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
module downcounter(
    output [`BCD_BIT_WIDTH-1:0]value,
    output borrow,
    input clk,
    input rst,
    input decrease,
    input [`BCD_BIT_WIDTH-1:0]init_value,
    input [`BCD_BIT_WIDTH-1:0]limit,
    input en
    );
    
    reg [`BCD_BIT_WIDTH-1:0]value;
    reg [`BCD_BIT_WIDTH-1:0]value_tmp;
    reg borrow;
    
    always @(value or decrease or en or limit)
        if(value==`BCD_ZERO && decrease && en)
        begin
            value_tmp = limit;
            borrow = `ENABLED;
        end
        else if(decrease && en)
        begin
            value_tmp = value - `INCREMENT;
            borrow = `DISABLED;
        end
        else if(en)
        begin
            value_tmp = value;
            borrow = `DISABLED;
        end
        else
        begin
            value_tmp = `BCD_ZERO;
            borrow = `DISABLED;
        end
        
    always @(posedge clk or posedge rst)
    if(rst)
        value <= init_value;
    else
        value <= value_tmp;
         
endmodule
