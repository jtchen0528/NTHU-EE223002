

module speaker_control_t;

    reg clk;
    reg rst_n;
    reg [15:0]audio_in_left;
    reg [15:0]audio_in_right;
    wire audio_mclk;
    wire audio_lrck;
    wire audio_sck;
    wire audio_sdin;

    
    speaker_control uus(.clk(clk), .rst_n(rst_n), .audio_in_left(audio_in_left),
    .audio_in_right(audio_in_right), .audio_mclk(audio_mclk), .audio_lrck(audio_lrck), .audio_sck(audio_sck), .audio_sdin(audio_sdin)

        );
    initial begin
        clk = 0; rst_n = 1; audio_in_left = 16'hB000; audio_in_right = 16'hB000; 
        #2 rst_n = 0;
        #4 rst_n = 1;
        #50 audio_in_left = 16'hB000; audio_in_right = 16'hB000;
        #50 audio_in_left = 16'h5FFF; audio_in_right = 16'h5FFF;
        #50 audio_in_left = 16'hB000; audio_in_right = 16'hB000;
                #50 audio_in_left = 16'h5FFF; audio_in_right = 16'h5FFF;
                #50 audio_in_left = 16'hB000; audio_in_right = 16'hB000;
                        #50 audio_in_left = 16'h5FFF; audio_in_right = 16'h5FFF;
                        #50 audio_in_left = 16'hB000; audio_in_right = 16'hB000;
                                #50 audio_in_left = 16'h5FFF; audio_in_right = 16'h5FFF;
                                #50 audio_in_left = 16'hB000; audio_in_right = 16'hB000;
                                        #50 audio_in_left = 16'h5FFF; audio_in_right = 16'h5FFF;
                                        #50 audio_in_left = 16'hB000; audio_in_right = 16'hB000;
                                                #50 audio_in_left = 16'h5FFF; audio_in_right = 16'h5FFF;


        end
        always
        
        #0.025 clk = ~clk;


endmodule
