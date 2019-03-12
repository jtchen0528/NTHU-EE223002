`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/22 21:13:06
// Design Name: 
// Module Name: lab043
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
module lab043(
    ssd,
    clk,
    rst,
    ssd_ctl
    );
    
    output [`BIT_WIDTH-1:0]ssd;
    output [3:0]ssd_ctl;
    input clk;
    input rst;
    wire clk_d;
    wire [`BIT_WIDTH-1:0]ssd;
    wire [3:0]ssd_ctl;
    
    reg [19:0]cnt;
    reg [3:0]ssd_ctl;
    
    lab043_fre U_FD(.clk_out(clk_d), .clk(clk), .rst(rst));
    
    lab043_shif U_D(.ssd(ssd), .clk(clk_d), .rst(rst));
    
    always @(posedge clk)
    begin
        cnt <= cnt + 20'd1;
        case(cnt[17:16])
            2'b00 : ssd_ctl = 4'b1110;
            2'b01 : ssd_ctl = 4'b1101;
            2'b10 : ssd_ctl = 4'b1011;
            2'b11 : ssd_ctl = 4'b0111;
        endcase
        case(ssd_ctl)
            
        endcase
    end
    
    
endmodule
