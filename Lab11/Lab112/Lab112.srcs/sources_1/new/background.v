module background(
   input clk_25MHz,
   input clk_22,
   input rst,
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   output [3:0] vgaRed,
   output [3:0] vgaGreen,
   output [3:0] vgaBlue
   );
   
   wire [16:0] pixel_addr;
   wire [11:0] pixel;
   wire [11:0] data;
   wire valid;
       
    mem_addr_gen mem_addr_gen_inst(
   .clk(clk_22),
   .rst(rst),
   .en(1),
   .h_cnt(h_cnt),
   .v_cnt(v_cnt),
   .pixel_addr(pixel_addr)
   );
   
    blk_mem_gen_0 blk_mem_gen_0_inst(
     .clka(clk_25MHz),
     .wea(0),
     .addra(pixel_addr),
     .dina(data[11:0]),
     .douta(pixel)
    ); 
   
     assign {vgaRed, vgaGreen, vgaBlue} = pixel;
   
endmodule