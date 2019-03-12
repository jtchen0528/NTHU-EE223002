module ledlights(
    input clk,
    input clk_22,
    input rst,
    input win,
    input [2:0]life,
    input mode,
    input [2:0]diff,
    input clk_random,
    output reg [15:0]led
    );
    
    always @(posedge clk or posedge rst) begin
        if(rst == 1) begin
            led <= 16'd0;
        end else begin
            if(win == 1) begin
                if(clk_22 == 1) led <= 16'b0101010101010101;
                if(clk_22 == 0) led <= 16'b1010101010101010;
            end else begin
                if(mode == 0) begin
                    if(clk_random == 1) led <= 16'b1001001001001001;
                    else led <= 16'b0000000000000000;
                end else if((mode == 1)&&(diff != 3'b000)) begin
                    if(life == 3'd5) led <= 16'b0000000000011111;
                    else if(life == 3'd4) led <= 16'b0000000000001111;
                    else if(life == 3'd3) led <= 16'b0000000000000111;
                    else if(life == 3'd2) led <= 16'b0000000000000011;
                    else if(life == 3'd1) led <= 16'b0000000000000001;
                    else if(life == 3'd0) led <= 16'b0000000000000000;
                end
            end
        end
    end
    
endmodule
