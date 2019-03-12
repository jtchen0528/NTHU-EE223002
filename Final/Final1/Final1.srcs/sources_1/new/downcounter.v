
module downcounter(
    input clk,
    input rst,
    input mode,
    input [2:0]diff,
    input [2:0]life,
    output reg [5:0]min,
    output reg [5:0]sec
    );
    
    always @(posedge clk or posedge rst) begin
        if(rst == 1) begin
            sec <= 0;
            min <= 6'd2;
        end else if (life == 0) begin
            sec <= 0;
            min <= 0;
        end else if((((diff == 3'b000)&&(mode == 1))||(mode == 0))) begin
            sec <= 0;
            min <= 6'd2;
        end else begin
            if(sec == 0) begin
               if(min == 0) begin
                    min <= min;
                    sec <= sec;
                end else begin
                    min <= min - 1;
                    sec <= 6'd59;
                end
             end else begin
                sec <= sec - 1;
             end 
        end
    end
    
endmodule
