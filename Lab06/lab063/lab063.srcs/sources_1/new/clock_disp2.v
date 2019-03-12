`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/09 15:46:16
// Design Name: 
// Module Name: clock_disp2
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
module clock_disp2(
    output [`SSD_DIGIT_NUM-1:0]ssd_ctl,
    output [0:`SSD_BIT_WIDTH-1]display,
    output led2,
    input clk,
    input rst,
    input [3:0]in
    );
    
    wire [`SSD_SCAN_CTL_BIT_NUM-1:0]ssd_ctl_en;
    wire [0:`SSD_BIT_WIDTH-1] disp0, disp1, disp2, disp3;
    wire clk_d;
    wire freeze_enable;
    wire [`BCD_BIT_WIDTH-1:0]sec0,sec1,min0,min1,hr0,hr1,date0,date1,month0,month1,year0,year1,year2,year3;
    wire [`BCD_BIT_WIDTH-1:0]hr0am,hr1am;

    wire [2:0]mode;
    
    reg [`BCD_BIT_WIDTH-1:0]dig0_latch, dig1_latch, dig2_latch, dig3_latch;
    reg [3:0]hram1,hram2;

    reg [`BCD_BIT_WIDTH-1:0]dig0_out, dig1_out, dig2_out, dig3_out;
    
    reg led;
    
    assign led2 = led;
    
    freq_div U_FD(.clk_out(clk_d),
    .ssd_ctl_en(ssd_ctl_en),
    .clk(clk),
    .rst(rst)
    );
    
    FSM U_fsm(.freeze_enable(freeze_enable),
    .mode(mode),
    .in(in),
    .clk(clk_d),
    .rst(rst)
    );
    
    clock uutt(.sec0(sec0),
    .sec1(sec1),
    .min0(min0),
    .min1(min1),
    .hr0(hr0),
    .hr1(hr1),
    .hr0am(hr0am),
    .hr1am(hr1am),
    .am(am2),
    .date0(date0),
    .date1(date1),
    .month0(month0),
    .month1(month1),
    .year0(year0),
    .year1(year1),
    .year2(year2),
    .year3(year3),
    .clk(clk_d),
    .rst(rst)
    );
    
    always @(posedge clk_d or posedge rst)
    if(rst) begin
        dig0_out <= min0;
        dig1_out <= min1;
        dig2_out <= hr0;
        dig3_out <= hr1;
    end
    else    begin
        dig0_out <= dig0_latch;
        dig1_out <= dig1_latch;
        dig2_out <= dig2_latch;
        dig3_out <= dig3_latch;
        
    end
    
    `define STAT_24 3'd0
    `define STAT_AM 3'd1
    `define STAT_SEC 3'd2
    `define STAT_MON 3'd3
    `define STAT_YR 3'd4
    
    always @(freeze_enable or 
             dig0_latch or dig1_latch or dig2_latch or dig3_latch or
             dig0_out or dig1_out or dig2_out or dig3_out or mode)
    if(freeze_enable) begin
        dig0_latch = dig0_out;
        dig1_latch = dig1_out;
        dig2_latch = dig2_out;
        dig3_latch = dig3_out;
    end else
    begin
    case(mode)
    `STAT_24:
    begin
        dig0_latch = min0;
        dig1_latch = min1;
        dig2_latch = hr0;
        dig3_latch = hr1;
    end
    `STAT_AM:
    begin
        dig0_latch = min0;
        dig1_latch = min1;
        if((hr0 + hr1*10)>11)
        begin
            led = 1;
            dig2_latch = hr0;
            dig3_latch = hr1;
            if((hr0 + hr1*10)>12)   
            begin 
                if(((hr0 + hr1*10)==20)||((hr0 + hr1*10)==21))
                begin
                    dig2_latch = hr0 + 6'd8;
                    dig3_latch = hr1 - 6'd2;
                end
                else
                begin
                    dig2_latch = hr0 - 6'd2;
                    dig3_latch = hr1 - 6'd1;
                end
            end
        end
        else
        begin
            led = 0;
            dig2_latch = hr0;
            dig3_latch = hr1;
        end
    end
    `STAT_SEC:
    begin
        dig0_latch = sec0;
        dig1_latch = sec1;
        dig2_latch = `BCD_DEF;
        dig3_latch = `BCD_DEF;
    end
    `STAT_MON:
    begin
        dig0_latch = date0;
        dig1_latch = date1;
        dig2_latch = month0;
        dig3_latch = month1;
    end
    `STAT_YR:
    begin
        dig0_latch = year0;
        dig1_latch = year1;
        dig2_latch = `BCD_DEF;
        dig3_latch = `BCD_DEF;
    end
    endcase
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
