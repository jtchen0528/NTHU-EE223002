module speaker_t;
    reg clk;
    reg rst_n;
    reg [2:0]in;
    reg [1:0]invol;
    wire audio_mclk;
    wire audio_lrck;
    wire audio_sck;
    wire audio_sdin;
    wire [3:0]ssd_ctl;
    wire [0:7]display;
   
    
    speaker uus(.clk(clk), .rst_n(rst_n), .in(in), .invol(invol), .audio_mclk(audio_mclk),.audio_lrck(audio_lrck), .audio_sck(audio_sck),.audio_sdin(audio_sdin),
    .ssd_ctl(ssd_ctl),.display(display)

    );
    
    initial begin
    clk = 0; rst_n = 0; in = 100; invol = 00;
    #2 rst_n = 1;
    #4 rst_n = 0;
    #10 invol = 01;
    #1 invol = 00;
    #10 invol = 01;
    #1 invol = 00;
    #10 invol = 01;
    #1 invol = 00;
    #30 in = 010;
    end
    always
    
    #0.025 clk = ~clk;
    

endmodule