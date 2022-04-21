`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/26 23:05:43
// Design Name: 
// Module Name: design_sim_2
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


module design_sim_2();
    parameter size = 10000;
    reg[2:0] a;
    reg[2:0] b;
    reg[2:0] c;
    reg[2:0] d;
    reg[1:0] S;
    wire[2:0]e;
    design_1 u(.a(a),.b(b),.c(c),.d(d),.S(S),.e(e));
    initial begin
        a = 'd0;
        b = 'd0;
        c = 'd0;
        d = 'd0;
        S = 'd0;
    
        repeat(size)
        begin
            #10
            a = $random;
            b = $random;
            c = $random;
            d = $random;
            S = $random;
        end
    end
endmodule