`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/22 19:49:14
// Design Name: 
// Module Name: nandgate_sim
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


module nandgate_sim(

    );
    reg a = 0;
    reg b = 0;
    wire c;
    nandgate #(1) u(.a(a),.b(b),.c(c));
    initial begin
        #100 a = 1;
        #100 b = 1;
        #100 begin
            a = 0 ;b = 1;
        end
    end
endmodule
