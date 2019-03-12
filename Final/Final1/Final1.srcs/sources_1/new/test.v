`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/01 17:11:54
// Design Name: 
// Module Name: test
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


module test(
    input [5:0]key,
    output reg [4:0]notes,
    input clk
    );
    
    always @(posedge clk) begin
        case(key)
            6'd0: notes <= 5'd0;
            6'd1: notes <= 5'd1;
            6'd2: notes <= 5'd2;
            6'd3: notes <= 5'd3;
            6'd4: notes <= 5'd4;
            6'd5: notes <= 5'd5;
            6'd6: notes <= 5'd6;
            6'd7: notes <= 5'd7;
            6'd8: notes <= 5'd8;
            6'd9: notes <= 5'd9;
            6'd10: notes <= 5'd10;
            6'd11: notes <= 5'd11;
            6'd12: notes <= 5'd12;
            6'd13: notes <= 5'd13;
            6'd14: notes <= 5'd14;
            6'd15: notes <= 5'd15;
            6'd63: notes <= 5'd16;
        endcase
    end
    
endmodule
