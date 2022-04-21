`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/23 12:13:51
// Design Name: 
// Module Name: design_1_sim
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


module design_1_sim(

    );
    reg [2:0]a = 3'b001;
    reg [2:0]b = 3'b010;
    reg [2:0]c = 3'b100;
    reg [2:0]d = 3'b111;
    reg [1:0]S = 2'b00;
    wire [2:0]e;
    design_1 u(.a(a),.b(b),.c(c),.d(d),.S(S),.e(e));
    initial begin
        #100 S = 2'b00;
        #100 S = 2'b01;
        #100 S = 2'b10;
        #100 S = 2'b11;
    end
endmodule
