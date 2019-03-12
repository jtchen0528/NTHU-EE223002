`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/22 23:16:32
// Design Name: 
// Module Name: lab04bo
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
module lab04bo(
    input clk,
    input rst,
    input rlsw,
    input bot,
    input [2:0]type,
    output [7:0]D_ssd,
    output [3:0]ssd_ctl
    );
    
    reg [7:0]D_ssd;
    reg [3:0]order;
    reg num;
    reg [3:0]ssd_ctl;
    reg [26:0]count;

    
    always @(posedge clk or negedge rst)
    begin
        if(rst)
        begin
            order <= 4'b1010;
            count <= 27'd0;
        end
        else
        begin
        if(bot == 1)
        begin
        if(count == 27'd49999999)
        begin
            if(type == 3'b100)
            begin
                if(rlsw == 1)
                begin
                    order[0] <= order[1];
                    order[1] <= order[2];
                    order[2] <= order[3];
                    order[3] <= 4'd0;
                end
                else
                begin
                    order[3] <= order[2];
                    order[2] <= order[1];
                    order[1] <= order[0];
                    order[0] <= 4'd0;
                end
            end
            else 
            begin
                if(type == 3'b010)
                begin
                    if(rlsw == 1)
                    begin
                        order[0] <= order[1];
                        order[1] <= order[2];
                        order[2] <= order[3];
                        order[3] <= order[3];
                    end
                    else
                    begin
                        order[3] <= order[2];
                        order[2] <= order[1];
                        order[1] <= order[0];
                        order[0] <= 4'd0;
                    end
                end
                else
                begin
                    if(rlsw == 1)
                    begin
                        order[0] <= order[1];
                        order[1] <= order[2];
                        order[2] <= order[3];
                        order[3] <= order[0];
                    end
                    else
                    begin
                        order[3] <= order[2];
                        order[2] <= order[1];
                        order[1] <= order[0];
                        order[0] <= order[3];
                    end
                end
            count <= 27'd0;
            end

        end
        end
        count <= count + 26'd1;
        case(count[17:16])
            2'b00 : ssd_ctl = 4'b1110;
            2'b01 : ssd_ctl = 4'b1101;
            2'b10 : ssd_ctl = 4'b1011;
            2'b11 : ssd_ctl = 4'b0111;
        endcase
        case(ssd_ctl)
            4'b1110: num = order[0];
            4'b1101: num = order[1];
            4'b1011: num = order[2];
            4'b0111: num = order[3];
        endcase
        case (num)
            1'd0: D_ssd = `SS_0; 
            1'd1: D_ssd = `SS_1;
            default: D_ssd = 8'b11111111;
        endcase
        end
    end
    
endmodule

