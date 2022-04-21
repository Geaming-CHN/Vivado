`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/01 22:44:21
// Design Name: 
// Module Name: divider_tb
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


module divider_tb(

    );
    reg clk;
    reg rst;
    reg[15:0]target;
    wire clk_div;
    initial begin
        clk = 0;
        target = 200;
        forever #5 clk = ~clk;
    end
    divider d(.clk(clk),.clk_div(clk_div),.target(target),.rst(rst));
    initial begin
        #10 rst = 1;
        #10 rst = 0;
    end
endmodule
