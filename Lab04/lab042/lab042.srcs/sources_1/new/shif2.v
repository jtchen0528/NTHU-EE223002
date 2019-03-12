`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/22 20:59:33
// Design Name: 
// Module Name: shif2
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
module shif2(
    q,
    in,
    clk, 
    rst
    );
    
    output [`BIT_WIDTH-1:0]q;
    input [`BIT_WIDTH-1:0]in;
    input clk;
    input rst;
    
    reg [`BIT_WIDTH-1:0]q;

    
    always @(posedge clk or posedge rst)
    
        if(rst)
        begin
           q <= in;
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
