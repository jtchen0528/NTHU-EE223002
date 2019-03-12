module volume(
    input clk,
    input rst_n,
    input [1:0]invol,
    output [4:0]vol,
    output [3:0]vol1,
    output [3:0]vol0
);
    reg [4:0]vol;
    
    assign vol1 = vol/10;
    assign vol0 = vol%10;
    
always @(posedge clk or posedge rst_n) begin
        if(rst_n) begin
    vol <= 5'd6;
    end
    else
    begin
        if(invol[1]==1)
        begin
            vol <= vol + 1;
            if(vol == 5'd15)
            vol <= 5'd15;
        end
        else if(invol[0]==1)
        begin
            vol <= vol - 1;
            if(vol == 5'd0)
            vol <= 5'd0;
        end
        else
            vol <= vol;
    end
    end

endmodule