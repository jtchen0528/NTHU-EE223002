`include "global.v"
module FSM(
    output count_enable,
    output freeze_enable,
    output reset_enable,
    output min_enable,
    output hr_enable,
    input in1,
    input clk,
    input in2,
    input in3,
    input setting
    );
    
    reg freeze_enable;
    reg count_enable;
    reg reset_enable;
    reg min_enable;
    reg hr_enable;

    reg [1:0]state;
    reg [1:0]next_state;
    reg [2:0]in1_latch;
    reg [2:0]in2_latch;
    reg [2:0]in3_latch;
    reg [2:0]in1_latch_temp;
    reg [2:0]in2_latch_temp;
    reg [2:0]in3_latch_temp;
    
    `define STAT_DEF 3'b000
    `define STAT_COUNT 3'b001
    `define STAT_FREEZE 3'b010
    `define STAT_STOP 3'b011
    `define STAT_SET 3'b100
    
    
    always @(posedge clk)
        state <= next_state;
    
    always @(*)
    begin
        if((state == `STAT_DEF))
        begin
            in1_latch_temp = 3'b000;
            in2_latch_temp = 3'b000;
            in3_latch_temp = 3'b000;
        end
        else
        begin
            in1_latch_temp = {in1_latch[1:0],in1};
            in2_latch_temp = {in2_latch[1:0],in2};
            in3_latch_temp = {in3_latch[1:0],in3};
        end
    end
        
    always @(posedge clk)
    begin
        in1_latch <= in1_latch_temp;
        in2_latch <= in2_latch_temp;
        in3_latch <= in3_latch_temp;
    end
    
    always @(*)
    case(state)
    `STAT_DEF:
    if(in1)  begin
        next_state = `STAT_COUNT;
        count_enable = `ENABLED;
        freeze_enable  = `DISABLED;
        reset_enable = `DISABLED;
        min_enable = `DISABLED;
        hr_enable = `DISABLED;
    end
    else if((in2))
    begin
        next_state = `STAT_DEF;
        count_enable = `DISABLED;
        freeze_enable  = `DISABLED;
        reset_enable = `DISABLED;
        min_enable = `ENABLED;
        hr_enable = `DISABLED;
    end
    else if((in3))
    begin
        next_state = `STAT_DEF;
        count_enable = `DISABLED;
        freeze_enable  = `DISABLED;
        reset_enable = `DISABLED;
        min_enable = `DISABLED;
        hr_enable = `ENABLED;
    end
    else    begin
        next_state = `STAT_DEF;
        count_enable = `DISABLED;
        freeze_enable  = `DISABLED;
        reset_enable = `DISABLED;
        min_enable = `DISABLED;
        hr_enable = `DISABLED;
    end
    `STAT_COUNT:
    if((in1) && (in1_latch==3'b111))  begin
        next_state = `STAT_STOP;
        count_enable = `DISABLED;
        freeze_enable  = `ENABLED;
        reset_enable = `DISABLED;
                min_enable = `DISABLED;
        hr_enable = `DISABLED;
    end
    else if((in2) && (in2_latch==3'b111))  begin
        next_state = `STAT_DEF;
        count_enable = `DISABLED;
        freeze_enable  = `DISABLED;
        reset_enable = `ENABLED;
                min_enable = `DISABLED;
        hr_enable = `DISABLED;
    end
    else if((in1)) begin
        next_state = `STAT_COUNT;
        count_enable = `ENABLED;
        freeze_enable  = `DISABLED;
        reset_enable = `DISABLED;
                min_enable = `DISABLED;
        hr_enable = `DISABLED;
    end
    else if((in2)) begin
        next_state = `STAT_FREEZE;
        count_enable = `ENABLED;
        freeze_enable  = `ENABLED;
        reset_enable = `DISABLED;
                min_enable = `DISABLED;
        hr_enable = `DISABLED;
    end
    else if((in3)&&(setting)) begin
        next_state = `STAT_DEF;
    count_enable = `DISABLED;
    freeze_enable  = `DISABLED;
    reset_enable = `DISABLED;
    min_enable = `DISABLED;
    hr_enable = `DISABLED;
    end
    else    begin
        next_state = `STAT_COUNT;
        count_enable = `ENABLED;
        freeze_enable = `DISABLED;
        reset_enable = `DISABLED;
                min_enable = `DISABLED;
        hr_enable = `DISABLED;
    end
    `STAT_FREEZE:
    if((in1) && (in1_latch==3'b111))  begin
        next_state = `STAT_STOP;
        count_enable = `DISABLED;
        freeze_enable  = `ENABLED;
        reset_enable = `DISABLED;
                min_enable = `DISABLED;
        hr_enable = `DISABLED;
    end
    else if((in2) && (in2_latch==3'b111))  begin
        next_state = `STAT_DEF;
        count_enable = `DISABLED;
        freeze_enable  = `DISABLED;
        reset_enable = `ENABLED;
                min_enable = `DISABLED;
        hr_enable = `DISABLED;
    end
    else if(in2)  begin
        next_state = `STAT_FREEZE;
        count_enable = `ENABLED;
        freeze_enable  = `DISABLED;
        reset_enable = `DISABLED;
                min_enable = `DISABLED;
        hr_enable = `DISABLED;
    end
    else
    begin
        next_state = `STAT_FREEZE;
        count_enable = `ENABLED;
        freeze_enable  = `ENABLED;
        reset_enable = `DISABLED;
                min_enable = `DISABLED;
        hr_enable = `DISABLED;
    end
    `STAT_STOP:
    begin
    if((in2)) begin
        next_state = `STAT_DEF;
        count_enable = `DISABLED;
        freeze_enable  = `DISABLED;
        reset_enable = `ENABLED;
                min_enable = `DISABLED;
        hr_enable = `DISABLED;
    end
    else if((in1) && (in1_latch==3'b111)) begin
        next_state = `STAT_COUNT;
        count_enable = `ENABLED;
        freeze_enable  = `DISABLED;
        reset_enable = `DISABLED;
                min_enable = `DISABLED;
        hr_enable = `DISABLED;
    end
    else
    begin
        next_state = `STAT_STOP;
        count_enable = `DISABLED;
        freeze_enable  = `ENABLED;
        reset_enable = `DISABLED;
                min_enable = `DISABLED;
        hr_enable = `DISABLED;
    end
    end
    default:    begin
        next_state = `STAT_DEF;
        count_enable = `DISABLED;
        freeze_enable = `DISABLED;
        reset_enable = `DISABLED;
        min_enable = `DISABLED;
        hr_enable = `DISABLED;
    end
    endcase
    
endmodule