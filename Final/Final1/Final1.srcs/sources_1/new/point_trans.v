
module point_trans(
    input [15:0]points,
    input [2:0]diff,
    output reg [3:0]P0,
    output reg [3:0]P1,
    output reg [3:0]P2,
    output reg [3:0]P3,
    output reg win,
    input clk,
    input clk_1s,
    input rst,
    input mode,
    input [2:0]life,
    input [5:0]min,
    input [5:0]sec
    );

    always @* begin
        if(mode == 0) begin
            P3 = (points / 1000)%10;
            P2 = (points/100)%10;
            P1 = ((points-points%10)/10)%10;
            P0 = points%10;
        end else begin
            P3 = min / 10;
            P2 = min[3:0];
            P1 = sec / 10;
            P0 = sec % 10;
        end
    end
    
    always @(posedge clk or posedge rst) begin
        if(mode == 0) begin
        if(rst == 1) begin
            win <= 0;
        end else begin
            case(diff)
                3'b001: begin
                    if(points >= 16'd100) win <= 1;
                end
                3'b010: begin
                    if(points >= 16'd5000) win <= 1;
                end
                3'b100: begin
                    if(points >= 16'd9000) win <= 1;
                end
                default: begin 
                    win <= 0;
                end
            endcase
        end
        end else begin
            if(rst == 1) begin win <= 0; end
            if((min == 0)&&(sec == 0)) begin
                win <= 1;
            end
        end
    end
    
endmodule
