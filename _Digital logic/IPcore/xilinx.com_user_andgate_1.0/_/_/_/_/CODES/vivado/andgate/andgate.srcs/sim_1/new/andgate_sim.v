`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/22 21:01:08
// Design Name: 
// Module Name: andgate_sim
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


module andgate_sim(

    );
    reg a = 0;
    reg b = 1;
    wire c;
    andgate #(1) u(a,b,c);
    initial begin
        #100 a = 1;
    end
endmodule
