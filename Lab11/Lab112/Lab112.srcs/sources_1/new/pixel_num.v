`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/24 15:55:33
// Design Name: 
// Module Name: pixel_num
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


module pixel_num(
    input [9:0]h_cnt,
    input [9:0]v_cnt,
    input [9:0]shift,
    input [3:0]num,
    input [3:0]vgaRed2,
    input [3:0]vgaGreen2,
    input [3:0]vgaBlue2,
    output reg [3:0]vgaRed,
    output reg [3:0]vgaGreen,
    output reg [3:0]vgaBlue,
    input valid
    );
    
    always @(*) begin
    if(!valid) begin
          {vgaRed, vgaGreen, vgaBlue} = {vgaRed2, vgaGreen2, vgaBlue2};
     end
     else begin
         case(num)
             4'd0: begin
                if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                   ((h_cnt > (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                   ((h_cnt > (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                end
             end
             4'd1: begin
                if(((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                end
             end
             4'd2: begin
                if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                   ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd32))) begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                end
             end
             4'd3: begin
                if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                   ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd32))) begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                end
             end
             4'd4: begin
                if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                   ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))) begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                end
             end
             4'd5: begin
                if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                   ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd32))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))) begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                end
             end
             4'd6: begin
                if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                   ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd32))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                end
             end
             4'd7: begin
                if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                   ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                end
             end
             4'd8: begin
                if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                   ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                end
             end
             4'd9: begin
                if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                   ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))) begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                end
             end
         default: begin
            {vgaRed, vgaGreen, vgaBlue} = {vgaRed2, vgaGreen2, vgaBlue2};
         end
         endcase         
     end
    end
endmodule
