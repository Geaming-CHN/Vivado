`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/14 00:48:21
// Design Name: 
// Module Name: clock_tb
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


module clock_tb();
    reg clk,rst;
    wire[3:0] h2,h1,m2,m1,s2,s1; 
    clock_conut u1(clk,rst,h2,h1,m2,m1,s2,s1);
    always #5 clk=~clk;  
    initial  
    begin  
        clk=0;
        rst=1;
        #10 rst=0;  
    end  
endmodule
