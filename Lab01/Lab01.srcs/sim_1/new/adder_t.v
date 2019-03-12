`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/05 18:54:00
// Design Name: 
// Module Name: adder_t
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


module adder_t;

    reg a3;
    reg a2;
    reg a1;
    reg a0;
    reg b3;
    reg b2;
    reg b1;
    reg b0;
    reg cin;
    wire cout0;
    wire cout1;
    wire cout2;
    wire cout3;
    wire s3;
    wire s2;
    wire s1;
    wire s0;
 
    adder uut(.a3(a3), .a2(a2), .a1(a1), .a0(a0), .b3(b3), .b2(b2), .b1(b1), .b0(b0), .s3(s3), .s2(s2), .s1(s1), .s0(s0), .cin(cin), .cout0(cout0), .cout1(cout1), .cout2(cout2), .cout3(cout3));
    
    initial begin
    a3=0; a2=0; a1=0;a0=0;b3=0;b2=0;b1=0;b0=0; cin=0;
    
    #100;
    #100 a3=0; a2=0; a1=0;a0=1;b3=1;b2=0;b1=0;b0=1; cin=1;
    
    end

endmodule
