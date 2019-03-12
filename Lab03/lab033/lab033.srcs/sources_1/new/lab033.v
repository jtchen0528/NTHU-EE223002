`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/18 17:07:57
// Design Name: 
// Module Name: lab033
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


module lab033(
    input clk,
    input rst,
    output [3:0]b
    );
    
    reg [25:0]counter;
    reg [3:0]b;
     
    always @(posedge clk or negedge rst)
    begin
    if(rst)
    begin
       counter<=26'd0;
       b <= 4'd0;
    end
    else
    begin
       if(counter==26'd49999999)
       begin
          counter<=26'd0;
          b <= b + 4'd1;
       end
    end
    counter<=counter+1;
    end
endmodule
