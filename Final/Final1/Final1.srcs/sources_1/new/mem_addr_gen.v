module mem_addr_gen(
  input clk,
  input rst,
  input [2:0]diff,
  input [5:0]random,
  input [5:0]key,
  input mode,
  input win,
  input [9:0] h_cnt,
  input [9:0] v_cnt,
  output reg [16:0] pixel_addr,
  output reg [15:0] points,
  output reg [4:0]combo,
  output reg clk_random,
  output reg [2:0]life
);

reg [7:0] position;
reg [5:0] last_key = 6'd0;

always @ (posedge clk or posedge rst) begin
  if(rst) begin
    position <= 0;
    points <= 0;
    combo <= 0;
    life <= 3'd5;
  end
  else if((position < 239)) begin
  if(win == 0)begin
    if(diff == 3'b100)begin
        position <= position + 5;
        if((position == 235)&&(points > 0)) begin points <= points - 16'd5; combo <= 0; life <= life - 1; end
        if((position == 235)&&(life > 0)) begin life <= life - 1; end
    end else if(diff == 3'b010)begin
        position <= position + 3;
        if((position == 237)&&(points > 0)) begin points <= points - 16'd5; combo <= 0; life <= life - 1; end
        if((position == 237)&&(life > 0)) begin life <= life - 1; end
    end else if(diff == 3'b001)begin
        position <= position + 1;
        if((position == 238)&&(points > 0)) begin points <= points - 16'd5; combo <= 0; life <= life - 1; end
        if((position == 238)&&(life > 0)) begin life <= life - 1; end
    end
    if((key == random)||((key == 3)&&(random == 52))||
                        ((key == 5)&&(random == 53))||
                        ((key == 9)&&(random == 54))||
                        ((key == 10)&&((random == 55)&&(mode == 0)))||
                        ((key == 11)&&(random == 56))||
                        ((key == 18)&&(random == 57))||
                        ((key == 29)&&(random == 58))||
                        ((key == 31)&&(random == 59))||
                        ((key == 35)&&(random == 60))||
                        ((key == 52)&&(random == 55)&&(mode == 1))||
                        ((key == 37)&&(random == 62))||
                        ((key == 36)&&(random == 61))) begin
        last_key <= key;
        points <= points + 16'd10;
        if(combo < 5'd29) begin
            combo <= combo + 5'd1;
        end else begin
            combo <= 5'd1;
        end
        if((key == 52)&&(random == 55)&&(mode == 1)) begin
            if(life < 3'd5) life <= life + 1; 
        end
        position <= 239;
    end
    if((key != 6'd63)&&(key != last_key)&&~((key == random)||((key == 3)&&(random == 52))||
                            ((key == 5)&&(random == 53))||
                            ((key == 9)&&(random == 54))||
                            ((key == 10)&&((random == 55)&&(mode == 0)))||
                            ((key == 11)&&(random == 56))||
                            ((key == 18)&&(random == 57))||
                            ((key == 29)&&(random == 58))||
                            ((key == 31)&&(random == 59))||
                            ((key == 35)&&(random == 60))||
                            ((key == 52)&&(random == 55)&&(mode == 1))||
                            ((key == 37)&&(random == 62))||
                            ((key == 36)&&(random == 61))))begin
        last_key <= key;
        combo <= 5'd1;
        if((life > 0)) life <= life - 1; 
        if(points == 0) begin
            points <= 0;
        end else begin
            points <= points - 16'd5;
        end                 
    end  
        clk_random <= 0;
  end
  end
  else begin
    clk_random <= 1;
    position <= 0;
  end
end

always @* begin
    if(diff == 3'd000) begin
        if(h_cnt>=0 && h_cnt<320 && v_cnt>=90 && v_cnt<(90+55)) begin
            pixel_addr = 37440 + h_cnt + (v_cnt-90) * 320;
        end else
            pixel_addr = 30;
    end else if((life == 0)&&(mode == 1)) begin
        if(h_cnt>=0 && h_cnt<320 && v_cnt>=100 && v_cnt<(100+20)) begin
            pixel_addr = 61440 + h_cnt + (v_cnt-100) * 320;
        end else
            pixel_addr = 30;
    end else if(win == 1) begin
        if(h_cnt>=0 && h_cnt<320 && v_cnt>=100 && v_cnt<(100+20)) begin
            pixel_addr = 55040 + h_cnt + (v_cnt-100) * 320;
        end else
            pixel_addr = 30;
    end else begin       
    if(random == 0) begin
        if(h_cnt>=0 && h_cnt<=15 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 1) begin
        if(h_cnt>=16 && h_cnt<=30 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 2) begin
        if(h_cnt>=31 && h_cnt<=45 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if((random == 3)||(random == 52))begin
        if(h_cnt>=47 && h_cnt<=62 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 4) begin
        if(h_cnt>=63 && h_cnt<78 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if((random == 5)||(random == 53))begin
        if(h_cnt>=79 && h_cnt<=93 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 6) begin
        if(h_cnt>=94 && h_cnt<108 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 7) begin
        if(h_cnt>=108 && h_cnt<123 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 8) begin
        if(h_cnt>=124 && h_cnt<139 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if((random == 9)||(random == 54)) begin
        if(h_cnt>=140 && h_cnt<155 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if((random == 10)||&((random == 55)&&(mode == 0))) begin
        if(h_cnt>=156 && h_cnt<170 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if((random == 11)||(random == 56)) begin
        if(h_cnt>= 171 && h_cnt< 186 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 12) begin
        if(h_cnt>= 187 && h_cnt< 201 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
        else if(random == 13) begin
        if(h_cnt>=202 && h_cnt< 216 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
        else if(random == 14) begin
        if(h_cnt>=217 && h_cnt<232 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 15) begin
        if(h_cnt>= 233 && h_cnt<248 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 16) begin
        if(h_cnt>=249 && h_cnt<264 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 17) begin
        if(h_cnt>=265 && h_cnt< 280 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if((random == 18)||(random == 57)) begin
        if(h_cnt>=0 && h_cnt<=15 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 8960 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 19) begin
        if(h_cnt>=16 && h_cnt<=30 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 8960 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 20) begin
        if(h_cnt>=31 && h_cnt<=45 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 8960 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 21) begin
        if(h_cnt>=47 && h_cnt<=62 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 8960 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 22) begin
        if(h_cnt>=63 && h_cnt<78 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 8960 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 23) begin
        if(h_cnt>=79 && h_cnt<=93 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 8960 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 24) begin
        if(h_cnt>=94 && h_cnt<108 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 8960 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 25) begin
        if(h_cnt>=108 && h_cnt<123 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 8960 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 26) begin
        if(h_cnt>=124 && h_cnt<139 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 8960 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 27) begin
        if(h_cnt>=140 && h_cnt<155 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 8960 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 28) begin
        if(h_cnt>=156 && h_cnt<170 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 8960 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if((random == 29)||(random == 58)) begin
        if(h_cnt>= 171 && h_cnt< 186 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 8960 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
        else if(random == 30) begin
        if(h_cnt>= 187 && h_cnt< 201 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 8960 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if((random == 31)||(random == 59)) begin
        if(h_cnt>=202 && h_cnt< 216 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 8960 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 32) begin
        if(h_cnt>=217 && h_cnt<232 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 8960 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 33) begin
        if(h_cnt>= 233 && h_cnt<248 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 8960 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 34) begin
        if(h_cnt>=249 && h_cnt<264 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 8960 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if((random == 35)||(random == 60)) begin
        if(h_cnt>=265 && h_cnt< 280 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 8960 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if((random == 36)||(random == 61)) begin
        if(h_cnt>=0 && h_cnt<=15 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 19200 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if((random == 37)||(random == 62)) begin
        if(h_cnt>=16 && h_cnt<=30 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 19200 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 38) begin
        if(h_cnt>=31 && h_cnt<=45 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 19200 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 39) begin
        if(h_cnt>=47 && h_cnt<=62 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 19200 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 40) begin
        if(h_cnt>=63 && h_cnt<78 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 19200 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 41) begin
        if(h_cnt>=79 && h_cnt<=93 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 19200 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 42) begin
        if(h_cnt>=94 && h_cnt<108 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 19200 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 43) begin
        if(h_cnt>=108 && h_cnt<123 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 19200 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if((random == 44)) begin
        if(h_cnt>=124 && h_cnt<139 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 19200 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 45) begin
        if(h_cnt>=140 && h_cnt<155 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 19200 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 46) begin
        if(h_cnt>=156 && h_cnt<170 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 19200 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 47) begin
        if(h_cnt>= 171 && h_cnt< 186 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 19200 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 48) begin
        if(h_cnt>= 187 && h_cnt< 201 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 19200 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 49) begin
        if(h_cnt>=202 && h_cnt< 216 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 19200 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 50) begin
        if(h_cnt>=217 && h_cnt<232 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 19200 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(random == 51) begin
        if(h_cnt>= 233 && h_cnt<248 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 19200 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if((random == 55)&&(mode == 1)) begin
        if(h_cnt>=249 && h_cnt<264 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 19200 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else begin
        if(h_cnt>= 249 && h_cnt<263 && v_cnt>=position && v_cnt<(position+28))
            pixel_addr = 19200 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    end
end

endmodule
