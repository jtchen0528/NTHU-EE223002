`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/05 18:43:58
// Design Name: 
// Module Name: adder
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


module adder(
    input a3,
    input a2,
    input a1,
    input a0,
    input b3,
    input b2,
    input b1,
    input b0,
    input cin,
    output s3,
    output s2,
    output s1,
    output s0,
    output cout3,
    output cout2,
    output cout1,
    output cout0
    );
    assign s3= a3^b3^cin;
    assign cout3 = (a3&b3)|(b3&cin)|(cin&a3);
    assign s2= a2^b2^cout3;
    assign cout2 = (a2&b2)|(b2&cout3)|(cout3&a2);
    assign s1= a1^b1^cout2;
    assign cout1 = (a1&b1)|(b1&cout2)|(cout2&a1);
    assign s0= a0^b0^cout1;
    assign cout0 = (a0&b0)|(b0&cout1)|(cout1&a0);
always @(*)    
    if(cout0==1)
    begin
      
    end
    
endmodule
