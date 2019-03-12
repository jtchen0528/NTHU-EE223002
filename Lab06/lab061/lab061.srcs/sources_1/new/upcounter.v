`include "global.v"
module upcounter(
    output [`BCD_BIT_WIDTH-1:0]value,
    output carry,
    input clk,
    input rst,
    input increase,
    input [`BCD_BIT_WIDTH-1:0]init_value,
    input [`BCD_BIT_WIDTH-1:0]limit,
    input en
    );
    
    reg [`BCD_BIT_WIDTH-1:0]value;
    reg [`BCD_BIT_WIDTH-1:0]value_tmp;
    reg carry;
    
    always @(value or increase or en or limit)
        if(value==limit && increase && en)
        begin
            value_tmp = `BCD_ZERO;
            carry = `ENABLED;
        end
        else if(increase && en)
        begin
            value_tmp = value + `INCREMENT;
            carry = `DISABLED;
        end
        else if(en)
        begin
            value_tmp = value;
            carry = `DISABLED;
        end
        else
        begin
            value_tmp = limit;
            carry = `DISABLED;
        end
        
    always @(posedge clk or posedge rst)
    if(rst)
        value <= init_value;
    else
        value <= value_tmp;
         
endmodule