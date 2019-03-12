`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/18 22:23:53
// Design Name: 
// Module Name: lab03bo
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

`define SS_0 8'b00000011
`define SS_1 8'b10011111
`define SS_2 8'b00100101
`define SS_3 8'b00001101
`define SS_4 8'b10011001
`define SS_5 8'b01001001
`define SS_6 8'b01000001
`define SS_7 8'b00011111
`define SS_8 8'b00000001
`define SS_9 8'b00001001
module lab03bo(
    input clk,
    input rst,
    output [7:0]D_ssd,
    output [3:0]ssd_ctl
    );
    
    reg [26:0]count;
    reg [7:0]D_ssd;
    reg [3:0]watch0;
    reg [3:0]watch1;
    reg [3:0]watch;
    reg [3:0]ssd_ctl;

    
    always @(posedge clk or negedge rst)
    begin
        if(rst)
        begin
            count <= 27'd0;
            watch0 <= 4'd0;
            watch1 <= 4'd3;
        end
        else
        begin
            if(count == 27'd49999999)
            begin
                count <= 27'd0;
                watch0 <= watch0 - 'd1; 
                if(watch0 == 4'd0)
                begin
                    if(watch1 == 4'd0)
                    begin
                        watch0 <= 4'd0;
                        watch1 <= 4'd0;
                    end
                    else
                    begin
                        watch0 <= 4'd9;
                        watch1 <= watch1 - 4'd1;
                    end
                end
            end
        count <= count + 27'd1;
        case(count[17:16])
            2'b00 : ssd_ctl = 4'b1110;
            2'b01 : ssd_ctl = 4'b1101;
            2'b10 : ssd_ctl = 4'b1110;
            2'b11 : ssd_ctl = 4'b1101;
        endcase
        case(ssd_ctl)
            4'b1110: watch = watch0;
            4'b1101: watch = watch1; 
        endcase
        case (watch)
            4'd0: D_ssd = `SS_0; 
            4'd1: D_ssd = `SS_1;
            4'd2: D_ssd = `SS_2;
            4'd3: D_ssd = `SS_3;
            4'd4: D_ssd = `SS_4;
            4'd5: D_ssd = `SS_5;
            4'd6: D_ssd = `SS_6;
            4'd7: D_ssd = `SS_7;
            4'd8: D_ssd = `SS_8;
            4'd9: D_ssd = `SS_9;
            default: D_ssd = 8'b01110001;
        endcase
        end
    end
    
endmodule
