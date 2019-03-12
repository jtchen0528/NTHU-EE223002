module pixel_gen_2(
   input [9:0] h_cnt, //640
   input [9:0] v_cnt, //480
   input [3:0]num,
   input [3:0]num1,
   input [3:0]num2,
   input [3:0]num3,
   input [2:0]mark,
   input valid,
   output [3:0] vgaRed,
   output [3:0] vgaGreen,
   output [3:0] vgaBlue
   );
   
   wire [3:0] vgaRed2 = 0;
   wire [3:0] vgaGreen2 = 0;
   wire [3:0] vgaBlue2 = 0;
   wire [3:0] vgaRed3;
   wire [3:0] vgaGreen3;
   wire [3:0] vgaBlue3;
   wire [3:0] vgaRed4;
   wire [3:0] vgaGreen4;
   wire [3:0] vgaBlue4;
   wire [3:0] vgaRed5;
   wire [3:0] vgaGreen5;
   wire [3:0] vgaBlue5;
   
    pixel_num U_pixel(
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .shift(10'd0),
        .num(num),
        .valid(valid),
        .vgaRed2(vgaRed2),
        .vgaGreen2(vgaGreen2),
        .vgaBlue2(vgaBlue2),
        .vgaRed(vgaRed3),
        .vgaGreen(vgaGreen3),
        .vgaBlue(vgaBlue3)
    );
    pixel_num U_pixel2(
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .shift(10'd20),
        .num(num1),
        .valid(valid),
        .vgaRed2(vgaRed3),
        .vgaGreen2(vgaGreen3),
        .vgaBlue2(vgaBlue3),
        .vgaRed(vgaRed4),
        .vgaGreen(vgaGreen4),
        .vgaBlue(vgaBlue4)
    );
    pixel_num U_pixel3(
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .shift(10'd45),
        .num(num2),
        .valid(valid),
        .vgaRed2(vgaRed4),
        .vgaGreen2(vgaGreen4),
        .vgaBlue2(vgaBlue4),
        .vgaRed(vgaRed5),
        .vgaGreen(vgaGreen5),
        .vgaBlue(vgaBlue5)
    );
    pixel_num U_pixel4(
        .h_cnt(h_cnt),
        .v_cnt(v_cnt),
        .shift(10'd65),
        .num(num3),
        .valid(valid),
        .vgaRed2(vgaRed5),
        .vgaGreen2(vgaGreen5),
        .vgaBlue2(vgaBlue5),
        .vgaRed(vgaRed),
        .vgaGreen(vgaGreen),
        .vgaBlue(vgaBlue)
    );
   
endmodule