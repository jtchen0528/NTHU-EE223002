`include "global.v"
module stopwatch2(
    output [`BCD_BIT_WIDTH-1:0]sec0,
    output [`BCD_BIT_WIDTH-1:0]sec1,
    output [`BCD_BIT_WIDTH-1:0]min0,
    output [`BCD_BIT_WIDTH-1:0]min1,
    input en,
    input clk,
    input rst
);

    reg [5:0]sec;
    reg [5:0]min;
    
    assign sec0 = (sec%10);
    assign sec1 = sec/10;
    assign min1 = (min/10);
    assign min0 = (min%10);
    
    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
            sec <= 6'd0;
            min <= 6'd0;
        end
        else
        begin
        if(en)
        begin
            sec <= sec + 1;
            if(sec == 6'd59)
            begin
                min <= min + 6'd1;
                sec <= 6'd0;
            end
            if((min == 6'd59)&&(sec == 6'd59))
            begin
                sec <= 6'd0;
                min <= 6'd0;
            end
        end
        end    
    end



endmodule