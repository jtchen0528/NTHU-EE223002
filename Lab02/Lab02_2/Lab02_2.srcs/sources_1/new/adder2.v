`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/10 22:39:39
// Design Name: 
// Module Name: adder2
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


module adder2(
    input [3:0]A,
    input [3:0]B,
    input cin,
    output [3:0]S,
    output  cout

    );
reg [4:0]Z;

assign S = Z[3:0];
assign cout = Z[4];

always @(A or B or cin)
begin
    Z = A + B + cin;
    if(Z>9)
    begin
        Z = Z + 6;
    end
end

endmodule
