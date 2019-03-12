module note_gen_t;

    reg clk;
    reg rst_n;
reg [21:0]note_div;
    wire [15:0]audio_left;
    wire [15:0]audio_right;

//    wire [15:0]audio_in_left;
 //   wire [15:0]audio_in_right;
    
    
    note_gen uus(.clk(clk), .rst_n(rst_n), .note_div(note_div), .audio_left(audio_left), .audio_right(audio_right)
   // .audio_in_left(audio_in_left),
   // .audio_in_right(audio_in_right)
    
    );
    
    initial begin
    clk = 0; rst_n = 0; note_div = 22'd191571;
    #2 rst_n = 1;
    #4 rst_n = 0;
    end
    always
    
    #0.025 clk = ~clk;
    

endmodule