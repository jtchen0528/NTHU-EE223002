`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/08 00:40:32
// Design Name: 
// Module Name: decoder
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


module decoder(
    input [2:0]A,
    output [7:0]B
    );
    reg [7:0]out;
    assign B = out;
    always @(A or B)
        begin
        case (A)
            3'b000: out = 8'b10000000;
            3'b001: out = 8'b01000000;
            3'b010: out = 8'b00100000;
            3'b011: out = 8'b00010000;
            3'b100: out = 8'b00001000;
            3'b101: out = 8'b00000100;
            3'b110: out = 8'b00000010;
            3'b111: out = 8'b00000001;
            default: out = 8'b00000000;
        endcase
        end
    
endmodule
