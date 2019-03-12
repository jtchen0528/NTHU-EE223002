
`include "global.v"
module clock_disp(
    output [`SSD_DIGIT_NUM-1:0]ssd_ctl,
    output [0:`SSD_BIT_WIDTH-1]display,
    output led,
    input clk,
    input setting,
    input in1,
    input in2,
    input in3
    );
    
    wire [`SSD_SCAN_CTL_BIT_NUM-1:0]ssd_ctl_en;
    wire [0:`SSD_BIT_WIDTH-1] disp0, disp1, disp2, disp3;
    wire en;
    wire freeze_enable;
    wire min_enable;
    wire hr_enable;
    wire rst_d;
    wire [`BCD_BIT_WIDTH-1:0]sec0, sec1, min0, min1, hr0, hr1;
    
    reg [`BCD_BIT_WIDTH-1:0]dig0_latch, dig1_latch, dig2_latch, dig3_latch;
    reg [`BCD_BIT_WIDTH-1:0]dig0_out, dig1_out, dig2_out, dig3_out;
    
    freq_div U_FD(.clk_out(clk_d),
    .ssd_ctl_en(ssd_ctl_en),
    .clk(clk),
    .rst(rst_d)
    );
    
    FSM U_fsm(.count_enable(en),
    .freeze_enable(freeze_enable),
    .reset_enable(rst_d),
    .min_enable(min_enable),
    .hr_enable(hr_enable),
    .in1(in1),
    .clk(clk_d),
    .in2(in2),
    .in3(in3),
    .setting(setting)
    );
    
    clock U_sw(.sec0(sec0),
    .sec1(sec1),
    .min0(min0),
    .min1(min1),
    .hr0(hr0),
    .led(led),
    .in2(min_enable),
    .in3(hr_enable),
    .setting(setting),
    .hr1(hr1),
    .en(en),
    .clk(clk_d),
    .rst(rst_d)
    );
    
    always @(posedge clk_d or posedge rst_d)
    if(rst_d) begin
    if((hr0==0)&&(hr1==0))
    begin
        dig0_out <= sec0;
        dig1_out <= sec1;
        dig2_out <= min0;
        dig3_out <= min1;
    end
    else
    begin
        dig0_out <= min0;
        dig1_out <= min1;
        dig2_out <= hr0;
        dig3_out <= hr1;    
    end
    end
    else    begin
        dig0_out <= dig0_latch;
        dig1_out <= dig1_latch;
        dig2_out <= dig2_latch;
        dig3_out <= dig3_latch;
    end
    
    always @(*)
    if(freeze_enable) begin
        dig0_latch = dig0_out;
        dig1_latch = dig1_out;
        dig2_latch = dig2_out;
        dig3_latch = dig3_out;
    end else
    begin
    if((hr1==0)&&(hr0==0))
    begin
        dig0_latch = sec0;
        dig1_latch = sec1;
        dig2_latch = min0;
        dig3_latch = min1;
    end
    else
    begin
        dig0_latch = min0;
        dig1_latch = min1;
        dig2_latch = hr0;
        dig3_latch = hr1;
    end
    end
    
    ssd U_SSD3(
    .display(disp3),
    .bcd(dig3_out));
    ssd U_SSD2(
    .display(disp2),
    .bcd(dig2_out));
    ssd U_SSD1(
    .display(disp1),
    .bcd(dig1_out));
    ssd U_SSD0(
    .display(disp0),
    .bcd(dig0_out));
    
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
