module mem_addr_gen(
  input clk,
  input rst,
  input [2:0]Q,
  input [9:0] h_cnt,
  input [9:0] v_cnt,
  output reg [16:0] pixel_addr
);
reg [7:0] position;
reg [2:0]bricktype;
wire [2:0]bricktype_tmp = bricktype - 1;
wire v_cnt_tmp;

always @ (posedge clk or posedge rst) begin
  if(rst) begin
    position <= 0;
    bricktype <= 3;
  end
  else if(position < 239) begin
    position <= position + 1;
    bricktype <= bricktype;
  end
  else begin
    position <= 0;
    bricktype[2:1] <= bricktype[1:0];
    bricktype[0] <= bricktype[2]^bricktype[1];
  end
end

always @* begin
    if(bricktype_tmp == 0) begin
        if(h_cnt>=0 && h_cnt<78 && v_cnt>=position && v_cnt<(position+52))
            pixel_addr = h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(bricktype_tmp == 1) begin
        if(h_cnt>=0 && h_cnt<78 && v_cnt>=position && v_cnt<(position+52))
            pixel_addr = 78 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(bricktype_tmp == 2) begin
        if(h_cnt>=0 && h_cnt<78 && v_cnt>=position && v_cnt<(position+52))
            pixel_addr = 156 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(bricktype_tmp == 3) begin
        if(h_cnt>=0 && h_cnt<78 && v_cnt>=position && v_cnt<(position+52))
            pixel_addr = 234 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(bricktype_tmp == 4) begin
        if(h_cnt>=0 && h_cnt<78 && v_cnt>=position && v_cnt<(position+52))
            pixel_addr = 16640 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(bricktype_tmp == 5) begin
        if(h_cnt>=0 && h_cnt<52 && v_cnt>=position && v_cnt<(position+52))
            pixel_addr = 16718 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else if(bricktype_tmp == 6) begin
        if(h_cnt>=0 && h_cnt<104 && v_cnt>=position && v_cnt<(position+26))
            pixel_addr = 16770 + h_cnt + (v_cnt-position) * 320;
        else
            pixel_addr = 30;
    end
    else begin
        pixel_addr = 30;
    end
end

endmodule
