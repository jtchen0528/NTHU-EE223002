module top(
  input clk,
  input rst,
  input PS2_CLK,
  input PS2_DATA,
  input [2:0]diff,
  input mode,
  input [1:0]invol,
  output [3:0] vgaRed,
  output [3:0] vgaGreen,
  output [3:0] vgaBlue,
  output hsync,
  output vsync,
  output audio_mclk,
  output audio_lrck,
  output audio_sck,
  output audio_sdin,
  output [3:0]ssd_ctl,
  output [0:7]display,
  output [15:0]led
);

wire [11:0] data;
wire clk_25MHz;
wire clk_22;
wire [1:0]ssd_ctl_en;
wire [16:0] pixel_addr;
wire [15:0] points;
wire [11:0] pixel;
wire valid;
wire [9:0] h_cnt; //640
wire [9:0] v_cnt;  //480
wire [5:0] random;
wire [5:0] key;
wire clk_random;
wire [0:7] disp0, disp1, disp2, disp3;
wire [3:0]P1, P2, P3, P0;
wire [4:0]combo;
wire win;
wire clk_1s;
wire [2:0]life;
wire [5:0]min, sec;

assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel:12'h0;

// Frequency Divider
clock_divisor clk_wiz_0_inst(
  .clk(clk),
  .clk1(clk_25MHz),
  .clk22(clk_22),
  .clk_1s(clk_1s),
  .ssd_ctl_en(ssd_ctl_en)
);

LFSR Urandom(.clk(clk), .clk_random(clk_random), .rst(rst), .out(random));

keyboard Ukb(
    .CLK(clk),    //board clock
    .PS2_CLK(PS2_CLK),    //keyboard clock and data signals
    .PS2_DATA(PS2_DATA),
    .key(key)
    );
// Reduce frame address from 640x480 to 320x240
mem_addr_gen mem_addr_gen_inst(
  .clk(clk_22),
  .rst(rst),
  .diff(diff),
  .key(key),
  .mode(mode),
  .win(win),
  .h_cnt(h_cnt>>1),
  .v_cnt(v_cnt>>1),
  .pixel_addr(pixel_addr),
  .points(points),
  .random(random),
  .combo(combo),
  .clk_random(clk_random),
  .life(life)
);
     
// Use reduced 320x240 address to output the saved picture from RAM 
blk_mem_gen_1 blk_mem_gen_0_inst(
  .clka(clk_25MHz),
  .wea(0),
  .addra(pixel_addr),
  .dina(data[11:0]),
  .douta(pixel)
); 

// Render the picture by VGA controller
vga_controller   vga_inst(
  .pclk(clk_25MHz),
  .reset(rst),
  .hsync(hsync),
  .vsync(vsync),
  .valid(valid),
  .h_cnt(h_cnt),
  .v_cnt(v_cnt)
);

downcounter(.clk(clk_1s), .rst(rst), .mode(mode), .life(life), .diff(diff), .min(min), .sec(sec));

point_trans U_pt(.clk(clk), .clk_1s(clk_1s), .diff(diff), .rst(rst), .mode(mode), .life(life),
         .points(points), .P0(P0), .P1(P1), .P2(P2), .P3(P3), .win(win), .min(min), .sec(sec));

ledlights U_led(.clk(clk), .clk_22(clk_1s), .clk_random(clk_random), .mode(mode), .diff(diff), .life(life), .rst(rst), .win(win), .led(led));

speaker U_sp(
    .clk(clk),
    .rst_n(rst),
    .invol(invol),
    .key(key),
    .combo(combo),
    .audio_mclk(audio_mclk),
    .audio_lrck(audio_lrck),
    .audio_sck(audio_sck),
    .audio_sdin(audio_sdin)
);

    ssd U_SSD3(.display(disp3),
               .bcd(P3));
    ssd U_SSD2(.display(disp2),
               .bcd(P2));
    ssd U_SSD1(.display(disp1),
               .bcd(P1));
    ssd U_SSD0(.display(disp0),
               .bcd(P0));
                                           
    ssd_ctl U_CTL(
              .display_c(ssd_ctl),
              .display(display),
              .ssd_ctl_en(ssd_ctl_en),
              .display0(disp0),
              .display1(disp1),
              .display2(disp2),
              .display3(disp3));

endmodule