`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/05 00:50:42
// Design Name: 
// Module Name: FSM_t
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


module FSM_t;

    wire freeze_enable;
    wire [2:0]mode;
    reg [3:0]in;
    reg clk;
    reg rst;
    
    FSM uut2(.freeze_enable(freeze_enable),
        .mode(mode),
        .in(in),
        .clk(clk),
        .rst(rst)
        );
        
     initial begin
        clk = 1; rst = 0; in = 4'b0000;
        #0.1 rst = 1;
        #0.1 rst = 0;
        #1 in = 4'b0000;
        #1 in = 4'b1000;
        #1 in = 4'b1100;
        #1 in = 4'b0100;
        #1 in = 4'b0110;
        #1 in = 4'b0010;
        #1 in = 4'b0011;
        #1 in = 4'b0001;
        

        end
        always
        #0.0025 clk = ~clk;

endmodule
