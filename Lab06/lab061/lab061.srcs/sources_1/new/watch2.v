`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/04 20:53:22
// Design Name: 
// Module Name: watch2
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
module clock(
    output [`BCD_BIT_WIDTH-1:0]sec0,
    output [`BCD_BIT_WIDTH-1:0]sec1,
    output [`BCD_BIT_WIDTH-1:0]min0,
    output [`BCD_BIT_WIDTH-1:0]min1,
    output am,
    output [`BCD_BIT_WIDTH-1:0]hr0,
    output [`BCD_BIT_WIDTH-1:0]hr1,
    output [`BCD_BIT_WIDTH-1:0]hr0am,
    output [`BCD_BIT_WIDTH-1:0]hr1am,
    output [`BCD_BIT_WIDTH-1:0]date0,
    output [`BCD_BIT_WIDTH-1:0]date1,
    output [`BCD_BIT_WIDTH-1:0]month0,
    output [`BCD_BIT_WIDTH-1:0]month1,
    output [`BCD_BIT_WIDTH-1:0]year0,
    output [`BCD_BIT_WIDTH-1:0]year1,
    output [`BCD_BIT_WIDTH-1:0]year2,
    output [`BCD_BIT_WIDTH-1:0]year3,
  /*  output [5:0]sec,
    output [5:0]min,
    output [5:0]hr,
    output [5:0]date,
    output [5:0]month,
    output [21:0]year,
    output apm,*/
    input clk,
    input rst
    //input mode
);

    reg [5:0]sec;
    reg [5:0]min;
    reg apm;
    reg [5:0]hr;
    reg [5:0]hram;
    reg [5:0]date;
    reg [5:0]month;
    reg [21:0]year;
    
    
    assign sec0 = (sec%10);
    assign sec1 = sec/10;
    assign min1 = (min/10);
    assign min0 = (min%10);
    assign hr1 = (hr/10);
    assign hr0 = (hr%10);
    assign hr1am = (hram/10);
    assign hr0am = (hram%10);
    assign am = apm;
    assign date1 = (date/10);
    assign date0 = (date%10);
    assign month0 = month%10;
    assign month1 = (month/10);
    assign year3 = (year/1000);
    assign year2 = (year/100) - (year/1000)*10;
    assign year1 = (year/10) - (year/100)*10;
    assign year0 = (year%10);
    
    always @(posedge clk or posedge rst)
    begin
    if(rst)
    begin
     /*   case(mode)
        1'b1:
        begin
            sec <= 6'd0;
            min <= 6'd0;
            hr <= 6'd0;
            apm <= 0;
            date <= 6'd1;
            month <= 6'd1;
            year <= 22'd2000;
        end
        1'b0:
        begin*/
            sec <= 6'd0;
            min <= 6'd0;
            hr <= 6'd0;
            apm <= 0;
            date <= 6'd1;
            month <= 6'd2;
            year <= 22'd2004;
     /*   end 
        endcase*/
    end
    else
    begin
        
        sec <= sec + 1;
        if(sec == 6'd59)
        begin
            min <= min + 1;
            sec <= 6'd0;
        end
        if((min == 6'd59)&&(sec == 6'd59))
        begin
            hr <= hr + 1;
            min <= 6'd0;
        end
        if((hr == 6'd23)&&(min == 6'd59)&&(sec == 6'd59))
        begin
            date <= date + 1;
            hr <= 6'd0;
        end
   /*     if((hr == 6'd11)&&(mode == 0)&&(apm == 0)&&(min == 6'd59)&&(sec == 6'd59))
        begin
            apm <= apm + 1;
        end
        if((hr == 6'd12)&&(mode == 0)&&(apm == 1)&&(min == 6'd59)&&(sec == 6'd59))
        begin
             hr <= 6'd1;;
        end
        if((hr == 6'd11)&&(mode == 0)&&(apm == 1)&&(min == 6'd59)&&(sec == 6'd59))
        begin
            apm <= 0;
            date <= date + 1;
            hr <= 6'd0;
        end*/
        case(month)
            6'd1, 6'd3, 6'd5, 6'd7, 6'd8, 6'd10, 6'd11:
            begin
                if((date == 6'd31)&&(hr == 6'd23)&&(min == 6'd59)&&(sec == 6'd59))
                begin
                    month <= month + 1;
                    date <= 6'd1;
                end
    /*            else if((date == 6'd31)&&(hr == 6'd11)&&(mode == 0)&&(apm == 1)&&(min == 6'd59)&&(sec == 6'd59))
                begin
                    month <= month + 1;
                    date <= 6'd1;
                end*/
            end
            6'd4, 6'd6, 6'd9, 6'd11:
            begin
                if((date == 6'd30)&&(hr == 6'd23)&&(min == 6'd59)&&(sec == 6'd59))
                begin
                    month <= month + 1;
                    date <= 6'd1;
                end/*
                else if((date == 6'd30)&&(hr == 6'd11)&&(mode == 0)&&(apm == 1)&&(min == 6'd59)&&(sec == 6'd59))
                begin
                    month <= month + 1;
                    date <= 6'd1;
                end*/
            end
            6'd2:
            begin
                if(((year%4) != 0)||((year%100) == 0))
                begin
                    if((date == 6'd28)&&(hr == 6'd23)&&(min == 6'd59)&&(sec == 6'd59))
                    begin
                        month <= month + 1;
                        date <= 6'd1;
                    end/*
                    else if((date == 6'd28)&&(hr == 6'd11)&&(mode == 0)&&(apm == 1)&&(min == 6'd59)&&(sec == 6'd59))
                    begin
                        month <= month + 1;
                        date <= 6'd1;
                    end*/
                end
                else
                begin
                    if((date == 6'd29)&&(hr == 6'd23)&&(min == 6'd59)&&(sec == 6'd59))
                    begin
                        month <= month + 1;
                        date <= 6'd1;
                    end/*
                    else if((date == 6'd29)&&(hr == 6'd11)&&(mode == 0)&&(apm == 1)&&(min == 6'd59)&&(sec == 6'd59))
                    begin
                        month <= month + 1;
                        date <= 6'd1;
                    end*/
                end
            end
        endcase
        if((month == 6'd12)&&(date == 6'd31)&&(hr == 6'd23)&&(min == 6'd59)&&(sec == 6'd59))
        begin
            year <= year + 1;
            date <= 6'd1;
            month <= 6'd1;
        end/*
        if((month == 6'd12)&&(date == 6'd31)&&(mode == 0)&&(hr == 6'd11)&&(min == 6'd59)&&(sec == 6'd59)&&(apm == 1))
        begin
            year <= year + 1;
            month <= 6'd1;
        end        */
    end
    end
    
    always @(*)
    begin
        if(hr>11)
        begin
            apm = 1;
            if(hr>12)
            begin
                hram = hr - 12;
            end
        end
        else
        begin
            apm = 0;
            hram = hr;
        end
    end


endmodule
