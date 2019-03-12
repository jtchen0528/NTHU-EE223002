`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/30 20:04:47
// Design Name: 
// Module Name: ssd_ctl
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


module ssd_ctl(
    input [1:0]ssd_ctl_en,
    input [0:14]display0, display1, display2, display3,
    output [0:7]display,
    output [3:0]display_c
    );
    
    reg [0:7]display;
    reg [3:0]display_c;
    
    always @(ssd_ctl_en or display0 or display1 or display2 or display3)
    
    case(ssd_ctl_en)
        2'b00: display = display0;
        2'b01: display = display1;
        2'b10: display = display2;
        2'b11: display = display3;
        default: display = 8'd0;
    endcase
    
    always @(ssd_ctl_en)
    case(ssd_ctl_en)
        2'b00: display_c = 4'b1110;
        2'b01: display_c = 4'b1101;
        2'b10: display_c = 4'b1011;
        2'b11: display_c = 4'b0111;
    endcase
    
endmodule
