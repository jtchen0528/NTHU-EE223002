`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/12 17:24:45
// Design Name: 
// Module Name: lab02bo_t
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


module lab02bo_t;
    reg [3:0]A;
    reg [3:0]B;
    wire X;
    
    lab02bo uut(.A(A), .B(B), .X(X));
    
    initial begin
    A[3:0] = 4'b0000; B[3:0] = 4'b0000;
    
    #100 A[3:0] = 4'b0001; B[3:0] = 4'b0000;
    #100 A[3:0] = 4'b0000; B[3:0] = 4'b0001; 
    #100 A[3:0] = 4'b0100; B[3:0] = 4'b0100;
    end
endmodule
