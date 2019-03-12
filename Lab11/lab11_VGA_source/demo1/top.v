module top(
   input clk,
   input rst,
   input PS2_CLK,
   input PS2_DATA,
   output [4-1:0]ssd_ctl,
   output [0:7]display,
   output [3:0] vgaRed,
   output [3:0] vgaGreen,
   output [3:0] vgaBlue,
   output hsync,
   output vsync
    );


    wire clk_25MHz;
    wire valid;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480
    wire [3:0]N2;
    wire [3:0]N1;
    wire [3:0]S1;
    wire [3:0]S0;
    wire [2:0]mark;
    wire [3:0] vgaRed2;
    wire [3:0] vgaGreen2;
    wire [3:0] vgaBlue2;
    wire [3:0] vgaRed3;
    wire [3:0] vgaGreen3;
    wire [3:0] vgaBlue3; 
    wire [2-1:0]ssd_ctl_en;
    wire [0:8-1] disp0, disp1, disp2, disp3;
    wire clk_out;

    freq_div U_FD(.clk_out(clk_out),
    .ssd_ctl_en(ssd_ctl_en),
    .clk(clk),
    .rst(rst)
    );
    
    clock_divisor clk_wiz_0_inst(
      .clk(clk),
      .clk1(clk_25MHz)
    );
    
    keyboard TestingKeyboard (
                                .CLK(clk),
                                .PS2_CLK(PS2_CLK), 
                                .PS2_DATA(PS2_DATA),
                                .N1(N1),
                                .N2(N2),
                                .S0(S0),
                                .S1(S1),
                                .mark(mark)
                                );
                                
   pixel_gen pixel_gen_inst(
       .h_cnt(h_cnt),
       .v_cnt(v_cnt),
       .num(N1),
       .num1(N2),
       .num2(S1),
       .num3(S0),
       .mark(mark),
       .valid(valid),
       .vgaRed(vgaRed),
       .vgaGreen(vgaGreen),
       .vgaBlue(vgaBlue)
    );

    vga_controller   vga_inst(
      .pclk(clk_25MHz),
      .reset(rst),
      .hsync(hsync),
      .vsync(vsync),
      .valid(valid),
      .h_cnt(h_cnt),
      .v_cnt(v_cnt)
    );
    
    ssd U_SSD3(
    .display(disp3),
    .bcd(N1));
    ssd U_SSD2(
    .display(disp2),
    .bcd(N2));
    ssd U_SSD1(
    .display(disp1),
    .bcd(S1));
    ssd U_SSD0(
    .display(disp0),
    .bcd(S0));
    
    ssd_ctl U_CTL(
    .display_c(ssd_ctl),
    .display(display),
    .ssd_ctl_en(ssd_ctl_en),
    .display0(disp0),
    .display1(disp1),
    .display2(disp2),
    .display3(disp3)
    );
      
endmodule
