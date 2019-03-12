`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/30 23:22:36
// Design Name: 
// Module Name: stopwatchFSM
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
`define SSD_SCAN_CTL_BIT_NUM 2
`define SSD_BIT_WIDTH 8
`define BCD_BIT_WIDTH 4
`define BCD_DEF 4'd15
//`include "global.v"
module stopwatchFSM(
    output [`BCD_BIT_WIDTH-1:0]dig0_out,
    output [`BCD_BIT_WIDTH-1:0]dig1_out,
    input clk,
    input rst,
    input mode,
    input in
    );
    
    wire [`SSD_SCAN_CTL_BIT_NUM-1:0]ssd_ctl_en;
  //  wire [0:`SSD_BIT_WIDTH-1] disp0, disp1, disp2, disp3;
    wire clk_d;
    wire count_enable;
    wire freeze_enable;
    wire [`BCD_BIT_WIDTH-1:0]dig0, dig1;
    
    reg [`BCD_BIT_WIDTH-1:0]dig0_latch, dig1_latch;
    reg [`BCD_BIT_WIDTH-1:0]dig0_out, dig1_out;
    
    freq_div2 U_FD(.clk_out(clk_d),
    .ssd_ctl_en(ssd_ctl_en),
    .clk(clk),
    .rst(rst)
    );
    
    FSM U_fsm(.count_enable(count_enable),
    .freeze_enable(freeze_enable),
    .in(in),
    .clk(clk_d),
    .rst(rst)
    );
    
    stopwatch U_sw(.digit1(dig1),
    .digit0(dig0),
    .clk(clk_d),
    .rst(rst),
    .mode(mode),
    .en(count_enable)
    );
    
    always @(posedge clk_d or posedge rst)
    if(rst) begin
        dig0_out <= 4'd0;
        dig1_out <= 4'd0;
    end
    else    begin
        dig0_out <= dig0_latch;
        dig1_out <= dig1_latch;
    end
    
    always @(freeze_enable or dig0 or dig1 or dig0_latch or dig1_latch or dig0_out or dig1_out)
    if(freeze_enable) begin
        dig0_latch = dig0_out;
        dig1_latch = dig1_out;
    end else
    begin
        dig0_latch = dig0;
        dig1_latch = dig1;
    end
    
    
endmodule
