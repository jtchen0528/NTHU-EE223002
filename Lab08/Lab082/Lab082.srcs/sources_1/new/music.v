module music(
    input clk,
    input rst_n,
    input [2:0]in,
    output [21:0]note_div
);
    reg [21:0]note_div;
always @(posedge clk or posedge rst_n) begin
        if(rst_n) begin
    note_div <= 22'd0;
    end
    else
    begin
        if(in[2]==1)
        begin
            note_div <= 22'd191571;
        end
        else if(in[1]==1)
        begin
            note_div <= 22'd170648;
        end
        else if(in[0]==1)
        begin
            note_div <= 22'd151515;
        end
        else
            note_div <= 22'd0;
    end
    end

endmodule