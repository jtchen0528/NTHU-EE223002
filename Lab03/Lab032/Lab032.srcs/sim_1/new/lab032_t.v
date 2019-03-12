`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/17 23:34:46
// Design Name: 
// Module Name: lab032_t
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


module lab032_t;

    wire clk_out; // divided output
    reg clk; // global clock input
    reg rst;
    
    lab032 uut(.clk_out(clk_out), .clk(clk), .rst(rst));
    
    initial begin
     clk = 1; rst = 0; 
     #10 rst = 1;
     #20 rst = 0;
    end
    always
    #1 clk = ~clk;
    
    
    

endmodule

