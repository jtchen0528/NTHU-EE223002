module speaker(
    input clk,
    input rst_n,
    input PS2_CLK,
    input PS2_DATA,
    input sw,
//    input [6:0]inhigh,
//    input [6:0]inlow,
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin,
    output [3:0]ssd_ctl,
    output [0:7]display
    );
    
    wire [15:0] audio_in_left, audio_in_right;
    wire [21:0]note_div1;
    wire [21:0]note_div2;
    wire clk_out;
    wire [1:0]ssd_ctl_en;
    wire [4:0]note1;
    wire [4:0]note2;
    wire [3:0]notes1;
    wire [3:0]notes2;
    wire [3:0]notes3;
    wire [3:0]notes4;
    wire [0:7] disp0, disp1, disp2, disp3;
    
    freq_div Ufd(.clk_out(clk_out), .clk(clk), .rst(rst_n), .ssd_ctl_en(ssd_ctl_en));
    
    keyboard Ukb(
        .CLK(clk),    //board clock
        .sw(sw),
        .PS2_CLK(PS2_CLK),    //keyboard clock and data signals
        .PS2_DATA(PS2_DATA),
        .notes(note1),
        .notes2(note2)
        );
        
 /*   keyboard2 Ukb(
         .CLK(clk),    //board clock
         .inhigh(inhigh),
         .inlow(inlow),
         .notes(note1),
         .notes2(note2)
         );*/
    
    note Untone(.clk(clk),
             .rst_n(rst_n),
             .notes(note1),
             .note_div(note_div1),
             .note1(notes1),
             .note2(notes2)
             );
             
        note Unttwo(.clk(clk),
             .rst_n(rst_n),
             .notes(note2),
             .note_div(note_div2),
             .note1(notes3),
             .note2(notes4)
             );    
             
         note_gen Ungleft(.clk(clk),
             .rst_n(rst_n),
             .note_div(note_div1),
             .vol(5'd6),
             .audio_out(audio_in_left));
             
         note_gen Ungright(.clk(clk),
             .rst_n(rst_n),
             .note_div(note_div2),
             .vol(5'd6),    
             .audio_out(audio_in_right));
                
    speaker_control Usc(.clk(clk),
        .rst_n(rst_n),
        .audio_in_left(audio_in_left),
        .audio_in_right(audio_in_right),
        .audio_mclk(audio_mclk),
        .audio_lrck(audio_lrck),
        .audio_sck(audio_sck),
        .audio_sdin(audio_sdin));
        
    ssd_note1 U_SSD3(
          .display(disp3),
          .bcd(notes3));
    ssd_note2 U_SSD2(
          .display(disp2),
          .bcd(notes4));
    ssd_note1 U_SSD1(
          .display(disp1),
          .bcd(notes1));
    ssd_note2 U_SSD0(
          .display(disp0),
          .bcd(notes2));
                                      
    ssd_ctl U_CTL(
          .display_c(ssd_ctl),
          .display(display),
          .ssd_ctl_en(ssd_ctl_en),
          .display0(disp0),
          .display1(disp1),
          .display2(disp2),
          .display3(disp3));
endmodule