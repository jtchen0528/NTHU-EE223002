
module lab022_ssd(
    input [3:0]i,
    output [7:0]D_ssd,
    output [3:0]ssd_ctl,
    output [3:0]d
    );
    
    lab022 U0(.i(i), .D_ssd(D_ssd), .d(d));
    
    assign ssd_ctl = 4'b0000;
    
endmodule
