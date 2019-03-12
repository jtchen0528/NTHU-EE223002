`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/08 00:59:56
// Design Name: 
// Module Name: decoder2_t
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


module decoder2_t;
	reg a;	reg b;	reg c;
	wire d0; wire d1; wire d2; wire d3; wire d4; wire d5; wire d6; wire d7;
    decoder2 uut (.a(a), .b(b), .c(c), .d0(d0), .d1(d1), .d2(d2),
                  .d3(d3), .d4(d4), .d5(d5), .d6(d6), .d7(d7));
    initial begin
    #100 a=0; b=0; c=0;
    #100 a=0; b=0; c=1;
    #100 a=0; b=1; c=0;
    #100 a=0; b=1; c=1;
    #100 a=1; b=0; c=0;
    #100 a=1; b=0; c=1;
    #100 a=1; b=1; c=0;
    #100 a=1; b=1; c=1;
    end
endmodule
