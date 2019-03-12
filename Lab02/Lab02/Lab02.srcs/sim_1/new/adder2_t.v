`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/10 20:59:02
// Design Name: 
// Module Name: adder2_t
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


module adder2_t;

    reg [3:0]A;
    reg [3:0]B;
    reg cin;
    wire cout;
    wire [3:0]S;
 
    adder2 uut(.A(A), .B(B), .cin(cin), .cout(cout), .S(S));
    
    initial begin
    A[3:0] = 4'b0000; B[3:0] = 4'b0000; cin = 1'b0;
    
    #100 A[3:0] = 4'b1001; B[3:0] = 4'b1001; cin = 1'b0;
    #100 A[3:0] = 4'b1000; B[3:0] = 4'b0011; cin = 1'b0;
    #100 A[3:0] = 4'b0100; B[3:0] = 4'b0101; cin = 1'b1;
    end
endmodule