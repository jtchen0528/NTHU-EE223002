`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/21 14:22:38
// Design Name: 
// Module Name: speaker
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


module speaker(
    input clk,
    input rst_n,
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin
  //  output [15:0]audio_in_left,
  //  output [15:0]audio_in_right
    
    );
    
    wire [15:0] audio_in_left, audio_in_right;
    
    note_gen Ung(.clk(clk),
                 .rst_n(rst_n),
                 .note_div((22'd191571)),
                 .audio_left(audio_in_left),    
                 .audio_right(audio_in_right)    
                );
                
    speaker_control Usc(.clk(clk),
                        .rst_n(rst_n),
                        .audio_in_left(audio_in_left),
                        .audio_in_right(audio_in_right),
                        .audio_mclk(audio_mclk),
                        .audio_lrck(audio_lrck),
                        .audio_sck(audio_sck),
                        .audio_sdin(audio_sdin)
                       );
endmodule
