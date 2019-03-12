`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/08 00:58:42
// Design Name: 
// Module Name: decoder2
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


module decoder2(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7);
	input a,b,c;
    output d0,d1,d2,d3,d4,d5,d6,d7;
    assign d0=(~a&~b&~c),
         d1=(~a&~b&c),
         d2=(~a&b&~c),
         d3=(~a&b&c),
         d4=(a&~b&~c),
         d5=(a&~b&c),
         d6=(a&b&~c),
         d7=(a&b&c);
endmodule
