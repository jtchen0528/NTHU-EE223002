module top(
    output [3:0]ssd_ctl,
    output [0:7]display,
    output [15:0]led,
    input clk,
    input in,
    input rst
    );
    
    wire [2-1:0]ssd_ctl_en;
    wire [0:8-1] disp0, disp1, disp2, disp3;
    wire clk_out;
    wire clk_d;
    wire [3:0]num;
    
    freq_div2(.clk(clk), .rst(rst), .clk_out(clk_out));
    
    freq_div U_FD(.clk_out(clk_d),
    .ssd_ctl_en(ssd_ctl_en),
    .clk(clk),
    .rst(rst)
    );

    counter(.clk(clk_out), .in(in), .rst(rst), .up_down(1), .led(num));
    
    num_led(.clk(clk), .rst(rst), .num(num), .led(led));
    
    ssd U_SSD3(
    .display(disp3),
    .bcd(4'd0));
    ssd U_SSD2(
    .display(disp2),
    .bcd(4'd0));
    ssd U_SSD1(
    .display(disp1),
    .bcd(4'd0));
    ssd U_SSD0(
    .display(disp0),
    .bcd(num));
    
    ssd_ctl U_CTL(
    .display_c(ssd_ctl),
    .display(display),
    .ssd_ctl_en(ssd_ctl_en),
    .display0(disp0),
    .display1(disp1),
    .display2(disp2),
    .display3(disp3)
    );
    
endmodule
