`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/16 17:18:50
// Design Name: 
// Module Name: pb_func
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


module pb_func(
    input clk,
    input pb_in,
    output pb_out
    );
    wire pb_debounce;
    debounce Udeb(.clk(clk),.pb_in(pb_in),.pb_debounce(pb_debounce));
    one_pulse Uo_p(.clk(clk),.in_trig(pb_debounce),.one_pulse(pb_out));
endmodule

