module freq_div2(
    input clk,
    input rst,
    output reg clk_out
    );
    
    reg [25:0]counter;
    reg clk_out;
     
    always @(posedge clk or negedge rst)
    begin
    if(rst)
    begin
       counter<=26'd0;
       clk_out <= 0;
    end
    else
    begin
       if(counter==26'd24999999)
       begin
          counter<=26'd0;
          clk_out<=~clk_out;
       end
    end
    counter<=counter+1;
    end
endmodule
