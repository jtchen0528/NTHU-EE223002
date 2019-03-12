`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/08 00:49:04
// Design Name: 
// Module Name: decoder_t
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


module decoder_t;

    reg [2:0]A;
    wire [7:0]B;
    
    decoder uut(.A(A), .B(B));
    
    initial begin
    A[2:0] = 3'b000;
    #100 A[2:0] = 3'b001;
    #100 A[2:0] = 3'b010;
    #100 A[2:0] = 3'b011;
    #100 A[2:0] = 3'b100;
    #100 A[2:0] = 3'b101;
    #100 A[2:0] = 3'b110;
    #100 A[2:0] = 3'b111;
    
    end
endmodule
