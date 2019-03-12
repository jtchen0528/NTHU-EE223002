`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/22 22:18:29
// Design Name: 
// Module Name: lab043_test
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


`define SS_n 8'b11010101
`define SS_t 8'b11100001
`define SS_h 8'b10010001
`define SS_u 8'b10000011
`define SS_e 8'b01100001
`define SS_f 8'b01110010
module lab043_test(
    input clk,
    input rst,
    output [7:0]D_ssd,
    output [3:0]ssd_ctl
    );
    
    reg [25:0]count;
    reg [7:0]D_ssd;
    reg [2:0]order;
    reg [2:0]order0;
    reg [2:0]order1;
    reg [2:0]order2;
    reg [2:0]order3;
    reg [2:0]order4;
    reg [2:0]order5;
    reg [3:0]ssd_ctl;

    
    always @(posedge clk or negedge rst)
    begin
        if(rst)
        begin
            count <= 26'd0;
            order0 <= 3'd0;
            order1 <= 3'd1;
            order2 <= 3'd2;
            order3 <= 3'd3;
            order4 <= 3'd4;
            order5 <= 3'd5;
        end
        else
        begin
            if(count == 26'd49999999)
            begin
                count <= 26'd0;
                order0 <= order5;
                order1 <= order0;
                order2 <= order1;
                order3 <= order2;
                order4 <= order3;
                order5 <= order4;
            end
        count <= count + 26'd1;
        case(count[17:16])
            2'b00 : ssd_ctl = 4'b1110;
            2'b01 : ssd_ctl = 4'b1101;
            2'b10 : ssd_ctl = 4'b1011;
            2'b11 : ssd_ctl = 4'b0111;
        endcase
        case(ssd_ctl)
            4'b1110: order = order1;
            4'b1101: order = order2;
            4'b1011: order = order3;
            4'b0111: order = order4;
        endcase
        case (order)
            3'd0: D_ssd = `SS_e; 
            3'd1: D_ssd = `SS_u;
            3'd2: D_ssd = `SS_h;
            3'd3: D_ssd = `SS_t;
            3'd4: D_ssd = `SS_n;
            3'd5: D_ssd = `SS_e;
            default: D_ssd = `SS_f;
        endcase
        end
    end
    
endmodule

