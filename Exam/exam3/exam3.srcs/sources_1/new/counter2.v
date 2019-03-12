module counter2(
    input clk,
    input rst,
    input [4:0]key,
    output reg [3:0]led
    );
    
    always @(posedge clk or posedge rst) begin
        if(rst == 1)begin
            led <= 4'd0;
        end else begin
            if(key != 5'd16)begin
                case(key)
                    5'd0: led <= 4'd0;
                    5'd1: led <= 4'd1;
                    5'd2: led <= 4'd2;
                    5'd3: led <= 4'd3;
                    5'd4: led <= 4'd4;
                    5'd5: led <= 4'd5;
                    5'd6: led <= 4'd6;
                    5'd7: led <= 4'd7;
                    5'd8: led <= 4'd8;
                    5'd9: led <= 4'd9;
                    5'd10: led <= 4'd10;
                    5'd11: led <= 4'd11;
                    5'd12: led <= 4'd12;
                    5'd13: led <= 4'd13;
                    5'd14: led <= 4'd14;
                    5'd15: led <= 4'd15;
                endcase
            end    
            else begin
                led <= led + 4'd1;
            end     
        end
    end
    
endmodule