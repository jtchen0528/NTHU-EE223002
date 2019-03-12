module LFSR_t;

    reg clk;
    reg clk_random;
    reg rst;
    wire [5:0]out;
    
    LFSR U_lfsr(.clk(clk), .clk_random(clk_random), .rst(rst), .out(out));
    
    initial begin
    
        clk = 0; clk_random = 0; rst = 0;
        
        #1 rst = 1;
        #2 rst = 0;
     end    
        always #0.5 clk = ~clk; 
        always #5 clk_random = ~clk_random;
    
   


endmodule
