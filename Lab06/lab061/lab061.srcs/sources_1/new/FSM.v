`include "global.v"
module FSM(
    output freeze_enable,
    output [2:0]mode,
    input [3:0]in,
    input clk,
    input rst
    );
    
    reg freeze_enable;
    reg [2:0]mode;

    reg [2:0]state;
    reg [2:0]next_state;
    
    `define STAT_24 3'd0
    `define STAT_AM 3'd1
    `define STAT_SEC 3'd2
    `define STAT_MON 3'd3
    `define STAT_YR 3'd4
    
    always @(posedge clk or posedge rst)
    if(rst) state <= `STAT_24;
    else    state <= next_state;
    
    always @(*)
    case(state)
    `STAT_24:
    begin
        mode = 3'd0;
        freeze_enable = `DISABLED;
        if(in[3]==1)
        begin
            next_state = `STAT_YR;
        end
        else if(in[2]==1)
        begin
            next_state = `STAT_MON;
        end
        else if(in[1]==1)
        begin
            next_state = `STAT_SEC;
        end
        else if(in[0]==1)
        begin
            next_state = `STAT_AM;
        end
        else
        begin
            next_state = `STAT_24;
        end
    end
    `STAT_AM:
    begin
        mode = `STAT_AM;
        freeze_enable = `DISABLED;
        if(in[3]==1)
        begin
            next_state = `STAT_YR;
        end
        else if(in[2]==1)
        begin
            next_state = `STAT_MON;
        end
        else if(in[1]==1)
        begin
            next_state = `STAT_SEC;
        end
        else if(in[0]==1)
        begin
            next_state = `STAT_AM;
        end
        else
        begin
            next_state = `STAT_24;
        end
    end
    `STAT_SEC:
    begin
        mode = `STAT_SEC;
        freeze_enable = `DISABLED;
        if(in[3]==1)
        begin
            next_state = `STAT_YR;
        end
        else if(in[2]==1)
        begin
            next_state = `STAT_MON;
        end
        else if(in[1]==1)
        begin
            next_state = `STAT_SEC;
        end
        else if(in[0]==1)
        begin
            next_state = `STAT_AM;
        end
        else
        begin
            next_state = `STAT_24;
        end
    end
    `STAT_MON:
    begin
        mode = `STAT_MON;
        freeze_enable = `DISABLED;
        if(in[3]==1)
        begin
            next_state = `STAT_YR;
        end
        else if(in[2]==1)
        begin
            next_state = `STAT_MON;
        end
        else if(in[1]==1)
        begin
            next_state = `STAT_SEC;
        end
        else if(in[0]==1)
        begin
            next_state = `STAT_AM;
        end
        else
        begin
            next_state = `STAT_24;
        end
    end
    `STAT_YR:
    begin
        mode = `STAT_YR;
        freeze_enable = `DISABLED;
        if(in[3]==1)
        begin
            next_state = `STAT_YR;
        end
        else if(in[2]==1)
        begin
            next_state = `STAT_MON;
        end
        else if(in[1]==1)
        begin
            next_state = `STAT_SEC;
        end
        else if(in[0]==1)
        begin
            next_state = `STAT_AM;
        end
        else
        begin
            next_state = `STAT_24;
        end
    end

    endcase
  
endmodule