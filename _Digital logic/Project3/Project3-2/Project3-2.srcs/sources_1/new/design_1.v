`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/23 11:38:01
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
    input [0:0] a,
    input [0:0] b,
    input [0:0] c,
    input [0:0] d,
    input [0:0] S1,
    input [0:0] S2,

    output [0:0] e
    );
    assign e = a&(~S2)&(~S1)|b&(~S2)&(S1)|c&(S2)&(~S1)|d&(S2)&(S1);
endmodule
