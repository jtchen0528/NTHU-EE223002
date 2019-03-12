`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/05 18:38:18
// Design Name: 
// Module Name: fulladder_t
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fulladder_t;
    reg a;
    reg b;
    reg cin;
    wire cout;
    wire s;
    
    fulladder uut(.a(a), .b(b), .cin(cin), .cout(cout), .s(s));
    
    initial begin
    a=0; b=0; cin=0;
    #100;
    #100 a=0; b=0; cin=1;
    #100 a=0; b=1; cin=0;
    #100 a=0; b=1; cin=1;
    #100 a=1; b=0; cin=0;
    #100 a=1; b=0; cin=1;
    #100 a=1; b=1; cin=0;
    #100 a=1; b=1; cin=1;
    end
endmodule

