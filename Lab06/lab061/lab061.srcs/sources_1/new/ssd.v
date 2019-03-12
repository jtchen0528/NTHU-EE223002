`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/04 19:16:22
// Design Name: 
// Module Name: ssd
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

`include "global.v"
module ssd(
    output [0:`SSD_BIT_WIDTH-1]display,
    input [`BCD_BIT_WIDTH-1:0]bcd
    );
    
    reg [0:`SSD_BIT_WIDTH-1]display;
    
    always @(bcd)
    case(bcd)
        `BCD_BIT_WIDTH'd0: display = `SSD_ZERO;
        `BCD_BIT_WIDTH'd1: display = `SSD_ONE;
        `BCD_BIT_WIDTH'd2: display = `SSD_TWO;
        `BCD_BIT_WIDTH'd3: display = `SSD_THREE;
        `BCD_BIT_WIDTH'd4: display = `SSD_FOUR;
        `BCD_BIT_WIDTH'd5: display = `SSD_FIVE;
        `BCD_BIT_WIDTH'd6: display = `SSD_SIX;
        `BCD_BIT_WIDTH'd7: display = `SSD_SEVEN;
        `BCD_BIT_WIDTH'd8: display = `SSD_EIGHT;
        `BCD_BIT_WIDTH'd9: display = `SSD_NINE;
        default: display = `SSD_DEF;
    endcase
    
endmodule

