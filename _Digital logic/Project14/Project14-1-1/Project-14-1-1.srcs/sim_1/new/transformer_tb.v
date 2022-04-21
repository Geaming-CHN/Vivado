`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/01 22:57:14
// Design Name: 
// Module Name: transformer_tb
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


module transformer_tb(

    );
    reg [3:0] data;
    wire [15:0] BCD;
    transformer t(.data(data),.BCD(BCD));
    initial begin
        #10 data = 4'b1111;
        #10 data = 4'b1010;
    end
endmodule
