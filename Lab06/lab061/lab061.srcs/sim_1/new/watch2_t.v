`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/04 22:08:12
// Design Name: 
// Module Name: watch2_t
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
module watch2_t;
wire [`BCD_BIT_WIDTH-1:0]sec0;
wire [`BCD_BIT_WIDTH-1:0]sec1;
wire [`BCD_BIT_WIDTH-1:0]min0;
wire [`BCD_BIT_WIDTH-1:0]min1;
wire am;
wire [`BCD_BIT_WIDTH-1:0]hr0;
wire [`BCD_BIT_WIDTH-1:0]hr1;
wire [`BCD_BIT_WIDTH-1:0]hr0am;
wire [`BCD_BIT_WIDTH-1:0]hr1am;
wire [`BCD_BIT_WIDTH-1:0]date0;
wire [`BCD_BIT_WIDTH-1:0]date1;
wire [`BCD_BIT_WIDTH-1:0]month0;
wire [`BCD_BIT_WIDTH-1:0]month1;
wire [`BCD_BIT_WIDTH-1:0]year0;
wire [`BCD_BIT_WIDTH-1:0]year1;
wire [`BCD_BIT_WIDTH-1:0]year2;
wire [`BCD_BIT_WIDTH-1:0]year3;
reg clk;
reg rst;

    clock uut(.sec0(sec0),
    .sec1(sec1),
    .min0(min0),
    .min1(min1),
    .hr0(hr0),
    .hr1(hr1),
    .hr0am(hr0am),
    .hr1am(hr1am),
    .am(am),
    .date0(date0),
    .date1(date1),
    .month0(month0),
    .month1(month1),
    .year0(year0),
    .year1(year1),
    .year2(year2),
    .year3(year3),
    .clk(clk),
    .rst(rst)
    );
    
    initial begin
    clk = 1; rst = 0;
    #0.1 rst = 1;
    #0.2 rst = 0;
    
 /*   #600 mode = 0;
    #600.1 rst = 0;
    #600.2 rst = 0;*/
    end
    always
    #0.0025 clk = ~clk;

endmodule
