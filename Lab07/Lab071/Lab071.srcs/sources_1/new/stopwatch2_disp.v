`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/14 11:06:38
// Design Name: 
// Module Name: stopwatch2_disp
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
module stopwatch_disp2(
    output [`SSD_DIGIT_NUM-1:0]ssd_ctl,
    output [0:`SSD_BIT_WIDTH-1]display,
    input clk,
    input in1,
    input in2
    );
    
    wire [`SSD_SCAN_CTL_BIT_NUM-1:0]ssd_ctl_en;
    wire [0:`SSD_BIT_WIDTH-1] disp0, disp1, disp2, disp3;
    wire en;
    wire freeze_enable;
    wire rst_d;
    wire [`BCD_BIT_WIDTH-1:0]dig0, dig1, dig2, dig3;
    
    reg [`BCD_BIT_WIDTH-1:0]dig0_latch, dig1_latch, dig2_latch, dig3_latch;
    reg [`BCD_BIT_WIDTH-1:0]dig0_out, dig1_out, dig2_out, dig3_out;
    
    freq_div2 U_FD(.clk_out(clk_d),
    .ssd_ctl_en(ssd_ctl_en),
    .clk(clk),
    .rst(rst_d)
    );
    
    FSM2 U_fsm(.count_enable(en),
    .freeze_enable(freeze_enable),
    .reset_enable(rst_d),
    .in1(in1),
    .clk(clk_d),
    .in2(in2)
    );
    
    stopwatch2 U_sw(.sec0(dig0),
    .sec1(dig1),
    .min0(dig2),
    .min1(dig3),
    .en(en),
    .clk(clk_d),
    .rst(rst_d)
    );
    
    always @(posedge clk_d or posedge rst_d)
    if(rst_d) begin
        dig0_out <= 4'd0;
        dig1_out <= 4'd0;
        dig2_out <= 4'd0;
        dig3_out <= 4'd0;
    end
    else    begin
        dig0_out <= dig0_latch;
        dig1_out <= dig1_latch;
        dig2_out <= dig2_latch;
        dig3_out <= dig3_latch;
    end
    
    always @(*)
    if(freeze_enable) begin
        dig0_latch = dig0_out;
        dig1_latch = dig1_out;
        dig2_latch = dig2_out;
        dig3_latch = dig3_out;
    end else
    begin
        dig0_latch = dig0;
        dig1_latch = dig1;
        dig2_latch = dig2;
        dig3_latch = dig3;
    end
    
    ssd U_SSD3(
    .display(disp3),
    .bcd(dig3_out));
    ssd U_SSD2(
    .display(disp2),
    .bcd(dig2_out));
    ssd U_SSD1(
    .display(disp1),
    .bcd(dig1_out));
    ssd U_SSD0(
    .display(disp0),
    .bcd(dig0_out));
    
    ssd_ctl U_CTL(
    .display_c(ssd_ctl),
    .display(display),
    .ssd_ctl_en(ssd_ctl_en),
    .display0(disp0),
    .display1(disp1),
    .display2(disp2),
    .display3(disp3)
    );
    
endmodule
