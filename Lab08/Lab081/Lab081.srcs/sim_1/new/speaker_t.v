`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/23 14:22:37
// Design Name: 
// Module Name: speaker_t
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


module speaker_t;

    reg clk;
    reg rst_n;
    wire audio_mclk;
    wire audio_lrck;
    wire audio_sck;
    wire audio_sdin;
//    wire [15:0]audio_in_left;
 //   wire [15:0]audio_in_right;
    
    
    speaker uus(.clk(clk), .rst_n(rst_n), .audio_mclk(audio_mclk), .audio_lrck(audio_lrck), .audio_sck(audio_sck), .audio_sdin(audio_sdin)
   // .audio_in_left(audio_in_left),
   // .audio_in_right(audio_in_right)
    
    );
    
    initial begin
    clk = 0; rst_n = 1;
    #2 rst_n = 0;
    #4 rst_n = 1;
    end
    always
    
    #0.025 clk = ~clk;
    

endmodule
