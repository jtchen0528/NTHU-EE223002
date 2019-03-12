module speaker(
    input clk,
    input rst_n,
    input [1:0]invol,
    input [5:0]key,
    input [4:0]combo,
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin
);

    wire [15:0] audio_in_left, audio_in_right;
    wire [21:0]note_div;
    wire [4:0]vol;
    wire [4:0]notes;
    wire clk_out;
    
    freq_div Ufd(.clk_out(clk_out), .clk(clk), .rst(rst_n), .ssd_ctl_en(ssd_ctl_en));
    
    volume Uvl(.clk(clk_out),
                .rst_n(rst_n),
                .invol(invol),
                .vol(vol)
                );      
  // test U_test(.clk(clk), .key(key), .notes(notes));             
  /*  note_combo(.clk(clk),
               .rst(rst_n),
               .key(key),
               .combo(conbo),
               .notes(notes));       
*/
    note Unt(.clk(clk),
        .rst_n(rst_n),
        .key(key),
        .notes(combo),
        .note_div(note_div)
        );

    note_gen Ung(.clk(clk),
                 .rst_n(rst_n),
                 .note_div(note_div),
                 .vol(vol),
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