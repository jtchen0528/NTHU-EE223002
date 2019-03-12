module mem_addr_gen(
   input clk,
   input rst,
   input en,
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   output [16:0] pixel_addr
   );
    
   reg [7:0] position;
   reg state;
  
   assign pixel_addr = ((h_cnt>>1)+320*(v_cnt>>1)+ position*320 )% 76800;  //640*480 --> 320*240 

   always @ (posedge clk or posedge rst) begin
      if(rst)
          position <= 0;
          state <= 1;
   end
   
   always @(posedge clk)begin
    case(state)
    1'd0: begin
        if(en == 1) begin
            state <= 1;
        end
        else begin
            state <= 1'd0;
            position <= position;
        end
    end
   
    1'd1: begin
        if(en == 1) begin
            state <= 0;
        end
        else begin
            state <= 1'd1;
        if(position < 239)
            position <= position + 1;
        else
            position <= 0;
        end
    end
    endcase
   end
endmodule
