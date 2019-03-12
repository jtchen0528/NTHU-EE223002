`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/17 19:47:11
// Design Name: 
// Module Name: lab03pre
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


module lab03pre(
    input clk, input reset,
    output [3:0]out
    );
    
    reg [3:0]out;
        
    always @(posedge clk or negedge reset)
        if(reset)
            out <= 4'd0;
        else
            out = out + 1;
   
    
endmodule
