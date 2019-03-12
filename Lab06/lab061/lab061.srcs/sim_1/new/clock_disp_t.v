`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/05 02:15:03
// Design Name: 
// Module Name: clock_disp_t
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
`define SSD_BIT_WIDTH 8
module clock_disp_t;
    wire [`SSD_DIGIT_NUM-1:0]ssd_ctl;
    wire [0:`SSD_BIT_WIDTH-1]display;
    wire ammode;
reg clk;
reg rst;
reg [3:0]in;

    clock_disp uut3(.ssd_ctl(ssd_ctl), .display(display), .ammode(ammode), .clk(clk), .rst(rst), .in(in));
    
    initial begin
    clk = 1; rst = 0; in = 4'b0000;
    #0.1 rst = 1;
    #0.1 rst = 0;
    #100 in = 4'b0001;
    #100 in = 4'b0000;
    

    end
    always
    #0.0025 clk = ~clk;



endmodule
