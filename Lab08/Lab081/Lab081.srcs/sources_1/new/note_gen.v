module note_gen ( clk , 
    rst_n,
    note_div,
    audio_left,
    audio_right
);

input clk;
input rst_n;
input [21:0]note_div;
output [15:0]audio_left;
output [15:0]audio_right;

reg [21:0]cnt_next;
reg [21:0]cnt;
reg b_clk, b_clk_next;
    
    always @(posedge clk or negedge rst_n)
    if (~rst_n)
    begin
        cnt<=22'd0;
        b_clk <= 1;
    end
    else
    begin
        if(cnt==note_div)
        begin
            cnt <= 22'd0;
            b_clk <= ~b_clk;
        end
        else 
        cnt<=cnt + 22'd1;
    end


assign audio_left = (b_clk == 1'b0) ? 16'hD800 : 16'h2FFF;
assign audio_right = (b_clk == 1'b0) ? 16'hD800 : 16'h2FFF;

endmodule