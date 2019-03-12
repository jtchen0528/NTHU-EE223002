module pixel_gen(
   input [9:0] h_cnt, //640
   input [9:0] v_cnt, //480
   input [3:0]num,
   input [3:0]num1,
   input [3:0]num2,
   input [3:0]num3,
   input [2:0]mark,
   input valid,
   output reg [3:0] vgaRed,
   output reg [3:0] vgaGreen,
   output reg [3:0] vgaBlue
   );
   
   reg [9:0]shift;
       always @(*) begin
       if(!valid)
             {vgaRed, vgaGreen, vgaBlue} = 12'h0;
        else begin
        case(num)
                     4'd0: begin
                     shift = 10'd10;
                        if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                           ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                           ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                           ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                            {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                        end
                     end
                     4'd1: begin
                     shift = 10'd10;
                        if(((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                            {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                        end
                     end
                     4'd2: begin
                     shift = 10'd10;
                        if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                           ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                           ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                           ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))||
                           ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd32))) begin
                            {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                        end
                     end
                     4'd3: begin
                     shift = 10'd10;
                        if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                           ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                           ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                           ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                            {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                        end
                     end
                     4'd4: begin
                     shift = 10'd10;
                        if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                           ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                           ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))) begin
                            {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                        end
                     end
                     4'd5: begin
                     shift = 10'd10;
                        if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                           ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                           ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                           ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd32))||
                           ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))) begin
                            {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                        end
                     end
                     4'd6: begin
                     shift = 10'd10;
                        if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                           ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                           ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                           ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd32))||
                           ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                            {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                        end
                     end
                     4'd7: begin
                     shift = 10'd10;
                        if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                           ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                            {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                        end
                     end
                     4'd8: begin
                     shift = 10'd10;
                                 if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                        ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                        ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                        ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                        ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                         {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                     end
                     end
                     4'd9: begin
                     shift = 10'd10;
                        if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                           ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                           ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                           ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                           ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))) begin
                            {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                        end
                     end
                 endcase
                 case(num1)
                              4'd0: begin
                              shift = 10'd30;
                                 if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                    ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                                     {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                 end
                              end
                              4'd1: begin
                              shift = 10'd30;
                                 if(((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                                     {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                 end
                              end
                              4'd2: begin
                              shift = 10'd30;
                                 if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                    ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd32))) begin
                                     {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                 end
                              end
                              4'd3: begin
                              shift = 10'd30;
                                 if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                    ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                                     {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                 end
                              end
                              4'd4: begin
                              shift = 10'd30;
                                 if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                    ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))) begin
                                     {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                 end
                              end
                              4'd5: begin
                
                              shift = 10'd30;
                                 if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                    ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd32))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))) begin
                                     {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                 end
                              end
                              4'd6: begin
                              shift = 10'd30;
                                 if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                    ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd32))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                                     {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                 end
                              end
                              4'd7: begin
                              shift = 10'd30;
                                 if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                    ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                                     {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                 end
                              end
                              4'd8: begin
                              shift = 10'd30;
                                 if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                    ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                                     {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                 end
                              end
                              4'd9: begin
                              shift = 10'd30;
                                 if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                    ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                                    ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))) begin
                                     {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                 end
                              end
                          endcase     
                          case(num2)
                                       4'd0: begin
                                       shift = 10'd60;
                                          if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                             ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                                              {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                          end
                                       end
                                       4'd1: begin
                                       shift = 10'd65;
                                          if(((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                                              {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                          end
                                       end
                                       4'd2: begin
                                       shift = 10'd60;
                                          if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                             ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd32))) begin
                                              {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                          end
                                       end
                                       4'd3: begin
                                       shift = 10'd60;
                                          if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                             ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                                              {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                          end
                                       end
                                       4'd4: begin
                                       shift = 10'd60;
                                          if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                             ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))) begin
                                              {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                          end
                                       end
                                       4'd5: begin
                                       shift = 10'd60;
                                          if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                             ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd32))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))) begin
                                              {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                          end
                                       end
                                       4'd6: begin
                                       shift = 10'd60;
                                          if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                             ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd32))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                                              {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                          end
                                       end
                                       4'd7: begin
                                       shift = 10'd60;
                                          if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                             ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                                              {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                          end
                                       end
                                       4'd8: begin
                                       shift = 10'd60;
                                          if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                             ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                                              {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                          end
                                       end
                                       4'd9: begin
                                       shift = 10'd60;
                                          if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                             ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                                             ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))) begin
                                              {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                          end
                                       end
                                   endcase
                        case(num3)
                                                        4'd0: begin
                                                        shift = 10'd80;
                                                           if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                                              ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                                                               {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                                           end
                                                        end
                                                        4'd1: begin
                                                        shift = 10'd80;
                                                           if(((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                                                               {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                                           end
                                                        end
                                                        4'd2: begin
                                                        shift = 10'd80;
                                                           if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                                              ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd32))) begin
                                                               {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                                           end
                                                        end
                                                        4'd3: begin
                                                        shift = 10'd80;
                                                           if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                                              ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                                                               {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                                           end
                                                        end
                                                        4'd4: begin
                                                        shift = 10'd80;
                                                           if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                                              ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))) begin
                                                               {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                                           end
                                                        end
                                                        4'd5: begin
                                                        shift = 10'd80;
                                                           if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                                              ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd32))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))) begin
                                                               {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                                           end
                                                        end
                                                        4'd6: begin
                                                        shift = 10'd80;
                                                           if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                                              ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd32))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                                                               {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                                           end
                                                        end
                                                        4'd7: begin
                                                        shift = 10'd80;
                                                           if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                                              ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                                                               {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                                           end
                                                        end
                                                        4'd8: begin
                                                        shift = 10'd80;
                                                           if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                                              ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))) begin
                                                               {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                                           end
                                                        end
                                                        4'd9: begin
                                                        shift = 10'd80;
                                                           if(((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd12))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd20)&&(v_cnt <= 10'd22))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd32))||
                                                              ((h_cnt >= (shift + 10'd20))&&(h_cnt <= (shift + 10'd22))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd32))||
                                                              ((h_cnt >= (shift + 10'd10))&&(h_cnt <= (shift + 10'd12))&&(v_cnt >= 10'd10)&&(v_cnt <= 10'd22))) begin
                                                               {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                                           end
                                                        end
                                                    endcase
                                                    case(mark)
                                                                 3'd0: begin
                                                    
                                                                 end
                                                                 3'd1: begin
                                                                 shift = 10'd15;
                                                                    if(((h_cnt >= (shift + 10'd45))&&(h_cnt <= (shift + 10'd50))&&(v_cnt >= 10'd27)&&(v_cnt <= 10'd28))||
                                                                       ((h_cnt >= (shift + 10'd47))&&(h_cnt <= (shift + 10'd48))&&(v_cnt >= 10'd25)&&(v_cnt <= 10'd30))) begin
                                                                        {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                                                    end
                                                                 end
                                                                 3'd2: begin
                                                                 shift = 10'd15;
                                                                    if(((h_cnt >= (shift + 10'd45))&&(h_cnt <= (shift + 10'd50))&&(v_cnt >= 10'd27)&&(v_cnt <= 10'd28))) begin
                                                                        {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                                                    end
                                                                 end
                                                                 3'd3: begin
                                                                 shift = 10'd15;
                                                                    if(((h_cnt >= (shift + 10'd45))&&(h_cnt <= (shift + 10'd46))&&(v_cnt >= 10'd25)&&(v_cnt <= 10'd26))||
                                                                    ((h_cnt >= (shift + 10'd46))&&(h_cnt <= (shift + 10'd47))&&(v_cnt >= 10'd26)&&(v_cnt <= 10'd27))||
                                                                    ((h_cnt >= (shift + 10'd47))&&(h_cnt <= (shift + 10'd48))&&(v_cnt >= 10'd27)&&(v_cnt <= 10'd28))||
                                                                    ((h_cnt >= (shift + 10'd48))&&(h_cnt <= (shift + 10'd49))&&(v_cnt >= 10'd28)&&(v_cnt <= 10'd29))||
                                                                    ((h_cnt >= (shift + 10'd49))&&(h_cnt <= (shift + 10'd50))&&(v_cnt >= 10'd29)&&(v_cnt <= 10'd30))||
                                                                    ((h_cnt >= (shift + 10'd45))&&(h_cnt <= (shift + 10'd46))&&(v_cnt >= 10'd29)&&(v_cnt <= 10'd30))||
                                                                    ((h_cnt >= (shift + 10'd46))&&(h_cnt <= (shift + 10'd47))&&(v_cnt >= 10'd28)&&(v_cnt <= 10'd29))||
                                                                    ((h_cnt >= (shift + 10'd47))&&(h_cnt <= (shift + 10'd48))&&(v_cnt >= 10'd27)&&(v_cnt <= 10'd28))||
                                                                    ((h_cnt >= (shift + 10'd48))&&(h_cnt <= (shift + 10'd49))&&(v_cnt >= 10'd26)&&(v_cnt <= 10'd27))||
                                                                    ((h_cnt >= (shift + 10'd49))&&(h_cnt <= (shift + 10'd50))&&(v_cnt >= 10'd25)&&(v_cnt <= 10'd26))) begin
                                                                     {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                                                 end
                                                                 end
                                                                 3'd4: begin
                                                                    shift = 10'd15;
                                                                    if(((h_cnt >= (shift + 10'd45))&&(h_cnt <= (shift + 10'd50))&&(v_cnt >= 10'd27)&&(v_cnt <= 10'd28))||
                                                                       ((h_cnt >= (shift + 10'd47))&&(h_cnt <= (shift + 10'd48))&&(v_cnt >= 10'd25)&&(v_cnt <= 10'd25))||
                                                                       ((h_cnt >= (shift + 10'd47))&&(h_cnt <= (shift + 10'd48))&&(v_cnt >= 10'd30)&&(v_cnt <= 10'd30))) begin
                                                                        {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                                                                    end
                                                                 end
                                                             endcase                                                                       
                end  
        end
   
   endmodule