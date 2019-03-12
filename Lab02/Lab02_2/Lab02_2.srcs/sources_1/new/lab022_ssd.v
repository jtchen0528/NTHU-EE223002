`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/12 14:03:36
// Design Name: 
// Module Name: lab022_ssd
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


module lab022_ssd(
    input [3:0]i,
    output [7:0]D_ssd,
    output [3:0]ssd_ctl,
    output [3:0]d
    );
    
    lab022 U0(.i(i), .D_ssd(D_ssd), .d(d));
    
    assign ssd_ctl = 4'b0000;
    
endmodule
