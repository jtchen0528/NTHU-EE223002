`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/21 00:23:21
// Design Name: 
// Module Name: shifter
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

`define BIT_WIDTH 8
module shifter(
    q,
    clk, 
    rst
    );
    
    output [`BIT_WIDTH-1:0]q;
    input clk;
    input rst;
    
    reg [`BIT_WIDTH-1:0]q;

    
    always @(posedge clk or posedge rst)
    
        if(rst)
        begin
           q <= `BIT_WIDTH'b01010101;
        end
        else 
        begin
            q[0]<=q[7];
            q[1]<=q[0];
            q[2]<=q[1];
            q[3]<=q[2];
            q[4]<=q[3];
            q[5]<=q[4];
            q[6]<=q[5];
            q[7]<=q[6];
        end
    
    
    
endmodule
