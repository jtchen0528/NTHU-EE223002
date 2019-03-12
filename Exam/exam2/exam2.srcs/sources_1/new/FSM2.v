module FSM2(
    input clk,
    input in1,
    input rst,
    output reg up_down
    );
    
    reg state;
    
    always @(posedge clk or posedge rst) begin
        if(rst == 1) begin
            state <= 1;
        end else begin
            case(state)
                1: begin
                    up_down <= 1;
                    if(in1 == 1) begin
                        up_down <= 0;
                        state <= 0;
                    end 
                end
                0: begin
                    up_down <= 0;
                    if(in1 == 1) begin
                        up_down <= 1;
                        state <= 1;
                    end 
                end
            endcase
        end
    end
    
endmodule
