module ssd_note2(
    output [0:8-1]display,
    input [4-1:0]bcd
    );
    
    reg [0:8-1]display;
    
    always @(bcd)
    case(bcd)
        4'd0: display = 8'b11000101;
        4'd1: display = 8'b00000101;
        4'd2: display = 8'b11011111;
        4'd3: display = 8'b00000101;
        4'd4: display = 8'b11000101;
        4'd5: display = 8'b00000101;
        4'd6: display = 8'b11011111;
        default: display = 8'b1111111_1;
    endcase
    
endmodule
