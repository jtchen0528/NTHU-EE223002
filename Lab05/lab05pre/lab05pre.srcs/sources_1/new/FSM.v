`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/30 18:38:11
// Design Name: 
// Module Name: FSM
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
module FSM(
    output count_enable,
    output freeze_enable,
    input in,
    input clk,
    input rst
    );
    
    reg freeze_enable;
    reg count_enable;

    reg [1:0]state;
    reg [1:0]next_state;
    reg [2:0]in_latch;
    reg [2:0]in_latch_temp;
    
    `define STAT_DEF 2'b00
    `define STAT_COUNT 2'b01
    `define STAT_FREEZE 2'b10
    
    always @(posedge clk or posedge rst)
    if(rst) state <= `STAT_DEF;
    else    state <= next_state;
    
    always @(*)
    if((in) && (state != `STAT_COUNT))
        in_latch_temp = 3'b000;
    else
        in_latch_temp = {in_latch[1:0],in};
        
    always @(posedge clk or posedge rst)
    if(rst) in_latch <= 3'b000;
    else    in_latch <= in_latch_temp;
    
    always @(state or in or in_latch)
    case(state)
    `STAT_DEF:
    if(in)  begin
        next_state = `STAT_DEF;
        count_enable = `DISABLED;
        freeze_enable  = `DISABLED;
    end
    else    begin
        next_state = `STAT_COUNT;
        count_enable = `ENABLED;
        freeze_enable  = `DISABLED;
    end
    `STAT_COUNT:
    if((in) && (in_latch==3'b111))  begin
        next_state = `STAT_DEF;
        count_enable = `DISABLED;
        freeze_enable  = `DISABLED;
    end
    else if((in) && (in_latch==3'b001)) begin
        next_state = `STAT_FREEZE;
        count_enable = `ENABLED;
        freeze_enable  = `ENABLED;
    end
    else    begin
        next_state = `STAT_COUNT;
        count_enable = `ENABLED;
        freeze_enable = `DISABLED;
    end
    `STAT_FREEZE:
    if(in)  begin
        next_state = `STAT_COUNT;
        count_enable = `ENABLED;
        freeze_enable  = `DISABLED;
    end
    else    begin
        next_state = `STAT_FREEZE;
        count_enable = `ENABLED;
        freeze_enable  = `ENABLED;
    end       
    default:    begin
        next_state = `STAT_DEF;
        count_enable = `DISABLED;
        freeze_enable = `DISABLED;
    end
    endcase
    
endmodule
