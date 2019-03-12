module counter(
    input clk,
    input up_down,
    input rst,
    input in,
    output reg [3:0]led
    );
    
    always @(posedge clk or posedge rst) begin
        if(rst == 1)begin
            led <= 4'd0;
        end else begin
            if(up_down == 1) begin
                if(in == 0)begin
                    if(led < 4'd12) led <= led + 4'd1;
                    else led <= 4'd0;
                end else begin
                    led <= led + 4'd1;
                end
            end else begin
                if(led > 4'd0) led <= led - 4'd1;
                else led <= 4'd12;
            end
        end
    end
    
endmodule
