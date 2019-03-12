module note_gen ( clk , 
    rst_n,
    note_div,
    vol,
    audio_left,
    audio_right
);

input clk;
input rst_n;
input [21:0]note_div;
input [4:0]vol;
output [15:0]audio_left;
output [15:0]audio_right;

reg [21:0]cnt;
reg b_clk, b_clk_next;
reg [15:0]volu;
reg [15:0]volu2;

    always @(posedge clk or posedge rst_n)
    if (rst_n)
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
        else begin
        cnt<=cnt + 22'd1;
        end
    case(vol)
        4'd0: begin volu2 = 16'h0000; volu = 16'h0000; end
        4'd1: begin volu2 = 16'h0000 - (16'd320*1); volu = 16'h0000 + (16'd384*1); end
        4'd2: begin volu2 = 16'h0000 - (16'd320*2); volu = 16'h0000 + (16'd384*2); end
        4'd3: begin volu2 = 16'h0000 - (16'd320*3); volu = 16'h0000 + (16'd384*3); end
        4'd4: begin volu2 = 16'h0000 - (16'd320*4); volu = 16'h0000 + (16'd384*4); end
        4'd5: begin volu2 = 16'h0000 - (16'd320*5); volu = 16'h0000 + (16'd384*5); end
        4'd6: begin volu2 = 16'h0000 - (16'd320*6); volu = 16'h0000 + (16'd384*6); end
        4'd7: begin volu2 = 16'h0000 - (16'd320*7); volu = 16'h0000 + (16'd384*7); end
        4'd8: begin volu2 = 16'h0000 - (16'd320*8); volu = 16'h0000 + (16'd384*8); end
        4'd9: begin volu2 = 16'h0000 - (16'd320*9); volu = 16'h0000 + (16'd384*9); end
        4'd10: begin volu2 = 16'h0000 - (16'd320*10); volu = 16'h0000 + (16'd384*10); end
        4'd11: begin volu2 = 16'h0000 - (16'd320*11); volu = 16'h0000 + (16'd384*11); end
        4'd12: begin volu2 = 16'h0000 - (16'd320*12); volu = 16'h0000 + (16'd384*12); end
        4'd13: begin volu2 = 16'h0000 - (16'd320*13); volu = 16'h0000 + (16'd384*13); end
        4'd14: begin volu2 = 16'h0000 - (16'd320*14); volu = 16'h0000 + (16'd384*14); end
        4'd15: begin volu2 = 16'h0000 - (16'd320*15); volu = 16'h0000 + (16'd384*15); end
    endcase
end
assign audio_left = (b_clk == 1'b0) ? volu2 : volu;
assign audio_right = (b_clk == 1'b0) ? volu2 : volu;

endmodule