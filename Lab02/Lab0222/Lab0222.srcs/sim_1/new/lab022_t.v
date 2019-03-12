`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/12 14:24:46
// Design Name: 
// Module Name: lab022_t
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


module lab022_t;
    
    reg [3:0]i;
    wire [7:0]D_ssd;
    wire [3:0]d;
    
    lab022 uut(.i(i), .D_ssd(D_ssd), .d(d));
    
    initial begin
    
    i[3:0] = 4'd0;
    
    #100 i[3:0] = 4'd1;
    #100 i[3:0] = 4'd2;
    #100 i[3:0] = 4'd3;
    #100 i[3:0] = 4'd4;
    #100 i[3:0] = 4'd5;
    #100 i[3:0] = 4'd6;
    #100 i[3:0] = 4'd7;
    #100 i[3:0] = 4'd8;
    #100 i[3:0] = 4'd9;
    #100 i[3:0] = 4'd10;
    
    end
    
endmodule
