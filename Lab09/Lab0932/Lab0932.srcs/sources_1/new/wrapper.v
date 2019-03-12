module wrapper(
	input CLK,		//board clock signal
	input rst,
	input PS2_CLK,		//keyboard clock signal
	input PS2_DATA,		//keyboard data signal
	output [7:0] LED,	//8 output LEDs
	output [3:0]ssd_ctl,
    output [0:7]display
    );
    wire clk_out;
    wire [1:0]ssd_ctl_en;
    wire [0:7] disp0, disp1, disp2, disp3;
    wire [3:0]N1;
    wire [3:0]N2;
    wire [3:0]S0;
    wire [3:0]S1;
    
    freq_div Ufd(.clk_out(clk_out), .clk(CLK), .rst(rst), .ssd_ctl_en(ssd_ctl_en));
keyboard TestingKeyboard (
							.CLK(CLK),
							.clk_out(clk_out),
							.PS2_CLK(PS2_CLK), 
							.PS2_DATA(PS2_DATA),
							.LED(LED),
							.N1(N1),
							.N2(N2),
							.S0(S0),
							.S1(S1)
							
							);
    ssd U_SSD3(.display(disp3),
               .bcd(N1));
    ssd U_SSD2(.display(disp2),
               .bcd(N2));
    ssd U_SSD1(.display(disp1),
               .bcd(S1));
    ssd U_SSD0(.display(disp0),
               .bcd(S0));
                                           
    ssd_ctl U_CTL(
              .display_c(ssd_ctl),
              .display(display),
              .ssd_ctl_en(ssd_ctl_en),
              .display0(disp0),
              .display1(disp1),
              .display2(disp2),
              .display3(disp3));

endmodule