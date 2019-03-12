module speaker_control(
    input clk,
    input rst_n,
    input [15:0]audio_in_left,
    input [15:0]audio_in_right,
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin
);

reg [21:0]clk_cnt;
reg audio_sdin;
reg [5:0]sdincnt;
reg [15:0]left;
reg [15:0]right;

assign audio_mclk = clk_cnt[1];
assign audio_lrck = clk_cnt[8];
assign audio_sck = 1;

always @(posedge clk or posedge rst_n)
    if(rst_n) begin
        clk_cnt <= 22'd0;
        sdincnt <= 6'd0;
        left <= 16'd0;
        right <= 16'd0;
    end
    else
    begin
        clk_cnt <= clk_cnt + 22'd1;
        if(clk_cnt[3:0]==4'b0000)
        begin
            sdincnt <= sdincnt + 6'd1;
            if(sdincnt == 6'd31)
            begin
                sdincnt <= 6'd0;

            end
        end
        left <= audio_in_left;
        right <= audio_in_right;
        case(sdincnt)
               6'd0: audio_sdin <= right[0];
               6'd1: audio_sdin <= left[15];
               6'd2: audio_sdin <= left[14];
               6'd3: audio_sdin <= left[13];
               6'd4: audio_sdin <= left[12];
               6'd5: audio_sdin <= left[11];
               6'd6: audio_sdin <= left[10];
               6'd7: audio_sdin <= left[9];
               6'd8: audio_sdin <= left[8];
               6'd9: audio_sdin <= left[7];
               6'd10: audio_sdin <= left[6];
               6'd11: audio_sdin <= left[5];
               6'd12: audio_sdin <= left[4];
               6'd13: audio_sdin <= left[3];
               6'd14: audio_sdin <= left[2];
               6'd15: audio_sdin <= left[1];
               6'd16: audio_sdin <= left[0];
               6'd17: audio_sdin <= right[15];
               6'd18: audio_sdin <= right[14];
               6'd19: audio_sdin <= right[13];
               6'd20: audio_sdin <= right[12];
               6'd21: audio_sdin <= right[11];
               6'd22: audio_sdin <= right[10];
               6'd23: audio_sdin <= right[9];
               6'd24: audio_sdin <= right[8];
               6'd25: audio_sdin <= right[7];
               6'd26: audio_sdin <= right[6];
               6'd27: audio_sdin <= right[5];
               6'd28: audio_sdin <= right[4];
               6'd29: audio_sdin <= right[3];
               6'd30: audio_sdin <= right[2];
               6'd31: audio_sdin <= right[1];
           endcase
    end

endmodule