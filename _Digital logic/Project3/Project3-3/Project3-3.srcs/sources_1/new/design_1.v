`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/23 12:01:07
// Design Name: 
// Module Name: design_1
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


module design_1
    (
    input [2:0]a,
    input [2:0]b,
    input [2:0]c,
    input [2:0]d,
    input [1:0]S,
    output reg[2:0]e
    );
    always @(a,b,c,d,S) 
    begin
        case(S[1:0])
            2'b00: e = a;      
            2'b01: e = b;
            2'b10: e = c;
            2'b11: e = d;
            default:e = 2'b00;  
        endcase
    end
endmodule
