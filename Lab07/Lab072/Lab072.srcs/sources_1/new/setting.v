`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/14 16:18:42
// Design Name: 
// Module Name: setting
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


module setting(
    input setting,
    input in1,
    input in2,
    output [5:0]init_sec,
    output [5:0]init_min,
    output [5:0]init_hr
    );
    
    reg [5:0]sec;
    reg [5:0]min;
    reg [5:0]hr;
    
    always @*
    begin
        if(setting == 1)
        begin
            if(in2 == 1)
            begin
                sec = sec + 6'd1;
            end
            if(in1 == 1)
            begin
                
            end
        end
    end
    
endmodule
