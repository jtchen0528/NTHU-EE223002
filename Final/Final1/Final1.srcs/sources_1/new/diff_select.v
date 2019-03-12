module diff_select(
    input clk,
    input [2:0]diff,
    output reg [1:0]diffout
);

    always @(posedge clk) begin
        if(diff == 3'b100) begin
            diffout <= 2'd0;
        end
        else  if(diff == 3'b010) begin
            diffout <= 2'd0;
        end
    end
    
endmodule