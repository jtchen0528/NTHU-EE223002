module note_combo(
    input clk,
    input rst,
    input [5:0]key,
    input [4:0]combo,
    output reg [4:0]notes
    );
    
    reg [4:0]note;
    
    always @(posedge clk or posedge rst) begin
        if(rst == 0) begin
            notes <= 5'd0;
        end
        else begin
                if(key != 6'd63) begin
                    note <= combo;
                end else begin
                    note <= 5'd16;
                end
        end
    end
    
    
endmodule
