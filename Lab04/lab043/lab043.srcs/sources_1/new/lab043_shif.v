`define BIT_WIDTH 6
`define SS_n 8'b11010101
`define SS_t 8'b11100001
`define SS_h 8'b10010001
`define SS_u 8'b10000011
`define SS_e 8'b01100001
`define SS_f 8'b01110010
module lab043_shif(
    ssd,
    clk, 
    rst
    );
    output [7:0]ssd;
    reg [`BIT_WIDTH-1:0]q;
    reg [20:0]count;
    input clk;
    input rst;
    reg [7:0]ssd;
    
    reg [`BIT_WIDTH-1:0]q;
    
    always @(posedge clk or posedge rst)
    begin
        if(rst)
        begin
           q <= `BIT_WIDTH'b000000;
        end
        else 
        begin
            if(q == `BIT_WIDTH'd5)
                q <= `BIT_WIDTH'd0;
            else
                q <= q + `BIT_WIDTH'd1;
        end
        case(q)
            6'd0: ssd = `SS_n;
            6'd1: ssd = `SS_t;
            6'd2: ssd = `SS_h;
            6'd3: ssd = `SS_u;
            6'd4: ssd = `SS_e;
            6'd5: ssd = `SS_e;
            default: ssd = `SS_f;
        endcase
    end
endmodule



