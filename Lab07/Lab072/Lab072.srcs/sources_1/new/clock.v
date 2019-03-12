`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/14 15:53:02
// Design Name: 
// Module Name: clock
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
    output [`BCD_BIT_WIDTH-1:0]hr0,
    output [`BCD_BIT_WIDTH-1:0]hr1,
    output led,
    input setting,
    input in3,
    input in2,
    input en,
    input clk,
    input rst
);

    reg [5:0]sec;
    reg [5:0]min;
    reg [5:0]hr;
    reg leds;
    reg [5:0]init_min;
    reg [5:0]init_hr;
    
    assign sec0 = (sec%10);
    assign sec1 = sec/10;
    assign min1 = (min/10);
    assign min0 = (min%10);
    assign hr1 = (hr/10);
    assign hr0 = (hr%10);
    assign led = leds;
    
    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
        if(setting == 0)
        begin
            sec <= 6'd0;
            min <= 6'd0;
            hr <= 6'd0;
            leds <= 0;
        end
        else
        begin
            sec <= 6'd0;
            min <= init_min;
            hr <= init_hr;
            leds <= 0;
        end
        end
        else
        begin
            if(setting == 0)
            begin
                if(en)
                begin
                    sec <= sec + 1;
                    if(sec == 6'd59)
                    begin
                        min <= min + 6'd1;
                        sec <= 6'd0;
                    end
                    if((min == 6'd59)&&(sec == 6'd59))
                    begin
                        hr <= hr + 6'd1;
                        sec <= 6'd0;
                        min <= 6'd0;
                    end
                    if((hr == 6'd23) && (min == 6'd59) && (sec == 6'd59))
                    begin
                        sec <= 6'd0;
                        hr <= 6'd0;
                        min <= 6'd0;
                    end
                end
                else
                if(in2)
                 begin
                     min <= min + 6'd1;
                     init_min <= min + 6'd1;
                     if(min == 6'd59)
                     begin
                         min <= 6'd0;
                         init_min <= min + 6'd1;
                     end
                 end
                 if(in3)
                 begin
                     hr <= hr + 6'd1;
                     init_hr <= hr + 6'd1;
                     if(hr == 6'd23)
                     begin
                         hr <= 6'd0;
                         init_hr <= hr + 6'd1;
                     end
                 end
                
            end
            else
            begin
                if(en)
                begin
                    sec <= sec - 1;
                    if(sec == 6'd0)
                    begin
                        min <= min - 6'd1;
                        sec <= 6'd59;
                    end
                    if((min == 6'd0)&&(sec == 6'd0))
                    begin
                        sec <= 6'd59;
                        min <= 6'd59;
                        hr <= hr - 6'd1;
                    end
                    if((hr == 6'd0) && (min == 6'd0) && (sec == 6'd0))
                    begin
                        sec <= 6'd0;
                        min <= 6'd0;
                        hr <= 6'd0;
                        leds <= 1;
                    end
                end
                else
                if(in2)
                begin
                    min <= min + 6'd1;
                    init_min <= min + 6'd1;
                    if(min == 6'd59)
                    begin
                        min <= 6'd0;
                        init_min <= min + 6'd1;
                    end
                end
                if(in3)
                begin
                    hr <= hr + 6'd1;
                    init_hr <= hr + 6'd1;
                    if(hr == 6'd23)
                    begin
                        hr <= 6'd0;
                        init_hr <= hr + 6'd1;
                    end
                end
            end
        end    
    end



endmodule
