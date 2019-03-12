`define ENABLED 1
`define DISABLED 0
module FSM(
    output reg rst_enable,
    input in,
    input clk
    );

    reg [1:0]state;
    reg [1:0]next_state;
    reg [2:0]in_latch;
    reg [2:0]in_latch_temp;
    
    `define STAT_DEF 2'b00
    `define STAT_COUNT 2'b01
    `define STAT_FREEZE 2'b10
    
    always @(posedge clk)
    state <= next_state;
    
    always @(*)
    if((in) && (state != `STAT_COUNT))
        in_latch_temp = 3'b000;
    else
        in_latch_temp = {in_latch[1:0],in};
        
    always @(posedge clk)
        in_latch <= in_latch_temp;
    
    always @(state or in or in_latch)
    case(state)
    `STAT_DEF:
    if((in)) begin
        next_state = `STAT_COUNT;
        rst_enable = `DISABLED;
    end
    else    begin
        next_state = `STAT_DEF;
        rst_enable = `ENABLED;
    end
    `STAT_COUNT:
    if((in)) begin
        next_state = `STAT_DEF;
        rst_enable = `ENABLED;
    end
    else    begin
        next_state = `STAT_COUNT;
        rst_enable = `DISABLED;
    end  
    default:    begin
        next_state = `STAT_DEF;
        rst_enable = `ENABLED;
    end
    endcase
    
endmodule