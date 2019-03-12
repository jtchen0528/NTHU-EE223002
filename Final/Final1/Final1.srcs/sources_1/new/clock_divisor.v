module clock_divisor(clk1, clk, clk22, clk_1s, ssd_ctl_en);
input clk;
output clk1;
output clk22;
output reg clk_1s;
output [1:0]ssd_ctl_en;
reg [21:0] num;
wire [21:0] next_num;
reg [25:0]cnt;

always @(posedge clk) begin
  num <= next_num;
  cnt <= cnt + 1;
  if(cnt == 26'd49999999) begin
    clk_1s <= ~clk_1s;
    cnt <= 26'd0;
  end
end

assign next_num = num + 1'b1;
assign clk1 = num[1];
assign clk22 = num[21];
assign ssd_ctl_en = num[20:19];
endmodule