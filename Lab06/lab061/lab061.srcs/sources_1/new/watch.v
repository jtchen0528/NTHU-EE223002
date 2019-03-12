`include "global.v"
module watch(
    output [`BCD_BIT_WIDTH-1:0]digit3,
    output [`BCD_BIT_WIDTH-1:0]digit2,
    output [`BCD_BIT_WIDTH-1:0]digit1,
    output [`BCD_BIT_WIDTH-1:0]digit0,
    input clk,
    input rst,
    input mode,
    input en
    );
    
    wire cr0, cr1, cr2, cr3;
    wire increase_enable;
    
    reg [3:0]ctl;
    reg [`BCD_BIT_WIDTH-1:0]init_dig0;
    reg [`BCD_BIT_WIDTH-1:0]init_dig1;
    reg [`BCD_BIT_WIDTH-1:0]init_dig2;
    reg [`BCD_BIT_WIDTH-1:0]init_dig3;
    
    always @(mode)
    case(mode)
    1'b0:
    begin
        ctl = 2'b11;
        init_dig0 = `BCD_ZERO;
        init_dig1 = `BCD_ZERO;
        init_dig2 = `BCD_ZERO;
        init_dig3 = `BCD_ZERO;
    end
    1'b1:
    begin
        ctl = 2'b11;
        init_dig0 = `BCD_ZERO;
        init_dig1 = `BCD_ZERO;
        init_dig2 = `BCD_TWO;
        init_dig3 = `BCD_ONE;
    end
    default:
    begin
        ctl = 2'b00;
        init_dig0 = `BCD_ZERO;
        init_dig1 = `BCD_ZERO;
        init_dig2 = `BCD_ZERO;
        init_dig3 = `BCD_ZERO;
    end
    endcase
    
    assign increase_enable = en && (~((digit0==`BCD_ZERO) && (digit1==`BCD_ZERO) && (digit2==`BCD_FOUR) && (digit3==`BCD_TWO)));
    
    upcounter Udc0(
    .value(digit0),
    .carry(cr0),
    .clk(clk),
    .rst(rst),
    .increase(increase_enable),
    .init_value(init_dig0),
    .limit(`BCD_NINE),
    .en(ctl[0])
    );
    
    upcounter Udc1(
    .value(digit1),
    .carry(cr1),
    .clk(clk),
    .rst(rst),
    .increase(increase_enable),
    .init_value(init_dig1),
    .limit(`BCD_FIVE),
    .en(ctl[1])
    );
    
    upcounter Udc2(
    .value(digit2),
    .carry(cr2),
    .clk(clk),
    .rst(rst),
    .increase(increase_enable),
    .init_value(init_dig2),
    .limit(`BCD_NINE),
    .en(ctl[2])
    );
    
    upcounter Udc3(
    .value(digit3),
    .carry(cr3),
    .clk(clk),
    .rst(rst),
    .increase(increase_enable),
    .init_value(init_dig3),
    .limit(`BCD_TWO),
    .en(ctl[3])
    );
    
endmodule