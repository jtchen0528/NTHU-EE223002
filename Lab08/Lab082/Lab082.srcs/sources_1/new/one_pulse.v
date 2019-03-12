`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/16 17:18:50
// Design Name: 
// Module Name: one_pulse
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


module one_pulse(
    input clk,
    input rst,
    input in_trig,
    output reg one_pulse
    );
    reg in_trig_delay;
    reg one_pulse_next;
    
    always @* begin
        one_pulse_next = in_trig & (~in_trig_delay);
    end
    
    always @(posedge clk or posedge rst) begin
        if(rst)
            in_trig_delay <= 1'b0;
        else
            in_trig_delay <= in_trig;
    end
    
    always @(posedge clk or posedge rst) begin
        if(rst)
            one_pulse <= 1'b0;
        else
            one_pulse <= one_pulse_next;
    end
endmodule

