module pixel_sym(
    input [9:0]h_cnt,
    input [9:0]v_cnt,
    input [9:0]shift,
    input [2:0]num,
    input [3:0]vgaRed2,
    input [3:0]vgaGreen2,
    input [3:0]vgaBlue2,
    output reg [3:0]vgaRed,
    output reg [3:0]vgaGreen,
    output reg [3:0]vgaBlue,
    input valid
    );
    
    always @(*) begin
    if(!valid) begin
          {vgaRed, vgaGreen, vgaBlue} = {vgaRed2, vgaGreen2, vgaBlue2};
     end
     else begin
         case(num)
             3'd0: begin

             end
             3'd1: begin
                if(((h_cnt >= (shift + 10'd45))&&(h_cnt <= (shift + 10'd50))&&(v_cnt >= 10'd2)&&(v_cnt <= 10'd30))) begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                end
             end
             3'd2: begin
                if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                   ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd32))) begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                end
             end
             3'd3: begin
                if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                   ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd32))) begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                end
             end
             3'd4: begin
                if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                   ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                   ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))) begin
                    {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                end
             end
         endcase
     end
    end
endmodule