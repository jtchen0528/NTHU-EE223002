`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/17 23:31:44
// Design Name: 
// Module Name: lab032
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

module lab032(clk,rst,clk_out, led);
input clk,rst;
output clk_out;
output reg [3:0]led;
reg [25:0]counter;
reg clk_out;
 
always @(posedge clk or negedge rst)
begin
if(rst)
begin
   counter<=26'd0;
   clk_out <= 0;
   led <= 0;
end
else
begin
   if(counter==26'd49999999)
   begin
      counter<=26'd0;
      clk_out<=~clk_out;
      led <= led + 4'd1;
   end
end
counter<=counter+1;
end
endmodule
