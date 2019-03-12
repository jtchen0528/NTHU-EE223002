module LFSR (out, clk_random, rst, clk);
    output reg [5:0]out;
    input clk, rst, clk_random;

    wire feedback;
    reg [7:0] out2;
    
    assign feedback = ~(out2[7] ^ out2[6]);

    always @(posedge clk, negedge rst) begin
        if (rst)  
            out2 <= 7'hFF;
        else
            out2 <= {out2[6:0],feedback};
    end
    
    always @(posedge clk_random) begin
        if(out2[5:0] == 6'd63)begin
            out <= 6'd62;
        end else begin
            out <= out2[5:0];
        end
    end

endmodule