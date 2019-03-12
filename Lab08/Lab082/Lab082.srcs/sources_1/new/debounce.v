`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/16 17:18:50
// Design Name: 
// Module Name: debounce
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


module debounce(
    input clk,
    input rst,
    input pb_in,
    output reg pb_debounce
    );
    reg [3:0]debounce_window;
    reg pb_debounce_next;
    
    always @* begin
        pb_debounce_next = (debounce_window == 4'b1111);
    end
    always @(posedge clk or posedge rst) begin
        if(rst)
            debounce_window <= 4'b0000;
        else
            debounce_window <= {debounce_window[2:0],pb_in};
    end
    always @(posedge clk or posedge rst) begin
        if(rst)
            pb_debounce <= 1'b0;
        else
            pb_debounce <= pb_debounce_next;
    end
endmodule

