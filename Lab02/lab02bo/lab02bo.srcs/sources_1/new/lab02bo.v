`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/12 17:15:33
// Design Name: 
// Module Name: lab02bo
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


module lab02bo(
    input [3:0]A,
    input [3:0]B,
    output X
    );
    
    reg X;
    
    always @*
    begin
        if(A>B)
        begin
            X = 1;
        end
        else
            X=0;
    end
    
endmodule
