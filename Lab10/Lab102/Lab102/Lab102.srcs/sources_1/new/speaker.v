module speaker(
    input clk,
    input rst_n,
    input PS2_CLK,
    input PS2_DATA,
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin,
    output [3:0]ssd_ctl,
    output [0:7]display
    );
    
    wire [15:0] audio_in_left, audio_in_right;
    wire [21:0]note_div;
    wire clk_out;
    wire [1:0]ssd_ctl_en;
    wire [3:0]note1;
    wire [3:0]note2;
    wire [4:0]notes;
    wire [0:7] disp0, disp1, disp2, disp3;
    
    freq_div Ufd(.clk_out(clk_out), .clk(clk), .rst(rst_n), .ssd_ctl_en(ssd_ctl_en));
    
    keyboard Ukb(
        .CLK(clk),    //board clock
        .PS2_CLK(PS2_CLK),    //keyboard clock and data signals
        .PS2_DATA(PS2_DATA),
        .notes(notes)
        );
    
    note Unt(.clk(clk),
        .rst_n(rst_n),
        .notes(notes),
        .note_div(note_div),
        .note1(note1),
        .note2(note2)
        );
    
    note_gen Ung(.clk(clk),
        .rst_n(rst_n),
        .note_div(note_div),
        .vol(5'd6),
        .audio_left(audio_in_left),    
        .audio_right(audio_in_right));
                
    speaker_control Usc(.clk(clk),
        .rst_n(rst_n),
        .audio_in_left(audio_in_left),
        .audio_in_right(audio_in_right),
        .audio_mclk(audio_mclk),
        .audio_lrck(audio_lrck),
        .audio_sck(audio_sck),
        .audio_sdin(audio_sdin));
        
    ssd U_SSD3(
          .display(disp3),
          .bcd(4'd15));
    ssd U_SSD2(
          .display(disp2),
          .bcd(4'd15));
    ssd_note1 U_SSD1(
          .display(disp1),
          .bcd(note1));
    ssd_note2 U_SSD0(
          .display(disp0),
          .bcd(note2));
                                      
    ssd_ctl U_CTL(
          .display_c(ssd_ctl),
          .display(display),
          .ssd_ctl_en(ssd_ctl_en),
          .display0(disp0),
          .display1(disp1),
          .display2(disp2),
          .display3(disp3));
endmodule
